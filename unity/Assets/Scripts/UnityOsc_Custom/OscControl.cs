//
//	  UnityOSC - Example of usage for OSC receiver
//
//	  Copyright (c) 2012 Jorge Garcia Martin
//	  Last edit: Gerard Llorach 2nd August 2017
//
// 	  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// 	  documentation files (the "Software"), to deal in the Software without restriction, including without limitation
// 	  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
// 	  and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// 	  The above copyright notice and this permission notice shall be included in all copies or substantial portions 
// 	  of the Software.
//
// 	  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
// 	  TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// 	  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// 	  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// 	  IN THE SOFTWARE.
//

using UnityEngine;
using System;
using System.Net;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityOSC;

public class OscControl : MonoBehaviour {

	public enum OscMode { SEND, RECEIVE, SEND_RECEIVE };
	public OscMode oscMode = OscMode.SEND;
    public string outIP = "127.0.0.1";
    public int outPort = 9999;
    public int inPort = 9998;
	public int bufferSize = 100; // Buffer size of the application (stores 100 messages from different servers)
	public int rxBufferSize = 1024;
	public int sleepMs = 10;

	[HideInInspector] public Vector3 pos = Vector3.zero;

	private OSCServer myServer;

    // Script initialization
    void Start() {
        // init OSC
        OSCHandler.Instance.Init(); 

        // Initialize OSC clients (transmitters)
		if (oscMode == OscMode.SEND || oscMode == OscMode.SEND_RECEIVE) {
			OSCHandler.Instance.CreateClient("myClient", IPAddress.Parse(outIP), outPort);
		}
        
		if (oscMode == OscMode.RECEIVE || oscMode == OscMode.SEND_RECEIVE) {
			// Initialize OSC servers (listeners)
			myServer = OSCHandler.Instance.CreateServer("myServer", inPort);
			// Set buffer size (bytes) of the server (default 1024)
			myServer.ReceiveBufferSize = rxBufferSize;
			// Set the sleeping time of the thread (default 10)
			myServer.SleepMilliseconds = sleepMs;
		}
    }

	// Reads all the messages received between the previous update and this one
	void Update() {
		if (oscMode == OscMode.RECEIVE || oscMode == OscMode.SEND_RECEIVE) {
			// Read received messages
			for (var i = 0; i < OSCHandler.Instance.packets.Count; i++) {
				// Process OSC
				receivedOSC(OSCHandler.Instance.packets[i]);
				// Remove them once they have been read.
				OSCHandler.Instance.packets.Remove(OSCHandler.Instance.packets[i]);
				i--;
			}
		}

        // Send random number to the client
		if (oscMode == OscMode.SEND || oscMode == OscMode.SEND_RECEIVE) {
			float randVal = UnityEngine.Random.Range(0f, 0.7f);
			OSCHandler.Instance.SendMessageToClient("myClient", "/1/fader1", randVal);
		}
    }

    // Process OSC message
    private void receivedOSC(OSCPacket pckt) {
        if (pckt == null) { Debug.Log("Empty packet"); return; }

		OSCMessage msg = pckt.Data[0] as UnityOSC.OSCMessage;
		pos = new Vector2((float) msg.Data[2], (float) msg.Data[3]);
		pos.x = -pos.x;
		Debug.Log(msg.Data[0] + ", " + msg.Data[1] + ", " + msg.Data[2] + ", " + msg.Data[3] + ", " + msg.Data[4]);

		/*
        // Origin
        int serverPort = pckt.server.ServerPort;

        // Address
        string address = pckt.Address.Substring(1);

        // Data at index 0
        string data0 = pckt.Data.Count != 0 ? pckt.Data[0].ToString() : "null";

        // Print out messages
        Debug.Log("Input port: " + serverPort.ToString() + "\nAddress: " + address + "\nData [0]: " + data0);
		*/
    }

}