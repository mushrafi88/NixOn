from bs4 import BeautifulSoup
import requests
import json
from urllib.request import urlopen
import sys
import datetime
import time


def name_id(id_no):
    query = """
    query ($id: Int) { # Define which variables will be used in the query (id)
    Media (id: $id) { # Insert our variables into the query arguments (id) (type: ANIME is hard-coded in the query)
      title {
        romaji
        english
        userPreferred
        }
      nextAiringEpisode{
                    id
                    }
          }
    }
    """
    variables = {"id": id_no}
    url = "https://graphql.anilist.co"
    response = requests.post(url, json={"query": query, "variables": variables})
    data = response.json()
    name = data["data"]["Media"]["title"]["userPreferred"]
    id_for_airing = data["data"]["Media"]["nextAiringEpisode"]["id"]
    return name, id_for_airing


def airing_time(id_for_airing):
    query = """
    query ($id: Int) { # Define which variables will be used in the query (id)
    AiringSchedule (id: $id) { # Insert our variables into the query arguments (id) (type: ANIME is hard-coded in the query)
         airingAt
         episode
       }
    }
    """
    variables = {"id": id_for_airing}
    url = "https://graphql.anilist.co"
    response = requests.post(url, json={"query": query, "variables": variables})
    data = response.json()
    t = data["data"]["AiringSchedule"]["airingAt"]
    epoch = t
    episode = data["data"]["AiringSchedule"]["episode"]
    airing_t = datetime.datetime.fromtimestamp(t).strftime("%a - %I:%M %p")
    return airing_t, episode, epoch


def mahayana(l):
    name, id_for_airing = name_id(l)
    airing_t, episode, epoch = airing_time(id_for_airing)
    if epoch - time.time() < 2 * 24 * 3600:
        print(f"{name} Episode {episode} airing at {airing_t}")


li = []

with open("$HOME/.config/animdl/anime-list.txt", "r") as filehandle:
    for line in filehandle:
        cur = line[:-1]
        li.append(cur)

for l in li:
    mahayana(l)
