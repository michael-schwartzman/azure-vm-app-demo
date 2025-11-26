#!/bin/bash
# install.sh - GitHub deployable version
echo "Installing Sample Application v4.0.0 from GitHub..."

APP_DIR="/opt/sample-app"
mkdir -p "$APP_DIR"

cat > "$APP_DIR/app.sh" <<'APP'
#!/bin/bash
echo "========================================="
echo "🚀 Sample Application v4.0.0"
echo "========================================="
echo "Deployed from: GitHub Public Repository"
echo ""
echo "✨ NEW in v4.0.0:"
echo "  - Health check endpoint"
echo "  - Performance monitoring"
echo "  - Automatic rollback support"
echo "  - JSON configuration support"
echo ""
echo "========================================="
echo "Status: ✓ Running"
echo "Timestamp: $(date)"
echo "Version: 4.0.0"
echo "Health: OK"
echo "Uptime: $(uptime -p)"
echo "========================================="
APP

chmod +x "$APP_DIR/app.sh"

# Create config file
cat > "$APP_DIR/config.json" <<'CONFIG'
{
  "version": "4.0.0",
  "features": {
    "health_check": true,
    "monitoring": true,
    "auto_rollback": true
  },
  "deployed_at": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"
}
CONFIG

# Update systemd service
cat > /etc/systemd/system/sample-app.service <<'SERVICE'
[Unit]
Description=Sample Application v4 (GitHub)
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

echo ""
echo "✅ Installation complete: v4.0.0"
echo "🔧 Config: $APP_DIR/config.json"
echo "🏃 Run: $APP_DIR/app.sh"
