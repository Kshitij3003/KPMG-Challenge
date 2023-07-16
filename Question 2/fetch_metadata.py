import requests
import os
import json

def get_metadata(url, headers=None):
    """
  Get the metadata of an instance for the specified URL.

  Args:
    url: URL for which metadata has to look for.
    headers: contains the token to authenticate and access metadata

  Returns:
    The metadata of the instance in JSON format.
  """

    response = requests.get(url, headers=headers)
    if response.status_code != 200:
        raise ValueError("Failed to get metadata: " + response.status_code)
    metadata_content = response.content.decode("utf-8")
    metadata_key = metadata_content.strip().split('\n')
    metadata_dict = {}
    for line in metadata_key:
        key_value = line.split(':')
        if len(key_value) == 2:
            key = key_value[0].strip()
            value = key_value[1].strip()
            metadata_dict[key] = value
    json_output = json.dumps(metadata_dict, indent=4)
    with open('metadata.json', 'w') as file:
        file.write(json_output)

    return json_output


if __name__ == "__main__":
    url = input("Enter the URL for which you want to look for metadata:")
    key = input("Enter the Key to look for metadata:")
    token = os.environ.get("TOKEN")
    metadata = get_metadata(url, headers={"X-aws-ec2-metadata-token": token})
    print(metadata)