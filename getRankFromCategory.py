import xml.etree.ElementTree as ET
from operator import itemgetter
import boto3
import json

DEFAULT_BUCKET = 'xmlfilerepository'
s3 = boto3.resource('s3')
usingNamespace = {'': 'http://www.orienteering.org/datastandard/3.0'}

def lambda_handler(event, context):
    content = event['body']
    #get ID XML file
    raceId = event['queryStringParameters']['raceId']   #check name in URL
    #egt category from URL
    category = event['queryStringParameters']['className']  #check name in URL

    xmlObj = s3.object(DEFAULT_BUCKET, raceId) #verificare che si possa usare get root e parse su object
    # in alternativa cercare metodo esempio s3.get item no GetXMLString

    myTree = ET.parse(xmlObj['Body'])
    myRoot = myTree.getroot()
   
    classificaFinale = []
    classificaFinaleOrdinata=[]
    for athlete in myRoot.findall('.//PersonResult', usingNamespace):
        atName = athlete.findall('.//Given', usingNamespace)
        atSurname = athlete.findall('.//Family', usingNamespace)
        atposition = athlete.findall('.//Position', usingNamespace)
        atcategory = athlete.findall('.//Course/Name', usingNamespace)
        name = ([a.text for a in atName])
        surname = ([b.text for b in atSurname])
        position = ([c.text for c in atposition])
        categor = ([d.text for d in atcategory])

        f = [position, name, surname, categor]
        if categor == category:
            classificaFinale.append(f)

        else:
            continue

    #  classificaFinaleOrdinata = sorted(classificaFinale, key=itemgetter(0))
    #  classificaFinaleOrdinata = sorted(classificaFinale, key=lambda x:x[0])

    #avendo messeo volutamente come primo elemento la posizione in classifica, posso usare semplicemente sort
    classificaFinaleOrdinata=classificaFinale.sort()

    #se voglio ritornare json
    #body = json.dumps(classificaFinaleOrdinata)

    return{
        'code': 200,
        'body': classificaFinaleOrdinata
        #se voglio ritornare jason
        #'body'=body
    }