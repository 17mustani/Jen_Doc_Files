node{
  stage('SCM Checkout'){
    git 'http://github.com/mustanigopi/project1'
  }

  stage('Compile-Package'){
    // Get maven home path
    def mvnHome = tool name: 'maven-3', type: 'maven'
    sh "${mvnHome}/bin/mvn package"
  }

  stage('Deploy to Tomcat'){
    sshagent(['tomcat-dev']){
      sh 'scp -o StrictHostKeyChecking=no target/*.war ec2-user@172.31.29.242:/opt/tomcat8/webapps/'
    }
  }

  stage('SonarQube Analysis'){
    def mvnHome = tool name: 'maven-3', type: 'maven'
    withSonarQubeEnv('sonar6'){
      sh "${mvnHome}/bin/mvn sonar:sonar"
    }
  }

  stage('Quality Gate Status Check'){
    timeout(time: 1, unit: 'HOURS'){
      def qg = waitForQualityGate()
      if (qg.status != 'OK') {
          mail bcc: '', body: '''Hi Welocme to jenkins email alerts that build failed
          Thanks
          Hari''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job', to: 'gopimustani@gmail.com'
          error "Pipeline aborted due to quality gate failure: ${qg.status}"
      }
    }
  }
  
  stage('Email Notification'){
    mail bcc: '', body: '''Hi Welocme to jenkins email alerts
    Thanks
    Hari''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job', to: 'gopimustani@gmail.com'
  }
    
}
