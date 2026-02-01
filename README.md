# Infrastructure Environment – DEV

This repository contains the **DEV** environment configuration for applications managed via GitOps.

## Structure

| Path | Description |
|------|-------------|
| `values/devops-project/values.yaml` | Application values (Helm/Kustomize) |
| `k8s/devops-project/` | Kubernetes manifests (Deployment, Service) |

---

## GitOps Process

After merging a PR to this repository:

1. ArgoCD detects the new commit
2. Auto-sync is triggered
3. New application version is rolled out to `environment-dev` namespace

---

## Promotion to TEST

The `promote-to-test` workflow automatically:

1. Reads current image tag from `values/devops-project/values.yaml`
2. Updates the same tag in `infrastructure-env-test` repository
3. Creates a Pull Request to TEST
4. After PR merge → ArgoCD TEST performs rollout

> **Note:** Workflow logic is defined in [ci-cd-templates/promote-environment.yml](https://github.com/Adrian-CICD-Project/ci-cd-templates/blob/main/.github/workflows/promote-environment.yml)

---

## Related Repositories

| Repository | Purpose |
|------------|---------|
| `devops-project` | Application source code |
| `ci-cd-templates` | Centralized CI/CD workflow templates |
| `infrastructure-env-test` | Promotion target |
