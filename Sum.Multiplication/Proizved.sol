pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Proizvedenie {

	uint public proizved = 1;

	constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	
	function mult(uint value) public checkOwnerAndAccept {
		proizved *= value;
        require(value > 0 && value <= 10, 99);
	}
}