# wonderland2-deploy-github-action

A GitHub action to deploy services to Wonderland2

## How to use it

1. Provide a valid Wonderland 2 manifest
2. Add a `WONDERLAND_GITHUB_TOKEN` and `BASTION_KEY` to your repository secrets
3. Add this step to your deployment job

```yaml
- name: Deploy to Wonderland 2
  uses: Jimdo/wonderland2-deploy-github-action@main
  with:
    token: ${{ secrets.WONDERLAND_GITHUB_TOKEN }}
    bastion_key: ${{ secrets.BASTION_KEY }}
    wonderland_manifest: wonderland2.yaml
```

## Inputs

### wonderland_manifest

The Wonderland 2 manifest file (default: **wonderland2.yaml**)

### bastion_key

**required** Ssh key for authentication in the bastion host (`secrets.BASTION_KEY`)

### token

**required** A GitHub token to use with wonderland (`secrets.WONDERLAND_GITHUB_TOKEN`)
