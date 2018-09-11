import com.nirima.jenkins.plugins.docker.DockerCloud
import com.nirima.jenkins.plugins.docker.DockerTemplate
import com.nirima.jenkins.plugins.docker.DockerTemplateBase
import com.nirima.jenkins.plugins.docker.launcher.AttachedDockerComputerLauncher
import io.jenkins.docker.connector.DockerComputerAttachConnector
import jenkins.model.Jenkins

// Customise these variables as needed
def imageDockerPath = 'gdsre/jenkins-agent-java8-with-maven:latest'
def dockerTemplateLabel = 'sample-docker-jnlp-java-agent'
def dockerCloudName = 'sample-docker-worker--java'

// Advanced settings - you should not need to change these

def dockerTemplateBaseParameters = [
  bindAllPorts:       false,
  bindPorts:          '',
  cpuShares:          null,
  dnsString:          '',
  dockerCommand:      '',
  environmentsString: '',
  extraHostsString:   '',
  hostname:           '',
  image:              imageDockerPath,
  macAddress:         '',
  memoryLimit:        null,
  memorySwap:         null,
  network:            '',
  privileged:         false,
  pullCredentialsId:  '',
  tty:                true,
  volumesFromString:  '',
  volumesString:      ''
]

def DockerTemplateParameters = [
  instanceCapStr: '4',
  labelString:    dockerTemplateLabel,
  remoteFs:       ''
]

def dockerCloudParameters = [
  connectTimeout:   3,
  containerCapStr:  '4',
  credentialsId:    '',
  dockerHostname:   '',
  name:             dockerCloudName,
  readTimeout:      60,
  serverUrl:        'tcp://worker:2375',
  version:          ''
]

// https://github.com/jenkinsci/docker-plugin/blob/docker-plugin-1.1.2/src/main/java/com/nirima/jenkins/plugins/docker/DockerTemplateBase.java
DockerTemplateBase dockerTemplateBase = new DockerTemplateBase(
  dockerTemplateBaseParameters.image,
  dockerTemplateBaseParameters.pullCredentialsId,
  dockerTemplateBaseParameters.dnsString,
  dockerTemplateBaseParameters.network,
  dockerTemplateBaseParameters.dockerCommand,
  dockerTemplateBaseParameters.volumesString,
  dockerTemplateBaseParameters.volumesFromString,
  dockerTemplateBaseParameters.environmentsString,
  dockerTemplateBaseParameters.hostname,
  dockerTemplateBaseParameters.memoryLimit,
  dockerTemplateBaseParameters.memorySwap,
  dockerTemplateBaseParameters.cpuShares,
  dockerTemplateBaseParameters.bindPorts,
  dockerTemplateBaseParameters.bindAllPorts,
  dockerTemplateBaseParameters.privileged,
  dockerTemplateBaseParameters.tty,
  dockerTemplateBaseParameters.macAddress,
  dockerTemplateBaseParameters.extraHostsString
)

// https://github.com/jenkinsci/docker-plugin/blob/docker-plugin-1.1.2/src/main/java/com/nirima/jenkins/plugins/docker/DockerTemplate.java
DockerTemplate dockerTemplate = new DockerTemplate(
  dockerTemplateBase,
  new DockerComputerAttachConnector(),
  DockerTemplateParameters.labelString,
  DockerTemplateParameters.remoteFs,
  DockerTemplateParameters.instanceCapStr
)

// https://github.com/jenkinsci/docker-plugin/blob/docker-plugin-1.1.2/src/main/java/com/nirima/jenkins/plugins/docker/DockerCloud.java
DockerCloud dockerCloud = new DockerCloud(
  dockerCloudParameters.name,
  [dockerTemplate],
  dockerCloudParameters.serverUrl,
  dockerCloudParameters.containerCapStr,
  dockerCloudParameters.connectTimeout,
  dockerCloudParameters.readTimeout,
  dockerCloudParameters.credentialsId,
  dockerCloudParameters.version,
  dockerCloudParameters.dockerHostname
)

// get Jenkins instance
Jenkins jenkins = Jenkins.getInstance()

// add cloud configuration to Jenkins
jenkins.clouds.add(dockerCloud)

// save current Jenkins state to disk
jenkins.save()
