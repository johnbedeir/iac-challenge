### In this readme we build EKS cluster, Nginx-ingress, Postgres instance as well as the stateless application `hello-app`
#
# 1st Stage: Docker

## 1. Docker Images 
### a) Nginx (for the stateless application)
    docker pull triple3a/nginx-image
### b) Laravel-ci (for the stateful application)
    docker pull triple3a/laravel-ci 
### c) laravel (for the stateful application)
    docker pull triple3a/laravel
### d) Application image
    docker pull triple3a/demo-app

## 2. Dockerfile 
### a) Copy the project inside the container, install composer and run entrypoint `artisian migrate`

    FROM triple3a/laravel-ci AS builder

    COPY . /var/www/html
    ENV COMPOSER_MEMORY_LIMIT=-1
    RUN mkdir -p /var/www/html/storage/framework/sessions \
        && mkdir -p /var/www/html/storage/framework/views \
        && mkdir -p /var/www/html/storage/framework/cache \
        && mkdir -p /var/www/html/storage/framework/cache/data \
        && chmod -R 777 /var/www/html/storage/framework \
        && chown -R www-data:www-data /var/www/html/storage/framework \
        && composer update

    FROM triple3a/laravel
    COPY --from=builder /var/www/html /var/www/html
    ENTRYPOINT /docker-entrypoint.sh
#
# 2nd Stage: Kubernetes `YML` files
## 1. `configmap.yaml` to get the DB artifacts from the image and keep containerized applications portable
    kind: ConfigMap
    apiVersion: v1
    metadata:
    name: demo-app
    namespace: development
    data:
    APP_NAME: Demo
    APP_ENV: development
    APP_KEY: base64:QJKvhZRjMbkFqmG93pYSH68IFSi1Th0lhLH3+PUL1Pc=
    APP_DEBUG: "true"
    APP_URL: http://localhost

    LOG_CHANNEL: stack

    DB_CONNECTION: pgsql
    DB_HOST: app-postgresql-master.cbckp8nutrni.us-east-2.rds.amazonaws.com
    DB_PORT: "5432"
    DB_DATABASE: appPostgresql
    DB_USERNAME: app_postgresql
    DB_PASSWORD: "YourPwdShouldBeLongAndSecure!"

    BROADCAST_DRIVER: log
    CACHE_DRIVER: file
    QUEUE_CONNECTION: sync
    SESSION_DRIVER: file
    SESSION_LIFETIME: "120"

    MAIL_MAILER: smtp
    MAIL_HOST: smtp.mailtrap.io
    MAIL_PORT: "2525"
    MAIL_USERNAME: "null"
    MAIL_PASSWORD: "null"
    MAIL_ENCRYPTION: "null"
    MAIL_FROM_ADDRESS: "null"
    MAIL_FROM_NAME: "${APP_NAME}"

## 2. `deployment.yaml` to specify docker image and the needed resources
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    labels:
        app: demo-app
    name: demo-app
    namespace: development
    spec:
    selector:
        matchLabels:
        app: demo-app
    strategy:
        rollingUpdate:
        maxSurge: 1
        maxUnavailable: 0
        type: RollingUpdate
    template:
        metadata:
        labels:
            app: demo-app
        spec:
        containers:
            - envFrom:
                - configMapRef:
                    name: demo-app
                    optional: true
                - secretRef:
                    name: demo-app
                    optional: true
            image: "triple3a/demo-app:latest"
            imagePullPolicy: Always
            name: demo-app
            ports:
                - containerPort: 8080
                name: http
            resources:
                limits:
                cpu: 250m
                memory: 512Mi
                requests:
                cpu: 150m
                memory: 128Mi
## 3. `service.yaml` to enable network access to the pods
    apiVersion: v1
    kind: Service
    metadata:
    name: demo-app
    namespace: development
    spec:
    ports:
        - name: http
        port: 8080
        targetPort: 8080
    selector:
        app: demo-app
    type: NodePort
## 4. `ingress.yaml` to give service a reachable URL
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
    name: demo-app
    namespace: development
    spec:
    ingressClassName: nginx
    rules:
        - host: demo.jb-host.net
        http:
            paths:
            - backend:
                service:
                    name: demo-app
                    port:
                    number: 8080
                path: /
                pathType: ImplementationSpecific
#
# 3rd Stage: Terraform

## 1. `db.tf` to create RDS instence

## 2. `eks.tf` to create Cluster on Elastic Kubernetes Service

## 3. `vpc.tf` to create the virtual private cloud and set the IP range

## 4. `k8s-hello.tf` deploying stateless app

## 5. `k8s-namespace.tf` create namespaces

## 6. `providers.tf` aws access

## 7. `variables.tf` set region, IAM role, autoscaling

#
# Last Stage: Makefile
## 1. to `build image`, `push image` and `deploy` the `YML` files  

    .PHONY : all

    all: build push deploy

    build:
        docker build -t triple3a/demo-app demo-app

    push:
        docker push triple3a/demo-app

    deploy:
        kubectl apply -n development -f demo-app/k8s








