import os
import requests

# Load API token from environment variables
ANILIST_API_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImEwOTQ1MGFlYWI5OGU2MDk3ZTE2OWQzMjI5MzdmMDVkZGU4YmViYzc1N2Y5NzEwMzcwNzE5OGVjZjhjNjBmYmZmNTZiNGI1ZWFlOTk4MGQ0In0.eyJhdWQiOiIxMjMwMyIsImp0aSI6ImEwOTQ1MGFlYWI5OGU2MDk3ZTE2OWQzMjI5MzdmMDVkZGU4YmViYzc1N2Y5NzEwMzcwNzE5OGVjZjhjNjBmYmZmNTZiNGI1ZWFlOTk4MGQ0IiwiaWF0IjoxNjgyMTc1NjYzLCJuYmYiOjE2ODIxNzU2NjMsImV4cCI6MTcxMzc5ODA2Mywic3ViIjoiOTYyNTgiLCJzY29wZXMiOltdfQ.aDIC9uLhOEAkBwZL0hSrwYW9sfFr_ulSn4wWkbaCdPEPT5BcG7fjQ50LatmBbLbhroM9vp81pyUwaz3FeEZTLR15USDHlmIXvYSiDbVi0EmLDMNS5_LtuUhsSoVsXNlMKh-4le3e9ZtI8MnIjQ87gTNukmV3NIghOq1Awnzk-sIwCCmqjSO0Ke-DmpLu51I58g1XxmoOO6A_VasQcu-qrjq3Gq5jbc3OcilYS0L8ValOj2NG7VzApXr80_VCGctg9Q50XKUAwhcwSKg-OOQ5-Go5N3v7BnXxHPUHwMyGFZjetGX4vrVSrxg2tZ2Hv8Yg_PUOuuY7lT0HI6mCOsPV922AR6Zfr-etHwesdLU3l7bVOsK3X6OmfPHJsGhx_Hu6eHEM20LXv_mQQfOYf1nKtBJ3bAIMl3qIdXR34L0aDQWjxSGlqZyu2m67UkIQ0C_yZyXz7kOam9v3u3dGZdifYZcQQHPPmJPTMJly2P_13kXph2WSWHiLjDgbtBIr9dnuFjA88pZdSEQcHaqOKYycdTSQ2ZcCBLdt4JYrDp_fGkuAgurlU7ns9aGLN-DPGX-zpVSsFQmY7cCNtJPb8I5Euj3n11KQU8fAqRVgasQi7zlLSx_2lHP_dx0D0r00yL9ufG7zO1dTq7nCkJyuWMSs5vmbFMXboPHO3MGotjPyDUY"

api_url = "https://graphql.anilist.co"

def get_anime_id(search):
    query = """
    query ($search: String) {
        Media (search: $search, type: ANIME) {
            id
        }
    }
    """
    variables = {"search": search}
    response = requests.post(api_url, json={"query": query, "variables": variables})
    data = response.json()
    return data["data"]["Media"]["id"]

def update_anime_list(anime_id, progress):
    query = """
    mutation ($id: Int, $progress: Int) {
        SaveMediaListEntry (mediaId: $id, progress: $progress) {
            id
            progress
        }
    }
    """
    variables = {"id": anime_id, "progress": progress}
    headers = {"Authorization": f"Bearer {ANILIST_API_TOKEN}"}
    response = requests.post(api_url, json={"query": query, "variables": variables}, headers=headers)
    data = response.json()
    return data["data"]["SaveMediaListEntry"]

def has_video_files(folder_path, video_extensions=(".mkv", ".mp4", ".ts")):
    for file in os.listdir(folder_path):
        if file.endswith(video_extensions):
            return True
    return False

anime_directory = "/run/media/media_m/Anime/Airing/"

for folder in os.listdir(anime_directory):
    folder_path = os.path.join(anime_directory, folder)
    
    if os.path.isdir(folder_path) and folder != ".stfolder":
        episode_txt_path = os.path.join(folder_path, "episode.txt")
        
        if os.path.exists(episode_txt_path):
            with open(episode_txt_path, "r") as f:
                episode_number = int(f.read().strip())
                
            if not has_video_files(folder_path):
                anime_name = folder
                anime_id = get_anime_id(anime_name)
                updated_entry = update_anime_list(anime_id, episode_number)
                print(f"Updated {anime_name}: {updated_entry['progress']} episodes watched")
