#Set the environment to the VirtualBox directoy
$env:Path = "C:\Program Files\Oracle\VirtualBox\";

#Set an array for each vm I want to boo up. This is just the name of the vm in VirtualBox
$vms = @("git01","web01","salt01","dns01")


#Loop through each vm in the array and start the vm
foreach ($i in $vms) {
    
    VBoxManage startvm $i

}





