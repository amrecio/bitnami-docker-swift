#!/bin/bash -e
. /opt/bitnami/base/functions

print_welcome_page
check_for_updates &

#set app name to ENV or default
SWIFT_APP="my-app"
COMMAND="$@"

if [ "$APP_NAME" != "" ]; then
  SWIFT_APP=$APP_NAME
fi

PROJECT_DIRECTORY=/app/$SWIFT_APP

app_present() {
  [ -d $PROJECT_DIRECTORY ]
}

if [ "$1" == "swift" -a "$2" == "app" -a "$3" == "start" ]; then
  if ! app_present; then
    log "Creating example Swift application"
    mkdir $PROJECT_DIRECTORY
    cd $PROJECT_DIRECTORY
    swift-package init --type executable
    swift build
    log "Swift app created"
  else
    log "App already created"
    cd $PROJECT_DIRECTORY
    swift build
  fi
  COMMAND=$PROJECT_DIRECTORY/.build/debug/$SWIFT_APP
fi

exec tini -- $COMMAND
