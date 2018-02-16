using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PiMocapReceiver : MonoBehaviour {

    public OscControl osc;
    public Transform dot1;

	private void Update() {
        dot1.position = osc.pos;
	}

}
