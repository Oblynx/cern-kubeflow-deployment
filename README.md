Kubeflow experiments
---

- [kubeflow](kubeflow): the kubeflow template and manual configs to deploy at CERN
- [kfsso-proxy](kfsso-proxy): HAProxy to gate and load balance the kubeflow cluster

## CERN integration notes

This deployment is integrated with the CERN SSO.
A HAProxy LB sits in front to regulate access.

Kubeflow's Istio is configured with Let's Encrypt TLS certs.
