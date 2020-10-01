#!/bin/sh -l

# default to false, so as to not create a new App Profile
createprofile=false

# parse the inputs
while :; do
     echo $1
     echo $2
     echo checking...
     case $1 in
          -appname) 
               appname=$2
               shift
               ;;
          -createprofile)
               if [ $2 = "true" ]; then
                    createprofile=true
               fi
               shift
               ;;
          -filepath)
               filepath=$2
               shift
               ;;
          -scan_name)
               scan_name=$2
               shift
               ;;
          -vid)
               vid=$2
               shift
               ;;
          -vkey)
               vkey=$2
               shift
               ;;
          -opt_args)
               opt_args=$2
               shift
               ;;
          *)
               break
     esac
     shift
done


echo "appname: $appname"
echo "createprofile: $createprofile"
echo "filepath: $filepath"
echo "scan_name: $scan_name"
echo "optional args: $opt_args"

#below pulls latest wrapper version. alternative is to pin a version like so:
#javawrapperversion=20.8.7.1

javawrapperversion=$(curl https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/maven-metadata.xml | grep latest |  cut -d '>' -f 2 | cut -d '<' -f 1)

echo "javawrapperversion: $javawrapperversion"

# curl -sS -o VeracodeJavaAPI.jar "https://repo1.maven.org/maven2/com/veracode/vosp/api/wrappers/vosp-api-wrappers-java/$javawrapperversion/vosp-api-wrappers-java-$javawrapperversion.jar"
# java -jar VeracodeJavaAPI.jar \
#      -action UploadAndScan \
#      -appname "$appname" \
#      -createprofile "$createprofile" \
#      -filepath "$filepath" \
#      -version "$scan_name" \
#      -vid "$vid" \
#      -vkey "$vkey" \
#      -autoscan true $opt_args
