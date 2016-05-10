job('zero-to-tested') {
    triggers {
        scm('H/15 * * * *')
    }
    wrappers {
        colorizeOutput('xterm')
    }
    parameters {
        stringParam("CONTAINER_NAME", "zerotest")
    }
    scm {
        git {
            remote {
                url('https://github.com/mcrmfc/zero-to-tested.git')
            }
            wipeOutWorkspace(false)
                createTag(false)
                branch('wip')
        }
    }
    steps {
        shell('cucumber/scripts/docker_start.sh')
    }
    publishers {
        cucumberReports {
            jsonReportPath()
                fileIncludePattern('cucumber/reports/**/report.json')
                failOnSkipSteps()
                failOnPendingSteps()
                failOnUndefinedSteps()
                failOnMissingSteps()
                turnOffFlashCharts()
                //ignoreFailedTests()
                //parallelTesting()
        }
        postBuildScripts {
            steps {
                shell('cucumber/scripts/docker_stop.sh')
            }
        }
    }
}
