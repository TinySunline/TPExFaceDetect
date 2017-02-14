# TPExFaceDetect

[![CI Status](http://img.shields.io/travis/kingdomrain/TPExFaceDetect.svg?style=flat)](https://travis-ci.org/kingdomrain/TPExFaceDetect)
[![Version](https://img.shields.io/cocoapods/v/TPExFaceDetect.svg?style=flat)](http://cocoapods.org/pods/TPExFaceDetect)
[![License](https://img.shields.io/cocoapods/l/TPExFaceDetect.svg?style=flat)](http://cocoapods.org/pods/TPExFaceDetect)
[![Platform](https://img.shields.io/cocoapods/p/TPExFaceDetect.svg?style=flat)](http://cocoapods.org/pods/TPExFaceDetect)

## Usage
   var face = new TPExFaceDetect();  
   face.personalName= personalName;  
   face.identityCardNo=identityCardNo;  
   face.success = function(data){
       alert(data);
   }  
   face.error = function(data){
        alert(data);
   }  
   face.start();  
   
   其中是personalName是姓名，identityCardNo是身份证号。
    
## Requirements
 需要真机调试，不支持模拟器。

## Installation

TPExFaceDetect is not available through [CocoaPods](http://cocoapods.org). 
手动将TPExFaceDetect目录添加到工程中。

## Author

kingdomrain, bygd2014@sina.com

## License

TPExFaceDetect is available under the MIT license. See the LICENSE file for more info.
