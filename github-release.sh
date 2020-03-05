#!/usr/bin/env bash
#!/usr/bin/env bash -x

# usage:
## install software:
### apt update  -yqq
### apt install -yqq jq curl
## perform release:
### GITHUB_TOKEN=$githubToken ./github-release.sh "$messageBody"
### ./github-release.sh "$messageBody" $githubToken
### GITHUB_TOKEN=$githubToken ./github-release.sh "`cat ./README.md`"

# private API:
## verify if required software has been installed:
function check_required_binaries() {
  ### jq
  jq --version >/dev/null
  if [[ $? -ne 0 ]] ; then
    echo "required binary: `jq` binary not found."
    exit 1;
  fi
  ### curl
  curl --version >/dev/null
  if [[ $? -ne 0 ]] ; then
    echo "required binary: `curl` binary not found."
    exit 2;
  fi
  ### git
  git --version >/dev/null
  if [[ $? -ne 0 ]] ; then
    echo "required `git` binary not found."
    exit 3;
  fi
  ### xargs
  #echo " test xargs " | xargs >/dev/null
  echo "helloi" | sed "s/hello//g" >/dev/null
  if [[ $? -ne 0 ]] ; then
    #echo "required `xargs` binary not found."
    echo "required `sed` binary not found."
    exit 4;
  fi
}
## usage
function usage() {
  echo '  Usage:
    GITHUB_TOKEN=$githubToken ./github-release.sh "$messageBody"
    # reads github token from ${GITHUB_TOKEN} environment variable.
  or:
    ./github-release.sh "$messageBody" $githubToken
    # otherwise reads github token from second argument.
  or:
    GITHUB_TOKEN=$githubToken ./github-release.sh "`cat ./path/to/RELEASE_NOTES.txt`"
    # last one depends on content, but does not really worked with big files
    # and complex formats, such as markdown, asciidoctor, etc...
  NOTE: replace your $messageBody and $githubToken values.'
}
## verify value by passing argument name as 1st param and argument value itself as 2nd parameter:
counter=0
function check_required_arguments() {
  let "counter+=1"
  name=${1:-"arg${counter}"}
  arg=${2:-}
  #echo "${counter}: $1=$2"
  if [[ -z "${arg}" ]] || [[ ".${arg}" == ".undefined" ]] ; then
    echo "${counter}: ${name} is required!"
    usage
    exit 5;
  fi
}
## returns github release data to be posted on release:
function github_release_data() {
  cat <<EOF
{
  "tag_name": "v${version:-undefined}",
  "target_commitish": "${branch:-undefined}",
  "name": "v${version:-undefined}",
  "body": "${messageBody:-undefined}",
  "draft": ${GITHUB_DRAFT:-false},
  "prerelease": ${GITHUB_PRERELEASE:-false}
}
EOF
}
## parse message body or github token:
function parseString() {
  echo "${1:-undefined}";
  #echo "${1:- }" | xargs;
  #echo "${1:- }" | sed "s/  */ /g" | sed "s/^ *//g" | sed "s/ *$//g";
}

# main:
## validations:
check_required_binaries
## body:
messageBody="$(parseString "${1:-undefined}")"
check_required_arguments messageBody "${messageBody}"
## token:
githubToken="$(parseString "${GITHUB_TOKEN:-"${2:-undefined}"}")"
check_required_arguments githubToken "${githubToken}"
## debug request:
echo "$(github_release_data)"
## release:
branch="$(git rev-parse --abbrev-ref HEAD)"
repositoryName="$(git config --get remote.origin.url | sed 's/.*github.com://;s/.git$//')"
version=`cat package.json | jq -r ".version"`
## perform release
echo "Release ${branch} branch of ${repositoryName} v${version}"
curl --data "$(github_release_data)" "https://api.github.com/repos/${repositoryName}/releases?access_token=${githubToken}"
#echo $?
