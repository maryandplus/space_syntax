import requests
import json
import os
import time

#specify api
overpass_url = "http://overpass-api.de/api/interpreter"

#use time out
def offline():
    time.sleep(10)

#try downloading specific data for Denmark    
try:

    
    overpass_query = """[out:json];area["ISO3166-1"="DK"][admin_level=2]->.searchArea;(node["shop"](area.searchArea););out center;"""
    response = requests.get(overpass_url,params={'data': overpass_query})
    data_shops = response.json()
    print('data_shops',data_shops)

    #create a list of downloaded data 
    dataset= [data_shops]

    geojson = {}
    geojson["type"] = "FeatureCollection"
    geojson["features"] = []

    for i in range(len(dataset)):


        for j in range(len(dataset[i]['elements'])):

            feature = {}
            feature["type"] = "Feature"
            feature["geometry"] = {}
            feature["geometry"]["type"] = "Point"
            feature["geometry"]["coordinates"] =dataset[i]['elements'][j]['lon'],dataset[i]['elements'][j]['lat']
            feature["properties"] = {}
            feature["properties"]["ID"] = dataset[i]['elements'][j]['id']
            feature["properties"]["type"] = dataset[i]['elements'][j]['tags']['shop']



            if 'name' in dataset[i]['elements'][j]['tags']:

                feature["properties"]["name"] = dataset[i]['elements'][j]['tags']['name']

            else:
                feature["properties"]["name"] = 'No_Name'

            geojson["features"].append(feature)


        with open(os.path.join(r'xxxxxxxxxxxxxxxxxxxx\osm_places','osm_denmark_shops.geojson'), 'w') as fp:
            json.dump(geojson, fp)
except:
    print('Error downloading', overpass_query)

offline()

try:


    
    overpass_query = """[out:json];area["ISO3166-1"="DK"][admin_level=2]->.searchArea;(node["amenity"](area.searchArea););out center;"""
    response = requests.get(overpass_url,params={'data': overpass_query})
    data_amenities = response.json()
    print('data_amenities',data_amenities)

    #create a list of downloaded data 
    dataset= [data_amenities]

    geojson = {}
    geojson["type"] = "FeatureCollection"
    geojson["features"] = []

    for i in range(len(dataset)):


        for j in range(len(dataset[i]['elements'])):

            feature = {}
            feature["type"] = "Feature"
            feature["geometry"] = {}
            feature["geometry"]["type"] = "Point"
            feature["geometry"]["coordinates"] =dataset[i]['elements'][j]['lon'],dataset[i]['elements'][j]['lat']
            feature["properties"] = {}
            feature["properties"]["ID"] = dataset[i]['elements'][j]['id']
            feature["properties"]["type"] = dataset[i]['elements'][j]['tags']['amenity']



            if 'name' in dataset[i]['elements'][j]['tags']:

                feature["properties"]["name"] = dataset[i]['elements'][j]['tags']['name']

            else:
                feature["properties"]["name"] = 'No_Name'

            geojson["features"].append(feature)


        with open(os.path.join(r'xxxxxxxxxxxxxx\osm_places','osm_denmark_amenities.geojson'), 'w') as fp:
            json.dump(geojson, fp)


except:
    print('Error downloading', overpass_query)


try:



    


    overpass_query = """[out:json];area["ISO3166-1"="DK"][admin_level=2]->.searchArea;(node["office"](area.searchArea););out center;"""
    response = requests.get(overpass_url,params={'data': overpass_query})
    data_offices = response.json()
    print('data_offices',data_offices)

    #create a list of downloaded data 
    dataset= [data_offices]

    geojson = {}
    geojson["type"] = "FeatureCollection"
    geojson["features"] = []

    for i in range(len(dataset)):


        for j in range(len(dataset[i]['elements'])):

            feature = {}
            feature["type"] = "Feature"
            feature["geometry"] = {}
            feature["geometry"]["type"] = "Point"
            feature["geometry"]["coordinates"] =dataset[i]['elements'][j]['lon'],dataset[i]['elements'][j]['lat']
            feature["properties"] = {}
            feature["properties"]["ID"] = dataset[i]['elements'][j]['id']
            feature["properties"]["type"] = dataset[i]['elements'][j]['tags']['office']



            if 'name' in dataset[i]['elements'][j]['tags']:

                feature["properties"]["name"] = dataset[i]['elements'][j]['tags']['name']

            else:
                feature["properties"]["name"] = 'No_Name'

            geojson["features"].append(feature)


        with open(os.path.join(r'xxxxxxxxxxxxx\osm_places','osm_denmark_offices.geojson'), 'w') as fp:
            json.dump(geojson, fp)

except:
    print('Error downloading', overpass_query)

offline()

try:



    


    overpass_query = """[out:json];area["ISO3166-1"="DK"][admin_level=2]->.searchArea;(node["leisure"](area.searchArea););out center;"""
    response = requests.get(overpass_url,params={'data': overpass_query})
    data_leisure = response.json()
    print('data_leisure',data_leisure)

    #create a list of downloaded data 
    dataset= [data_leisure]

    geojson = {}
    geojson["type"] = "FeatureCollection"
    geojson["features"] = []

    for i in range(len(dataset)):


        for j in range(len(dataset[i]['elements'])):

            feature = {}
            feature["type"] = "Feature"
            feature["geometry"] = {}
            feature["geometry"]["type"] = "Point"
            feature["geometry"]["coordinates"] =dataset[i]['elements'][j]['lon'],dataset[i]['elements'][j]['lat']
            feature["properties"] = {}
            feature["properties"]["ID"] = dataset[i]['elements'][j]['id']
            feature["properties"]["type"] = dataset[i]['elements'][j]['tags']['leisure']

            if 'name' in dataset[i]['elements'][j]['tags']:

                feature["properties"]["name"] = dataset[i]['elements'][j]['tags']['name']

            else:
                feature["properties"]["name"] = 'No_Name'

            geojson["features"].append(feature)


        with open(os.path.join(r'xxxxxxxxxxxx\osm_places','osm_denmark_leisure.geojson'), 'w') as fp:
            json.dump(geojson, fp)

except:
    print('Error downloading', overpass_query)




