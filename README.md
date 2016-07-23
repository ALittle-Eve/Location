##Location
location for iOS
##Steps:
 - import"Location.h" in your class.
 - Set your instance variable as global variable.(In case that your object being destoryed by the ARC) e.g. @property Location * location;
 - Then : [location beginLocate]; 
 - You can modify the default notification name in the class if you have your defined a notification of your own.The default notification name I set in this class is 'updateCurrentCityNotification'.
  
