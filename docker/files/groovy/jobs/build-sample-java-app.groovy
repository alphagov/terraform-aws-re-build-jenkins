import hudson.plugins.git.*;
import jenkins.model.Jenkins;

def parent = Jenkins.instance

def scm = new GitSCM("https://github.com/alphagov/re-build-systems-sample-java-app")
def flowDefinition = new org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition(scm, "Jenkinsfile")
def job = new org.jenkinsci.plugins.workflow.job.WorkflowJob(parent, "build-sample-java-app")
job.description = "Build and test sample app at https://github.com/alphagov/re-build-systems-sample-java-app"
job.definition = flowDefinition

parent.reload()
