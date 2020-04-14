Kubeflow at CERN
---

Resources and instructions to deploy multi-user [Kubeflow](https://www.kubeflow.org/) at CERN k8s clusters
with letsencrypt certificates and SSO integration.

- [Kubeflow cluster](kubeflow): k8s cluster where the kubeflow templates (+ some customizations) are deployed

# Setup

From zero to kubeflow at CERN

## Overview

1. Create a Magnum cluster with some [extra labels](notes/magnum-cluster-labels.md)
1. Enable the default storage class `geneva-cephfs-testing`
   - `kubectl patch storageclass geneva-cephfs-testing -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`
1. Using the cluster's DNS name or maybe a [DNS alias](https://clouddocs.web.cern.ch/containers/tutorials/lb.html), [register an Application + OIDC at the resource portal](notes/application-registration.md)
1. Follow [the instructions](kubeflow/README.md) to deploy the templates in [kubeflow](kubeflow) 

### CERN integration notes

This deployment is integrated with the CERN SSO.

Kubeflow's Istio is configured with Let's Encrypt TLS certs.

### Resources

- [Understand Istio ingress](https://blog.jayway.com/2018/10/22/understanding-istio-ingress-gateway-in-kubernetes/)
