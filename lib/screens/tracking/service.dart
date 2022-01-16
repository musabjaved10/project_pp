// class Service{
//
//   Future<Locations> getGoogleOffices() async {
//     const googleLocationsURL = 'https://about.google/static/data/locations.json';
//
//     // Retrieve the locations of Google offices
//     try {
//       final response = await http.get(Uri.parse(googleLocationsURL));
//       if (response.statusCode == 200) {
//         return Locations.fromJson(json.decode(response.body));
//       }
//     } catch (e) {
//       print(e);
//     }
//
//     // Fallback for when the above HTTP request fails.
//     return Locations.fromJson(
//       json.decode(
//         await rootBundle.loadString('assets/locations.json'),
//       ),
//     );
//   }
// }