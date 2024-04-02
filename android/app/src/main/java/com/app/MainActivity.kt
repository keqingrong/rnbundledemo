package com.app

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.maskhub.Page
import com.maskhub.activity.LoadReactActivity

//
//public class MainActivity extends ReactActivity {
//
//  /**
//   * Returns the name of the main component registered from JavaScript. This is used to schedule
//   * rendering of the component.
//   */
//  @Override
//  protected String getMainComponentName() {
//    return "app";
//  }
//}
class MainActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    findViewById<View>(R.id.to_mask_hub).setOnClickListener { v: View? ->
      LoadReactActivity
              .build(this@MainActivity)
              .page(Page()
                      .name("app")
                      .url("rn://app/index.android.jsbundle")
                      .extras("param1", "this is a test...")
              )
              .start()
    }
  } //
  //  /**
  //   * Returns the name of the main component registered from JavaScript. This is used to schedule
  //   * rendering of the component.
  //   */
  //  @Override
  //  protected String getMainComponentName() {
  //    return "app";
  //  }
}
