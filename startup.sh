 #!/bin/bash
        APP_DIR="/opt/nudgeengine"
        ZIP_URL="gs://byf-bucket/nudgeengine/releases/${_VERSION}-app.zip"
        
        mkdir -p \$APP_DIR
        gsutil cp \$ZIP_URL \$APP_DIR/app.zip
        unzip -o \$APP_DIR/app.zip -d \$APP_DIR
        
        cp \$APP_DIR/deploy/scripts/nudgeengine.service /etc/systemd/system/
        chmod +x \$APP_DIR/src/run.sh
        
        systemctl daemon-reexec
        systemctl enable nudgeengine
        systemctl start nudgeengine
