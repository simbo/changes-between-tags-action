#!/bin/bash
# ╔═══════════════════════════════════════════════════════╗
# ║                                                       ║
# ║  RELEASE VERSION SCRIPT                               ║
# ║  https://github.com/simbo/release-version-script      ║
# ║                                                       ║
# ╟───────────────────────────────────────────────────────╢
# ║                                                       ║
# ║  Author: Simon Lepel (https://simbo.de/)              ║
# ║  License: MIT (http://simbo.mit-license.org/)         ║
# ║                                                       ║
# ║  A simple yet convenient bash script to create a      ║
# ║  semantic version tag and push it to the git remote.  ║
# ║                                                       ║
# ╚═══════════════════════════════════════════════════════╝

# script version tag to use (available versions: https://github.com/simbo/release-version-script/tags)
VERSION=v1

script=$(curl -so- https://raw.githubusercontent.com/simbo/release-version-script/${VERSION}/release.sh)
if [[ "${script:0:3}" = "404" ]]; then
  t="${TERM:-"dumb"}"
  printf "\n$(tput -T$t setaf 1)ERROR: could not find version '${VERSION}'$(tput -T$t sgr0)"
  printf "\nSee ${b}${u}https://github.com/simbo/release-version-script/tags${x} for available versions.\n"
  exit 1
fi
bash -c "$script" -s $1
