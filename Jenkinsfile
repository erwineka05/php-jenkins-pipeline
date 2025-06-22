pipeline {
    agent any // Agent default untuk tahap yang tidak butuh alat khusus

    stages {
        // Tahap ini sebenarnya sudah dilakukan Jenkins secara otomatis,
        // tapi kita biarkan sesuai file Anda.
        stage('Clone Repository') {
            steps {
                echo 'Cloning the repository...'
            }
        }

        // Tahap ini akan dijalankan di dalam kontainer 'composer'
        stage('Install & Test') {
            agent {
                // Gunakan image docker 'composer:lts' sebagai lingkungan eksekusi
                docker { image 'composer:lts' }
            }
            steps {
                echo 'Installing PHP dependencies...'
                // Perintah ini akan dijalankan di dalam kontainer 'composer'
                sh 'composer install'

                echo 'Running unit tests...'
                // Perintah ini juga dijalankan di dalam kontainer 'composer'
                sh 'vendor/bin/phpunit tests/SimpleTest.php'
            }
        }

        // Tahap ini kembali menggunakan agent default (Jenkins) yang punya akses ke Docker
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t php-app-image .'
            }
        }

        // Tahap ini juga menggunakan agent default
        stage('Deploy Application') {
            steps {
                echo 'Deploying application using local Docker image...'
                sh 'docker run -d --rm --name my-php-app -p 8081:80 php-app-image'
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
            // Pastikan untuk membersihkan kontainer aplikasi setelah selesai
            sh 'docker stop my-php-app || true'
            sh 'docker rm my-php-app || true'
        }
        success {
            echo 'Pipeline completed successfully! Test the application at http://localhost:8081'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
