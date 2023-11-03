// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {LockTokens} from "../src/LockTokens.sol";

contract LockTokensTest is Test {
  LockTokens lockTokens;
  function setUp() external {
    lockTokens = new LockTokens();
  }

  function testSwapRatioIsThirty() public {
    assertEq(lockTokens.swapRatio(), 30);
  }
}
