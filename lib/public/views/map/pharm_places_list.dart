import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Marker> myMarkers = [
  const Marker(
      markerId: MarkerId('2'),
      infoWindow: InfoWindow(
          title: 'E.S. Repsol Llano Alegre',
          snippet:
              'Lugar Montaña De Guía \n Santa María de Guía de Gran Canaria'),
      position: LatLng(28.143419705936992, -15.613802389308262)),
  const Marker(
    markerId: MarkerId('3'),
    infoWindow: InfoWindow(title: 'Betancuria', snippet: 'Plaza Santa María'),
    position: LatLng(28.42485267548014, -14.057534501161399),
  ),
  const Marker(
      markerId: MarkerId('4'),
      infoWindow: InfoWindow(
          title: 'Urb. Bahia Azul', snippet: 'Calle Pardela \n Geafond'),
      position: LatLng(28.709585295216186, -13.87133934576218)),
  const Marker(
      markerId: MarkerId('5'),
      infoWindow: InfoWindow(
          title: 'Hotel Barceló Corralejos',
          snippet: 'Calle Anguila\nCorralejo'),
      position: LatLng(28.73389642744337, -13.871103760492957)),
  const Marker(
      markerId: MarkerId('6'),
      infoWindow: InfoWindow(
          title: 'Avenida Grandes Playas',
          snippet: 'Avenida Grandes Playas\nCorralejo'),
      position: LatLng(28.732576948121704, -13.86742184707606)),
  const Marker(
      markerId: MarkerId('7'),
      infoWindow: InfoWindow(
          title: 'Residencia Amavir Tías', snippet: 'Tajinaste\nTías'),
      position: LatLng(28.956228893395092, -13.657068096025881)),
  const Marker(
      markerId: MarkerId('8'),
      infoWindow:
          InfoWindow(title: 'Urb. Santo Tomás', snippet: 'Santo Tomás\nAlaior'),
      position: LatLng(39.91416690970246, 4.043596022230787)),
  const Marker(
      markerId: MarkerId('9'),
      infoWindow:
          InfoWindow(title: 'Seth Hotel', snippet: 'Urbanització Santo Tomàs'),
      position: LatLng(39.9150246415449, 4.045671616962636)),
  const Marker(
      markerId: MarkerId('10'),
      infoWindow: InfoWindow(
          title: 'Carrer de Biniarroca', snippet: 'Carrer de Biniarroca'),
      position: LatLng(39.859088071814796, 4.261160757269465)),
  const Marker(
      markerId: MarkerId('11'),
      infoWindow: InfoWindow(
          title: 'Casas del Lago Calan\'s Bosh',
          snippet: 'Passeig Marítim (sector Est)\nCiutadella'),
      position: LatLng(39.9266921723966, 3.8356457690282753)),
  const Marker(
      markerId: MarkerId('12'),
      infoWindow: InfoWindow(
          title: 'Hotel Cala Millor Garden',
          snippet: 'Carrer d\'en Cristòfol Colom\nSant Llorenç des Cardassar'),
      position: LatLng(39.593792463307665, 3.380442477713814)),
  const Marker(
      markerId: MarkerId('13'),
      infoWindow:
          InfoWindow(title: 'Hotel La Dorada', snippet: 'Carrer Romaní\nMuro'),
      position: LatLng(39.80406167255305, 3.1169886147096975)),
  const Marker(
      markerId: MarkerId('14'),
      infoWindow: InfoWindow(
          title: 'Carrer del Creuer', snippet: 'Carrer del Creuer\nMuro'),
      position: LatLng(39.81435765324508, 3.1101423430034174)),
  const Marker(
      markerId: MarkerId('15'),
      infoWindow: InfoWindow(
          title: 'Parking Continental Comte de Sallent',
          snippet: 'Avinguda del Comte de Sallent\nCanavall'),
      position: LatLng(39.578328422781766, 2.6495261604034965)),
  const Marker(
      markerId: MarkerId('16'),
      infoWindow: InfoWindow(
          title: 'Hard Rock Hotel Ibiza',
          snippet: 'Carretera de Platja d\'en Bossa'),
      position: LatLng(38.88371796080159, 1.4042279226841856)),
  const Marker(
      markerId: MarkerId('17'),
      infoWindow: InfoWindow(
          title: 'C.C. El Farallón',
          snippet: 'Calle Acuario\nR-66-A (El Arco)'),
      position: LatLng(39.47357522715757, -6.3933722337972085)),
  const Marker(
      markerId: MarkerId('18'),
      infoWindow: InfoWindow(
          title: 'Parking Plaza Nuestra Señora de Guadalupe',
          snippet: 'Plaza Nuestra Señora de Guadalupe\nDon Benito'),
      position: LatLng(38.958740267485695, -5.860736671318392)),
  const Marker(
      markerId: MarkerId('19'),
      infoWindow: InfoWindow(
          title: 'Ayunt. Sevilla: Pasaje Agustín Arguelles (Endesa)',
          snippet: 'Pasaje Agustín Arguelles\nNervión'),
      position: LatLng(37.37810848939293, -5.967407532190947)),
  const Marker(
      markerId: MarkerId('20'),
      infoWindow: InfoWindow(
          title: 'Ayunt. Sevilla: Calle Leonardo da Vinci (Endesa)',
          snippet: 'Calle Leonardo da Vinci\nTriana'),
      position: LatLng(37.40739281255679, -6.0065834388805115)),
  const Marker(
      markerId: MarkerId('21'),
      infoWindow: InfoWindow(
          title: 'Ayunt. Sevilla: Calle Leonardo da Vinci (Endesa)',
          snippet: 'Calle Leonardo da Vinci\nTriana'),
      position: LatLng(37.412235849174664, -6.005107674755521)),
  const Marker(
      markerId: MarkerId('22'),
      infoWindow: InfoWindow(
          title: 'Calle Aviación', snippet: 'Calle Aviación\nDistrito Norte'),
      position: LatLng(37.408075995378184, -5.951219961421202)),
  const Marker(
      markerId: MarkerId('23'),
      infoWindow: InfoWindow(
          title: 'Parking Plaza Coronación',
          snippet: 'Avenida de la Constitución\nMoguer'),
      position: LatLng(37.27882670474615, -6.836734497462601)),
  const Marker(
      markerId: MarkerId('24'),
      infoWindow: InfoWindow(
          title: 'Hotel AC Huelva', snippet: 'Plaza de Linares de la Sierra'),
      position: LatLng(37.27544176823467, -6.925568738326774)),
  const Marker(
      markerId: MarkerId('25'),
      infoWindow: InfoWindow(
          title: 'Parking Avenida Italia', snippet: 'Avenida de Italia'),
      position: LatLng(37.25322180277543, -6.949408677627673)),
  const Marker(
      markerId: MarkerId('26'),
      infoWindow: InfoWindow(
          title: 'Parking Duque de la Victoria',
          snippet: 'Calle Duque de la Victoria'),
      position: LatLng(37.2561999822361, -6.953841066844461)),
  const Marker(
      markerId: MarkerId('27'),
      infoWindow: InfoWindow(title: 'Parking INSUR', snippet: 'Calle Larga'),
      position: LatLng(36.68370561755815, -6.136898188759346)),
  const Marker(
      markerId: MarkerId('28'),
      infoWindow: InfoWindow(
          title: 'Winterwood Pavilion',
          snippet: '2226 S Nellis Blvd\nLas Vegas'),
      position: LatLng(36.14618, -115.06522)),
  const Marker(
      markerId: MarkerId('29'),
      infoWindow: InfoWindow(
          title: 'Hotel Estrella de Mar (Endesa)',
          snippet: 'Avenida José Ribera\nElviria'),
      position: LatLng(36.49479410625261, -4.785394140874615)),
  const Marker(
      markerId: MarkerId('30'),
      infoWindow: InfoWindow(
          title: 'Parking Centro Torremolinos',
          snippet: 'Calle Río Arba\nTorremolinos'),
      position: LatLng(36.62442521965295, -4.5018312935350195)),
  const Marker(
      markerId: MarkerId('31'),
      infoWindow:
          InfoWindow(title: 'Parking Grund Málaga', snippet: 'Calle Vendeja'),
      position: LatLng(36.71639554996301, -4.423763246159865)),
  const Marker(
      markerId: MarkerId('32'),
      infoWindow:
          InfoWindow(title: 'Baños de la Encina', snippet: 'Calle Rumblar'),
      position: LatLng(38.17665321008775, -3.7750984783058357)),
  const Marker(
      markerId: MarkerId('33'),
      infoWindow: InfoWindow(title: 'CR-6131', snippet: 'CR-6131'),
      position: LatLng(38.64477654468169, -3.452721858679098)),
  const Marker(
      markerId: MarkerId('34'),
      infoWindow:
          InfoWindow(title: 'Rest. Santa Cruz', snippet: 'Rest. Santa Cruz'),
      position: LatLng(38.63542400883139, -3.4706531682249135)),
  const Marker(
      markerId: MarkerId('35'),
      infoWindow: InfoWindow(
          title: 'Parking Avenida de los Custodios',
          snippet: 'Avenida de los Custodios'),
      position: LatLng(37.87510406924066, -4.787498160662949)),
  const Marker(
      markerId: MarkerId('36'),
      infoWindow: InfoWindow(title: 'Ayunt. Nerpio', snippet: 'Plaza Mayor'),
      position: LatLng(38.148005127373295, -2.30205118722418)),
  const Marker(
      markerId: MarkerId('37'),
      infoWindow: InfoWindow(
          title: 'Ayunt. Montoro',
          snippet: 'Calle Alcalde Manuel León Cañete\nMontoro'),
      position: LatLng(38.01675735269009, -4.381180316297957)),
  const Marker(
      markerId: MarkerId('38'),
      infoWindow: InfoWindow(
          title: 'Rest. La Cantina', snippet: 'Vía Verde del Aceite'),
      position: LatLng(37.546482658527324, -4.3513829265551465)),
  const Marker(
      markerId: MarkerId('39'),
      infoWindow:
          InfoWindow(title: 'Ayunt. Encinas Reales', snippet: 'Calle Cruz'),
      position: LatLng(37.27353673591179, -4.492485055514237)),
  const Marker(
      markerId: MarkerId('40'),
      infoWindow: InfoWindow(
          title: 'Sheraton', snippet: '200 Admiral Byrd Rd\nSalt Lake City'),
      position: LatLng(40.772793, -112.021206)),
  const Marker(
      markerId: MarkerId('41'),
      infoWindow: InfoWindow(
          title: 'UVa Parking Campus La Yutera', snippet: 'Tercer Barrio'),
      position: LatLng(41.98703763361064, -4.516596584608806)),
  const Marker(
      markerId: MarkerId('42'),
      infoWindow: InfoWindow(
          title: 'Ayunt. Astudillo', snippet: 'Calle Escuelas Viejas'),
      position: LatLng(42.19324142776779, -4.292476184009132)),
  const Marker(
      markerId: MarkerId('43'),
      infoWindow:
          InfoWindow(title: 'Orchard Walk', snippet: 'Port Erin\nIsle of Man'),
      position: LatLng(54.08594988, -4.75714704)),
  const Marker(
      markerId: MarkerId('44'),
      infoWindow: InfoWindow(
          title: 'Barratt & David Wilson Homes North Thames',
          snippet: 'Aylesbury Village\nKingsbrook'),
      position: LatLng(51.82277, -0.78194)),
  const Marker(
      markerId: MarkerId('45'),
      infoWindow: InfoWindow(
          title: 'Old Forge Garage', snippet: 'Menefreda Way\nSt Minver'),
      position: LatLng(50.559177, -4.873152)),
  const Marker(
      markerId: MarkerId('46'),
      infoWindow: InfoWindow(
          title: 'Carrer Xaloc', snippet: 'Carrer Xaloc\nl\'Alfàs del Pi'),
      position: LatLng(38.57710458414897, -0.09584810833192137)),
  const Marker(
      markerId: MarkerId('47'),
      infoWindow: InfoWindow(
          title: 'Consum Jávea',
          snippet: 'Camí de Cabanes\nLa Finca\nXàbia / Jávea'),
      position: LatLng(38.762398662753924, 0.19071266513830665)),
  const Marker(
      markerId: MarkerId('48'),
      infoWindow: InfoWindow(
          title: 'Hotel Vincci Palace',
          snippet: 'Carrer de Bonaire\nCiutat Vella'),
      position: LatLng(39.47276769381972, -0.37136651109165086)),
  const Marker(
      markerId: MarkerId('49'),
      infoWindow: InfoWindow(
          title: 'Parking Parkia San Agustín',
          snippet: 'Carrer de Xàtiva\nCiutat Vella'),
      position: LatLng(39.46837560724612, -0.3797860890539084)),
  const Marker(
      markerId: MarkerId('50'),
      infoWindow: InfoWindow(title: 'Gasexpress Benegida', snippet: 'CV-560'),
      position: LatLng(39.06449620449072, -0.5380190748446694)),
  const Marker(
      markerId: MarkerId('51'),
      infoWindow: InfoWindow(
          title: 'Parking SABA Cosmocaixa',
          snippet: 'Carrer d\'Isaac Newton\nSarrià - Sant Gervasi'),
      position: LatLng(41.41193138454804, 2.1327958824903703)),
  const Marker(
      markerId: MarkerId('52'),
      infoWindow: InfoWindow(
          title: 'Residencia Amavir Hortá',
          snippet: 'Carrer de Joan B. Cendrós\nHorta-Guinardó'),
      position: LatLng(41.4356356134989, 2.1513089656950797)),
  const Marker(
      markerId: MarkerId('53'),
      infoWindow: InfoWindow(
          title: 'Parking BAMSA Avinguda de Josep Tarradellas',
          snippet: 'Avinguda de Josep Tarradellas\nEixample'),
      position: LatLng(41.387034499267145, 2.142879133690542)),
  const Marker(
      markerId: MarkerId('54'),
      infoWindow: InfoWindow(
          title: 'Hotel Ayre Gran vía',
          snippet: 'Carrer de Mèxic\nSants-Montjuïc'),
      position: LatLng(41.37321679186053, 2.147455187412959)),
  const Marker(
      markerId: MarkerId('55'),
      infoWindow: InfoWindow(
          title: 'Parking Feria Barcelona Pabellón 8',
          snippet: 'Carrer de les Ciències'),
      position: LatLng(41.35662727537084, 2.1369565854087114)),
  const Marker(
      markerId: MarkerId('56'),
      infoWindow: InfoWindow(
          title: 'Trangourmet GM Hospitalet',
          snippet: 'Carrer de Montserrat Roig'),
      position: LatLng(41.35068359498473, 2.1264090263845787)),
  const Marker(
      markerId: MarkerId('57'),
      infoWindow: InfoWindow(
          title: 'McDonalds Calafell',
          snippet: 'Passatge del Ferrocarril\nCalafell'),
      position: LatLng(41.19137471636603, 1.5925516348272595)),
  const Marker(
      markerId: MarkerId('58'),
      infoWindow: InfoWindow(
          title: 'Puerto La Ginesta', snippet: 'Costes del Garraf\nSitges'),
      position: LatLng(41.25844873553879, 1.9233563487389915)),
  const Marker(
      markerId: MarkerId('59'),
      infoWindow: InfoWindow(
          title: 'Hotel IBIS Aeropuerto',
          snippet: 'Carretera de Barcelona\nViladecans'),
      position: LatLng(41.321611728219494, 2.0286680442459897)),
  const Marker(
      markerId: MarkerId('60'),
      infoWindow: InfoWindow(
          title: 'Transgourmet GrosMercat Sant Boi',
          snippet: 'Carrer d\'Andorra\nSant Boi de Llobregat'),
      position: LatLng(41.32278422037393, 2.0320709946373654)),
  const Marker(
      markerId: MarkerId('61'),
      infoWindow: InfoWindow(
          title: 'carretera de Montcada', snippet: 'carretera de Montcada'),
      position: LatLng(41.55773130719942, 2.016080086281818)),
  const Marker(
      markerId: MarkerId('62'),
      infoWindow: InfoWindow(
          title: 'McDonald\'s Rubí', snippet: 'Carrer del Conflent\nRubí'),
      position: LatLng(41.50736213186897, 2.0354502736895483)),
  const Marker(
      markerId: MarkerId('63'),
      infoWindow: InfoWindow(
          title: 'Residencia Amavir San Cugat',
          snippet: 'Carrer de Víctor Hugo\nSant Cugat del Vallès'),
      position: LatLng(41.483586685007054, 2.0843138565684)),
  const Marker(
      markerId: MarkerId('64'),
      infoWindow: InfoWindow(
          title: 'Plaça de Xavier Cugat',
          snippet: 'Plaça de Xavier Cugat\nSant Cugat del Vallès'),
      position: LatLng(41.49192564585789, 2.0745240701571674)),
  const Marker(
      markerId: MarkerId('65'),
      infoWindow: InfoWindow(
          title: 'Zona Deportiva Franqueses del Valles', snippet: 'Ronda Nord'),
      position: LatLng(41.62360313249977, 41.62360313249977)),
  const Marker(
      markerId: MarkerId('66'),
      infoWindow: InfoWindow(
          title: 'Plaça de l\'Església', snippet: 'Plaça de l\'Església'),
      position: LatLng(41.53210796143301, 2.298258554328214)),
  const Marker(
      markerId: MarkerId('67'),
      infoWindow: InfoWindow(
          title: 'Parque Acuático Isla Fantasía',
          snippet: 'Avinguda de la Pedra Blanca'),
      position: LatLng(41.50246667943304, 2.3617228437815356)),
  const Marker(
      markerId: MarkerId('68'),
      infoWindow: InfoWindow(
          title: 'Residencia Amavir Teia', snippet: 'Avinguda Kennedy'),
      position: LatLng(41.48876438312118, 2.3251761871678127)),
  const Marker(
      markerId: MarkerId('69'),
      infoWindow: InfoWindow(
          title: 'Hotel B&B Mataró', snippet: 'Carrer de Jaume Vicens Vives'),
      position: LatLng(41.528307689339755, 2.4348035096192007)),
  const Marker(
      markerId: MarkerId('70'),
      infoWindow: InfoWindow(
          title: 'Ecoveritas Arenys',
          snippet: 'Camí Ral del Camp de Sa Mar\nArenys de Mar'),
      position: LatLng(41.57484282442323, 2.541271032909549)),
  const Marker(
      markerId: MarkerId('71'),
      infoWindow: InfoWindow(
          title: 'Carrer del Castell',
          snippet: 'Carrer del Castell\nCassà de la Selva'),
      position: LatLng(41.89104622655708, 2.8779804554462487)),
  const Marker(
      markerId: MarkerId('72'),
      infoWindow:
          InfoWindow(title: 'Rest. Els Tinars', snippet: 'Ruta del carrilet'),
      position: LatLng(41.82769210516673, 2.9535561921401268)),
  const Marker(
      markerId: MarkerId('73'),
      infoWindow: InfoWindow(
          title: 'Plaza Pablo Ruiz Picasso',
          snippet: 'Plaza Pablo Ruiz Picasson\nSant Feliu de Guíxols'),
      position: LatLng(41.790974910225316, 3.0470077662710082)),
  const Marker(
      markerId: MarkerId('74'),
      infoWindow: InfoWindow(
          title: 'Hotel silken Paya de Aro', snippet: 'Avinguda s\'Agaró'),
      position: LatLng(41.81344393810497, 3.0629143508607797)),
  const Marker(
      markerId: MarkerId('75'),
      infoWindow: InfoWindow(
          title: 'Aldi Paya de Aro', snippet: 'Carrer de Santiago Rusiñol'),
      position: LatLng(41.807027401284245, 3.0528666561891384)),
  const Marker(
      markerId: MarkerId('76'),
      infoWindow: InfoWindow(title: 'Spar Calogne', snippet: 'GI-660\nCalonge'),
      position: LatLng(41.866196745439964, 3.073160887180336)),
  const Marker(
      markerId: MarkerId('77'),
      infoWindow: InfoWindow(
          title: 'Carrer dels Vinyers',
          snippet: 'Carrer dels Vinyers\nCalonge'),
      position: LatLng(41.853950454251134, 3.081185118593936)),
  const Marker(
      markerId: MarkerId('78'),
      infoWindow: InfoWindow(
          title: 'Transgourmet', snippet: 'Carrer de Rafael Savalls\nPalamós'),
      position: LatLng(41.86226225033445, 3.133459470600087)),
  const Marker(
      markerId: MarkerId('79'),
      infoWindow: InfoWindow(
          title: 'Torremirona Golf Club',
          snippet: 'Avinguda de Josep Maria de Ventós'),
      position: LatLng(42.23382092212489, 2.86516501846551)),
  const Marker(
      markerId: MarkerId('80'),
      infoWindow: InfoWindow(
          title: 'Hotel Barceló Rosas',
          snippet: 'Carrer Caravel·la Santa Maria\nRoses'),
      position: LatLng(42.26546891335431, 3.1671914347821257)),
  const Marker(
      markerId: MarkerId('81'),
      infoWindow: InfoWindow(title: 'La Valleta', snippet: 'N-260'),
      position: LatLng(42.35257393152858, 3.109105364348437)),
  const Marker(
      markerId: MarkerId('82'),
      infoWindow: InfoWindow(
          title: 'Carrer de la Font d\'en Falcó',
          snippet: 'Carrer de la Font d\'en Falcó'),
      position: LatLng(42.36027163251717, 3.153247206167748)),
  const Marker(
      markerId: MarkerId('83'),
      infoWindow: InfoWindow(
          title: 'Carrer de l\'Estació', snippet: 'Carrer de l\'Estació'),
      position: LatLng(42.142498882150164, 2.458298144154469)),
  const Marker(
      markerId: MarkerId('84'),
      infoWindow: InfoWindow(
          title: 'Carretera de la Parcel·lària',
          snippet: 'Carretera de la Parcel·lària'),
      position: LatLng(42.15299330691295, 2.4667901660664597)),
  const Marker(
      markerId: MarkerId('85'),
      infoWindow: InfoWindow(
          title: 'McDonalds Tortosa',
          snippet: 'Pont de Tirant lo Blanc\nTortosa'),
      position: LatLng(40.79842874809319, 0.5218496866731925)),
  const Marker(
      markerId: MarkerId('86'),
      infoWindow: InfoWindow(
          title: 'Parking Plaza de la Concordia',
          snippet: 'Plaça de la Concordia'),
      position: LatLng(41.068085500433426, 1.061789555513542)),
  const Marker(
      markerId: MarkerId('87'),
      infoWindow:
          InfoWindow(title: 'La Granada', snippet: 'Carrer de Vilafranca'),
      position: LatLng(41.37650903217582, 1.7149828937132554)),
  const Marker(
      markerId: MarkerId('88'),
      infoWindow: InfoWindow(
          title: 'Carrer de Montserrat', snippet: 'Carrer de Montserrat'),
      position: LatLng(41.452108761468025, 1.7036625174751237)),
  const Marker(
      markerId: MarkerId('89'),
      infoWindow: InfoWindow(
          title: 'Carrer del Montseny', snippet: 'Carrer del Montseny'),
      position: LatLng(41.45311501915117, 1.703210323115286)),
  const Marker(
      markerId: MarkerId('90'),
      infoWindow: InfoWindow(
          title: 'E.S. Sant Pere de Riudebitlles', snippet: 'La Carretera'),
      position: LatLng(41.45169971826809, 1.6977641037473177)),
  const Marker(
      markerId: MarkerId('91'),
      infoWindow: InfoWindow(
          title: 'Residencia AMMA Vilanova del Camí',
          snippet: 'Carrer dels Fusters\nVilanova del Camí'),
      position: LatLng(41.571091085432215, 1.649276658876147)),
  const Marker(
      markerId: MarkerId('92'),
      infoWindow: InfoWindow(title: 'E.S. Montferrer', snippet: 'N-260'),
      position: LatLng(42.34665452626538, 1.4284732415583221)),
  const Marker(
      markerId: MarkerId('93'),
      infoWindow: InfoWindow(
          title: 'Parking Tárrega', snippet: 'Avinguda de Catalunya\nTàrrega'),
      position: LatLng(41.64850719128631, 1.1385461713970813)),
  const Marker(
      markerId: MarkerId('94'),
      infoWindow:
          InfoWindow(title: 'Perafort', snippet: 'Carrer de Joan Palau'),
      position: LatLng(41.19092869536982, 1.2554310393982178)),
  const Marker(
      markerId: MarkerId('95'),
      infoWindow: InfoWindow(
          title: 'Ulldemolins', snippet: 'Avinguda de la Verge de Montserrat'),
      position: LatLng(41.32026815094366, 0.8812889249101374)),
  const Marker(
      markerId: MarkerId('96'),
      infoWindow: InfoWindow(
          title: 'Mora de Ebro', snippet: 'passeig del Pont\nMóra d\'Ebre'),
      position: LatLng(41.09078204794622, 0.6439147309903319)),
  const Marker(
      markerId: MarkerId('97'),
      infoWindow: InfoWindow(
          title: 'Club Natación Lérida',
          snippet: 'Camí Travessera de Marimunt'),
      position: LatLng(41.64295067245982, 0.6186909356455601)),
  const Marker(
      markerId: MarkerId('98'),
      infoWindow: InfoWindow(title: 'Castelló de Farfanya', snippet: 'C-26'),
      position: LatLng(41.81760760099789, 0.729419391021338)),
  const Marker(
      markerId: MarkerId('99'),
      infoWindow: InfoWindow(title: 'Taüll', snippet: 'Carrer dels Aiguals'),
      position: LatLng(42.51771095582376, 0.8509489632353677)),
  const Marker(
      markerId: MarkerId('100'),
      infoWindow:
          InfoWindow(title: 'Boí Parking', snippet: 'Carretera de Taüll'),
      position: LatLng(42.521155791916044, 0.8352117212955363)),
  const Marker(
    markerId: MarkerId('101'),
    infoWindow:
        InfoWindow(title: 'Hotel Cotiella', snippet: 'Calle San Antonio'),
    position: LatLng(42.408015393032116, 0.394987058165043),
  ),
  const Marker(
      markerId: MarkerId('102'),
      infoWindow: InfoWindow(
          title: 'Chillout Mohamed Naguib', snippet: 'محور محمد نجيب'),
      position: LatLng(29.9914882, 31.4692734)),
  const Marker(
      markerId: MarkerId('103'),
      infoWindow: InfoWindow(
          title: 'Chillout El Sokhna Master 1',
          snippet: 'طريق القطامية, العين السخنه'),
      position: LatLng(29.960891179641976, 31.455246853512108)),
  const Marker(
      markerId: MarkerId('104'),
      infoWindow: InfoWindow(
          title: 'Aladawy International Coastal Station',
          snippet: 'الطريق الساحلى الدولى'),
      position: LatLng(31.42448, 31.53681)),
  const Marker(
      markerId: MarkerId('105'),
      infoWindow: InfoWindow(
          title: 'El Mahalla - El Mansoura Road', snippet: 'الطريق الدائري'),
      position: LatLng(30.99733, 31.27803)),
  const Marker(
      markerId: MarkerId('106'),
      infoWindow: InfoWindow(title: 'Swell Lake', snippet: 'غرينلاند'),
      position: LatLng(29.990055555555557, 30.99716666666667)),
  const Marker(
      markerId: MarkerId('107'),
      infoWindow:
          InfoWindow(title: 'Chillout Ras El Hekma 1', snippet: 'Ras El Hekma'),
      position: LatLng(31.101222222222223, 27.850055555555556)),
  const Marker(
      markerId: MarkerId('108'),
      infoWindow: InfoWindow(title: 'Chillout Hacienda', snippet: 'Hacienda'),
      position: LatLng(30.998972222222225, 28.647166666666667)),
  const Marker(
      markerId: MarkerId('109'),
      infoWindow: InfoWindow(title: 'Chillout Marassi', snippet: 'Marassi'),
      position: LatLng(30.97375, 28.735388888888888)),
  const Marker(
      markerId: MarkerId('110'),
      infoWindow:
          InfoWindow(title: 'Watanya Alamein 3', snippet: 'طريق البترول'),
      position: LatLng(30.8505, 28.768916666666666)),
  const Marker(
      markerId: MarkerId('111'),
      infoWindow: InfoWindow(
          title: 'Watanya Alamein 1', snippet: 'الطريق الساحلى الدولى'),
      position: LatLng(30.884999999999998, 28.86116666666667)),
  const Marker(
      markerId: MarkerId('112'),
      infoWindow: InfoWindow(
          title: 'Chillout Alamein 3', snippet: 'الطريق الساحلى الدولى'),
      position: LatLng(30.870555555555555, 28.879)),
  const Marker(
      markerId: MarkerId('113'),
      infoWindow: InfoWindow(title: 'Chillout Alamein 1', snippet: 'Alamein'),
      position: LatLng(30.84875, 28.918055555555558)),
  const Marker(
      markerId: MarkerId('114'),
      infoWindow: InfoWindow(
          title: 'Watanya Borqan 2', snippet: 'طريق وادى النطرون, العلمين'),
      position: LatLng(30.676166666666667, 29.293472222222224)),
  const Marker(
      markerId: MarkerId('115'),
      infoWindow: InfoWindow(title: 'Chillout El Hamam', snippet: 'El Hamam'),
      position: LatLng(30.90063888888889, 29.413777777777778)),
  const Marker(
      markerId: MarkerId('116'),
      infoWindow: InfoWindow(title: 'Chillout K21 Agamy', snippet: 'Agamy'),
      position: LatLng(31.065416666666668, 29.769222222222222)),
  const Marker(
      markerId: MarkerId('117'),
      infoWindow: InfoWindow(
          title: 'Mcdonald\'s Amerya',
          snippet: 'طريق القاهرة, الاسكندرية الصحراوي'),
      position: LatLng(31.03125, 29.78538888888889)),
  const Marker(
      markerId: MarkerId('118'),
      infoWindow: InfoWindow(
          title: 'Chillout Rest House',
          snippet: 'طريق القاهرة, الاسكندرية الصحراوي'),
      position: LatLng(30.3925, 30.377222222222223)),
  const Marker(
      markerId: MarkerId('119'),
      infoWindow: InfoWindow(
          title: 'OLA Sahrawy',
          snippet: 'طريق القاهرة, الاسكندرية الصحراوي الجانبي'),
      position: LatLng(30.30575, 30.5635)),
  const Marker(
      markerId: MarkerId('120'),
      infoWindow: InfoWindow(
          title: 'Chillout El Wahaa 1', snippet: 'طريق القطامية, العين السخنه'),
      position: LatLng(29.80602777777778, 31.895194444444446)),
  const Marker(
      markerId: MarkerId('121'),
      infoWindow: InfoWindow(
          title: 'Chillout El Wahaa 2', snippet: 'طريق القطامية, العين السخنه'),
      position: LatLng(29.805305555555556, 31.89686111111111)),
  const Marker(
      markerId: MarkerId('122'),
      infoWindow:
          InfoWindow(title: 'Chillout El Galala', snippet: 'طريق الجلالة'),
      position: LatLng(29.641194444444444, 32.22786111111111)),
  const Marker(
      markerId: MarkerId('123'),
      infoWindow: InfoWindow(
          title: 'Chillout Zafarana', snippet: 'طريق الزعفرانه, رأس غارب'),
      position: LatLng(29.097666666666665, 32.64575)),
  const Marker(
      markerId: MarkerId('124'),
      infoWindow: InfoWindow(
          title: 'Mobil Ras Ghareb', snippet: 'طريق راس غارب, الغردقة'),
      position: LatLng(28.33972222222222, 33.05986111111111)),
  const Marker(
      markerId: MarkerId('125'),
      infoWindow:
          InfoWindow(title: 'El Gouna Gourmet', snippet: 'El Gouna,جمشه'),
      position: LatLng(27.39913888888889, 33.66375)),
  const Marker(
      markerId: MarkerId('126'),
      infoWindow: InfoWindow(
          title: 'El Gouna Sports District', snippet: 'شارع محمد ابراهيم كمال'),
      position: LatLng(27.398416666666666, 33.67066666666666)),
  const Marker(
      markerId: MarkerId('127'),
      infoWindow: InfoWindow(
          title: 'Co-op Gas Station', snippet: 'طريق نخل, صدر الحيطان'),
      position: LatLng(30.03211111111111, 32.62925)),
  const Marker(
      markerId: MarkerId('128'),
      infoWindow: InfoWindow(
          title: 'Distribution Office New Admin Capital',
          snippet: 'New Admin Capital'),
      position: LatLng(30.00993226255281, 31.744566637657243)),
  const Marker(
      markerId: MarkerId('129'),
      infoWindow: InfoWindow(
          title: 'FUEL UP - Police Academy',
          snippet: 'محور مصطفى كامل الجانبى'),
      position: LatLng(30.049583333333334, 31.44161111111111)),
  const Marker(
      markerId: MarkerId('130'),
      infoWindow:
          InfoWindow(title: 'Water Park Walkway', snippet: 'طريق وصله دهشور'),
      position: LatLng(30.001666666666665, 30.987472222222223)),
  const Marker(
      markerId: MarkerId('131'),
      infoWindow: InfoWindow(
          title: 'OLA Energy Sadat',
          snippet: 'طريق القاهرة, الاسكندرية الصحراوي الجانبي'),
      position: LatLng(30.339805555555554, 30.487416666666668)),
  const Marker(
      markerId: MarkerId('132'),
      infoWindow: InfoWindow(
          title: 'Rally Motors - IKARUS', snippet: 'شارع 5, الحى السادس'),
      position: LatLng(29.918523301689614, 30.911591387747603)),
  const Marker(
      markerId: MarkerId('133'),
      infoWindow: InfoWindow(
          title: 'IKARUS New Capital',
          snippet:
              'New Administrative Capital, Cairo Governorate Desert, Cairo Governorate'),
      position: LatLng(30.00966, 31.74528)),
  const Marker(
      markerId: MarkerId('134'),
      infoWindow: InfoWindow(
          title: 'ID Store',
          snippet:
              'طريق مصر, Ismailia Desert Rd, Ismailia Governorate, Cairo Governorate 11828'),
      position: LatLng(30.160615827942298, 31.462727158471807)),
  const Marker(
      markerId: MarkerId('135'),
      infoWindow: InfoWindow(
          title: 'Misr Petrol Gas Station', snippet: 'شارع الأصبهانى'),
      position: LatLng(30.01025927132416, 31.435911465768868)),
  const Marker(
      markerId: MarkerId('136'),
      infoWindow: InfoWindow(
          title: 'Hilton Alexandria - King\'s Ranch',
          snippet: 'طريق برج العرب, العامريه الجانبي'),
      position: LatLng(30.98222222222222, 29.69286111111111)),
]; //collection
