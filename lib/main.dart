import 'dart:math';
import 'dart:io';

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate(this.latitude, this.longitude);
}

class DiwaliKMLGenerator {
  static const String kmlHeader = '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>India Night Lights</name>
    
    <!-- Yellow dot style -->
    <Style id="yellowDot">
      <IconStyle>
        <Icon>
          <href>http://maps.google.com/mapfiles/kml/paddle/ylw-blank.png</href>
        </Icon>
        <scale>0.3</scale>
      </IconStyle>
      <LabelStyle>
        <scale>0</scale>
      </LabelStyle>
    </Style>

    <!-- Initial view settings -->
    <LookAt>
      <longitude>78.9629</longitude>
      <latitude>20.5937</latitude>
      <altitude>0</altitude>
      <heading>0</heading>
      <tilt>0</tilt>
      <range>3000000</range>
    </LookAt>''';

  static const String kmlFooter = '''
  </Document>
</kml>''';

  final Random _random = Random();

  // Major cities with their regions - Updated list
  final List<Map<String, dynamic>> regions = [
    {
      'center': Coordinate(28.6139, 77.2090), // Delhi
      'bounds': {'minLat': 28.0, 'maxLat': 29.0, 'minLon': 76.8, 'maxLon': 77.5}
    },
    {
      'center': Coordinate(19.0760, 72.8777), // Mumbai
      'bounds': {'minLat': 18.8, 'maxLat': 19.3, 'minLon': 72.7, 'maxLon': 73.0}
    },
    {
      'center': Coordinate(12.9716, 77.5946), // Bangalore
      'bounds': {'minLat': 12.8, 'maxLat': 13.2, 'minLon': 77.4, 'maxLon': 77.8}
    },
    {
      'center': Coordinate(22.5726, 88.3639), // Kolkata
      'bounds': {'minLat': 22.3, 'maxLat': 22.8, 'minLon': 88.2, 'maxLon': 88.5}
    },
    {
      'center': Coordinate(17.3850, 78.4867), // Hyderabad
      'bounds': {'minLat': 17.2, 'maxLat': 17.6, 'minLon': 78.3, 'maxLon': 78.7}
    },
    {
      'center': Coordinate(13.0827, 80.2707), // Chennai
      'bounds': {'minLat': 12.9, 'maxLat': 13.3, 'minLon': 80.1, 'maxLon': 80.4}
    },
    {
      'center': Coordinate(26.9124, 75.7873), // Jaipur
      'bounds': {'minLat': 26.7, 'maxLat': 27.1, 'minLon': 75.6, 'maxLon': 75.9}
    },
    {
      'center': Coordinate(26.8467, 80.9462), // Lucknow
      'bounds': {'minLat': 26.7, 'maxLat': 27.0, 'minLon': 80.8, 'maxLon': 81.1}
    },
    {
      'center': Coordinate(25.5941, 85.1376), // Patna
      'bounds': {'minLat': 25.4, 'maxLat': 25.7, 'minLon': 85.0, 'maxLon': 85.3}
    },
    {
      'center': Coordinate(23.0225, 72.5714), // Ahmedabad
      'bounds': {'minLat': 22.9, 'maxLat': 23.2, 'minLon': 72.4, 'maxLon': 72.7}
    }
  ];

  bool isInIndia(double lat, double lon) {
    // Basic boundary box
    if (lat < 8.4 || lat > 37.6 || lon < 68.7 || lon > 97.25) return false;

    // Exclude specific ocean areas
    if (lon < 72.8 && lat < 20) return false; // Arabian Sea
    if (lon > 89 && lat < 22) return false; // Bay of Bengal
    if (lat < 8.8 && lon > 76) return false; // Indian Ocean

    // Exclude neighboring countries
    if (lat > 32 && lon < 75) return false; // Pakistan
    if (lat > 26 && lon > 89) return false; // Bangladesh
    if (lat > 23 && lon > 94) return false; // Myanmar
    if (lat < 10 && lon > 79) return false; // Sri Lanka

    return true;
  }

  String createPlacemark(Coordinate coord) {
    return '''    <Placemark>
      <styleUrl>#yellowDot</styleUrl>
      <Point>
        <coordinates>${coord.longitude},${coord.latitude},0</coordinates>
      </Point>
    </Placemark>''';
  }

  Future<void> generateNightLights(int numPoints) async {
    StringBuffer kmlContent = StringBuffer();
    kmlContent.writeln(kmlHeader);
    kmlContent.writeln('    <Folder><name>Night Lights</name>');

    // Generate points in urban areas (70% of points)
    int urbanPoints = (numPoints * 0.7).round();
    int pointsPerRegion = urbanPoints ~/ regions.length;

    // Generate city lights
    for (var region in regions) {
      var bounds = region['bounds'];
      // More points for larger cities
      int cityPoints = pointsPerRegion;
      if (region['center'].latitude > 25 && region['center'].latitude < 29) {
        cityPoints = (pointsPerRegion * 1.3).round(); // More points for northern cities
      }

      for (int i = 0; i < cityPoints; i++) {
        double lat = bounds['minLat'] + _random.nextDouble() * (bounds['maxLat'] - bounds['minLat']);
        double lon = bounds['minLon'] + _random.nextDouble() * (bounds['maxLon'] - bounds['minLon']);

        if (isInIndia(lat, lon)) {
          kmlContent.writeln(createPlacemark(Coordinate(lat, lon)));
        }
      }
    }

    // Generate points in other areas (30% of points)
    int remainingPoints = numPoints - urbanPoints;
    int pointsGenerated = 0;

    // Define mainland India regions
    List<Map<String, double>> mainlandRegions = [
      {'minLat': 20, 'maxLat': 28, 'minLon': 75, 'maxLon': 87}, // North-Central
      {'minLat': 15, 'maxLat': 20, 'minLon': 74, 'maxLon': 85}, // Central
      {'minLat': 11, 'maxLat': 15, 'minLon': 76, 'maxLon': 80}, // South
      {'minLat': 22, 'maxLat': 26, 'minLon': 71, 'maxLon': 85}, // Western-Central
    ];

    while (pointsGenerated < remainingPoints) {
      var region = mainlandRegions[_random.nextInt(mainlandRegions.length)];
      double lat = region['minLat']! + _random.nextDouble() * (region['maxLat']! - region['minLat']!);
      double lon = region['minLon']! + _random.nextDouble() * (region['maxLon']! - region['minLon']!);

      if (isInIndia(lat, lon)) {
        kmlContent.writeln(createPlacemark(Coordinate(lat, lon)));
        pointsGenerated++;
      }
    }

    kmlContent.writeln('    </Folder>');
    kmlContent.writeln(kmlFooter);

    await File('india_night_lights.kml').writeAsString(kmlContent.toString());
  }
}

void main() async {
  var generator = DiwaliKMLGenerator();
  await generator.generateNightLights(10000);
  print('Night lights visualization generated successfully!');
}