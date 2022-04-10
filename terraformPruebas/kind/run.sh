#!/usr/bin/env sh

set -e

terraform apply --auto-approve

printf "\n Esperando a que se levante el servicio web \n"
kubectl apply -f https://king.sigs.k8s,io/examples/ingress/usage.yaml
sleep 10

printf "\n si ves 'foo' es qeu está funcionando ingress\n"
curl http://localhost/foo

