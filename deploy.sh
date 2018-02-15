vhd="./output-qemu/packer-qemu.vhd"

rg=qemu-iso-alpine
location=eastus
sa=tcoalpinesa
container=mydisks
disk=alpine-disk
blob=alpine.vhd
vhdurl=https://$sa.blob.core.windows.net/$container/$blob

az group create --name $rg --location $location

az storage account create --resource-group $rg --location $location --name $sa --kind Storage --sku Standard_LRS

key=$(az storage account keys list --resource-group $rg --account-name $sa --query [0].value)

az storage container create --account-name $sa --name $container

az storage blob upload --account-name $sa --account-key $key --container-name $container --type page --file $vhd --name $blob

read -p "Press Enter to continue"

az disk create --resource-group $rg --name $disk --source $vhdurl

az vm create --resource-group $rg --location $location --name alpine --os-type linux --attach-os-disk $disk
