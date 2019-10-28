import json

def sum_list(usage):
  s = 0
  for date, count in usage.items():
    s += count
  return s

with open('data.json') as f:
  d = json.load(f)

usage = d['Usage']

app_opens = usage.get('app_opens')
swipe_likes = usage.get('swipes_likes')
swipe_passes = usage.get('swipes_passes')
matches = usage.get('matches')
tx_msg = usage.get('messages_sent')
rx_msg = usage.get('messages_received')

opens = sum_list(app_opens)
likes = sum_list(swipe_likes)
passes = sum_list(swipe_passes)
swipes = likes + passes
matched = sum_list(matches)
non_matched = likes - matched
sent = sum_list(tx_msg)
received = sum_list(rx_msg)

match_rate = matched/likes
response_rate = received/sent

print(f'Tinder statistics:\nSwipes: {swipes}\nSwipe like: {likes}\nSwipe pass: {passes}\nNon match: {non_matched}\nMatches: {matched} \t\t\tMatch Rate: {match_rate}\nSent messages: {sent}\nReceived messages: {received}\t\tResponse rate: {response_rate}')

messages = d.get('Messages')
contacted = len(messages)
no_contact = matched - contacted

one_msg = 0
for msg in messages:
    if len(msg['messages']) == 1:
        one_msg += 1

convo = contacted - one_msg
convo_rate = convo/contacted

print(f'\nConversation details:\nContacted: {contacted}\nNo contact: {no_contact}\nOne message: {one_msg}\nConversation: {convo}\t\tConversation rate: {convo_rate}')
