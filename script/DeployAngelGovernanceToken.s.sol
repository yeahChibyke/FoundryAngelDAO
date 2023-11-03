// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.9.0;

import {Script} from "forge-std/Script.sol";
import {AngelGovernanceToken} from "../src/AngelGovernanceToken.sol";

contract DeployAngelGovernanceToken is Script {
    function run() external returns (AngelGovernanceToken) {
        vm.startBroadcast();
        AngelGovernanceToken angelGovernanceToken = new AngelGovernanceToken();
        vm.stopBroadcast();
        return angelGovernanceToken;
    }
}
