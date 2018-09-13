using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PiMocapReceiver : MonoBehaviour {

    public OscControl oscCtl;
	public Stroke strokePrefab;
    public float scale = 1f;

	private List<Stroke> strokes;

	private void Start() {
		strokes = new List<Stroke>();
	}

	private void Update() {
		List<Stroke.SPoint> pointsToAdd = new List<Stroke.SPoint>();

		for (int i = 0; i < oscCtl.maxDots; i++) {
			if (oscCtl.dot1[i] != null && oscCtl.dot2[i] != null) {
				Vector2 d1 = oscCtl.dot1[i];
				Vector2 d2 = oscCtl.dot2[i];
				float x = (d1.x + d2.x) / 2f;
				x = map(x, 0f, 1f, -scale, scale);

				float y = (d1.y + d2.y) / 2f;
				y = map(y, 0f, 1f, -scale, scale);

				float z = Vector2.Distance(d1, d2);
				z = map(z, 0f, 1f, -scale, scale);

				pointsToAdd.Add(new Stroke.SPoint(x, y, z, Time.realtimeSinceStartup));
			}
		}

		if (pointsToAdd.Count > strokes.Count) {
			for (int i = strokes.Count; i < pointsToAdd.Count; i++) {
				strokes.Add(Instantiate(strokePrefab));
			}
		}

		for (int i = 0; i < pointsToAdd.Count; i++) {
			strokes[i].addPoint(pointsToAdd[i]);
		}

		for (int i = 0; i < strokes.Count; i++) {
			if (strokes[i].aliveCounter > 2f) {
				Destroy(strokes[i].gameObject);
				strokes.RemoveAt(i);
			}
		}
    }

    private float map(float s, float a1, float a2, float b1, float b2) {
        return b1 + (s - a1) * (b2 - b1) / (a2 - a1);
    }

}
