//  건물 목록 데이터
// 📌 아래 형식으로 계속 추가하세요
// Building(name: '건물명', location: LatLng(위도, 경도)),
import '../models/building.dart';
import 'package:latlong2/latlong.dart';

/// 북(N) 구역 건물들
final List<Building> northBuildings = [
  Building(name: "법학전문대학원(N2)", location: LatLng(36.631918, 127.454300)), // N2
  Building(name: "산학협력관(N4)", location: LatLng(36.632529, 127.455171)), // N4
  Building(name: "평생교육원(N5)", location: LatLng(36.632069, 127.455791)), // N5
  Building(name: "고시원(N6)", location: LatLng(36.632463, 127.455539)), // N6
  Building(name: "형설관(N7)", location: LatLng(36.632781, 127.455692)), // N7
  Building(name: "보육교사교육원(N8)", location: LatLng(36.633166, 127.456518)), // N8
  Building(
      name: "언어교육관,보육교사교육원(N9)", location: LatLng(36.633248, 127.457065)), // N9
  Building(
      name: "대학 본부,국제교류원(N10)", location: LatLng(36.630075, 127.454613)), // N10
  Building(
      name: "공동실험실습관(N11)", location: LatLng(36.629283, 127.455252)), // N11
  Building(name: "중앙도서관(N12)", location: LatLng(36.628377, 127.457363)), // N12
  Building(name: "경영학관(N13)", location: LatLng(36.630032, 127.457019)), // N13
  Building(
      name: "인문사회관(강의동)(N14)", location: LatLng(36.630962, 127.456515)), // N14
  Building(
      name: "사회과학대학본관(N15)", location: LatLng(36.629750, 127.457736)), // N15
  Building(
      name: "인문대학본관(N16-1)", location: LatLng(36.629873, 127.458945)), // N16-1
  Building(
      name: "미술관(N16-2)", location: LatLng(36.630907, 127.457365)), // N16-2
  Building(
      name: "미술과(N16-3)", location: LatLng(36.630799, 127.458583)), // N16-3
  Building(
      name: "개성재 관리동(N17-2)", location: LatLng(36.631584, 127.457588)), // N17-2
  Building(
      name: "개성재(진리관)(N17-3)",
      location: LatLng(36.631094, 127.457736)), // N17-3
  Building(
      name: "개성재(정의관)(N17-4)",
      location: LatLng(36.631165, 127.458189)), // N17-4
  Building(
      name: "개성재(개척관)(N17-5)",
      location: LatLng(36.631533, 127.458446)), // N17-5
  Building(
      name: "계영원(N17-6)", location: LatLng(36.631892, 127.458621)), // N17-6
  Building(name: "법학관(N18)", location: LatLng(36.631027, 127.459334)), // N18
  Building(name: "제2본관(N19)", location: LatLng(36.630609, 127.459940)), // N19
  Building(
      name: "생활과학관(N20-1)", location: LatLng(36.630437, 127.460681)), // N20-1
  Building(name: "은하수식당(N21)", location: LatLng(36.629942, 127.460284)), // N21
  ];

