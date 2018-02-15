az vm deallocate -g qemu-iso-alpine -n alpine

az vm generalize -g qemu-iso-alpine -n alpine

az image create -g qemu-iso-alpine -n alpine-image --source alpine

az vm create -g qemu-iso-alpine -n alpine-vm --image alpine-image --admin-username azureuser --ssh-key-value ~/.ssh/id_rsa.pub
