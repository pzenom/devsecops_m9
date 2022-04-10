#!/bin/bash
echo "CHECK IMAGE VULNERABILITIES"
for pod_images in `kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n'`
do
	echo "'\n'===================POD: $pod_images"
	grype $pod_images |& tee -a "scan_image_$(pod_images)_$(date +%Y-%m-%d_%H:%M).log"
  # docker scan $pod_images d
  # python3 dagda.py check --docker_image $pod_images
  # Any other installed stuff for checking images would come here!!!
done

echo "CHECK PUBLISHED NODEPORT SERVICES"
# Check if it has a NodePort Associated (Why nodeport? You are exposing it only to your host, dont you? Otherwise check its public IP and dont waste my time!! lol )

# get ip, this script is based on minikube wahahaha!
dir_ip=$(minikube ip)
#for pod in `kubectl get pods -o jsonpath="{.items[*].metadata.name}" | tr -s '[[:space:]]' '\n'`
for nodeports in `kubectl get services --all-namespaces -o jsonpath="{.items[*].spec.ports[].nodePort}" | tr -s '[[:space:]]' '\n'`
do
  # LETS DO IT WITH NIKTO!!!
  # nikto -h $dir_ip:$nodeports |& tee -a "scan_service_$(nodeports)_$(date +%Y-%m-%d_%H:%M).log"
  nikto -h $dir_ip:$nodeports -output "scan_service_$(nodeports)_$(date +%Y-%m-%d_%H:%M)" -Format html
  echo "---"
done




done

echo "END"
