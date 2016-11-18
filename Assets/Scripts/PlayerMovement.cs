using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PlayerMovement : MonoBehaviour {

    private Rigidbody rb;
    private Dictionary<int, Portal> teleportLinks;
    public float speed;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        teleportLinks = new Dictionary<int, Portal>();
        teleportLinks.Add(1, new Portal("scene2", new Vector3(0, 0.1f, 2.5f)));
        teleportLinks.Add(2, new Portal("scene1", new Vector3(0, 0.1f, -2.5f)));
    }
	
	void FixedUpdate () {
        float horizontalMovement = Input.GetAxis("Horizontal");        
        float verticalMovement = Input.GetAxis("Vertical");
        Vector3 movement = new Vector3(horizontalMovement, 0.0f, verticalMovement);

        rb.AddForce(movement * speed);

    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Portal"))
        {
            string portalName = other.gameObject.name;
            int Portal = int.Parse(portalName.Replace("Portal ", ""));
            SceneManagement.goToScene(teleportLinks[Portal].getScene());
            //rb.velocity = Vector3.zero;
            //rb.angularVelocity = Vector3.zero;
            transform.position = teleportLinks[Portal].getPos() + new Vector3( 0, transform.position.y, 0);
        }
    }
    
}

public class Portal
{
    private string scene;
    private Vector3 position;

    public Portal(string scene, Vector3 position)
    {
        this.scene = scene;
        this.position = position;
    }

    public string getScene()
    {
        return scene;
    }

    public Vector3 getPos()
    {
        return position;
    }
}
