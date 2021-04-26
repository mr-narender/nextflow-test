
params.genome = 'genome'
params.autoMountHostPaths = true
params.volumeClaim = 'pvc-nextflow'
params.mountPath = '/workspace/ubuntu'
params.subPath = 'work'

commands = ['ls']

log.info """\

        =============================

        S A N G E R   P I P E L I N E

        =============================
        genome: ${params.genome}
        outdir: ${params.volumeClaim}
        mountPath: ${params.mountPath}

        """
        .stripIndent()

process assignedTask {
    container = 'ubuntu:latest'

    echo true

    pod = [
            [runAsUser: 0],
            [env: 'msg', value: 'Hello-World.!'],
            [volumeClaim: "${params.volumeClaim}", mountPath: "${params.mountPath}", subPath: "${params.subPath}"]
        ]

    input:
        val xin from commands

    output:
        val xout into receiver

    script:
        '''
        echo $msg
        '''
        xout = xin
        "echo rEcIeVeD... $xin"
}

receiver.view {
    xout -> "pRoCeSsInG... $xout"
}
