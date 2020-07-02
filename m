Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB02127FB
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2020 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgGBPgB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 11:36:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45214 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgGBPgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 11:36:00 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id E991320B7186;
        Thu,  2 Jul 2020 08:35:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E991320B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593704159;
        bh=nfOR/4lSKPBe0dS4ahP1ymZ+G03/wLgflzjGDkMidQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvZ21KPsxPptikdji33nchh3BQYrT8aJqxdbiKOSKiiid1ZyX7ko5asi9cdXzW6ZF
         g74Nh8LsqFdyQXrDwAn1YLFhKVQEoS7mwCQX+pdCXEvbLdaKu2Tc1n9Pi+/BursbYb
         kEmqJM2K1I3WdVAhTse1sHONGJNXFNQfuR4itjgs=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and measured correctly through the kexec barrier.
Date:   Thu,  2 Jul 2020 11:35:44 -0400
Message-Id: <20200702153545.3126-2-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702153545.3126-1-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a testcase that verifies that kexec correctly logs the
kernel command line to the IMA buffer and that the command
line is then correctly measured.

This test must be run standalone, since it runs kexec
multiple times (and therefore reboots several times).

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 testcases/kexec/README.md  | 26 +++++++++++++
 testcases/kexec/cmdline.sh | 78 ++++++++++++++++++++++++++++++++++++++
 testcases/kexec/utils.sh   | 47 +++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 testcases/kexec/README.md
 create mode 100755 testcases/kexec/cmdline.sh
 create mode 100755 testcases/kexec/utils.sh

diff --git a/testcases/kexec/README.md b/testcases/kexec/README.md
new file mode 100644
index 000000000..42988cd7b
--- /dev/null
+++ b/testcases/kexec/README.md
@@ -0,0 +1,26 @@
+# IMA + Kexec Tests
+
+Since these tests cannot be run by the usual LTP machinery (runltp, etc)
+because the machine you run these on will reboot several times, these
+tests must be run standalone.
+
+To run these tests, you must first copy over either the entire LTP repo, or
+just the `testcases/kexec` directory.
+
+You must supply a kernel image that will be passed to kexec, either
+though the `IMAGE` environment variable, or placed at `testcases/kexec/Image`.
+
+If the kernel is built to require signed kernel images, you must supply
+a signed image.
+
+Currently, the only arch that has support in the upstream kernel to pass
+the IMA buffer through kexec is powerpc. A patchset that adds support for
+IMA buffer passing through kexec on aarch64 is in the process of being
+upstreamed. Therefore, these tests will not let you run them on
+architectures other than powerpc or aarch64.
+
+Running
+-------
+- kexec cmdline measurement
+    1. `IMAGE=<path to kernel image> testcases/kexec/cmdline.sh start`
+    2. Runtime logs will be emitted in `testcases/kexec/kexec_cmdline.log`.
diff --git a/testcases/kexec/cmdline.sh b/testcases/kexec/cmdline.sh
new file mode 100755
index 000000000..e3d050ce0
--- /dev/null
+++ b/testcases/kexec/cmdline.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+ASCII_MEASUREMENTS="/sys/kernel/security/integrity/ima/ascii_runtime_measurements"
+SCRIPT_DIR="$(dirname $(realpath $0))"
+IMAGE=$(realpath "${IMAGE:-$SCRIPT_DIR/Image}")
+LOG_FILE="$SCRIPT_DIR/kexec_cmdline.log"
+
+. $SCRIPT_DIR/utils.sh
+
+must_be_root
+on_correct_machine
+
+case $1 in
+    start)
+        # Start the state machine
+        echo "$(cat /proc/cmdline | tr -d '\n' | text2hex)" > /etc/saved-kexec-cmdline
+
+        install 1
+        if ! kexec -s $IMAGE --reuse-cmdline; then
+            echo "kexec failed: $?" >> $LOG_FILE
+        fi
+        ;;
+    1)
+        cmdline="$(cat /proc/cmdline | tr -d '\n')"
+        printf "$cmdline" | text2hex | xargs echo >> /etc/saved-kexec-cmdline
+
+        install 2
+        if ! kexec -s $IMAGE --append="$cmdline"; then
+            echo "kexec failed: $?" >> $LOG_FILE
+        fi
+        ;;
+    2)
+        cmdline="$(cat /proc/cmdline | tr -d '\n')"
+        printf "$cmdline" | text2hex | xargs echo >> /etc/saved-kexec-cmdline
+
+        install 3
+        if ! kexec -s $IMAGE --command-line="$cmdline"; then
+            echo "kexec failed: $?" >> $LOG_FILE
+        fi
+        ;;
+    3)
+        update-rc.d resume-after-kexec remove
+        rm /etc/init.d/resume-after-kexec
+
+        success=true
+
+        grep "kexec-cmdline" $ASCII_MEASUREMENTS \
+        | tail -n "$(wc -l /etc/saved-kexec-cmdline | cut -d' ' -f1)" \
+        | paste -d'|' /etc/saved-kexec-cmdline - \
+        | while IFS="|" read -r saved_cmdline logged_line
+        do
+            # saved_cmdline is encoded in hex
+            algorithm=$(echo "$logged_line" | cut -d' ' -f4 | cut -d':' -f1)
+            digest=$(echo "$logged_line" | cut -d' ' -f4 | cut -d':' -f2)
+            logged_cmdline=$(echo "$logged_line" | cut -d' ' -f6)
+            saved_digest=$(echo "$saved_cmdline" | hex2text | ${algorithm}sum | cut -d' ' -f1)
+
+            if [ "$saved_cmdline" != "$logged_cmdline" ]; then
+                echo "saved cmdline != logged cmdline" >> $LOG_FILE
+                success=false
+            fi
+
+            if [ "$saved_digest" != "$digest" ]; then
+                echo "computed digest != logged digest" >> $LOG_FILE
+                success=false
+            fi
+        done
+
+        if $success; then
+            echo "test succeeded" >> $LOG_FILE
+        else
+            echo "test failed" >> $LOG_FILE
+        fi
+        ;;
+    *)
+        echo "You must run '$0 start' to begin the test"
+        ;;
+esac
diff --git a/testcases/kexec/utils.sh b/testcases/kexec/utils.sh
new file mode 100755
index 000000000..2399294d4
--- /dev/null
+++ b/testcases/kexec/utils.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+install() {
+    local arg="$1"
+
+    if [ ! -d "/etc/init.d" ]; then
+        mkdir /etc/init.d
+    fi
+
+    cat << EOF > /etc/init.d/resume-after-kexec
+#!/bin/sh
+# Run the test
+IMAGE=$IMAGE $(realpath $0) $arg
+EOF
+
+    chmod +x /etc/init.d/resume-after-kexec
+    update-rc.d resume-after-kexec defaults
+}
+
+must_be_root() {
+    if [ "$EUID" != 0 ]; then
+        echo "run this script as root"
+        exit
+    fi
+}
+
+# Since the IMA buffer passing through kexec is only
+# implemented on powerpc right now with support for aarch64 in review,
+# only support running this test on powerpc or aarch64 systems.
+on_correct_machine() {
+    case "$(uname -m)" in
+        ppc|ppc64|ppcle|ppc64le|aarch64)
+            ;;
+        *)
+            echo "must be on powerpc or aarch64 architecture"
+            exit
+            ;;
+    esac
+}
+
+hex2text() {
+    sed 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI' | xargs printf
+}
+
+text2hex() {
+    hexdump -v -e '1/1 "%02x"'
+}
-- 
2.25.1

