Kubeflow at CERN
---

Resources and instructions to deploy multi-user [Kubeflow](https://www.kubeflow.org/) at CERN k8s clusters
with letsencrypt certificates and SSO integration.

# Architecture

1. [Kubeflow cluster](kubeflow): k8s cluster where the kubeflow templates (+ some customizations) are deployed
1. [loadbalancer](loadbalancer): HAProxy that sits in front of the kubeflow cluster to load balance from a friendly, internet-accessible DNS name
   - "PaaS application" CERN website accessible from the Internet
   - deployed on Openshift

# Setup

From zero to kubeflow at CERN

## Overview

1. Create a Magnum cluster with some [extra labels](notes/magnum-cluster-labels.md)
1. Enable the default storage class `geneva-cephfs-testing`
   - `kubectl patch storageclass geneva-cephfs-testing -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'`
1. Pick a DNS name `<SITENAME>` for the deployment and [register an Application + OIDC at the resource portal](notes/application-registration.md)
1. Deploy the templates in [kubeflow](kubeflow) (see README in each deployment for customizable parameters)
1. [Create a CERN website](https://webservices.web.cern.ch/webservices/Services/CreateNewSite/Default.aspx) to expose the deployment to the world
   - name: the same used for the SSO registration
   - official, PaaS application
   - verify that CERN SSO has been set up correctly
   - expose Kubeflow to the internet: `https://webservices.web.cern.ch/webservices/Tools/Permissions/?SiteName=<SITENAME>`


### CERN integration notes

This deployment is integrated with the CERN SSO.

Kubeflow's Istio is configured with Let's Encrypt TLS certs.
