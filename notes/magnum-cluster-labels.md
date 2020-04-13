# Magnum cluster extra labels to support certificates for Kubeflow deployments

Kubeflow deployments use Istio SDS and require the kubeapi server to [issue JWTs representing service accounts](https://www.kubeflow.org/docs/started/k8s/kfctl-istio-dex/#notes-on-the-configuration-file).
On top of the Magnum `kubernetes-1.15.3-3` template, this requires an additional label:

```
--label kubeapi_options='--service-account-signing-key-file=/etc/kubernetes/certs/service_account_private.key --service-account-issuer=kubernetes.default.svc'
```

The full magnum cluster template definition as an 1-liner:
```
openstack coe cluster template create --image 2886e9bf-7702-4c06-99c1-39a9e7bd5951 --coe kubernetes --external-network CERN_NETWORK --fixed-network CERN_NETWORK --network-driver flannel --dns-nameserver 137.138.17.5 --flavor m2.large --master-flavor m2.medium --docker-storage-driver overlay2 --server-type vm --floating-ip-enabled \
  --labels influx_grafana_dashboard_enabled=true --labels cephfs_csi_enabled=true --labels ingress_controller=traefik --labels kube_csi_version=cern-csi-1.0-2 --labels cloud_provider_tag=v1.15.0 --labels container_infra_prefix=gitlab-registry.cern.ch/cloud/atomic-system-containers/ --labels manila_enabled=true --labels cgroup_driver=cgroupfs --labels autoscaler_tag=v1.15.2 --labels kube_csi_enabled=true --labels cvmfs_csi_version=v1.0.0 --labels admission_control_list=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota,Priority --labels flannel_backend=vxlan --labels manila_version=v0.3.0 --labels cvmfs_csi_enabled=true --labels heat_container_agent_tag=stein-dev-2 --labels kube_tag=v1.15.3 --labels cephfs_csi_version=cern-csi-1.0-2 --labels cert_manager_api=true \
  --label kubeapi_options='--service-account-signing-key-file=/etc/kubernetes/certs/service_account_private.key --service-account-issuer=kubernetes.default.svc' \
  kubernetes-1.15.3-3-signingSA
```

### Notes

`/etc/kubernetes/certs/server.key` isn't valid for this use

#### [Magunum options](https://docs.openstack.org/magnum/latest/user/index.html#kubernetes)

> `kubeapi_options`
> This label can hold any additional options to be passed to the kube api server. For more details, refer to the kube api admin guide. By default no additional options are passed.
