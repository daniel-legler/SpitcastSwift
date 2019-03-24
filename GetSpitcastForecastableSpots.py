from requests_html import HTMLSession
session = HTMLSession()
counties = ["Del-Norte","Humboldt","Sonoma","Mendocino","Marin","San-Francisco","San-Mateo","Santa-Cruz","Monterey","San-Luis-Obispo","Santa-Barbara","Ventura","Los-Angeles","Orange-County","San-Diego"]

result = []
for c in counties:
    r = session.get('http://www.spitcast.com/surf-report/county/' + c)
    for element in r.html.find('.spot_forecast'):
        id = element.attrs['id']
        if id.startswith('spot'): continue
        result.append(int(id))
print(sorted(result))
