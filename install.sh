#!/bin/bash
# install.sh - GitHub deployable version
echo "Installing Sample Application v3.0.0 from GitHub..."

APP_DIR="/opt/sample-app"
mkdir -p "$APP_DIR"

cat > "$APP_DIR/app.sh" <<'APP'
#!/bin/bash
echo "========================================="
echo "Sample Application v3.0.0"
echo "========================================="
echo "Deployed from: GitHub Public Repository"
echo "New Features:"
echo "  - GitHub-based deployment"
echo "  - Auto-update capability"
echo "  - Enhanced logging"
echo "========================================="
echo "Status: Running"
echo "Timestamp: $(date)"
echo "Version: 3.0.0"
echo "========================================="
APP

chmod +x "$APP_DIR/app.sh"

# Update systemd service
cat > /etc/systemd/system/sample-app.service <<'SERVICE'
[Unit]
Description=Sample Application v3 (GitHub)
After=network.target

[Service]
Type=oneshot
ExecStart=/opt/sample-app/app.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable sample-app.service
systemctl restart sample-app.service

echo "✓ Installation complete: v3.0.0"
