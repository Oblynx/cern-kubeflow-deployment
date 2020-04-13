# Kfdef changes

## cert-manager-kube-system-resources

+ overlay letsencrypt
+      - name: acmeEmail
+        value: konstantinos.samaras-tsakiris@cern.ch
+      - name: acmeUrl
+        value: https://acme-v02.api.letsencrypt.org/directory

## OIDC

       - name: oidc_provider
         value: https://auth.cern.ch/auth/realms/cern
-      # oidc_auth_url overrides the default Endpoint given by the OIDC_PROVIDER.
-      # According to the authzsvc examples, it shouldn't be set
-      #- name: oidc_auth_url
-      #  value: /auth/realms/cern/protocol/openid-connect/auth
       - name: oidc_redirect_uri
         value: https://test-kfsso2.web.cern.ch/login/oidc
       - name: redirect_url
         value: https://test-kfsso2.web.cern.ch/login/oidc
+      - name: skip_auth_uri
+        value: /.well-known/acme-challenge
       - name: client_id
         value: kf-test-brainhack
+      - name: client_secret
+        value: SECRET

# Manifest changes

- Put OIDC client secret in `kustomize/oidc-authservice$/base/params.env`
- [The Gateway patch should apply automatically]
- `kc create -f istio-ingressgateway-certs.yaml`

