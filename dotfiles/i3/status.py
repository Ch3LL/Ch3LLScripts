from i3pystatus import Status

status = Status()

status.register("clock", format="%a %-d %b %X KW%V",)

status.register("battery",
    format="{status} {remaining:%E%hh:%Mm}",
    alert=True,
    alert_percentage=5,
    status={
        "DIS":  "Discharging",
        "CHR":  "Charging",
        "FULL": "Bat full",
    },)


status.run()
