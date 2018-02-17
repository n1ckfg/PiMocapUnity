using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PiMocapReceiver : MonoBehaviour {

    public OscControl osc;
    public Transform dot1;
    public Transform dot2;
    public Transform dot3;
    public float scale = 1f;

    private void Update() {
        dot1.position = osc.pos1;
        dot2.position = osc.pos2;
        Vector3 newPos = Vector3.Lerp(dot1.position, dot2.position, 0.5f);
        newPos.z = Vector3.Distance(dot1.position, dot2.position);

        float x = map(newPos.x, 0f, 1f, -scale, scale);
        float y = map(newPos.y, 0f, 1f, -scale, scale);
        float z = map(newPos.z, 0f, 1f, -scale, scale);

        dot3.position = new Vector3(x, y, z);
    }

    private float map(float s, float a1, float a2, float b1, float b2) {
        return b1 + (s - a1) * (b2 - b1) / (a2 - a1);
    }

}
