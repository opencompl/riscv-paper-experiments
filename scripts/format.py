"""
Usage: python format.py test.txt.format '{"Name": "World"}'
"""

import json
import sys


def format_text_with_json(text, json_data):
    # Load JSON data into Python context
    json_dict = json.loads(json_data)
    # Add JSON data to local context
    locals().update(json_dict)

    # Convert text to an f-string

    try:
        formatted_text = eval(f'f"""{text}"""')
        return formatted_text
    except Exception as e:
        print("Error occurred while formatting the text:", e)
        return None


def main():
    # Check if correct number of arguments are provided
    if len(sys.argv) != 3:
        print("Usage: python script.py <path_to_text_file> <json_string>")
        sys.exit(1)

    text_file_path = sys.argv[1]
    json_string = sys.argv[2]

    # Load text from file
    try:
        with open(text_file_path, "r") as file:
            text = file.read()
    except FileNotFoundError:
        print(f"Error: File '{text_file_path}' not found.")
        sys.exit(1)
    except Exception as e:
        print("An error occurred while reading the file:", e)
        sys.exit(1)

    # Format text with JSON data
    formatted_text = format_text_with_json(text, json_string)
    if formatted_text is not None:
        print(formatted_text)


if __name__ == "__main__":
    main()
