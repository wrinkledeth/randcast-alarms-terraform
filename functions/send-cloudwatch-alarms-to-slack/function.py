import urllib3
import json

slack_url = (
    "https://hooks.slack.com/services/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"
)
http = urllib3.PoolManager()


def get_alarm_attributes(sns_message):
    alarm = dict()

    alarm["name"] = sns_message["AlarmName"]
    alarm["description"] = sns_message["AlarmDescription"]
    alarm["reason"] = sns_message["NewStateReason"]
    alarm["region"] = sns_message["Region"]
    alarm["state"] = sns_message["NewStateValue"]
    alarm["previous_state"] = sns_message["OldStateValue"]

    return alarm


def send_slack_notification(alarm):
    return {
        "type": "home",
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": ":tada: Alarm: " + alarm["name"],
                },
            },
            {"type": "divider"},
            {
                "type": "section",
                "text": {"type": "mrkdwn", "text": "_" + alarm["reason"] + "_"},
                "block_id": "text1",
            },
            {"type": "divider"},
            {
                "type": "context",
                "elements": [
                    {"type": "mrkdwn", "text": "Region: *" + alarm["region"] + "*"}
                ],
            },
        ],
    }


def lambda_handler(event, context):
    # print("Event:")
    # print("-------------------------")
    # print(event)
    # print("Context:")
    # print("-------------------------")
    # print(context)
    sns_message = json.loads(event["Records"][0]["Sns"]["Message"])
    alarm = get_alarm_attributes(sns_message)

    msg = str()

    # if alarm["previous_state"] == "INSUFFICIENT_DATA" and alarm["state"] == "OK":
    #     msg = register_alarm(alarm)
    # elif alarm["previous_state"] == "INSUFFICIENT_DATA" and alarm["state"] == "ALARM":
    #     msg = activate_alarm(alarm)
    # elif alarm["previous_state"] == "OK" and alarm["state"] == "ALARM":
    #     msg = activate_alarm(alarm)
    # elif alarm["previous_state"] == "ALARM" and alarm["state"] == "OK":
    #     msg = resolve_alarm(alarm)

    if (
        alarm["previous_state"] == "INSUFFICIENT_DATA"
        or alarm["previous_state"] == "OK"
        and alarm["state"] == "ALARM"
    ):
        msg = send_slack_notification(alarm)

    # encoded_msg = json.dumps(msg).encode("utf-8")
    # print("MSG")
    # print(msg)
    # print("TEXT_DICT")
    # print(text_dict)
    # text_dict = dict(text=msg)
    encoded_msg = json.dumps(msg).encode("utf-8")

    print("ENCODED MSG")
    print("-------------------------")
    print(encoded_msg)

    resp = http.request("POST", slack_url, body=encoded_msg)
    print(
        {
            "message": msg,
            "status_code": resp.status,
            "response": resp.data,
        }
    )


# def register_alarm(alarm):
#     return {
#         "type": "home",
#         "blocks": [
#             {
#                 "type": "header",
#                 "text": {
#                     "type": "plain_text",
#                     "text": ":warning: " + alarm["name"] + " alarm was registered",
#                 },
#             },
#             {"type": "divider"},
#             {
#                 "type": "section",
#                 "text": {"type": "mrkdwn", "text": "_" + alarm["description"] + "_"},
#                 "block_id": "text1",
#             },
#             {"type": "divider"},
#             {
#                 "type": "context",
#                 "elements": [
#                     {"type": "mrkdwn", "text": "Region: *" + alarm["region"] + "*"}
#                 ],
#             },
#         ],
#     }


# def activate_alarm(alarm):
#     return {
#         "type": "home",
#         "blocks": [
#             {
#                 "type": "header",
#                 "text": {
#                     "type": "plain_text",
#                     "text": ":red_circle: Alarm: " + alarm["name"],
#                 },
#             },
#             {"type": "divider"},
#             {
#                 "type": "section",
#                 "text": {"type": "mrkdwn", "text": "_" + alarm["reason"] + "_"},
#                 "block_id": "text1",
#             },
#             {"type": "divider"},
#             {
#                 "type": "context",
#                 "elements": [
#                     {"type": "mrkdwn", "text": "Region: *" + alarm["region"] + "*"}
#                 ],
#             },
#         ],
#     }


# def resolve_alarm(alarm):
#     return {
#         "type": "home",
#         "blocks": [
#             {
#                 "type": "header",
#                 "text": {
#                     "type": "plain_text",
#                     "text": ":large_green_circle: Alarm: "
#                     + alarm["name"]
#                     + " was resolved",
#                 },
#             },
#             {"type": "divider"},
#             {
#                 "type": "section",
#                 "text": {"type": "mrkdwn", "text": "_" + alarm["reason"] + "_"},
#                 "block_id": "text1",
#             },
#             {"type": "divider"},
#             {
#                 "type": "context",
#                 "elements": [
#                     {"type": "mrkdwn", "text": "Region: *" + alarm["region"] + "*"}
#                 ],
#             },
#         ],
#     }
