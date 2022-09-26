#!/bin/bash
echo $VERSION
IFS='.' read -a array <<< "$VERSION"

forge_install() {
  java -jar forge.jar --installServer
  rm forge.jar
  cd ${SERVER_PATH} || exit
  if [ ${array[1]} -gt 16 ]; then
      sh ./run.sh nogui
  else
      java -Xms${MIN_RAM} -Xmx${MAX_RAM} -jar $MOD_LOADER
  fi
  sleep 1
  sed -i "s|false|true|g" ${SERVER_PATH}/eula.txt
  if [ ${array[1]} -gt 16 ]; then
      sed -i "/# -Xmx4G/i\-Xmx${MAX_RAM} -Xms${MIN_RAM}" ${SERVER_PATH}/user_jvm_args.txt
      chmod +x ./run.sh
  else
      echo "#!/bin/sh
      java -Xmx${MAX_RAM} -Xms${MIN_RAM} -jar ${SERVER_PATH}/${MOD_LOADER}.jar" >> ${SERVER_PATH}/run.sh
      chmod +x ./run.sh
  fi
}

farbic_install() {
    java -jar farbic.jar
    cd ${SERVER_PATH} || exit
    echo "#!/bin/sh
    java -Xmx${MAX_RAM} -Xms${MIN_RAM} -jar ${SERVER_PATH}/${MOD_LOADER}.jar" >> ${SERVER_PATH}/run.sh
    chmod +x ./run.sh
    sh ./run.sh nogui
    sleep 1
    sed -i "s|false|true|g" ${SERVER_PATH}/eula.txt
}

main() {
  if [ $MOD_LOADER == forge ]; then
    forge_install
  elif [ $MOD_LOADER == farbic ]; then
    farbic_install
  else
    echo "Wrang loader ${MOD_LOADER} type, please check your compose file!"
    exit -1
  fi
}

main
exit 0