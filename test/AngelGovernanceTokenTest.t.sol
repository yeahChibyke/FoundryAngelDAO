// SPDX-License-Identifier: MIT

pragma solidity >= 0.6.0 < 0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {AngelGovernanceToken} from "../src/AngelGovernanceToken.sol";

contract AngelGovernanceTokenTest is Test {
  AngelGovernanceToken angelGovernanceToken;
  function setUp() external {
    angelGovernanceToken = new AngelGovernanceToken();
  }
}
