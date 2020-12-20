# Scoops.Mobile
The Mobile app code for the Scoops application

### Build Status 

[![Build status](https://build.appcenter.ms/v0.1/apps/4426b4da-568e-4b8d-8469-da5e003158bf/branches/main/badge)](https://appcenter.ms)


### Installation

#### Prerequisites

- Google Auth Application
  - Add dev Keystore to white list

In order to run the app there are two required files:

#### Google Services Json File
    File Name : `google-services.json`
    File Path : `/src/scoops/android/app/google-services.json`
#### App Configuration File
    File Name : `config.json`
    File Path : `/src/scoops/config.json`
    Sample File : 
  ```json
  {
    "appCenterConfig" : {
        "platformIdentifiers" : {
            "androidId": "xxxxxxxxxxx",
            "iosId" : "xxxxxxxx"
        },        
        "enableDistribution" : true
    } 
  } 
  ```