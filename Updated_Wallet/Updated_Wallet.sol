
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Updated_Wallet {
    /*
     Exception codes:
      100 - message sender is not a wallet owner.
      101 - invalid transfer value.
     */

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		_;
	}

 
    function sendTransactionWithoutCommission(address dest, uint128 value) public pure checkOwnerAndAccept {
        tvm.accept();
        dest.transfer(value, true, 0);
    }

    function sendTransactionWithCommissionAtYourOwn(address dest, uint128 value) public pure checkOwnerAndAccept {
        tvm.accept();
        dest.transfer(value, true, 1);
    }

    function sendTransactionOfAllMoneyAndDestroyWallet(address dest) public pure checkOwnerAndAccept {
        tvm.accept();
        dest.transfer(1, true, 160);
    }
}
