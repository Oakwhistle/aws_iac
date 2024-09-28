#!/bin/bash

folder=$1 
varfile=$2
#---Import checks script
. commons/checks.sh $folder $varfile

prepare_terrraform_remote_state_file