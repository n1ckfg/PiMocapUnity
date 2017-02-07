using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProtoTracker : MonoBehaviour {

	public enum FollowMode { AVG_X, PERFECT }
	public FollowMode followMode = FollowMode.PERFECT;
	public Transform realTarget;
	public float speed = 0.1f;
	public float measureOdds = 0.1f;
	public float hitThreshold = 1f;

	private Vector3 predictedTarget;
	private Vector2 topViewPos = Vector2.zero;
	private Vector2 sideViewPos = Vector2.zero;

	void Update () {
		if (followMode == FollowMode.PERFECT) {
			predictedTarget = realTarget.position;
		} else if (followMode == FollowMode.AVG_X) {
			if (Random.Range(0f, 1f) < measureOdds) topViewPos = new Vector2(realTarget.position.x, realTarget.position.z);
			if (Random.Range(0f, 1f) < measureOdds) sideViewPos = new Vector2(realTarget.position.x, realTarget.position.y);
			Debug.Log(topViewPos + " " + sideViewPos);

			if (hitDetect(topViewPos.x, topViewPos.x, hitThreshold, hitThreshold, sideViewPos.x, sideViewPos.x, hitThreshold, hitThreshold)) {
				predictedTarget = new Vector3((topViewPos.x + sideViewPos.x)/2f, sideViewPos.y, topViewPos.y);
			}
		}
	
		transform.position = Vector3.Lerp(transform.position, predictedTarget, speed);	
	}

	bool hitDetect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
		w1 /= 2;
		h1 /= 2;
		w2 /= 2;
		h2 /= 2; 
		if (x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
			return true;
		} else {
			return false;
		}
	}

}
