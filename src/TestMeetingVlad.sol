pragma solidity ^0.4.18;

contract TestMeetingVlad {

  address owner;
  string meetingDescription;
  Participant[] public participants;

  struct Participant {
    uint256 passportNumberHash;
  }

  // добавление участника по паспорту
  function registrationParticipantByPassportNumber(uint passportNumber) public {
    if (participants.length != 0) {
      for (uint256 i = 0; i < participants.length; i++) {
        require(participants[i].passportNumberHash != uint256(keccak256(passportNumber)));
      }
    }
    participants.push(Participant(uint256(keccak256(passportNumber))));
  }


  // метод для тестирования количества участников
  function getCountParticipants() public constant returns (uint) {
    return participants.length;
  }

  // проверка того, что участник зарегистрирован на определенную встречу по паспорту
  function isParticipantByPassport(uint256 passportNumber) public constant returns (bool) {
    if (participants.length != 0) {
      for (uint256 i = 0; i < participants.length; i++) {
        if (participants[i].passportNumberHash == uint256(keccak256(passportNumber))) {
          return true;
        }
      }
    }
    return false;
  }

  // конструктор
  function TestMeetingVlad() public {
    owner = msg.sender;
  }

  // регистрация произвольного текста
  function setMeetingDescription(string value) public {
    require(msg.sender == owner);
    meetingDescription = value;
  }

  function getMeetingDescription() public constant returns (string) {
    return meetingDescription;
  }
}
