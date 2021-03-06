#!/bin/bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#               http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/testConfig.sh"

# from testConfig.sh
#URL=
#ADMIN_USER=
#ADMIN_PASSWORD=
#ORG=
#APP=
#AUTH_TYPE=
#TOKEN_TYPE=
#CREATE_ORG=
#CREATE_APP=
#LOAD_ENTITIES=
#SANDBOX_COLLECTION=
#NUM_ENTITIES=
#SKIP_SETUP=
#COLLECTION=
#ENTITY_SEED=
#SEARCH_QUERY=
#SEARCH_LIMIT=  #may be overridden on command line
#END_CONDITION_TYPE=
#END_MINUTES=
#END_REQUEST_COUNT=
#CONSTANT_USERS_PER_SEC=
#CONSTANT_USERS_DURATION=

die() { echo "$@" 1>&2 ; exit 1; }

[ "$#" -ge 2 ] || die "At least 2 arguments required, $# provided.  Example is $0 RAMP_USERS RAMP_TIME(seconds) [SEARCH_LIMIT]"

RAMP_USERS="$1"
RAMP_TIME="$2"
[ "$#" -ge 3 ] && SEARCH_LIMIT="$3"

shift $#

SCENARIO_TYPE=getAllByCursor

#Compile everything
mvn compile

#Execute the test
mvn gatling:execute \
-DbaseUrl=${URL} \
-DadminUser=${ADMIN_USER}  \
-DadminPassword=${ADMIN_PASSWORD}  \
-Dorg=${ORG} \
-Dapp=${APP} \
-DauthType=${AUTH_TYPE} \
-DtokenType=${TOKEN_TYPE} \
-DcreateOrg=${CREATE_ORG} \
-DcreateApp=${CREATE_APP} \
-DloadEntities=${LOAD_ENTITIES} \
-DsandboxCollection=${SANDBOX_COLLECTION} \
-DnumEntities=${NUM_ENTITIES} \
-DskipSetup=${SKIP_SETUP} \
-Dcollection=${COLLECTION} \
-DentitySeed=${ENTITY_SEED} \
-DsearchQuery=${SEARCH_QUERY} \
-DsearchLimit=${SEARCH_LIMIT} \
-DendConditionType=${END_CONDITION_TYPE} \
-DendMinutes=${END_MINUTES} \
-DendRequestCount=${END_REQUEST_COUNT} \
-DconstantUsersPerSec=${CONSTANT_USERS_PER_SEC}    \
-DconstantUsersDuration=${CONSTANT_USERS_DURATION}    \
-DscenarioType=${SCENARIO_TYPE} \
-DrampUsers=${RAMP_USERS}  \
-DrampTime=${RAMP_TIME}  \
-DprintFailedRequests=${PRINT_FAILED_REQUESTS} \
-Dgatling.simulationClass=org.apache.usergrid.simulations.ConfigurableSimulation

