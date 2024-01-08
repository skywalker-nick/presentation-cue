package kubernetes

parameter: {
	namespace: "default"
    name: "hello-cue"
    image: "nginx:1.14.2"
    port: 80
	replicas: 2
}