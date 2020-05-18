using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LunTai : MonoBehaviour
{
    public GameObject luntai;
    public GameObject forwardBtn;
    public GameObject backBtn;
    public Animator luntaiAnim;

    public void OnShow()
    {
        luntai.SetActive(true);
        forwardBtn.SetActive(false);
        Invoke("InvokeShow", 2f);

    }
    public void OnHide()
    {
        luntaiAnim.SetTrigger("back");
        backBtn.SetActive(false);
        Invoke("InvokeDisable", 2f);
    }

    void InvokeDisable()
    {
        luntai.SetActive(false);
        forwardBtn.SetActive(true);
    }

    void InvokeShow()
    {
        backBtn.SetActive(true);
    }
}
