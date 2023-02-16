//*Week 11 assignment 2
//write  smart contract that do the following
//This contract will be a school system which can do this things and more.
//Register a student with at least 5 information of the student 
//Only 3 person from the school can register the student 
//Keep track of student performance in class 1,2 and 3 
//Before  a student is register he or she must have paid school fees (build a token or use ETH)
//Only one person can withdraw the school fees from the smart contract 
//Have a function to remove a student from the school
//etc( you can have other functionality )

//Note Using Hardhat or Foundry to Deploy and verify/publish your contract write a basic test 
//using hardhat or Foundry.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

    error notAdmin(string _message);

contract Registration{
    struct Student{
        string firstName;
        string lastName;
        uint256 class;
        uint256 studentID;
    }
    struct Registrars{
        string name;
        address wallet;
        uint256 id;
    }
    constructor(){
        owner = msg.sender;
        studentCount =0;
    }
    mapping(uint256=>Registrars) officeAdmins;
    address[] private registeredAdmins;
    mapping(uint256 => Student) registeredStudents;
    uint256 private studentCount;
    address private owner;
    string[] private class1;
    string[] private class2;

    modifier adminCompliance() {
        require(registeredAdmins.length <=3, "Number of admins exceeded");
        _;
    }
    modifier onlyAdmins(){
        for(uint256 i;i < registeredAdmins.length;i++){
            if(msg.sender!=registeredAdmins[i]){
                revert notAdmin("Sorry only admins can call this function");
            }
            _;
        }
    }
    modifier onlyOwner(){
        require(
            msg.sender ==owner,
            "Only the principal and school admins can call this function"
        );
        _;
    }
    function registerAdmins(
        string memory _name,
        address _wallet,
        uint _id
    )public adminCompliance onlyOwner{
        Registrars memory admin = Registrars({
            name:_name,
            wallet:_wallet,
            id:_id
        });

        officeAdmins[_id]=admin;
        registeredAdmins.push(admin.wallet);
    }
    //this function registers a student and add the student to their respective classses
    function registerStudents(
        string memory _firstName,
        string memory _lastName,
        uint256 _class,
        uint256 _studentID
    ) public onlyOwner onlyAdmins{
        require(_class & _studentID > 0, "class and studentID can not be zero");
        Student memory student = Student({
            firstName: _firstName,
            lastName: _lastName,
            class:_class,
            studentID:_studentID
        });

        registeredStudents[_studentID] = student;

        if(student.class ==1){
            class1.push(student.firstName);
        }else {
            class2.push(student.firstName);
        }
        studentCount++;
        }
        function getOfficeAdmins(
            uint256 _id
        )public view returns (Registrars memory){
            return officeAdmins[_id];
        }
        function getRegisteredStudents(
            uint256 _id
        )public view returns (Student memory){
            return registeredStudents[_id];
        }
        function getStudentCount() external view returns (uint256){
            return studentCount;
        }
        function getClass1Students() external view returns (string[]memory){
            return class1;
        }
        function getClass2Students() external view returns (string[]memory){
            return class2;
        }
    }
















