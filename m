Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE467CD0F
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAZN70 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 08:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAZN7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:16 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3C76D369
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 05:59:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P2hts736Jz9xFgL
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 21:51:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39P_4htJj+ajLAA--.553S7;
        Thu, 26 Jan 2023 14:58:50 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v4 05/11] Add support for creating a new testing environment in functions.sh
Date:   Thu, 26 Jan 2023 14:58:01 +0100
Message-Id: <20230126135807.1848668-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
References: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB39P_4htJj+ajLAA--.553S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4kWr1DWF4xWrW5ArWrKrg_yoWrAr48pw
        1kWFyYyFZ2qFy7J39xWa1SqFyfJ3y8Zr1UZrZrJws0yw45GrWktF4SyFyaqw1Y9rZY9rWF
        y3yIqrs3urnrCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4ggcwACsk
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add the new functions _run_env(), _exit_env(), _init_env() and
_cleanup_env() to run the tests inside a new environment specified with the
TST_ENV environment variable.

A typical structure of a script with tests is:

trap '_report_exit_and_cleanup _cleanup_env cleanup' \
    SIGINT SIGTERM SIGSEGV EXIT

cleanup() {
	<test cleanup>
}

<tests implementations>

_run_env "$TST_KERNEL" "$PWD/$(basename "$0")" "env_var1=$env_var1 ..."

_exit_env "$TST_KERNEL"

_init_env

<tests init>

<tests call>

If TST_ENV is not set or empty, don't create a new testing environment and
perform the cleanup in the current environment. Don't create a new testing
environment also if the script is already executed in a new environment, to
avoid loops. Instead, for cleanup, do it in the new environment and skip it
in the host environment (if the cleanup function is passed to
_cleanup_env()).

Signal to the creator of the environment failures of tests or of the script
itself run in the new environment (if the exit code is 1 ($FAIL) or 99
($HARDFAIL)) with an unclean shutdown of the system.

Add haveged and systemd as dependencies for the tests in ci/fedora.sh,
respectively for initializing the random number generator and for shutting
down the system in the new environment.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ci/fedora.sh       |  4 +-
 tests/functions.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)

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
index d0a9e8e62ca5..03785db91ad6 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -271,6 +271,25 @@ _report_exit_and_cleanup() {
   [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
   echo " FAIL: $testsfail"
   echo "$NORM"
+  # Signal failure to the testing environment creator with an unclean shutdown.
+  if [ -n "$TST_ENV" ] && [ $$ -eq 1 ]; then
+    if [ -z "$(command -v poweroff)" ]; then
+      echo "Warning: cannot properly shutdown system"
+    fi
+
+    # If no test was executed and the script was successful,
+    # do a clean shutdown.
+    if [ $testsfail -eq 0 ] && [ $testspass -eq 0 ] && [ $testsskip -eq 0 ] &&
+       [ $exit_code -ne "$FAIL" ] && [ $exit_code -ne "$HARDFAIL" ]; then
+      poweroff -f
+    fi
+
+    # If tests were executed and no test failed, do a clean shutdown.
+    if { [ $testspass -gt 0 ] || [ $testsskip -gt 0 ]; } &&
+       [ $testsfail -eq 0 ]; then
+      poweroff -f
+    fi
+  fi
   if [ $testsfail -gt 0 ]; then
     exit "$FAIL"
   elif [ $testspass -gt 0 ]; then
@@ -319,3 +338,75 @@ _softhsm_teardown() {
   unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
     EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
 }
+
+# Syntax: _run_env <kernel> <init> <additional kernel parameters>
+_run_env() {
+  if [ -z "$TST_ENV" ]; then
+    return
+  fi
+
+  if [ $$ -eq 1 ]; then
+    return
+  fi
+
+  if [ "$TST_ENV" = "um" ]; then
+    expect_pass "$1" rootfstype=hostfs rw init="$2" quiet mem=2048M "$3"
+  else
+    echo $RED"Testing environment $TST_ENV not supported"$NORM
+    exit "$FAIL"
+  fi
+}
+
+# Syntax: _exit_env <kernel>
+_exit_env() {
+  if [ -z "$TST_ENV" ]; then
+    return
+  fi
+
+  if [ $$ -eq 1 ]; then
+    return
+  fi
+
+  exit "$OK"
+}
+
+# Syntax: _init_env
+_init_env() {
+  if [ -z "$TST_ENV" ]; then
+    return
+  fi
+
+  if [ $$ -ne 1 ]; then
+    return
+  fi
+
+  mount -t tmpfs tmpfs /tmp
+  mount -t proc proc /proc
+  mount -t sysfs sysfs /sys
+  mount -t securityfs securityfs /sys/kernel/security
+
+  if [ -n "$(command -v haveged 2> /dev/null)" ]; then
+    $(command -v haveged) -w 1024 &> /dev/null
+  fi
+
+  pushd "$PWD" > /dev/null || exit "$FAIL"
+}
+
+# Syntax: _cleanup_env <cleanup function>
+_cleanup_env() {
+  if [ -z "$TST_ENV" ]; then
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
+  umount /tmp
+}
-- 
2.25.1

