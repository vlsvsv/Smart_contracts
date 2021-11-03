
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Test {
    int value1 = 10;
    function testUint(int value) public returns (int) {
        return value1 - value;
    }
}
