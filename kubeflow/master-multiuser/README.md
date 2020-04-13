# Kubeflow deployment

1. Change kfdef if needed
1. `kfctl build -f kfctl_istio_dex.v1.0.2.yaml`
1. Change generated manifests
   - OIDC secret -> `kustomize/oidc-authservice$/base/params.env`
1. `kfctl apply -f kfctl_istio_dex.v1.0.2.yaml`
1. Issue ACME challenge

## Kfdef changes

### cert-manager

       overlays:
-      - self-signed
+      - letsencrypt
       parameters:
+      - name: acmeEmail
+        value: <EMAIL>
+      - name: acmeUrl
+        value: https://acme-v02.api.letsencrypt.org/directory

### oidc-authservice

       - name: oidc_provider
         value: https://auth.cern.ch/auth/realms/cern
-      - name: oidc_auth_url
-        value: /dex/auth
       - name: oidc_redirect_uri
         value: https://<SITENAME>/login/oidc
+      - name: redirect_url
+        value: https://<SITENAME>/login/oidc
       - name: skip_auth_uri
         value: /.well-known/acme-challenge
       - name: client_id
         value: <CLIENT_ID>
+      - name: client_secret			# NOTE: client_secret might need to be replaced manually in the generated manifests
+        value: <CLIENT_SECRET>

### istio

+      overlays:
+      - https-gateway    # Consider enabling after first connection test with kubectl proxy

### dex

remove kustomizeConfig with name `dex`

## Manual changes

- If you didn't put the OIDC client secret in the kfdef, put it in `kustomize/oidc-authservice$/base/params.env`

### letsencrypt

- `kustomize/cert-manager/overlays/letsencrypt/cluster-issuer.yaml` append:
```
      solvers:
      - http01:
          ingress:
            class: traefik
```

## Issue ACME challenge
- `kc create -f istio-ingressgateway-certs.yaml`

This will create a traefik ingress object for the ACME challenge pointing to a NodePort service,
which seems to be incompatible with Istio ingress.
I haven't yet found a way to make ACME and Istio work well together, so I work around
by adding an extra route on the loadbalancer from the `/.well-known/acme-challenge/*` path
to the service's node port.

