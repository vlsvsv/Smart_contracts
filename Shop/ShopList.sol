pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract ShopList {

   modifier onlyOwner() {
        require(msg.pubkey() == m_ownerPubkey, 101);
        _;
    }

    uint32 m_count;

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

    mapping(uint32 => Purchase) m_purchase;

    uint256 m_ownerPubkey;

    constructor(uint256 pubkey) public {
        require(pubkey != 0, 120);
        tvm.accept();
        m_ownerPubkey = pubkey;
    }


    function createPurchase(string purchaseName, uint32 purchaseNumber) public onlyOwner{
         tvm.accept();
         m_count++;
         m_purchase[m_count] = Purchase(m_count, purchaseName, purchaseNumber, now, false, 0);
    }


    function deletePurchase(uint32 purchaseID) public onlyOwner {
        require(m_purchase.exists(purchaseID), 102);
        tvm.accept();
        delete m_purchase[purchaseID];
    }


    function updatePurchase(uint32 purchaseID, uint32 purchasePrice) public onlyOwner {
        optional(Purchase) purchase  = m_purchase.fetch(purchaseID);
        require(purchase .hasValue(), 102);
        tvm.accept();
        Purchase thisPurchase = purchase.get();
        thisPurchase.isBought = true;
        thisPurchase.price = purchasePrice;
        m_purchase[purchaseID] = thisPurchase;
    }


    function getPurchases() public view returns (Purchase[] purchases) {
        string name;
        uint32 quantity;
        uint32 timestamp;
        bool isDone; 
        uint32 price;

        for((uint32 id, Purchase purchase) : m_purchase) {
            name = purchase.name;
            isDone = purchase.isDone;
            quantity = purchase.quantity;
            timestamp = purchase.timestamp;
            price = purchase.price;
            purchases.push(Purchase(id, name, quantity,timestamp, isDone,price));
       }
    }

    function getSumPurchase() public view returns (SumPurchase sumPurchase) {
        uint32 paidFor;
        uint32 unpaidt;
        uint32 sumpricepaid;

        for((, Purchase purchase) : m_purchase) {
            if  (purchase.isDone) {
                paidFor += purchase.quantity;
                sumpricepaid += purchase.price;
            } else {
                unpaidt ++;
            }
        }
        sumPurchase = SumPurchase( paidFor, unpaidt, sumpricepaid);
    }

  
}