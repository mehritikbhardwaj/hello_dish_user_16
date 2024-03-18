class APIs {
  static const base = "https://api.hellodish.in/";

  static const login = "${base}customer/api/login";
  static const signup = "${base}customer/api/signup";
  static const update = "${base}customer/api/update";
  static const getLocation = "${base}customer/api/getLocation";

  static const getOffers = "${base}customer/api/getOffers";
  static const home = "${base}customer/api/home";
  static const addFav = "${base}restaurant/api/addFav/";

  static const restDetails = "${base}customer/api/getRestaurantDetailById";
  static const createOrder = "${base}customer/api/createOrder";
  static const getCartItem = "${base}customer/api/getCartItem/";
  static const updateOrder = "${base}customer/api/updateOrder";

  static const addLocation = "${base}customer/api/addLocation";
  static const deleteLocation = "${base}customer/api/deleteLocation/";
  static const updateLocation = "${base}customer/api/updateLocation/";
}
