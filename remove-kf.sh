# Delete non-namespaced resources first
kubectl get crd -o name | grep -v storage.k8s.io | xargs -n1 kubectl delete --grace-period=1
kubectl delete apiservice v1beta1.custom.metrics.k8s.io --grace-period=1
kubectl delete apiservice v1beta1.webhook.cert-manager.io --grace-period=1
kubectl delete validatingwebhookconfiguration --all --grace-period=1
kubectl delete mutatingwebhookconfiguration --all --grace-period=1
kubectl delete pv all --all --grace-period=1

# Cluster roles
kubectl get clusterrolebindings -l 'app.kubernetes.io/part-of=kubeflow' -o name | xargs -n1 kubectl delete --grace-period=1
kubectl get clusterroles -l 'app.kubernetes.io/part-of=kubeflow' -o name | xargs -n1 kubectl delete --grace-period=1
kubectl get clusterrolebindings -o name | grep 'istio\-' | xargs -n1 kubectl delete --grace-period=1
kubectl get clusterroles -o name | grep 'istio\-' | xargs -n1 kubectl delete --grace-period=1
kubectl delete clusterrolebindings dex
kubectl delete clusterroles dex

echo "kubeflow knative-serving istio-system cert-manager auth" | xargs -n1 kubectl delete --grace-period=1 ns
