
current_state = hass.states.get("input_select.current_state").state
current_temp = float(hass.states.get("sensor.indoor_temperature").state)
night = hass.states.get("binary_sensor.night").state
hour = datetime.datetime.now().hour


current_price = float(hass.states.get("sensor.power_price_oslo").state)
all_prices = hass.states.get("sensor.power_price_oslo").attributes.get('today') + hass.states.get("sensor.power_price_oslo").attributes.get('tomorrow')

in_1h_price = float(all_prices[hour+1])
in_2h_price = float(all_prices[hour+2])
	
# Price changes:
change_in_1h = (in_1h_price / current_price) - 1.0
change_in_2h = (in_2h_price / in_1h_price) - 1.0

# Chenge factor sets the relationships between price change and temperature change:
change_factor = 5

if current_state != "home" or night == "on":
	change_factor = change_factor * 2.0

change_temp = change_in_1h * change_factor + change_in_2h * change_factor/2
change_temp = round(change_temp, 1)

# Do not set temp too when home during the day:
if current_temp < 21 and current_state == 'home' and night == 'off' and change_temp < 0:
	change_temp = 0

hass.states.set("sensor.power_price_temp_change", change_temp, {
	'unit_of_measurement': '°C',
	'friendly_name': "Degrees to change due to power price",
	'icon': 'mdi:power-plug',
	'change_in_1h': round(change_in_1h, 2),
	'change_in_2h': round(change_in_2h, 2),
	'change_factor': change_factor,
})

# Set indoor temperture

preset_mode = hass.states.get("climate.kitchen").attributes.get('preset_mode')

if preset_mode == 'away':
	wanted_indoor_temperature = wanted_indoor_temperature - 1.0

