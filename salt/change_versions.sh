#!/bin/bash

#####Functions######
usage ()
{
	echo "=========USAGE========="
	echo "$0 -v <version> -o <os> -f <vagrantfile_location>"
	echo "Neither of these options are required"
	echo "Make sure to excape the / when changing operating systems. For example: "
	echo '      ./change_versions.sh  -o "centos\/test'
	exit
}

change_salt_version ()
{
	sed -i 's/.*salt.install_args.*/      salt.install_args = "'${version}'"/' ${file}
}

change_os ()
{
	sed -i 's/.*master_config.vm.box.*/    master_config.vm.box = "'${os}'"/' ${file}
}

#####Parse Arguments######
while getopts "v:o:f:h" opt; do
  case $opt in
    v)
      version=$OPTARG
      ;;
    o)
      os=$OPTARG
      ;;
    f)
      file=$OPTARG
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done

[[ -z $file ]] && usage
[[ ! -z $version ]] && change_salt_version
[[ ! -z $os ]] && change_os
