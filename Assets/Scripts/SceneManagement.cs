using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class SceneManagement : MonoBehaviour {

    static SceneManagement SceneManagementInstance;
    public GameObject MainCam;

    void Awake ()
    {
        if (SceneManagementInstance != null)
        {
            Destroy(gameObject);
            Destroy(MainCam);
        }
        else
        {
            DontDestroyOnLoad(gameObject);
            DontDestroyOnLoad(MainCam);
            SceneManagementInstance = this;
        }
    }
	
	void Update () {
        if (Input.GetKeyUp(KeyCode.Keypad1))
        {
            SceneManager.LoadScene("scene1");
        }
        if (Input.GetKeyUp(KeyCode.Keypad2))
        {
            SceneManager.LoadScene("scene2");
        }
	
	}

    public static void goToScene(string scene)
    {
        SceneManager.LoadScene(scene);
    }
}
