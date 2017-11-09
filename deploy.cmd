set vhd=".\output-hyperv-iso\Virtual Hard Disks\packer-hyperv-iso.vhd"

set rg=hyperv-iso-alpine
set location=eastus
set sa=tcoalpinesa
set container=mydisks
set disk=alpine-disk
set blob=alpine.vhd
set vhdurl=https://%sa%.blob.core.windows.net/%container%/%blob%

call az group create --name %rg% --location %location%

call az storage account create --resource-group %rg% --location %location% --name %sa% --kind Storage --sku Standard_LRS

for /f %%i in ('az storage account keys list --resource-group %rg% --account-name %sa% --query [0].value') do set key=%%i

call az storage container create --account-name %sa% --name %container%

call az storage blob upload --account-name %sa% --account-key %key% --container-name %container% --type page --file %vhd% --name %blob%

pause

call az disk create --resource-group %rg% --name %disk% --source %vhdurl%

call az vm create --resource-group %rg% --location %location% --name alpine --os-type linux --attach-os-disk %disk%
