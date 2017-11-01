#! /bin/bash

alias mk='minikube'
alias ktl='kubectl'

# Blackboard kubernetes
bbktl () {
    case "$1" in
    "fozzie")
        (
            cd $HOME/bb/starter/kubernetes
            export KUBECONFIG=~/.kube/config-cluster01-us-east-1.fozzie.bbsaas.io
            shift
            ./k8s-okta-auth.sh -n learn-services-playground "$@"
        )
        ;;
    *)
        echo 'Unrecognized command options'
        ;;
    esac
}
