Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318602127FC
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2020 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgGBPgB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 11:36:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45244 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgGBPgB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 11:36:01 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED1CD20B7188;
        Thu,  2 Jul 2020 08:35:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED1CD20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593704160;
        bh=03nbl+iFuiB7QIrlhRdMYrQud8qhaYwTynrsYxwma/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXoXlQljiBWPNe30nyeaD4fomcfmOhdZSDlbl3kJIcuhV+AkPPERgC7kORja6phMw
         xbHGrAE4NkIfaiVi9gVri+3dMz3w5FJyASR59iJBhOMavxFYs27ymLyd121HYN3GNJ
         1vX9yDFaEB+VGMKk7RKXoX0668mNvUax23jsqEw0=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] IMA: Verify IMA buffer passing through the kexec barrier
Date:   Thu,  2 Jul 2020 11:35:45 -0400
Message-Id: <20200702153545.3126-3-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702153545.3126-1-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a testcase that verifies that kexec correctly passes
the IMA buffer through the soft reboot.

This test must be run standalone, since it runs kexec.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 testcases/kexec/README.md     |  4 ++++
 testcases/kexec/ima_buffer.sh | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100755 testcases/kexec/ima_buffer.sh

diff --git a/testcases/kexec/README.md b/testcases/kexec/README.md
index 42988cd7b..f4018387e 100644
--- a/testcases/kexec/README.md
+++ b/testcases/kexec/README.md
@@ -24,3 +24,7 @@ Running
 - kexec cmdline measurement
     1. `IMAGE=<path to kernel image> testcases/kexec/cmdline.sh start`
     2. Runtime logs will be emitted in `testcases/kexec/kexec_cmdline.log`.
+
+- kexec ima buffer passing
+    1. `IMAGE=<path to kernel image> testcases/kexec/ima_buffer.sh start`
+    2. Runtime logs will be emitted in `testcases/kexec/kexec_ima_buffer.log`.
diff --git a/testcases/kexec/ima_buffer.sh b/testcases/kexec/ima_buffer.sh
new file mode 100755
index 000000000..3ce661236
--- /dev/null
+++ b/testcases/kexec/ima_buffer.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+ASCII_MEASUREMENTS="/sys/kernel/security/integrity/ima/ascii_runtime_measurements"
+SCRIPT_DIR="$(dirname $(realpath $0))"
+IMAGE=$(realpath "${IMAGE:-$SCRIPT_DIR/Image}")
+LOG_FILE="$SCRIPT_DIR/kexec_ima_buffer.log"
+
+. $SCRIPT_DIR/utils.sh
+
+must_be_root
+on_correct_machine
+
+case $1 in
+    start)
+        # Start the state machine
+        cp $ASCII_MEASUREMENTS /etc/saved-ima-buffer
+
+        install 1
+        if ! kexec -s $IMAGE --reuse-cmdline; then
+            echo "kexec failed: $?" >> $LOG_FILE
+        fi
+        ;;
+    1)
+        update-rc.d resume-after-kexec remove
+        rm /etc/init.d/resume-after-kexec
+
+        n_lines=$(wc -l /etc/saved-ima-buffer | cut -d' ' -f1)
+        if cat $ASCII_MEASUREMENTS | \
+            head -n $n_lines | \
+            cmp -s - /etc/saved-ima-buffer
+        then
+            echo "test succeeded" > $LOG_FILE
+        else
+            echo "test failed" > $LOG_FILE
+        fi
+
+        rm /etc/saved-ima-buffer
+        ;;
+    *)
+        echo "You must run '$0 start' to begin the test"
+        ;;
+esac
-- 
2.25.1

