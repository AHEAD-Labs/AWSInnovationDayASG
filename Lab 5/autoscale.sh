#!/bin/bash
# script to find the region the instance is in and configure index.html to reference that
#
# get the region
AWS_REGION="$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)"
AWS_REGION=${AWS_REGION::-1}
# push index.html
echo "<html>" > /var/www/html/index.html
echo "<head>" >> /var/www/html/index.html
echo '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">' >> /var/www/html/index.html
echo '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">' >> /var/www/html/index.html
echo '<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>' >> /var/www/html/index.html
echo '<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>' >> /var/www/html/index.html
echo '<script type="text/javascript">' >> /var/www/html/index.html
echo "google.charts.load('current', {'packages':['geochart']});" >> /var/www/html/index.html
echo 'google.charts.setOnLoadCallback(drawRegionsMap);' >> /var/www/html/index.html
echo 'function drawRegionsMap() {' >> /var/www/html/index.html
if [ "$AWS_REGION" == "us-east-1" ] ; then
  echo "var data = google.visualization.arrayToDataTable([['State', 'Select'],['US-VA', 1],]);" >> /var/www/html/index.html
elif [ "$AWS_REGION" == "us-east-2" ] ; then
  echo "var data = google.visualization.arrayToDataTable([['State', 'Select'],['US-OH', 1],]);" >> /var/www/html/index.html
elif [ "$AWS_REGION" == "us-west-1" ] ; then
  echo "var data = google.visualization.arrayToDataTable([['State', 'Select'],['US-CA', 1],]);" >> /var/www/html/index.html
elif [ "$AWS_REGION" == "us-west-2" ] ; then
  echo "var data = google.visualization.arrayToDataTable([['State', 'Select'],['US-OR', 1],]);" >> /var/www/html/index.html
fi
echo 'var options = {' >> /var/www/html/index.html
echo "region: 'US'," >> /var/www/html/index.html
echo "colorAxis: {colors: ['#B40937', '#B40937']}," >> /var/www/html/index.html
echo "displayMode: 'regions'," >> /var/www/html/index.html
echo "resolution: 'provinces'," >> /var/www/html/index.html
echo "legend: 'none'," >> /var/www/html/index.html
echo '};' >> /var/www/html/index.html
echo "var chart = new google.visualization.GeoChart(document.getElementById('regions_div'));" >> /var/www/html/index.html
echo 'chart.draw(data, options);' >> /var/www/html/index.html
echo '}' >> /var/www/html/index.html
echo '</script>' >> /var/www/html/index.html
echo '<title>AHEAD Innovation Day</title>' >> /var/www/html/index.html
echo '</head>' >> /var/www/html/index.html
echo '<body>' >> /var/www/html/index.html
echo '<div class="jumbotron">' >> /var/www/html/index.html
echo '<div class="container">' >> /var/www/html/index.html
echo '<h1>AHEAD INNOVATION DAY</h1>' >> /var/www/html/index.html
echo '<h2>Autoscaling Lab</h2>' >> /var/www/html/index.html
echo '<p>Where in the US is your EC2 instance?</p>' >> /var/www/html/index.html
echo '</div>' >> /var/www/html/index.html
echo '</div>' >> /var/www/html/index.html
echo '<div class="center-block" id="regions_div" style="width: 900px; height: 500px;"></div>' >> /var/www/html/index.html
# get instance details from instance metadata
INSTANCE_ID="$(curl http://169.254.169.254/latest/meta-data/instance-id)"
INSTANCE_TYPE="$(curl http://169.254.169.254/latest/meta-data/instance-type)"
LOCAL_HOSTNAME="$(curl http://169.254.169.254/latest/meta-data/local-hostname)"
LOCAL_IP="$(curl http://169.254.169.254/latest/meta-data/local-ipv4)"
PUBLIC_HOSTNAME="$(curl http://169.254.169.254/latest/meta-data/public-hostname)"
PUBLIC_IP="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)"
AVAILABILITY_ZONE="$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)"
echo '<div class="container">' >> /var/www/html/index.html
echo '<h4>INSTANCE DETAILS</h4><br>' >> /var/www/html/index.html
echo '<b>instance id</b> - ' $INSTANCE_ID '<br>' >> /var/www/html/index.html
echo '<b>instance type</b> - ' $INSTANCE_TYPE '<br>' >> /var/www/html/index.html
echo '<b>local hostname</b> - ' $LOCAL_HOSTNAME '<br>' >> /var/www/html/index.html
echo '<b>local ip</b> - ' $LOCAL_IP '<br>' >> /var/www/html/index.html
echo '<b>public hostname</b> - ' $PUBLIC_HOSTNAME '<br>' >> /var/www/html/index.html
echo '<b>public ip</b> - ' $PUBLIC_IP '<br>' >> /var/www/html/index.html
echo '<b>region</b> - ' $AWS_REGION '<br>' >> /var/www/html/index.html
echo '<b>availability zone</b> - ' $AVAILABILITY_ZONE '<br><br>' >> /var/www/html/index.html
echo '</div>' >> /var/www/html/index.html
echo '<div>' >> /var/www/html/index.html
echo '<footer class="footer">' >> /var/www/html/index.html
echo '<div class="container">' >> /var/www/html/index.html
echo '<p class="text-muted"><a href="https://www.thinkahead.com/">AHEAD</a></p>' >> /var/www/html/index.html
echo '</div>' >> /var/www/html/index.html
echo '</footer>' >> /var/www/html/index.html
echo '</body>' >> /var/www/html/index.html
echo '</html>' >> /var/www/html/index.html
