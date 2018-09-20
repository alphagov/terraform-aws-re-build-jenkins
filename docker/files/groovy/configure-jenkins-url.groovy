import jenkins.model.JenkinsLocationConfiguration
def env = System.getenv()
jlc = JenkinsLocationConfiguration.get()
jlc.setUrl(env['JENKINS_URL']) 
println(jlc.getUrl())
jlc.save()
