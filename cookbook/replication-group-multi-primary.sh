#!/bin/bash
# DBDeployer - The MySQL Sandbox
# Copyright © 2006-2018 Giuseppe Maxia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
cd $(dirname $0)
source cookbook_include.sh

version=$1
[ -z "$version" ] && version=5.7.23
check_version $version

if [ -n "$(dbdeployer sandboxes | grep 'group-multi-primary\s*'$version)" ]
then
    echo "group replication version $version is already installed"
else
    (set -x
    dbdeployer deploy replication $version --topology=group --concurrent
    )
fi
