function CameraCalibration()
%CAMERACALIBRATION Summary of this function goes here
%   Detailed explanation goes here

try
    ocam_calib;
catch
    warning('Please be sure OCamCalib toolbox is installed and on the path');
end

end

