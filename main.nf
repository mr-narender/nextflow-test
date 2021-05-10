
params.genome = 'genome'
params.volumeClaim = 'pvc-nextflow'
params.mountPath = '/workspace/ubuntu/'
params.subPath = 'work'

commands = ['pwd', 'pwd', 'pwd',]

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

process pod_1 {
    pod = [
            [env: 'msg', value: 'Hello-World.!'],
            [
                volumeClaim: "${params.volumeClaim}",
                mountPath: "${params.mountPath}",
                subPath: "${params.subPath}"
            ]
        ]

    input:
        val pod_1_xin from commands

    output:
        val pod_1_xout into pod_1_receiver

    script:
        pod_1_xout = pod_1_xin
}

process pod_2 {
    pod = [
            [
                volumeClaim: "${params.volumeClaim}",
                mountPath: "${params.mountPath}",
                subPath: "${params.subPath}"
            ]
        ]

    input:
        val pod_2_xin from pod_1_receiver

    output:
        val pod_2_xout into pod_2_receiver

    script:
        pod_2_xout = pod_2_xin
        template 'main.sh'
}

pod_2_receiver.view {
    xout -> "$xout"
}
