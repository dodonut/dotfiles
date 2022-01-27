#!/usr/bin/env bash

# snapshots - https://download.eclipse.org/jdtls/snapshots/?d
# lombok - https://projectlombok.org/download
JAR="$HOME/dev/source-proj/jdt/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$GRADLE_HOME/bin/gradle $JAVA_HOME/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -javaagent:$HOME/dev/source-proj/jdt/plugins/lombok.jar \
  -jar $(echo "$JAR") \
  -configuration "$HOME/dev/source-proj/jdt/config_linux" \
  -data "${1:-$HOME/workspace}" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