/// 동(E) 구역 건물들
final List<Building> eastBuildings = [
  Building(name: "사범대학실험동(E1-1)", location: LatLng(0.0, 0.0)), // E1-1
  Building(name: "사범대학강의동(E1-2)", location: LatLng(0.0, 0.0)), // E1-2
  Building(name: "개신문화관(E2)", location: LatLng(0.0, 0.0)), // E2
  Building(name: "제1학생회관(E3)", location: LatLng(0.0, 0.0)), // E3
  Building(name: "NH관(E3-1)", location: LatLng(0.0, 0.0)), // E3-1
  Building(name: "실내체육관(E4-1)", location: LatLng(0.0, 0.0)), // E4-1
  Building(name: "운동장본부석(E4-2)", location: LatLng(0.0, 0.0)), // E4-2
  Building(name: "보조체육관(E4-3)", location: LatLng(0.0, 0.0)), // E4-3
  Building(name: "123학군단(E5)", location: LatLng(0.0, 0.0)), // E5
  Building(name: "특고변전실(E6)", location: LatLng(0.0, 0.0)), // E6
  Building(name: "의과대학(E7-1)", location: LatLng(0.0, 0.0)), // E7-1
  Building(name: "임상 연구동(E7-2)", location: LatLng(0.0, 0.0)), // E7-2
  Building(name: "의과대학2호관(E7-3)", location: LatLng(0.0, 0.0)), // E7-3
  Building(name: "공학관(E8-1)", location: LatLng(0.0, 0.0)), // E8-1
  Building(name: "합동강의실(E8-2)", location: LatLng(0.0, 0.0)), // E8-2
  Building(name: "건설공학관(E8-3)", location: LatLng(0.0, 0.0)), // E8-3
  Building(name: "제1공장동(E8-4)", location: LatLng(0.0, 0.0)), // E8-4
  Building(name: "제2공장동(E8-5)", location: LatLng(0.0, 0.0)), // E8-5
  Building(name: "토목공학관(E8-6)", location: LatLng(0.0, 0.0)), // E8-6
  Building(name: "공대공학관(E8-7)", location: LatLng(0.0, 0.0)), // E8-7
  Building(name: "공학지원센터(E8-8)", location: LatLng(0.0, 0.0)), // E8-8
  Building(name: "신소재재료실험실(E8-9)", location: LatLng(0.0, 0.0)), // E8-9
  Building(name: "제5공학관(E8-10)", location: LatLng(0.0, 0.0)), // E8-10
  Building(name: "학연산공동기술연구원(E9)", location: LatLng(0.0, 0.0)), // E9
  Building(name: "학연산공동 교육관(E10)", location: LatLng(0.0, 0.0)), // E10
  Building(name: "목장창고", location: LatLng(0.0, 0.0)), // E11-1
  Building(name: "우사", location: LatLng(0.0, 0.0)), // E11-2
  Building(name: "목장관리사", location: LatLng(0.0, 0.0)), // E11-3
  Building(name: "건조창고", location: LatLng(0.0, 0.0)), // E11-4
  Building(name: "동물자원연구지원센터", location: LatLng(0.0, 0.0)), // E11-5
  Building(name: "수의과대학2호관", location: LatLng(0.0, 0.0)), // E12-2
  Building(name: "수의과대학및동물의료센터", location: LatLng(0.0, 0.0)), // E12-1
  Building(name: "실험동물연구지원센터", location: LatLng(0.0, 0.0)), // E12-3
  ];

