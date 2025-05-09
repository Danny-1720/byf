#!/bin/bash

APP_DIR="/opt/nudgeengine"
ZIP_URL=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/app-zip-url" -H "Metadata-Flavor: Google")

mkdir -p $APP_DIR
gsutil cp "$ZIP_URL" "$APP_DIR/app.zip"
unzip -o "$APP_DIR/app.zip" -d $APP_DIR

cp $APP_DIR/deploy/scripts/nudgeengine.service /etc/systemd/system/
systemctl daemon-reexec
systemctl enable nudgeengine
systemctl restart nudgeengine
