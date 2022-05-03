pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
pragma AbiHeader pubkey;
pragma AbiHeader time;



struct Purchase {
        uint32 ID;
        string name;
        uint32 number;
        uint32 timestamp;
        bool isBought;
        uint32 price;
    }
    

struct SumPurchase {
        uint32 itemsPaid;
        uint32 itemsUnpaid;
        uint32 amountPaid;
    }


interface Transactable {
    function sendTransaction(address dest, uint128 value, bool bounce, uint8 flags, TvmCell payload  ) external;
    }


abstract contract HasConstructorWithPubKey {
    constructor(uint256 pubkey) public {}
    }


//interface IShopList {
      function createPurchase(string nameP, uint32 quantityP) external;
      function updatePurchase(uint32 id, uint32 price) external;
      function deletePurchase(uint32 id) external;
      function getPurchases() external returns (Purchase[] purchasess);
      function getSumPurchase() external returns (SumPurchase );
}