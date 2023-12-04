# "Changes between Tags" Action

[![Action on GitHub Marketplace](https://img.shields.io/badge/action-marketplace-orange.svg?logo=github)](https://github.com/marketplace/actions/changes-between-tags)
[![GitHub latest Release](https://img.shields.io/github/v/release/simbo/changes-between-tags-action?logo=github)](https://github.com/simbo/changes-between-tags-action/releases)

A GitHub action to collect all changes between two git tags and provides them
for further usage in a release description, a changelog entry or something
similar.

---

<!-- TOC depthFrom:2 anchorMode:github.com -->

- [About](#about)
- [Usage](#usage)
  - [Inputs](#inputs)
  - [Outputs](#outputs)
  - [Example](#example)
- [License](#license)

<!-- /TOC -->

---

## About

This action collects all git commit messages between two git tags and provides
them for further usage.

It uses the repository in the current working directory and fetches all tags
from the origin remote.

A regex pattern `tag-pattern` can be defined to filter tags. Matching tags will
be sorted and the latest two tags are taken for comparison.

The action will fail if no matching tags are found.

If only one matching tag is found, the changes from the initial commit to this
tag will be collected.

The action is meant to be run on a
[`push:tags`](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#running-your-workflow-only-when-a-push-of-specific-tags-occurs)
event.

## Usage

### Inputs

| Name                 | Description                                                                               | Required | Default                       |
| -------------------- | ----------------------------------------------------------------------------------------- | -------- | ----------------------------- |
| `tag-pattern`        | the regex pattern to filter tags                                                          | No       | `'^v[0-9]+\.[0-9]+\.[0-9]+$'` |
| `validate-tag`       | whether to check if the determined latest tag is the same tag that triggered the workflow | No       | `'true'`                      |
| `include-tag-commit` | whether to include the commit with the current tag                                        | No       | `'true'`                      |
| `include-hashes`     | whether or not each commit message should be prefixed with the corresponding hash         | No       | `'true'`                      |
| `line-prefix`        | the prefix to add to every listed commit                                                  | No       | `'- '`                        |

### Outputs

| Name      | Description                                         |
| --------- | --------------------------------------------------- |
| `changes` | collected changes as multiline string               |
| `tag`     | the current/latest tag that was used for comparison |
| `ref`     | the git reference that the tag was compared with    |

### Example

```yml
on:
  push:
    tags:
      - v*

jobs:
  ci:
    runs-on: ubuntu-22.04

    steps:
      - name: 🛎 Checkout
        uses: actions/checkout@v4

      - name: 📋 Get Changes between Tags
        id: changes
        uses: simbo/changes-between-tags-action@v1

      - name: 📣 Output collected Data
        run: |
          echo "tag: ${{ steps.changes.outputs.tag }}"
          echo "ref: ${{ steps.changes.outputs.ref }}"
          echo "changes:"
          echo "${{ steps.changes.outputs.changes }}"
```

## License

[MIT &copy; 2023 Simon Lepel](http://simbo.mit-license.org/2023/)
