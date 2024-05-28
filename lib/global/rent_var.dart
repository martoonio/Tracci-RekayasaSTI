class RentVar {
  final int id;
  final String name;
  final int phoneNum;
  final String dateStart, dateEnd;

  RentVar({
    required this.id,
    required this.name,
    required this.phoneNum,
    required this.dateStart,
    required this.dateEnd,
  });
}

// Our demo RentVars

List<RentVar> demoRentVars = [
  RentVar(
    id: 1,
    name: "Farchan",
    phoneNum: 123456789,
    dateStart: "2022-10-10",
    dateEnd: "2022-10-20",
  ),
  RentVar(
    id: 2,
    name: "Martha",
    phoneNum: 123456789,
    dateStart: "2022-10-10",
    dateEnd: "2022-10-20",
  ),
  RentVar(
    id: 3,
    name: "Adji",
    phoneNum: 123456789,
    dateStart: "2022-10-10",
    dateEnd: "2022-10-20",
  ),
  RentVar(
    id: 4,
    name: "Chandra",
    phoneNum: 123456789,
    dateStart: "2022-10-10",
    dateEnd: "2022-10-20",
  ),
];
