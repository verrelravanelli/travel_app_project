import 'package:get/get.dart';

class PilihSeatController extends GetxController {
  var indexKursi = 0.obs;
  var userSelectedSeat = [].obs;

  void SelectSeat(int indexKursiTerpilih) {
    if (seat[0][indexKursiTerpilih]["status"] == "available") {
      seat[0][indexKursiTerpilih].update("status", (value) => "selected");
      userSelectedSeat.add(seat[0][indexKursiTerpilih]["id"]);
      userSelectedSeat.refresh();
      List.from(userSelectedSeat);
      print(userSelectedSeat);
    } else if (seat[0][indexKursiTerpilih]["status"] == "selected") {
      seat[0][indexKursiTerpilih].update("status", (value) => "available");
      userSelectedSeat.remove(seat[0][indexKursiTerpilih]["id"]);
      userSelectedSeat.refresh();
      print(userSelectedSeat);
    }
    seat.refresh();
  }

  var seat = List.generate(
    1,
    (indexRow) => List<Map<String, dynamic>>.generate(
      20,
      (indexBangku) {
        if (indexRow == 0) {
          if (indexBangku >= 5 && indexBangku <= 9) {
            return {
              "id": "ID${indexRow + 1}-${indexBangku + 1}",
              "status": "available",
            };
          } else {
            return {
              "id": "ID${indexRow + 1}-${indexBangku + 1}",
              "status": "available",
            };
          }
        } else {
          return {
            "id": "ID${indexRow + 1}-${indexBangku + 1}",
            "status": "available",
          };
        }
      },
    ),
  ).obs;
}
