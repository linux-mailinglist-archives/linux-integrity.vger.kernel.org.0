Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F167ACD3
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAYIwI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 03:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYIwH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 03:52:07 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1B172A
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 00:52:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P1y721RSqz9xFrD
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 16:43:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQmG7dBjf2fGAA--.15976S7;
        Wed, 25 Jan 2023 09:51:51 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3 05/11] Add support for creating a new testing environment in functions.sh
Date:   Wed, 25 Jan 2023 09:50:24 +0100
Message-Id: <20230125085030.1568256-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQmG7dBjf2fGAA--.15976S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4kWr1DWF4xWrW5ArWrKrg_yoWrGFWfpw
        1DGFyYyFs7tFy7J39xWa1SqFyfA3y8Ar1UXFZrG390yw45KrZ2qF4SyFyaqwn0krZYvrWF
        v3ySqrs3ur1DCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj4QNwQAAs3
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
 ci/fedora.sh       |  4 ++-
 tests/functions.sh | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)

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
index cf83ad21562f..9dc9b96d1d7a 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -271,6 +271,17 @@ _report_exit_and_cleanup() {
   [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
   echo " FAIL: $testsfail"
   echo "$NORM"
+  # Signal failure to the testing environment creator with an unclean shutdown.
+  if [ -n "$TST_ENV" ] && [ $$ -eq 1 ]; then
+    if [ -z "$(command -v poweroff)" ]; then
+      echo "Warning: cannot properly shutdown system"
+    fi
+
+    if [ $testsfail -eq 0 ] && [ $exit_code -ne "$FAIL" ] &&
+       [ $exit_code -ne "$HARDFAIL" ]; then
+      poweroff -f
+    fi
+  fi
   if [ $testsfail -gt 0 ]; then
     exit "$FAIL"
   elif [ $testspass -gt 0 ]; then
@@ -319,3 +330,75 @@ _softhsm_teardown() {
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

