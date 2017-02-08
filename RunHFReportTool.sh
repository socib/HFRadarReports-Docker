#!/bin/bash
#script to run HFradar docker tool

report_output_directory_host=$HOME/Reports

if [ $# -lt 2 ]; then
  echo "\nNot enough arguments!\n"
  echo "Usage: RunHRReportTool.sh yyyy mm"
  exit 
elif [ $# -gt 2 ]; then
  echo "\nToo many arguments!\n"
  echo "Usage: RunHRReportTool.sh yyyy mm"
  exit 
fi

#take arguments passed to script
year=$1
month=$2

docker run \
-v /data/current/opendap/observational/mooring/currentmeter/:/data/current/opendap/observational/mooring/currentmeter/ \
-v /home/radar/data_rt/radar_system_eivissa:/home/radar/data_rt/radar_system_eivissa \
-v $report_output_directory_host:/HFRadarReports/Reports \
-it --dns=172.16.135.60 --dns=172.16.135.61 \
--name hfradarcontainer \
socib/hfradarreports $year $month

##remove docker container
docker rm hfradarcontainer
