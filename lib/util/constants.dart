import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//create custom Colors
MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  // ignore: avoid_multiple_declarations_per_line
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  // ignore: avoid_function_literals_in_foreach_calls

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

//Image urls
const String icon = 'assets/icons/';
const String images = 'assets/images/';

//Http Requests Base url and End Points

// ignore: constant_identifier_names
const CLIENT_ID = '964de1d6-590d-4455-94fd-5a96bdb53df7';
// ignore: constant_identifier_names
const CLIENT_SECRET = 'Z1WE08cIoI66s4pHArle5H8awfUSszumw1UxU70V';

//http://ndume.digicow.co.ke/API/
const baseURL = 'https://ndume.digicow.co.ke/';
//const baseURL = 'http://3.80.199.119/ndume/public/';
// ignore: constant_identifier_names
const baseURLEndPoint = '${baseURL}api/v2/';
//const mpesaBaseURLEndPoint = 'http://34.194.84.35/mpesa/';
const mpesaBaseURLEndPoint =
    'https://p0yhwlfgqh.execute-api.us-east-1.amazonaws.com/prod/';
// ignore: constant_identifier_names
const imgBaseURL = '${baseURL}storage/';

const coachImgUrl = '${imgBaseURL}coach_profiles/';
const studentImgUrl = '${imgBaseURL}student_profiles/';
const assessmentIconUrl = '${imgBaseURL}assessment_icons/';
const trainingImageUrl="${baseURL}files/";

/*API Base Urls*/
const countyAPI = '${baseURLEndPoint}county';
const subCountyAPI = '${baseURLEndPoint}county/sub-county';
const wardAPI = '${baseURLEndPoint}county/sub-county/ward';
const authenticateAPI = '${baseURLEndPoint}authenticate';

const registerAPI = '${baseURLEndPoint}register';
const findFarmerAPI = '${baseURLEndPoint}farmer-vet/find-and-insert';
const storeFarmerAPI = '${baseURLEndPoint}farmer-vet/store';
const cowCalfRecordAPI = '${baseURLEndPoint}cow-calf/';
const cowBreedingAndGroupAPI = '${baseURLEndPoint}cow-breedings-and-cow-groups';
const registerCowAPI = '${baseURLEndPoint}cow/store';
const addBreedingAPI = '${baseURLEndPoint}breeding/store';
const getBreedingAPI = '${baseURLEndPoint}breeding/show';
const updateBreedingAPI = '${baseURLEndPoint}breeding/update';
const addHealthAPI = '${baseURLEndPoint}health/store';
const updateHealthAPI = '${baseURLEndPoint}health/update';
const getHealthRecordsAPI = '${baseURLEndPoint}health/show';
const getFarmersAPI = '${baseURLEndPoint}farmer-vet/list';
const deleteBreedingRecordAPI = '${baseURLEndPoint}breeding/';
const deleteHealthRecordAPI = '${baseURLEndPoint}health/';
const getNdumeWalletAPI = '${baseURLEndPoint}vet/wallet/';
const updateWithdrawalWalletAPI = '${baseURLEndPoint}vet/withdraw';
const getPaidBreedingAPI = '${baseURLEndPoint}vet/paid_breeding/';
const fetchSourceOfSemenAPI = '${baseURLEndPoint}source_of_semen';
const getPaidHealthingAPI = '${baseURLEndPoint}vet/paid_health/';
const checkTandCapi='${baseURLEndPoint}tandc';
const updateTandCapi='${baseURLEndPoint}update_tc';
const updateFarmer='${baseURLEndPoint}farmer-vet/update_location';
const changePasswordapi='${baseURLEndPoint}change-password';
const forgotapi='${baseURLEndPoint}forgot-password';

//new api of new module
const getFarmersServiceCountAPI = '${baseURLEndPoint}farmer_service/list';
const getPregnencyDueAPI = '${baseURLEndPoint}farmer_service/pregnancy_diagnosis_due';
const getDwormerDueAPI = '${baseURLEndPoint}farmer_service/deworming_diagnosis_due';
const updateRecordStatusAPI = '${baseURLEndPoint}farmer_service/contact_for_service';

const getTrainingCategory='${baseURLEndPoint}vet_training/category';
const getTrainingTopic='${baseURLEndPoint}vet_training/training_list';
const getTrainingDetail='${baseURLEndPoint}vet_training/training_detail';
const updateTrainingTime='${baseURLEndPoint}vet_training/update_time';

//Mpesa API
const mpesaLoginAPI = '${mpesaBaseURLEndPoint}signin';
const withMpesaAPI = '${mpesaBaseURLEndPoint}MpesaWidthrawal';
const confirmPaymentAPI = '${mpesaBaseURLEndPoint}confirmPayment';

/*Route Names*/
const splashScreen = '/';
const startScreen ='/startActivity';
const loginPage = '/loginPage';
const registrationPage = "/registration";
const homePage = '/home';
const breedingRecordManagement = '/breedingRecordManagement';
const addBreedingRecord = '/addBreedingRecord';
const addHealthRecord = '/addHealthRecord';
const farmerDetail = '/farmerDetail';
const breedingRecordDetail = '/breedingRecordDetail';
const healthRecordDetail = '/healthRecordDetail';
const editBreedingRecordDetail = '/editBreedingRecordDetail';
const editHealthRecordDetail = '/editHealthRecordDetail';
const registerCow = '/registerCow';
const viewEditBreedingRecords = '/viewEditBreedingRecords';
const viewEditHealthRecords = '/viewEditHealthRecords';
const walletWithdraw = '/walletWithdraw';
const ndumeWallet = '/ndumeWallet';
const paidBreedingRecordList = '/paidBreedingRecordList';
const paidHealthRecordList='/paidHealthRecordList';
const verifiedBreedingRecordList = '/verifiedBreedingRecordList';
const verifiedHealthRecordList = '/verifiedHealthRecordList';
const addPregnancyStatus = '/addPregnancyStatus';
const farmerInNeedOfService = '/farmerInNeedOfService';
const forgotPassPage = '/forgotPassword';
const trainingTopicList = '/trainingTopic';
const trainingDetail='/trainingDetail';

//Session value keys
const userData = 'user_data';
const isLoggedIn = 'is_logged_in';
const mpesaToken = 'mpesaToken';

//Page Arguments keys
const studentDataKey = 'student';
const assessmentDataKey = 'assessmentData';
const assessmentIDKey = 'assessmentID';
const assessmentNameKey = 'assessmentName';
const assessmentDescKey = 'assessmentDesc';

final dateAndTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
final dateAndTimeDDMMMYYYYFormat = DateFormat('dd MMM yyyy');

//Admin Credentials:
//http://test.codeclinic.in/kreeda_tantra_dev/public/admin/login
//E : admin@gmail.com
//P : 12345678
