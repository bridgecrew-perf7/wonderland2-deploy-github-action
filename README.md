# wonderland2-deploy-github-action

A GitHub action to deploy or delete services to Wonderland2.

*For infos how to release a new version have a look at [How to
release][htr]*

[htr]: #how-to-release

## How to use it

1. Provide a valid Wonderland 2 manifest
2. Add a `WONDERLAND_GITHUB_TOKEN` and `BASTION_KEY` to your repository secrets
3. Add this step to your deployment job

```yaml
- name: Deploy to Wonderland 2
  uses: Jimdo/wonderland2-deploy-github-action@v0.1.0
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

## How to release

- Choose a new version number
- Update README example with new version number
- Go to [draft a new release][dnr]
- Create the new version number
- Put the version number in the title
- Press `Auto-generate release notes`
- Press `Publish release`
- Done

[dnr]: https://github.com/Jimdo/wonderland2-deploy-github-action/releases/new
