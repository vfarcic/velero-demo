#!/usr/bin/env nu

def apply_velero [provider: string, storage_name: string] {

    if $provider == "aws" {

        (
            velero install --provider aws
                --plugins velero/velero-plugin-for-aws:v1.10.0
                --bucket $storage_name
                --backup-location-config region=us-east-1
                --snapshot-location-config region=us-east-1
                --secret-file ./aws-creds.conf --output yaml
        )

    } else if $provider == "google" {

        (
            velero install --provider gcp
                --plugins velero/velero-plugin-for-gcp:v1.11.0
                --bucket $storage_name
                --secret-file ./google-creds.json --output yaml
        )

    } else {

        print $"(ansi red_bold)($provider)(ansi reset) is not a supported."
        exit 1

    }

}
