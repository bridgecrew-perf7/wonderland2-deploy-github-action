# wonderland2-deploy-github-action

A GitHub action to deploy or delete services to Wonderland2

## How to use it

1. Provide a valid Wonderland 2 manifest
2. Add a `WONDERLAND_GITHUB_TOKEN` and `BASTION_KEY` to your repository secrets
3. Add this step to your deployment job

```yaml
- name: Deploy to Wonderland 2
  uses: Jimdo/wonderland2-deploy-github-action@main
  with:
    token: ${{ secrets.WONDERLAND_CI_GITHUB_TOKEN }}
    bastion_key: ${{ secrets.WONDERLAND_CI_SSH_KEY }}
    wonderland_manifest: wonderland2.yaml
    timeout: 45s
```

## Inputs

### timeout

Maximum time to wait for the deployment to become available (default: **5m**)

### wonderland_manifest

The Wonderland 2 manifest file (default: **wonderland2.yaml**)

### bastion_key

**required** Ssh key for authentication in the bastion host (`secrets.BASTION_KEY`)

### token

**required** A GitHub token to use with wonderland (`secrets.WONDERLAND_GITHUB_TOKEN`)

### delete

set this to `"true"` if you intend to delete the service instead of deploying it 
