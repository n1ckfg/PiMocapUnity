﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Stroke : MonoBehaviour {

    List<SPoint> points;
    float point_life = 1;
    float time = 0;
    Vector3 lastPos = new Vector3(0, 0, 0);

    private void Start() {
        points = new List<SPoint>();
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

        SPoint p2 = points[points.Count - 1];
        Vector3 pos = new Vector3(p2.x, p2.y, p2.z);
        if (Vector3.Distance(pos, lastPos) > 0.1) {
            //fill(0, 240, 100);
        } else {
            //fill(140);
        }

        lastPos = pos;
    }

    void addPoint(float x, float y, float z, float t) {
        points.Add(new SPoint(x, y, z, t));
    }

    void addPoint(SPoint point) {
        points.Add(point);
    }

}

public class SPoint {

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