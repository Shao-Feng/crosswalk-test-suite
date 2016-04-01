// Copyright (c) 2014 Intel Corporation. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package org.xwalk.embedded.api.silentdownload;

import android.app.Activity;
import org.xwalk.core.XWalkInitializer;
import org.xwalk.core.XWalkUpdater;
import org.xwalk.core.XWalkView;

import android.os.Bundle;
import android.util.Log;

public class XWalkCopyTextWithSilentDownload extends Activity
                    implements XWalkInitializer.XWalkInitListener, XWalkUpdater.XWalkBackgroundUpdateListener{
    private XWalkView mXWalkView;
    private XWalkInitializer mXWalkInitializer;
    private XWalkUpdater mXWalkUpdater;

    private static final String TAG = "XWalkSilentDownload";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        mXWalkInitializer = new XWalkInitializer(this, this);
        mXWalkInitializer.initAsync();
    }

    @Override
    public final void onXWalkInitStarted() {
        // It's okay to do nothing
    }

    @Override
    public final void onXWalkInitCancelled() {
        // It's okay to do nothing
    }

    @Override
    public final void onXWalkInitFailed() {
        // Do crash or logging or anything else in order to let the tester know if this method get called
        if (mXWalkUpdater == null) mXWalkUpdater = new XWalkUpdater(this, this);
        mXWalkUpdater.updateXWalkRuntime();
    }

    @Override
    public final void onXWalkInitCompleted() {
        setContentView(R.layout.activity_copy_text_silent_async);
        mXWalkView = (XWalkView) findViewById(R.id.xwalkview);
        mXWalkView.load("http://www.baidu.com/duty/", null);
    }

    @Override
    public void onXWalkUpdateCancelled() {
        // TODO Auto-generated method stub
        Log.d(TAG, "XWalkUpdate Cancelled");
        finish();
    }

    @Override
    public void onXWalkUpdateCompleted() {
        // TODO Auto-generated method stub
        mXWalkInitializer.initAsync();
        Log.d(TAG, "XWalkUpdate Completed");
    }

    @Override
    public void onXWalkUpdateFailed() {
        // TODO Auto-generated method stub
        Log.d(TAG, "XWalkUpdate Failed");
        finish();
    }

    @Override
    public void onXWalkUpdateProgress(int percentage) {
        // TODO Auto-generated method stub
        Log.d(TAG, "XWalkUpdate progress: " + percentage);
    }

    @Override
    public void onXWalkUpdateStarted() {
        // TODO Auto-generated method stub
        Log.d(TAG, "XWalkUpdate Started");
    }

    @Override
    protected void onResume() {
        super.onResume();
        mXWalkInitializer.initAsync();
    }
}