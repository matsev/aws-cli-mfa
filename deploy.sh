#!/usr/bin/env bash

set -e


script=$(basename $0)
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
region="eu-west-1"
stackName="aws-cli-mfa"

usage="usage: $script [-h|-r]
    -h| --help      this help
    -r| --region    AWS region (defaults to '$region')"

#
# For Bash parsing explanation, please see https://stackoverflow.com/a/14203146
#
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -h|--help)
        echo "$usage"
        exit 0
        ;;
        -r|--region)
        region="$2"
        shift
        ;;
        *)
        # Unknown option
        ;;
    esac
    shift # past argument or value
done

aws cloudformation update-stack \
    --template-body file://${scriptDir}/aws-cli-mfa.yaml \
    --region ${region} \
    --stack-name ${stackName} \
    --capabilities CAPABILITY_NAMED_IAM