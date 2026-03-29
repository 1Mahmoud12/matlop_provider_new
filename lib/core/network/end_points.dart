class EndPoints {
  static const domain = 'https://test.wrdah.com';

  //static const domainPrimary = 'https://aspdev.matlop.com/index.html';
  static const baseUrl = '$domain/api';
  static const storageUrl = 'https://tashira.infinitybridge.org/storage/';

  //Auth
  static const login = '/auth/technical-login';
  static const verifyOtp = '/Authentication/VerfiyOtp';
  static const setFirebaseToken = '/Authentication/setfirebasetoken';

  // Forget   Password
  static const forgetPassword = '/auth/forgot-password';
  static const verifyForgetPassword = '/auth/verify-reset-code';
  static const resetPassword = '/auth/reset-password';

  static const updateProfile = '/Technical/Update';
  static const getProfileById = '/Technical/GetById';

  static const register = '/technicals/mobile-register';
  static const getAllTechnicalSpecialist = '/technical-specialists';
  static const editProfile = '/client/edit-profile';

  // Home
  static const getAllBlogs = '/client/get-all-blogs';

  // search
  static const projectDistricts = '/client/project_districts';
  static const features = '/client/features';
  static const realtyTypes = '/client/realty_types';
  static const paymentMethod = '/client/payment-method';

  //Auth
  static const sliders = '/client/sliders';
  static const commonQuestions = '/client/faqs';
  static const contacts = '/client/contacts';
  static const socialMedia = '/client/social-media';

  // Favorite
  static const updateFavoriteProject = '/client/update-favorite-project/';
  static const updateFavoriteUnit = '/client/update-favorite-unit/';

  static const complaints = '/client/complaints';
  static const units = '/client/units';
  static const unitsNoAuth = '/client/get-all-units';

  static const myEstateRental = '/client/units?filter[client_id]=1';
  static const projects = '/client/projects';
  static const projectsNoAuth = '/client/get-all-projects';
  static const oneProjectData = '/client/projects';
  static const allNotification = '/client/get-all-notifications';
  static const allUnReaddNotification = '/client/get-all-unread-notifications';
  static const markAllReaddNotification = '/client/mark-all-notifications';

  // home
  static const interestProject = '/client/update-interest-project/';
  static const interestEstates = '/client/update-interest-unit/';

  //unit
  static const unit = '/client/units?filter[project_id]=';

  // more
  static const getOrders = '/developer/order-requests/';
  static const postOrder = '/developer/order-request';
  static const getOrderType = '/developer/orders?type';
  static const getVacationType = '/developer/vacation';
  static const addVacation = '/employee/vacation-request';

  static const getServices = '/Service/GetAll';
  static String getMyAddress = '/Location/GetByUserId/';
  static String aboutUs = '/AboutUs/GetAll';
  static String postComplaint = '/Complaint/Create';
  static String getAllComplaints = '/Complaint/GetByClinetId';
  static String deleteAccount = '/Client/Delete?userId=';
  static const getContracts = '/ContractType/GetByServiceId';
  static const getPackagesByContractId = '/Package/GetPackageByContractId';
  static const GetCountry = '/countries';
  static const getDistricts = '/District/GetByCityId?CityId=';
  static const getCitiesById = '/City/GetByCountryId/';
  static const postLocation = '/Location/Create';
  static const verfiyCopone = '/Copone/Verfiy/';
  static const getAllAdditionalItem = '/OrderAdditionalItems/GetAll';
  static const payment = '/PaymentWay/GetAll';
  static const getVacations = '/employee/vacation-request';

  // task

  static const postEvent = '/developer/event';
  static const postTask = '/developer/task';
  static const eventType = '/developer/event-type';
  static const event = '/developer/event';
  static const getEvents = '/developer/public-vacation';
  static const getTask = '/developer/task';
  static const getEmployee = '/developer/employee';
  static const getClients = '/developer/clients';
  static const getUnitsByClient = '/developer/get-units-by-client';
  static const addClient = '/developer/clients';
  static const postTaskDone = '/developer/task';
  static const getMeeting = '/developer/events-type';
  static const getPaymentMethods = '/developer/payment-method';
  static const getFAQ = '/FAQs/GetAll';
  static const workTime = '/WorkingTime/GetAll';
  static const getSlider = '/Slider/GetAll';
  static const createOrder = '/Order/Create';
  static const getTermAndConditions = '/TermsAndConditions/GetAllByUserType';
  static const privacyAndPolicy = '/PrivacyPolicy/GetAllByUserType';
  static const Orders = '/Order/GetAllWitPagination';
  static const GetOrderSchedule = '/Order/GetOrderSchedule/';
  static const OrderDetails = '/Order/Get/';
  static const cancelOrder = '/Order/CancelOrder';
  static const cancelReason = '/CancelReason/GetAll';

  // orders
  static const getOrdersByStatus = '/Order/GetByTechnicalId';
  static const getOrderDetails = '/Order/Get/';
  static const changeStatus = '/Order/ChangeStatus';

  // SpecialOrder
  static const getSpecialOrdersByStatus = '/SpecialOrder/GetByTechnicalId';
  static const getSpecialOrderDetails = '/SpecialOrder/Get';
  static const getSpecialOrder = '/SpecialOrder/GetAllWitPagination';
  static const getAllSpecialOrder = '/SpecialOrder/GetAll';
  static const getNewSpecialOrder = '/SpecialOrder/GetNewSpecialOrder';
  static const addSpecialOrder = '/SpecialOrder/Create';

  // offer
  static const createSpecialOrderOffer = '/SpecialOrderOffer/Create';

  // Wallet
  static const addWallet = '/Wallet/WalletTransaction';
  static const getBalance = '/Wallet/GetBalanceClientId';
  static const getTransaction = '/Wallet/GetClientTransactions';

  // Notification
  static const getNotification = '/Notification/GetNotifications';

  static const markNotification = '/Notification/seenNotification';
}
