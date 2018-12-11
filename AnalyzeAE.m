function [HF, LF, LoadData
%% LoadData.m
%  Loads AE data from a scan taken using 
%% TOC
%   @000 High Level Flags
%   @001 Load bScanParm into workspace
%% @000 High Level Flags
% Modify these for specific parameters that you would like to modify in the
% script
%% @001 Load Data
% Read in binary data from HF and LF files and from info file saved to VSX
%  @001a Get filenames for use in later
[File, Path] = uigetfile(pwd,'*.mat'); % Have the user select the file 
cd(Path); % Change the working directory to the path
load([Path,File]); % Load bScanParm variables from the mat file into the workspace
% bScanParm is made up of the following quantities:
%   bScanParm.AxialFocus:       Axial Focus (double; in mm) 
%   bScanParm.LatFocus:         Lateral Focus (double; in mm)
%   bScanParm.ActiveScan:       If the VSX is in active scan mode (Boolean; =1)
%   bScanParm.Duration:         Duration of the scan (double; in ms)
%   bScanParm.AvgNum:           Number of averages at each scan position (double)
%   bScanParm.HFSamplingRate:   HF Sampling Rate (double; in MHz)
%   bScanParm.PulseRate:        Pulse Rate (double; in Hz) 
%   bScanParm.IsChirp:          If Chirp is Used (Boolean; =1)
%   bScanParm.ScriptRoot        Root name of the script (string)
%   bScanParm.nFrames           AMAQ: Is this PE or AE frames? 
%   bScanParm.numRep            AMAQ: Not actually sure what this is
%   bScanParm.PEMMode           If PEMMode is checked (Boolean; =1)
%   bScanParm.remote_path       Remote path used to save PE (string)
%   bScanParm.FileRoot          Name root for HF_avg, LF_avg, info files, etc. (string)
%   bScanParm.local_path        Local path that AE data was saved to (string)
%   bScanParm.wavlen            Wavelength of the transducer (double; in mm)
%   bScanParm.TransName         Name of the transducer (string)
%   bScanParm.TransFreq         Transducer Center Frequency (double; in MHz)
%   bScanParm.numFrames         AMAQ: What is this
%   bScanParm.ConfFile          The file used to create bScanParm (string)
%   bScanParm.script            The script root for the ConfFile (string)
%   bScanParm.Format            Structure that contains directories and files
%       bScanParm.Format.local                Path for the AE data (string)
%       bScanParm.Format.remote               Path for the PE data (string)
%       bScanParm.Format.date                 Date of scan (string) 
%       bScanParm.Format.filename             File Root name (no extension)(string)
%       bScanParm.Format.raw_pe               If Raw PE was saved (Boolean; =1)
%       bScanParm.Format.reconstructed_pe     If Reconstructed PE was saved (Boolean; =1)
%       bScanParm.Format.ae_dir               Directory for AE files (string)
%       bScanParm.Format.pe_dir               Directory for PE files (string)
%       bScanParm.Format.verasonics_IP        IP address for VSX (string)
%       bScanParm.Format.NI_IP                IP address for NI (string)
%       bScanParm.Format.filename2            File Root name (with scan parameters included)(string)
%       bScanParm.Format.Save_One             If Save One File Only was selected (Boolean; =1)
%       bScanParm.Format.Save_Avg             If Save Average was selected (Boolean; =1)
%       bScanParm.Format.PE_Pulse             AMAQ: Not sure what this is
%   bScanParm.Daq               Structure that contains DAQ info
%       bScanParm.Daq.HF              Structure that contains HF DAQ parameters
%           bScanParm.Daq.HF.PulseRate        Ultrasound pulse rate (double; in Hz)
%           bScanParm.Daq.HF.Rate_mhz         Sampling frequency (double; in MHz)
%           bScanParm.Daq.HF.Samples          Number of samples taken for a given imaging depth (double) 
%           bScanParm.Daq.HF.Gain             Digital gain on HF board (double)
%           bScanParm.Daq.HF.Range            Sampling range of HF board (double; in V)
%           bScanParm.Daq.HF.Channels         HF channels used (string)
%       bScanParm.Daq.LF              Structure that contains LF DAQ parameters used 
%           bScanParm.Daq.LF.Rate_hz          Sampling frequency (double; in kHz)
%           bScanParm.Daq.LF.Samples          Number of LF samples (based on slow time waveform) (double)
%           bScanParm.Daq.LF.Gain             Analog gain on the LF side (double)
%           bScanParm.Daq.LF.Range            Sampling range of LF board (double; in V)
%           bScanParm.Daq.LF.Channels         LF channels used (string)
%       bScanParm.Daq.PulseMode       If Pulse mode was used instead of burst mode (Boolean; =1)
%       bScanParm.Daq.UseNI           If NI should be used in the scan or just VSX is run (Boolean; =1)
%       bScanParm.Daq.STimeFilt       If slow time filter should be used in displaying the scan on NI GUI (Boolean; =1)
%       bScanParm.Daq.FilterDisplay   If fast time filter should be used in displaying the scan on NI GUI (Boolean; =1)
%   bScanParm.Scan              Structure that contains info on the scan  
%       bScanParm.Scan.Xpt            Number of x points in scan (double)
%       bScanParm.Scan.XDist          Range of x scan (double; in mm)
%       bScanParm.Scan.Ypt            Number of y points in scan (double)
%       bScanParm.Scan.YDist          Range of y scan (double; in mm)
%       bScanParm.Scan.SlowAxis       AMAQ: What is this and how is it used
%       bScanParm.Scan.FastAxis       AMAQ: What is this and how is it used
%       bScanParm.Scan.Duration_ms    Duration of the scan (double; in ms)
%       bScanParm.Scan.Sound_Speed    Speed of sound in the medium (double; in m/s)
%       bScanParm.Scan.Tpt            Number of time points collected (double)
%       bScanParm.Scan.steps          AMAQ: What is this and how is it used
%       bScanParm.Scan.Avg            Number of averages at each scan point (double)
%       bScanParm.Scan.Type           Type of scan (focused, plane, cone) (string)
%       bScanParm.Scan.ZDist          Range of z scan (double; in mm)
%       bScanParm.Scan.Zpt            Number of z points in scan (double)
%       bScanParm.Scan.pts            Total number of x,y,z,t points (double)
%       bScanParm.Scan.dtheta         AMAQ: Is this in radians or degrees dtheta step size for steering
%       bScanParm.Scan.ThetaRange     AMAQ: Is this in radians or degrees Range of angles 
%       bScanParm.Scan.PE_fps         Frames per second in the pulse echo movies (double)
%   bScanParm.Stim              Structure that contains info on the stimulation parameters      
%       bScanParm.Stim.IsChirp        If chirp was used in the scan (Boolean; =1) 
%       bScanParm.Stim.Amplitude      Amplitude of injected signal (double; V) 
%       bScanParm.Stim.Duration       AMAQ: What is this and how is it used
%       bScanParm.Stim.Waveform       Type of Waveform (Sin, Pls, ECG, etc.) (string) 
%       bScanParm.Stim.Width          Width of pulse (double; in ms) 
%       bScanParm.Stim.Cycles         Number of cycles in a burst (double) 
%       bScanParm.Stim.Frequency      Frequency of waveform (double; in Hz) 
%       bScanParm.Stim.Delay          Delay of pulse (double; in ms) 
%       bScanParm.Stim.Period         Period of pulse (double; in ms) 
%       bScanParm.Stim.IP             IP address of function generator (string) 
%       bScanParm.Stim.Ag             (1x2 Instrument Object Array)
%       bScanParm.Stim.tcp            (1x1 tcpip)
%       bScanParm.Stim.Phys_Trig      If physiologic triggering selected (Boolean; =1) 
%       bScanParm.Stim.Ext_Trig       If VSX expects trigger from the function generator (Boolean; =1) 
%   bScanParm.Velmex            Structure that contains info on the velmex/or any 2D scan      
%       bScanParm.Velmex.X            Defines which motor axis is X (double) 
%       bScanParm.Velmex.Y            Defines which motor axis is Y (double) 
%       bScanParm.Velmex.Speed        AMAQ: What are the units of speed used 
%       bScanParm.Velmex.Pause        AMAQ: What are the units of pause 
%       bScanParm.Velmex.Port         Defines the COM port used (double) 
%       bScanParm.Velmex.Axis         AMAQ: What is this and how is it used? 
%       bScanParm.Velmex.Motor        AMAQ: What is this and how is it used
%   bScanParm.nScanPt           Number of scan points (x*y) (double)
%   bScanParm.xlen              Range of x scan (double; in mm)
%   bScanParm.ylen              Range of y scan (double; in mm)
%   bScanParm.XSteps            Number of x steps in scan (double)
%   bScanParm.YSteps            Number of y steps in scan (double)
%   bScanParm.vsx_fs            AMAQ: What is this and how is it used?
%   bScanParm.daq               Structure that defines more daq parameters
%       bScanParm.daq.HFdaq           Structure that defines HF DAQ parameters 
%           bScanParm.daq.HFdaq.fs_MHz          Sampling frequency of HF board (double; in MHz)             
%           bScanParm.daq.HFdaq.pts             Number of HF sample (double)
%           bScanParm.daq.HFdaq.pulseRepRate_Hz Ultrasound pulse rate (double; in Hz) 
%           bScanParm.daq.HFdaq.NoBurstTriggers Number of triggers in a scan (double) 
%           bScanParm.daq.HFdaq.duration_ms     Duration of scan (double; in ms) 
%       bScanParm.daq.LFdaq           Structure that defines LF DAQ parameters 
%           bScanParm.daq.LFdaq.fs_Hz           Sampling frequency of LF board (double; in Hz) 
%           bScanParm.daq.LFdaq.pts             Number of LF samples (double) 
%   bScanParm.velmex            Structure that defines more velmex parameters 
%       bScanParm.velmex.XNStep                 Number of x points (double)
%       bScanParm.velmex.YNStep                 Number of y points (double)
%       bScanParm.velmex.XDist                  X range (double; in mm) 
%       bScanParm.velmex.YDist                  Y range (double; in mm)
%       bScanParm.velmex.SlowAxis               Slow Time Axis (string) 
%       bScanParm.velmex.FastAxis               Fast Time Axis (string)
fid = fopen(strcat(bScanParm.Format.filename2,'_HF_Avg.dat'));
HFData = fscanf(
%% @002 