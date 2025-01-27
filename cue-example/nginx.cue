package kubernetes

import (
    corev1 "k8s.io/api/core/v1"
    appsv1 "k8s.io/api/apps/v1"
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name: parameter.name
		namespace: parameter.namespace
	}
	spec: {
		replicas: parameter.replicas
		selector: matchLabels: app: parameter.name
		template: {
			metadata: labels: app: parameter.name
			spec: containers: [{
				name:  parameter.name
				image: parameter.image
				ports: [{
					containerPort: parameter.port
				}]
			}]
		}
	}
}

service: corev1.#Service & {
    apiVersion: "v1"
    kind:       "Service"
    metadata: {
	name: parameter.name
        namespace: parameter.namespace
    }
    spec: {
	type: "NodePort"
        ports: [{
            port:       parameter.port
	    protocol: 	"TCP"
        }]
        selector: app: parameter.name
    }
}

output: metav1.#List & {
    apiVersion: "v1"
    kind: "List"
    items: [deployment, service]
}
