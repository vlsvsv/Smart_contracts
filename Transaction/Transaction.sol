
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Transaction {

    uint32 public timestamp;


    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

        timestamp = now;
    }

    function renderHelloWorld () public pure returns (string) {
        return 'helloWorld';
    }

    function touch() external {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        timestamp = now;
    }

    function sendValue(address dest, uint128 amount, bool bounce, uint16 flag) public view {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        dest.transfer(amount, bounce, flag);
    }
}
