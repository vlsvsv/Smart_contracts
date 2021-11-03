
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import "GameObjectInt.sol";

contract BattleUnit is GameObjectInt {

    uint public baseUnitHealth = 5;
    address attackerAddress;
    address unitAddress;


    struct statsOfObject{  // структура характеристик объекта
        uint defenseOfObject;
        uint attackOfObject;
    }
    
    mapping(address=>statsOfObject) stats; // связка адреса объекта с его характеристиками

    modifier onlyOwner {
        require(tvm.pubkey() != 0 && tvm.pubkey() == msg.pubkey());
        tvm.accept();
        _;
    }

    function takeAttack(address gameObjectAddress) external onlyOwner override {
        attackerAddress = msg.sender;
        stats[gameObjectAddress].defenseOfObject -= stats[attackerAddress].attackOfObject;
        if (checkAlive(gameObjectAddress) == false) deathHandling(attackerAddress);
    }

    function checkAlive(address gameObjectAddress) private onlyOwner view returns (bool objectAlive)  {
        if (stats[gameObjectAddress].defenseOfObject > 0) objectAlive = true;
        else objectAlive = false;
    }

    function deathHandling(address gameObjectAddress)  internal onlyOwner returns (string deathStatus) {
        if (stats[gameObjectAddress].defenseOfObject <= 0) {
            moneyTransferToWinner(attackerAddress);
            deathStatus = "Объект пал в битве. Все его богатства были захвачены противником.";
        } else deathStatus = "Объект пока еще в порядке и не потерял свои сокровища.";
    }

    function moneyTransferToWinner(address gameObjectAddress) internal pure onlyOwner {
        gameObjectAddress.transfer(1, true, 160);
    }

    function attackUnit(GameObjectInt gameObject) external onlyOwner{
        gameObject.takeAttack(gameObject);
    }

    function getAttackOfUnit() virtual public onlyOwner returns(uint) {
        return stats[unitAddress].attackOfObject;
    }

    function getDefenseOfUnit() virtual public onlyOwner returns(uint) {
        return stats[unitAddress].defenseOfObject;
    }

}

//0:b187f8e0b1a867c6342241a5f3655589c539b6de1c10ba89a389928698f372e2
//0:7b26782b3eef3a52a13b7c417de5b896946fa24b06cbca78242b4c6f2c77167c