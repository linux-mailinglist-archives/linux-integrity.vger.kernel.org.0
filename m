Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97654667219
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjALMZt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 07:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjALMZq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 07:25:46 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0030749151
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 04:25:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Nt3Ty1sv9z9xFHS
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 20:17:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3sg0f_L9jKjyOAA--.25294S6;
        Thu, 12 Jan 2023 13:25:31 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2 4/9] Add support for UML in functions.sh
Date:   Thu, 12 Jan 2023 13:24:21 +0100
Message-Id: <20230112122426.3759938-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3sg0f_L9jKjyOAA--.25294S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw45WrWfuFW5KFykJr13Jwb_yoWrGr4kpw
        1UWFyYqas7XF9FvaySg3yxWF1fJrWrCr10qr9xX398Awn8Kr4vqr4IvF1aqry5GrWYg3y0
        q3yIqr4rG3W7CwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj4eEOwAAsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the new functions _run_user_mode(), _exit_user_mode(),
_init_user_mode() and _cleanup_user_mode() to run the tests inside a system
booted with the UML kernel.

A typical structure of a script with tests is:

trap cleanup SIGINT SIGTERM SIGSEGV EXIT

_cleanup() {
	<test cleanup>
}

cleanup() {
	_cleanup_user_mode _cleanup
	_report_exit_and_cleanup
}

<tests implementations>

_run_user_mode ../linux $PWD/$(basename $0) "env_var1=$env_var1 ..."

_exit_user_mode ../linux

_init_user_mode

<tests init>

<tests call>

If the UML_MODE environment variable is not set to 1, ignore the UML kernel
execution and initialization requests, and perform the cleanup in the
current environment. Ignore the same also if the script is already run in
the UML environment, to avoid loops. Instead, for cleanup, do it only in
the UML environment and skip it in the host environment.

Signal to the host environment failures of tests run in the UML environment
with an unclean shutdown of the UML kernel.

Add haveged and systemd as dependencies for the tests in ci/fedora.sh,
respectively for initializing the random number generator and for shutting
down the system in the environment created by the UML kernel.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ci/fedora.sh       |  4 ++-
 tests/functions.sh | 79 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/ci/fedora.sh b/ci/fedora.sh
index e60de7981c60..198034a34e3c 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -45,7 +45,9 @@ yum -y install \
 	vim-common \
 	wget \
 	which \
-	zstd
+	zstd \
+	haveged \
+	systemd
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
diff --git a/tests/functions.sh b/tests/functions.sh
index 8f6f02dfcd95..98829d94fae1 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -267,6 +267,16 @@ _report_exit_and_cleanup() {
   [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
   echo " FAIL: $testsfail"
   echo "$NORM"
+  # Signal failure to UML caller with an unclean shutdown.
+  if [ -n "$UML_MODE" ] && [ "$UML_MODE" -eq 1 ] && [ $$ -eq 1 ]; then
+    if [ -z "$(which poweroff)" ]; then
+      echo "Warning: cannot properly shutdown system"
+    fi
+
+    if [ $testsfail -eq 0 ]; then
+      poweroff -f
+    fi
+  fi
   if [ $testsfail -gt 0 ]; then
     exit "$FAIL"
   elif [ $testspass -gt 0 ]; then
@@ -312,4 +322,71 @@ _softhsm_teardown() {
   rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
   unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
     EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
-}
\ No newline at end of file
+}
+
+# Syntax: _run_user_mode <UML binary> <init> <additional kernel parameters>
+_run_user_mode() {
+  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
+    return
+  fi
+
+  if [ $$ -eq 1 ]; then
+    return
+  fi
+
+  expect_pass $1 rootfstype=hostfs rw init=$2 quiet mem=256M $3
+}
+
+# Syntax: _exit_user_mode <UML binary>
+_exit_user_mode() {
+  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
+    return
+  fi
+
+  if [ $$ -eq 1 ]; then
+    return
+  fi
+
+  if [ -f "$1" ]; then
+    exit $OK
+  fi
+}
+
+# Syntax: _init_user_mode
+_init_user_mode() {
+  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
+    return
+  fi
+
+  if [ $$ -ne 1 ]; then
+    return
+  fi
+
+  mount -t proc proc /proc
+  mount -t sysfs sysfs /sys
+  mount -t securityfs securityfs /sys/kernel/security
+
+  if [ -n "$(which haveged 2> /dev/null)" ]; then
+    $(which haveged) -w 1024 &> /dev/null
+  fi
+
+  pushd $PWD > /dev/null
+}
+
+# Syntax: _cleanup_user_mode <cleanup function>
+_cleanup_user_mode() {
+  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
+    $1
+    return
+  fi
+
+  if [ $$ -ne 1 ]; then
+    return
+  fi
+
+  $1
+
+  umount /sys/kernel/security
+  umount /sys
+  umount /proc
+}
-- 
2.25.1

