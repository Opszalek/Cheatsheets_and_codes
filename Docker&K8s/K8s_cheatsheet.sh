##############################################################################
# KUBERNETES BASICS
##############################################################################

kubectl version                              # Display Kubernetes version
kubectl cluster-info                         # Display cluster information
kubectl get nodes                            # List all nodes
kubectl describe node <node-name>            # Show detailed information about a node
kubectl top node <node-name>                 # Display resource (CPU/Memory) usage of nodes
kubectl diff -f <yaml-file.yml>		     # Shows diffrence between this and last used yaml
kubectl api-versions                         # List the API versions that are available
kubectl api-resources                        # List the API resources that are available

##############################################################################
# PODS
##############################################################################

kubectl get pods                             # List all pods in the current namespace
kubectl get pods -n <namespace>              # List all pods in a specific namespace
kubectl describe pod <pod-name>              # Show detailed information about a pod
kubectl logs <pod-name>                      # Show logs from a pod
kubectl logs -f <pod-name>                   # Stream logs from a pod
kubectl exec -it <pod-name> -- /bin/bash     # Access a running pod
kubectl delete pod <pod-name>                # Delete a pod
kubectl get pod <pod-name> -o yaml           # Get the YAML for a pod
kubectl top pod <pod-name>                   # Display resource (CPU/Memory) usage of pods

##############################################################################
# DEPLOYMENTS
##############################################################################

kubectl get deployments                      # List all deployments
kubectl describe deployment <deployment-name> # Show detailed information about a deployment
kubectl create deployment <name> --image=<image> # Create a deployment
kubectl set image deployment/<deployment-name> <container-name>=<new-image> # Update image of deployment
kubectl scale deployment <deployment-name> --replicas=<number> # Scale a deployment
kubectl delete deployment <deployment-name>  # Delete a deployment
kubectl rollout status deployment <deployment-name> # Watch rollout status
kubectl rollout undo deployment <deployment-name>  # Rollback to previous deployment

##############################################################################
# SERVICES
##############################################################################

kubectl get services                         # List all services
kubectl describe service <service-name>      # Show detailed information about a service
kubectl expose deployment <deployment-name> --type=<type> --port=<port> # Expose a deployment as a service
kubectl delete service <service-name>        # Delete a service
kubectl explain services --recursive	     # Shows all aviable fields for services and its structure

##############################################################################
# CONFIGMAPS & SECRETS
##############################################################################

kubectl create configmap <configmap-name> --from-literal=<key>=<value> # Create a ConfigMap from literal value
kubectl create configmap <configmap-name> --from-file=<path> # Create a ConfigMap from file
kubectl get configmaps                      # List all ConfigMaps
kubectl describe configmap <configmap-name> # Show detailed information about a ConfigMap
kubectl delete configmap <configmap-name>   # Delete a ConfigMap

kubectl create secret generic <secret-name> --from-literal=<key>=<value> # Create a Secret from literal value
kubectl create secret generic <secret-name> --from-file=<path> # Create a Secret from file
kubectl get secrets                         # List all Secrets
kubectl describe secret <secret-name>       # Show detailed information about a Secret
kubectl delete secret <secret-name>         # Delete a Secret

##############################################################################
# NAMESPACES
##############################################################################

kubectl get namespaces                      # List all namespaces
kubectl create namespace <namespace>        # Create a new namespace
kubectl delete namespace <namespace>        # Delete a namespace


##############################################################################
# VOLUMES & PERSISTENT VOLUME CLAIMS
##############################################################################

kubectl get pv                              # List all persistent volumes
kubectl get pvc                             # List all persistent volume claims
kubectl describe pv <pv-name>               # Show detailed information about a persistent volume
kubectl describe pvc <pvc-name>             # Show detailed information about a persistent volume claim
kubectl delete pv <pv-name>                 # Delete a persistent volume
kubectl delete pvc <pvc-name>               # Delete a persistent volume claim

##############################################################################
# INGRESS
##############################################################################

kubectl get ingress                         # List all ingresses
kubectl describe ingress <ingress-name>     # Show detailed information about an ingress
kubectl delete ingress <ingress-name>       # Delete an ingress

##############################################################################
# RBAC (Role-Based Access Control)
##############################################################################

kubectl get roles                           # List all roles
kubectl get rolebindings                    # List all role bindings
kubectl describe role <role-name>           # Show detailed information about a role
kubectl describe rolebinding <rolebinding-name> # Show detailed information about a role binding
kubectl create role <role-name> --verb=<verb> --resource=<resource> # Create a role
kubectl create rolebinding <rolebinding-name> --role=<role-name> --user=<username> # Create a role binding
kubectl delete role <role-name>             # Delete a role
kubectl delete rolebinding <rolebinding-name> # Delete a role binding

##############################################################################
# MISCELLANEOUS
##############################################################################

kubectl apply -f <file.yml>                 # Apply a configuration to a resource by file or stdin
kubectl delete -f <file.yml>                # Delete resources by file or stdin
kubectl get all                             # List all resources in the namespace
kubectl get events                          # List all events in the namespace
kubectl label pods <pod-name> <label-key>=<label-value> # Add or update label on a pod
kubectl annotate pods <pod-name> <annotation-key>=<annotation-value> # Add or update annotation on a pod
kubectl edit <resource>/<name>              # Edit a resource on the server
kubectl proxy                               # Run a proxy to the Kubernetes API server
kubectl config view                         # Show configuration
kubectl config get-contexts                 # Shows all aviable contexts
kubectl config use-context <context-name>   # Switch to a specific context
kubectl explain <resource>                  # Get documentation for a resource
kubectl explain <resource>.<child>          # Get documentation for a resource child
kubectl apply -f <file.yml> --dry-run=client # Validate the configuration without applying it (client-side)
kubectl apply -f <file.yml> --dry-run=server # Validate the configuration without applying it (server-side)
kubectl create deployment <name> --image=<image> --dry-run=client  # Simulate creating a deployment
kubectl create deployment <name> --image=<image> --dry-run=server  # Simulate creating a deployment (server-side)
kubectl delete -f <file.yml> --dry-run=client # Validate the deletion without applying it (client-side)
kubectl delete -f <file.yml> --dry-run=server # Validate the deletion without applying it (server-side)
kubectl get pods -o json                      # Get pods in JSON format
kubectl get pods -o wide                      # Get pods with additional information (wide format)

##############################################################################
# HELM (Package Manager for Kubernetes)
##############################################################################

helm version                                # Show the Helm version information
helm repo add <repo-name> <repo-url>        # Add a chart repository
helm repo update                            # Update information on available charts
helm search repo <keyword>                  # Search for charts in repositories
helm install <release-name> <chart>         # Install a chart
helm upgrade <release-name> <chart>         # Upgrade a release
helm list                                   # List releases
helm get all <release-name>                 # Get all information for a release
helm rollback <release-name> <revision>     # Rollback to a previous release
helm uninstall <release-name>               # Uninstall a release
helm status <release-name>                  # Display the status of a release


