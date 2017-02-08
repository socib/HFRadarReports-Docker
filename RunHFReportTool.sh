#!/bin/bash
#script to run HFradar docker tool

#Setup directory to receive finished PDF report
report_output_directory_host=$HOME/HF_Radar

#Ensure the directory owner is current user
mkdir -p $report_output_directory_host;
chown `stat -c "%u:%g" $HOME` $report_output_directory_host

#Check Time arguments have been supplied
if [ $# -lt 2 ]; then
  echo "\nNot enough arguments!\n"
  echo "Usage: RunHRReportTool.sh yyyy mm"
  exit 
elif [ $# -gt 2 ]; then
  echo "\nToo many arguments!\n"
  echo "Usage: RunHRReportTool.sh yyyy mm"
  exit 
fi

#take time arguments passed to script
year=$1
month=$2

#run the docker image 
#setting up shared volumes, DNS server
docker run \
-v /data/current/opendap/observational/mooring/currentmeter/:/data/current/opendap/observational/mooring/currentmeter/ \
-v /home/radar/data_rt/radar_system_eivissa:/home/radar/data_rt/radar_system_eivissa \
-v $report_output_directory_host:/HFRadarReports/Reports \
-it --dns=172.16.135.60 --dns=172.16.135.61 \
--name hfradarcontainer \
socib/hfradarreports $year $month

##remove docker container
docker rm hfradarcontainer

#cleanup TOC file if present
rm -f $report_output_directory_host/*.toc 
