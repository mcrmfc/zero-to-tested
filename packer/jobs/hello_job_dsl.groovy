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
                //parallelTesting()
        }
        archiveJunit('**/reports/*.xml')
      publishHtml {
        report('cucumber/reports') {
           reportName('Rubocop Report')
           reportFiles('rubocop.html')
        }
       }
        postBuildScripts {
            steps {
                shell('cucumber/scripts/docker_stop.sh')
            }
        }
    }
}
