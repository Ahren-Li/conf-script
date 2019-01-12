#!/bin/bash
if [[ ! $UBUNTU ]]; then
	return
fi

function MAKE_UBUNTU_ICON(){
	out_path=""

	local OPTIND LOCAL_ARG
    while getopts ":o:v:t:n:i:e:c:S:T:" LOCAL_ARG; do
        case "${LOCAL_ARG}" in
            o)
                out_path="${OPTARG}"
                echo "#!/usr/bin/env xdg-open" > ${out_path}
                echo "[Desktop Entry]" >> ${out_path}
                ;;
            v)
            	echo "Version=${OPTARG}" >> ${out_path}
            	;;
            t)
            	echo "Type=${OPTARG}" >> ${out_path}
            	;;
            n)
            	echo "Name=${OPTARG}" >> ${out_path}
            	;;
            i)
            	echo "Icon=${OPTARG}" >> ${out_path}
            	;;
            e)
            	echo "Exec=${OPTARG}" >> ${out_path}
            	;;
            c)
            	echo "Categories=${OPTARG}" >> ${out_path}
            	;;
            S)
            	echo "StartupNotify=${OPTARG}" >> ${out_path}
            	;;
            T)
            	echo "Terminal=${OPTARG}" >> ${out_path}
            	;;
            *)
                ;;
        esac
    done
    shift $((OPTIND-1))
    chmod 755 ${out_path}
}

# function INSTALL_ICON(){
# 	src_desktop=${1}
# 	dts_desktop=${2}
# 	icon_path=${3}
# 	exec_path=${4}

# 	if [ -z "$src_desktop" ];then
# 		return
# 	fi

# 	cp ${src_desktop} ${dts_desktop}

# 	if [ -d "${dts_desktop}" ];then
# 		name=$(basename ${src_desktop})
# 		dts_desktop="${dts_desktop}/${name}"
# 	fi

# 	sed -i s/'\${icon}'/${icon_path//"/"/"\/"}/g ${dts_desktop}
# 	sed -i s/'\${path}'/${exec_path//"/"/"\/"}/g ${dts_desktop}
# }