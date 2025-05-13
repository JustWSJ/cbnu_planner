//  건물 목록 데이터
// 📌 아래 형식으로 계속 추가하세요
// Building(name: '건물명', location: LatLng(위도, 경도)),
import '../models/building.dart';
import 'package:latlong2/latlong.dart';

final List<Building> buildingList = [
  Building(name: '미래창조관', location: LatLng(36.628373, 127.456287)),
  Building(name: '전자정보대학', location: LatLng(36.628754, 127.459352)),
  Building(name: '도서관', location: LatLng(36.627653, 127.457817)),
  Building(name: '공과대학1호관', location: LatLng(36.629000, 127.457000)),
  Building(name: '글로벌라운지', location: LatLng(36.628600, 127.455000)),
];
