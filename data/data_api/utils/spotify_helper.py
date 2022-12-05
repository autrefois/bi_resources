from dotenv import load_dotenv
import numpy as np
import os
import pandas as pd
import requests

import spotipy
from spotipy.oauth2 import SpotifyClientCredentials


# load global variables
load_dotenv(dotenv_path='credentials.env')

SPOTIPY_CLIENT_ID = os.getenv('SPOTIPY_CLIENT_ID')
SPOTIPY_CLIENT_SECRET = os.getenv('SPOTIPY_CLIENT_SECRET')
SPOTIFY_BASE_URL = 'https://api.spotify.com/v1/'
SPOTIFY_AUTH_URL = 'https://accounts.spotify.com/api/token'

class SpotifyHelper():

    def __init__(self):

        self.spotify = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials())
        auth_response = requests.post(SPOTIFY_AUTH_URL, {
                                                            'grant_type': 'client_credentials',
                                                            'client_id': SPOTIPY_CLIENT_ID,
                                                            'client_secret': SPOTIPY_CLIENT_SECRET,
                                                                })

        auth_response_data = auth_response.json()
        access_token = auth_response_data['access_token']
        self.headers = {'Authorization': 'Bearer {token}'.format(token=access_token)}


    def get_artist_details(self, artist):
        result = self.spotify.search(artist)
        # print(result)
        artist_details = {
            'artist_id': result['tracks']['items'][0]['album']['artists'][0]['id'],
            'full_name': artist
        }
        return pd.DataFrame([artist_details]) 

    
    def get_artist_tracks(self, artist):

        result = self.spotify.search(artist)
        artist_id = result['tracks']['items'][0]['album']['artists'][0]['id']
        artist_items = result['tracks']['items']
        items = pd.DataFrame(artist_items)

        # add some bad data
        items = pd.concat([items, items], ignore_index=True)
        items.loc[items.iloc[-1].name + 1,:] = np.nan


        # add artist
        items['artist_id'] = artist_id

        return items
