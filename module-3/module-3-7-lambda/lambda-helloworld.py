print('Loading function')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    heiverden="Hei Verden"
    print(heiverden)
    return heiverden
    #raise Exception('Something went wrong')
