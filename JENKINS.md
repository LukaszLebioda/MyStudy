# Jenkins

## Installation

- install the latest LTS version: `brew install jenkins-lts`,
- start the Jenkins service: `brew services start jenkins-lts`,
- restart the Jenkins service: `brew services restart jenkins-lts`,
- stop the Jenkins service: `brew services stop jenkins-lts`,
- update the Jenkins version: `brew upgrade jenkins-lts`,

Jenkins is now available on: `http://localhost:8080`

- unlock Jenkins (provide initial password from the path on the unlocking screen),
- choose option: install suggested plugins,
- create first admin user (username & password),
- download additional plugins, e.g.: Pipeline Stage View,

## Pipeline Example

```groovy
pipeline {
agent any
    environment { // here we can declare variables for pipeline
        BUILD_FILENAME = 'laptop.txt'
    }
    //agent { // how to tell agent to run docker image
    //        docker {
    //                image 'node:18-alpine'
    //                reuseNode true // make sure all the stages use the same workspace
    //            }
    //        }
    stages {
        stage('Build') {
            steps {
                cleanWs() // clean the workspace (clean artifacts, like .txt files etc.)
                // sh 'sleep 500' // sleep for x seconds
                sh 'echo "Building a new laptop..."' // print info to the console
                sh 'mkdir -p build' // create directory if it doesn't exist
                sh 'touch build/$BUILD_FILENAME' // create .txt file (or update its timestamp)
                sh '''
                    echo "Mainboard" >> build/$BUILD_FILENAME
                    # sh 'exit 7' // how to in comment (in sh series) and to intentionally invoke error (1-255)
                    cat build/$BUILD_FILENAME
                    echo "Display" >> build/$BUILD_FILENAME
                    cat build/$BUILD_FILENAME
                    echo "Keyboard" >> build/$BUILD_FILENAME
                    cat build/$BUILD_FILENAME
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing new laptop...'
                sh 'test -f build/$BUILD_FILENAME' // linux test command to verify it artifact file exists
                sh 'grep "Mainboard" build/$BUILD_FILENAME' // cli tool to search (here: string in a file)
                sh 'grep "Display" build/$BUILD_FILENAME'
                sh 'grep "Keyboard" build/$BUILD_FILENAME'
            }
        }
    }
    post { // run this after all the stages
        success { // run this if success only (success, failure or always)
            archiveArtifacts artifacts: 'build/**' // archive whatever is inside build dir
        }
    }
}
```
