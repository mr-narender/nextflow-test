
params.genome = 'genome'
params.volumeClaim = 'pvc-nextflow'
params.mountPath = '/workspace/ubuntu/'
params.subPath = 'work'

commands = ['command1', 'command2', 'command3',]

log.info """\

        =======================================
        ||   S A N G E R   P I P E L I N E   ||
        =======================================

        genome: ${params.genome}
        volumeClaim: ${params.volumeClaim}
        baseDir: ${baseDir}
        workDir: ${workDir}

        """
        .stripIndent()

process entry {
    pod = [
            [env: 'msg', value: 'Hello-World.!'],
            [
                volumeClaim: "${params.volumeClaim}",
                mountPath: "${params.mountPath}",
                subPath: "${params.subPath}"
            ]
        ]

    input:
        val xin from commands

    output:
        val xout into receiver

    script:
        xout = xin
        template 'main.sh'
}

receiver.view {
    xout -> "$xout"
}