/// 남(S) 구역 건물들
final List<Building> southBuildings = [
  Building(
      name: "자연과학대학본관(S1-1)", location: LatLng(36.627764, 127.456824)), // S1-1
  Building(
      name: "자연대2호관(S1-2)", location: LatLng(36.627166, 127.456904)), // S1-2
  Building(
      name: "자연대3호관(S1-3)", location: LatLng(36.626701, 127.456850)), // S1-3
  Building(
      name: "자연대4호관(S1-4)", location: LatLng(36.626313, 127.456861)), // S1-4
  Building(
      name: "자연대5호관(S1-5)", location: LatLng(36.625513, 127.455499)), // S1-5
  Building(
      name: "자연대6호관(S1-6)", location: LatLng(36.624871, 127.455906)), // S1-6
  Building(
      name: "과학기술도서관(S1-7)", location: LatLng(36.626946, 127.457084)), // S1-7
  Building(name: "전산정보원(S2)", location: LatLng(36.626396, 127.455397)), // S2
  Building(name: "본부관리동(S3)", location: LatLng(36.626473, 127.454495)), // S3
  Building(
      name: "약학대학본관(S4-1)", location: LatLng(36.625625, 127.454415)), // S4-1
  Building(
      name: "약학연구동(S4-2)", location: LatLng(36.625254, 127.454823)), // S4-2
  Building(
      name: "농장관리실(S5-1)", location: LatLng(36.625095, 127.453777)), // S5-1
  Building(
      name: "농장관리실창고(S5-2)", location: LatLng(36.624927, 127.453739)), // S5-2
  Building(
      name: "자연대온실 1(S6-1)", location: LatLng(36.625781, 127.453331)), // S6-1
  Building(
      name: "자연대온실 2(S6-2)", location: LatLng(36.626662, 127.453144)), // S6-2
  Building(
      name: "에너지저장연구센터(S7-1)", location: LatLng(36.626020, 127.453830)), // S7-1
  Building(
      name: "교육대학원, 동아리방(S7-2)",
      location: LatLng(36.626533, 127.453664)), // S7-2
  Building(name: "야외공연장(S8)", location: LatLng(36.626821, 127.453959)), // S8
  Building(name: "박물관(S9)", location: LatLng(36.627721, 127.455263)), // S9
  Building(name: "차고(S10)", location: LatLng(36.627994, 127.455552)), // S10
  Building(name: "유류저장창고(S11)", location: LatLng(36.627859, 127.455576)), // S11
  Building(
      name: "쓰레기 처리장(S12)", location: LatLng(36.628321, 127.455013)), // S12
  Building(name: "목공실(S13)", location: LatLng(36.628110, 127.454630)), // S13
  Building(name: "제2학생회관(S14)", location: LatLng(36.628027, 127.454326)), // S14
  Building(name: "제1본관(S15)", location: LatLng(0.0, 0.0)), // S15
  Building(name: "본부 창고(S16)", location: LatLng(0.0, 0.0)), // S16
  Building(
      name: "양성재(지선관)(S17-1)",
      location: LatLng(36.628061, 127.452704)), // S17-1
  Building(
      name: "양성재(명덕관(S17-2)", location: LatLng(36.628061, 127.452704)), // S17-2
  Building(
      name: "양성재(신민관)(S17-3)",
      location: LatLng(36.627192, 127.452221)), // S17-3
  Building(
      name: "양현재(수위실)(S17-4)",
      location: LatLng(36.627587, 127.450118)), // S17-4
  Building(
      name: "양현재(청운관)(S17-5)",
      location: LatLng(36.627760, 127.450140)), // S17-5
  Building(
      name: "양현재(등용관)(S17-6)",
      location: LatLng(36.627097, 127.451011)), // S17-6
  Building(
      name: "양현재(관리동)(S17-7)",
      location: LatLng(36.626998, 127.450496)), // S17-7
  Building(
      name: "승리관(운동부합숙소)(S18)", location: LatLng(36.628538, 127.451448)), // S18
  Building(name: "종양 연구소(S19)", location: LatLng(36.628776, 127.451749)), // S19
  Building(
      name: "첨단바이오 연구센터(S20)", location: LatLng(36.628883, 127.452435)), // S20
  Building(
      name: "농업전문창업보육센터(S21-1)",
      location: LatLng(36.628875, 127.453042)), // S21-1
  Building(
      name: "임산가공공장(S21-2)", location: LatLng(36.629309, 127.451465)), // S21-2
  Building(
      name: "농업과학기술센터(S21-3)",
      location: LatLng(36.629521, 127.451663)), // S21-3
  Building(
      name: "농학관 강의동(S21-4)", location: LatLng(36.629443, 127.452666)), // S21-4
  Building(
      name: "농학관 실험동(S21-5)", location: LatLng(36.630033, 127.453267)), // S21-5
  Building(
      name: "건조실(S21-6)", location: LatLng(36.629998, 127.451797)), // S21-6
  Building(
      name: "온실(특용식물학과)(S21-7)",
      location: LatLng(36.630095, 127.451862)), // S21-7
  Building(
      name: "온실(식물자원학과)(S21-8)",
      location: LatLng(36.630033, 127.451993)), // S21-8
  Building(
      name: "온실(식물의학과)(S21-9)",
      location: LatLng(36.630267, 127.452022)), // S21-9
  Building(
      name: "온실(산림학과)(S21-10)",
      location: LatLng(36.630192, 127.452132)), // S21-10
  Building(
      name: "온실(원예과학과)(S21-11)",
      location: LatLng(36.630429, 127.452146)), // S21-11
  Building(
      name: "온실(원예과학과)(S21-12)",
      location: LatLng(36.630347, 127.452234)), // S21-12
  Building(
      name: "온실창고(S21-13)", location: LatLng(36.630274, 127.451548)), // S21-13
  Building(
      name: "온실(1)(S21-14)", location: LatLng(36.630517, 127.451580)), // S21-14
  Building(
      name: "온실(2)(S21-15)", location: LatLng(36.630517, 127.451580)), // S21-15
  Building(
      name: "온실(3)(S21-16)", location: LatLng(36.630517, 127.451580)), // S21-16
  Building(
      name: "온실(4)(S21-17)", location: LatLng(36.630517, 127.451580)), // S21-17
  Building(
      name: "온실(5)(S21-18)", location: LatLng(36.630517, 127.451580)), // S21-18
  Building(
      name: "넷트하우스(S21-19)", location: LatLng(36.630812, 127.451247)), // S21-19
  Building(
      name: "온실관리동(S21-20)", location: LatLng(36.630678, 127.451749)), // S21-20
  Building(
      name: "동위원소실(S21-21)", location: LatLng(36.630571, 127.452256)), // S21-21
  Building(
      name: "농기계공작실(S21-22)",
      location: LatLng(36.631096, 127.451904)), // S21-22
  Building(
      name: "농기계실습실(S21-23)",
      location: LatLng(36.630894, 127.452151)), // S21-23
  Building(
      name: "농대부속건물(S21-24)",
      location: LatLng(36.630773, 127.452382)), // S21-24

];

/// 구역별 건물들을 모아둔 맵
final Map<String, List<Building>> categorizedBuildings = {
  'N': northBuildings,
  'E': eastBuildings,
  'S': southBuildings,
};