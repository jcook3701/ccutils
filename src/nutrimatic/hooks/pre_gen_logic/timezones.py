"""nutri-matic Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
"""

import json
import zoneinfo
from pathlib import Path

# 1. Filter and Sort the zones (using the previous filter logic)
filtered_zones = [
    tz
    for tz in zoneinfo.available_timezones()
    if "/" in tz and not tz.startswith(("Etc/", "SystemV/", "US/"))
]

all_timezones = sorted(filtered_zones)

# 2. Reorder the list to prioritize "America/Los_Angeles"
preferred_zone = "America/Los_Angeles"

if preferred_zone in all_timezones:
    # Remove it from its sorted place
    all_timezones.remove(preferred_zone)
    # Insert it at the very beginning (index 0)
    all_timezones.insert(0, preferred_zone)

# 3. Load existing config and update
config_path = Path("cookiecutter.json")
data = json.loads(config_path.read_text())

# Update the 'timezone' key with the reordered list
data["timezone"] = all_timezones

# Write back to the temporary cookiecutter.json
config_path.write_text(json.dumps(data, indent=4))
