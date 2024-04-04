"""
Usage: python format.py test.txt.format '{"Name": "World"}'
"""

import json
import re
import sys


def format_text_with_json(text, json_data):
    # Load JSON data into Python context
    json_dict = json.loads(json_data)
    # Add JSON data to local context

    # Use regex to match only the content within double curly braces
    def replace_match(match):
        expr = match.group(1)
        try:
            return str(eval(expr, globals(), json_dict))
        except Exception as e:
            print(f"Error occurred while evaluating expression '{expr}': {e}")
            return match.group(0)

    formatted_text = re.sub(r"\{\{(.*?)\}\}", replace_match, text)
    return formatted_text


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
