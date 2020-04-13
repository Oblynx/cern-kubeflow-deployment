# Application & OIDC registration

This registration will integrate the Kubeflow deployment with the CERN Authorization service
and provide an OIDC SSO flow (authorization code flow).

Given a DNS name `<SITENAME>`,
1. register an Application at the [applications portal](https://application-portal.web.cern.ch/).
1. create an OIDC registration
   - redirect uri: `https://<SITENAME>/login/oidc`
