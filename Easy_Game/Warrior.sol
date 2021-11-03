pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
import "BattleUnit.sol";


contract Warrior is BattleUnit {
    
    uint static warriorAttack;
    uint static warriorDefense;

    address warriorAddress = address(this);

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        stats[warriorAddress] = statsOfObject(warriorDefense + baseUnitHealth, warriorAttack);
    }

    function getAttackOfUnit() public override onlyOwner returns(uint) {
        unitAddress = warriorAddress;
        return stats[unitAddress].attackOfObject;
    }

    function getDefenseOfUnit() public override onlyOwner returns(uint) {
        unitAddress = warriorAddress;
        return stats[unitAddress].defenseOfObject;
    }
    
    }