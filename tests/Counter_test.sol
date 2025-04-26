// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // Import for Remix testing
import "hardhat/console.sol"; // Import for console logging
import "../contracts/Counter.sol"; // Adjust path if needed

contract CounterTest {

    Counter counter;

    // This function runs before all other tests
    function beforeAll() public {
        counter = new Counter();
    }

    function testInitialCountIsZero() public {
        console.log("Checking if initial count is 0");
        Assert.equal(counter.get(), uint(0), "Initial count should be 0");
    }

    function testIncrement() public {
        console.log("Testing increment function");
        counter.inc();
        Assert.equal(counter.get(), uint(1), "Count should be 1 after one increment");
    }

    function testDecrement() public {
        console.log("Testing decrement function");
        counter.dec();
        Assert.equal(counter.get(), uint(0), "Count should be 0 after one increment and one decrement");
    }

    function testDecrementBelowZeroShouldFail() public {
        console.log("Testing that decrementing below zero should fail");

        try counter.dec() {
            Assert.ok(false, "Should not be able to decrement below zero");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Counter: cannot decrement below zero", "Expected revert message");
        } catch {
            Assert.ok(false, "Unexpected error type");
        }
    }

    function testReset() public {
        console.log("Testing reset function");
        counter.inc();
        counter.inc();
        counter.reset();
        Assert.equal(counter.get(), uint(0), "Count should be reset to 0");
    }
}
