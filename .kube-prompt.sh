__kube_ps1 () {
    current_context=$(grep "current\-context" ~/.kube/config | sed -e 's/current-context: gke_retailops-1_us-central1_//')
    if [[ $(pwd) = *"prod-deploy"* ]]; then
        printf -- " ($current_context)"
    fi
}
