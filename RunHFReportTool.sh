#script to run HFradar docker tool

docker_image_name=tequila_test

report_output_directory_host=/home/grogers/Reports

year=2016
month=1

docker run -v /data/current/opendap/observational/mooring/currentmeter/:/data/current/opendap/observational/mooring/currentmeter/ -v /home/radar/data_rt/radar_system_eivissa:/home/radar/data_rt/radar_system_eivissa -v $report_output_directory_host:/HFRadarReports/Reports -it --dns=172.16.135.60 --dns=172.16.135.61 $docker_image_name $year $month