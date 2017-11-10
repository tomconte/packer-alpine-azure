call az vm deallocate -g hyperv-iso-alpine -n alpine

call az vm generalize -g hyperv-iso-alpine -n alpine

call az image create -g hyperv-iso-alpine -n alpine-image --source alpine

call az vm create -g hyperv-iso-alpine -n alpine-vm --image alpine-image --admin-username azureuser --ssh-key-value %HOME%\.ssh\id_rsa.pub
