
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract TaskList {

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

    struct taskList {
        string taskName;
        uint32 addTime;
        bool taskFlag;
    }

    mapping (uint8=>taskList) tasks;

    uint32 addTime;
    uint8 public numTasks;


    function AddTask (string taskName, bool taskFlag) public checkOwnerAndAccept returns (uint8 taskID) {
        taskID = ++numTasks;
        addTime = now;
        tasks[taskID] = taskList(taskName,addTime,taskFlag);
    }
   
    function NumberOfTasks () public checkOwnerAndAccept returns (uint8 countOfTasks) {
        countOfTasks = numTasks;
    }

    function ListOfTasks () public checkOwnerAndAccept returns (string[] listOfTasks) {
        for (uint8 i = 1; i <= numTasks; i++){
            listOfTasks.push(tasks[i].taskName);
        }
    }

    function DescriptionOfTask (uint8 taskID) public checkOwnerAndAccept returns (string taskName, uint32 addTime, bool taskFlag){
        taskName = tasks[taskID].taskName;
        addTime = tasks[taskID].addTime;
        taskFlag = tasks[taskID].taskFlag;
    }

    function DeleteTask (uint8 taskID) public checkOwnerAndAccept {
        delete tasks[taskID];
    }

    function MarkTask (uint8 taskID) public checkOwnerAndAccept {
        tasks[taskID].taskFlag = true;
    }
}
