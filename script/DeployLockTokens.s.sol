// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.9.0;

import {Script} from "forge-std/Script.sol";
import {LockTokens} from "../src/LockTokens.sol";

contract DeployLockTokens is Script {
  function run() external returns(LockTokens) {
    vm.startBroadcast();
    LockTokens lockTokens = new LockTokens();
    vm.stopBroadcast();
    return lockTokens;
  }
}
