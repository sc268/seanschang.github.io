"""
Example script that scrapes data from the IEM ASOS download service
https://github.com/akrherz/iem/blob/master/scripts/asos/iem_scraper_example.py
modified by Sean Chang 2016
"""
import json
import datetime
import urllib2

# timestamps in UTC to request data for
startts = datetime.datetime(2014, 1, 1) 
#startts = datetime.datetime(2015, 12, 21)
endts = datetime.datetime(2016, 1, 1)

#states = " NY "
# IEM quirk to have Iowa AWOS sites in its own labeled network
#networks = ['AWOS']
#for state in states.split():
 #   networks.append("%s_ASOS" % (state,))

SERVICE  = "http://mesonet.agron.iastate.edu/cgi-bin/request/asos.py?data=all"
starttime = startts.strftime('year1=%Y&month1=%m&day1=%d&')
endtime   = endts.strftime('year2=%Y&month2=%m&day2=%d&')

labels = [('ATL', """America%2FNew_York"""),('ORD', """America%2FChicago"""), 
		  ('CLT', """America%2FNew_York"""),('DFW', """America%2FChicago"""), 
		  ('IAH', """America%2FNew_York"""),('LAX', """America%2FLos_Angeles"""), 
          ('JFK', """America%2FNew_York"""),('SFO', """America%2FLos_Angeles""") ]

for label in labels:
	faaid    = label[0]
	timezone = label[1]
	uri = '%s&tz=%s&format=comma&latlon=yes&%s%s&station=%s' % (SERVICE, timezone, starttime, endtime, faaid)
	print uri
	print 'Network: %s Downloading: %s' % (faaid, timezone)
	data = urllib2.urlopen(uri)
	#outfn = './data/%s_%s_%s.txt' % (faaid, startts.strftime("%Y%m%d"),
  #                                     endts.strftime("%Y%m%d"))
	outfn = './data/%s.txt' % faaid
	out = open(outfn, 'w')
	out.write(data.read())
	out.close()

print 
print 
