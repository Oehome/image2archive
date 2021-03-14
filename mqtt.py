

#!python3
import paho.mqtt.client as mqtt  #import the client1
import time
import subprocess
import sys
import textile
import os

def on_connect(client, userdata, flags, rc):
    if rc==0:
        client.connected_flag=True #set flag
        print("connected OK")
        client.publish(myname+"/todo", "container_started")
        client.subscribe(myname+"/todo")
        client.publish(myname+"/rc_txt", "container_started")
        client.publish(myname+"/rc_html", "container_started")
    else:
        print("Bad connection Returned code=",rc)
        client.bad_connection_flag=True
  
def on_message(client, userdata, msg):
    wert=msg.payload.decode()
    print("message recieved: "+str(wert))
    if str(msg.payload.decode()) == "start":
       print(msg.payload.decode())
       client.publish(myname+"/todo", "null")
       value=run_exiftool()
       client.publish(myname+"/rc_txt", str(value))
       client.publish(myname+"/rc_html", textile.textile(str(value)))
       client.publish(myname+"/todo", "finished")


def on_disconnect(client, userdata, rc):
    print("disconnecting reason  "  +str(rc))
    client.connected_flag=False
    client.disconnect_flag=True

def on_publish(client,userdata,result):
    print("publish...")
    pass

def run_exiftool():
    result=subprocess.run([script], capture_output=True, text=True)
    print("stdout:", result.stdout)
    print("stderr:", result.stderr)
    return(str(result.stdout)+" "+str(result.stderr))

username=os.environ.get('BROKER_USER')
password=os.environ.get('BROKER_PASS')
broker=os.environ.get('BROKER_IPADDR')
port=int(os.environ.get('BROKER_PORT'))
#port=1883
timelive=60
myname="pic2archive"
script="/bin/pic2archive.sh"
#script="ls -la"
print("starting....")
client = mqtt.Client(myname)
client.username_pw_set(username=username,password=password)
client.connect(broker,port,timelive)
client.on_connect = on_connect
client.on_message = on_message
client.on_publish = on_publish
client.loop_forever()

