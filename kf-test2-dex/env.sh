# Set KF_NAME to the name of your Kubeflow deployment. You also use this
# value as directory name when creating your configuration directory.
# For example, your deployment name can be 'my-kubeflow' or 'kf-test'.
export KF_NAME=kf-test2-dex

# Set the path to the base directory where you want to store one or more
# Kubeflow deployments. For example, /opt.
# Then set the Kubeflow application directory for this deployment.
export BASE_DIR=/home/kosamara/ws/my/kubeflow-experiments
export KF_DIR=${BASE_DIR}/${KF_NAME}
export CONFIG_FILE=${KF_DIR}/kfctl_istio_dex.yaml
