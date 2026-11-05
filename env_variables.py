from pathlib import Path

from dotenv import dotenv_values


def get_variables():
    values = dotenv_values(Path(__file__).with_name(".env"))
    env_names = {
        "URL": "SAUCEDEMO_URL",
        "USERNAME": "SAUCEDEMO_USERNAME",
        "PASSWORD": "SAUCEDEMO_PASSWORD",
    }
    missing = [name for name in env_names.values() if not values.get(name)]
    if missing:
        raise ValueError(f"Missing required values in .env: {', '.join(missing)}")

    return {variable: values[name] for variable, name in env_names.items()}
