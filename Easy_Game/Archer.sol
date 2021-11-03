pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "BattleUnit.sol";


contract Archer is BattleUnit {
    
    uint static public archerAttack;
    uint static public archerDefense;

    address public archerAddress = address(this);

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        stats[archerAddress] = statsOfObject(archerDefense + baseUnitHealth, archerAttack);
            }

    function getAttackOfUnit() public override onlyOwner returns(uint) {
        unitAddress = archerAddress;
        return stats[unitAddress].attackOfObject;
    }

    function getDefenseOfUnit() public override onlyOwner returns(uint) {
        unitAddress = archerAddress;
        return stats[unitAddress].defenseOfObject;
    }
}