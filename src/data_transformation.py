import pandas as pd
import base64

def lambda_handler(event, context):

    data = base64.b64encode(event['records']['data']).decode('utf-8')
    beer_modificated = cleaned_data(data)

    return beer_modificated

def cleaned_data(data):
  print('cleaned_data')
  df = pd.DataFrame(data, columns=['id', 'name', 'abv', 'ibu', 'target_fg', 'target_og', 'ebc', 'srm', 'ph'])

  return df