# Sample Application v3.0.0

GitHub-deployable VM application

## Deploy to Azure VM:
```bash
az vm extension set \
  --resource-group YOUR_RG \
  --vm-name YOUR_VM \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/yourusername/your-repo/main/install.sh"], "commandToExecute": "bash install.sh"}'
```
