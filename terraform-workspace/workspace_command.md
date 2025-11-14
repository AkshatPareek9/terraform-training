# Terraform workspace commmand

### List the workspace
```
terraform workspace list
```
*Note: default will  be there only*
 
### Check the state of default workspace
```
terraform state list
```

### Create a new workspace 
```
terraform workspace new dev
```

### Switch to dev workspace
```
terraform workspace select dev
```

### Check the states of dev workspace
```
terraform state list
```
*Note: nothing will show, as it is new workspace*
