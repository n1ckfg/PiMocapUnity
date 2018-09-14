using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Stroke : MonoBehaviour {

	[System.Serializable]
	public struct SPoint {
		public float x;
		public float y;
		public float z;
		public float timestamp;

		public SPoint(float _x, float _y, float _z, float _timestamp) {
			x = _x;
			y = _y;
			z = _z;
			timestamp = _timestamp;
		}
	}

    public List<SPoint> points;
	public float point_life = 1;


	[HideInInspector] public float aliveCounter = 0f;

	private float time = 0;
    private Vector3 lastPos = new Vector3(0, 0, 0);
	private LineRenderer lineRen;

	private void Awake() {
        points = new List<SPoint>();
		lineRen = GetComponent<LineRenderer>();
    }

    private void Update() {
        time = Time.realtimeSinceStartup;

        if (points.Count > 1) {
            for (int i = 0; i < points.Count; i++) {
                SPoint p1 = points[i];
                if (time < p1.timestamp + point_life) {
                    //vertex(p.x, p.y, p.z);
                } else {
                    points.RemoveAt(i);
                }
            }
        }

		 Vector3[] vec = new Vector3[points.Count];
		for (int i = 0; i < points.Count; i++) {
			vec[i] = new Vector3(points[i].x, points[i].y, points[i].z);
		}
		if (vec.Length > 2) lineRen.SetPositions(vec);

        SPoint p2 = points[points.Count - 1];
        Vector3 pos = new Vector3(p2.x, p2.y, p2.z);
        if (Vector3.Distance(pos, lastPos) > 0.1) {
			//fill(0, 240, 100);
			aliveCounter = 0f;
        } else {
			//fill(140);
			aliveCounter += Time.deltaTime;
        }

		transform.position = pos;

        lastPos = pos;
    }

    public void addPoint(float x, float y, float z, float t) {
        points.Add(new SPoint(x, y, z, t));
    }

    public void addPoint(SPoint point) {
		points.Add(point);
    }

}