pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract QueueShop {

	string[] public queueArray;
    
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

    function getInQueue (string member) public checkOwnerAndAccept {
        queueArray.push(member);
    }

    function getOfQueue () public checkOwnerAndAccept {
        queueArray.pop();
    }
}