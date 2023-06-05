#!/usr/bin/env bash

# Verify the operation of "ctdb stop" and "ctdb continue"

. "${TEST_SCRIPTS_DIR}/integration.bash"

set -e

ctdb_test_init

select_test_node_and_ips

echo "Stopping node ${test_node}..."
try_command_on_node 1 $CTDB stop -n $test_node
wait_until_node_has_status $test_node stopped
wait_until_node_has_no_ips "$test_node"

echo "Continuing node $test_node"
try_command_on_node 1 $CTDB continue -n $test_node
wait_until_node_has_status $test_node notstopped
wait_until_node_has_some_ips "$test_node"
