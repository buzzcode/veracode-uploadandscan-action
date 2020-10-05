#!/bin/sh -l

# default to false, so as to not create a new App Profile
createprofile=false

# parse the inputs
# note that this relies on every param having a value, even if it's the empty string
# this should be fine due to how this is called (from the action.yml)
while :; do
     case $1 in
          -appname) 
               appname=\"$2\"
               shift
               ;;
          -createprofile)
               if [ $2 = "true" ]; then
                    createprofile=true
               fi
               shift
               ;;
          -filepath)
               filepath=\"$2\"
               shift
               ;;
          -scan_name)
               scan_name=\"$2\"
               shift
               ;;
          -vid)
               vid=\"$2\"
               shift
               ;;
          -vkey)
               vkey=\"$2\"
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

echo "Calling Veracode Upload and Scan with:"
echo "    appname: $appname"
echo "    createprofile: $createprofile"
echo "    filepath: $filepath"
echo "    scan_name: $scan_name"
echo "    optional args: $opt_args"

# check for at least something in the filepath 
if [ -z $filepath ]; then
     echo "ERROR: filepath is not set.  Please fix this."
     exit 1
fi

# check for vid and vkey set
if [ -z $vid ] || [ -z $vkey ]; then     
     echo "ERROR: Veracode ID or Key not set.  Please fix this."
     exit 1
fi 

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
#      -autoscan true \
#      $opt_args
