Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51763D2B3E
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhGVQyO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:54:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3455 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhGVQyL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:54:11 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzqx03rbz6DH0p;
        Fri, 23 Jul 2021 01:25:49 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:34:44 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 4/7] Add functions to the testing library to run a test script with UML
Date:   Thu, 22 Jul 2021 19:34:11 +0200
Message-ID: <20210722173414.1738041-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722173414.1738041-1-roberto.sassu@huawei.com>
References: <20210722173414.1738041-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch introduces four new functions to execute a test script with a
UML kernel.

_run_user_mode <UML binary> <init> <additional kernel parameters>

It executes the UML kernel passed as first argument, with the init program
specified as second argument. Additional kernel parameters can be passed
through the third argument.

This function is used to re-execute the script calling this function, so
that the tests will be executed in the new environment rather than in the
launching environment. This behavior is similar to doing a fork() in C.

_exit_user_mode <UML binary>

This function terminates the process that launched the UML kernel, so that
the following commands in the script are executed by the UML kernel.

_init_user_mode

This function performs some initialization tasks, such as mounting sysfs,
securityfs and procfs, and launching haveged to initialize the random
device in the UML kernel.

_cleanup_user_mode

This function cleans the environment by unmounting the filesystems mounted
by _init_user_mode.

A typical structure of a test script to be launched by the UML kernel is:

--
trap cleanup EXIT

cleanup() {
    < cleanup commands >

    _cleanup_user_mode
    _report_exit
}

< commands before launching the UML kernel >

_run_user_mode <UML binary> <init> <additional kernel parameters>

_exit_user_mode <UML binary>

_init_user_mode

< tests executed by the UML kernel >
--

Finally, this patch adds haveged as software dependency.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ci/alpine.sh       |  3 ++-
 ci/debian.sh       |  3 ++-
 ci/fedora.sh       | 10 ++++++++-
 ci/tumbleweed.sh   |  3 ++-
 tests/functions.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 588f450bdb5f..a6db9271b28f 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -43,7 +43,8 @@ apk add \
 	wget \
 	which \
 	xxd \
-	curl
+	curl \
+	haveged
 
 if [ ! "$TSS" ]; then
 	apk add git
diff --git a/ci/debian.sh b/ci/debian.sh
index 07ef28c3a2f0..13127b16d2d8 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -50,7 +50,8 @@ $apt \
 	wget \
 	xsltproc \
 	curl \
-	ca-certificates
+	ca-certificates \
+	haveged
 
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
diff --git a/ci/fedora.sh b/ci/fedora.sh
index f07c678130ae..5808e65fde3a 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -17,6 +17,13 @@ esac
 # ibmswtpm2 requires gcc
 [ "$CC" = "gcc" ] || CC="gcc $CC"
 
+. /etc/os-release
+
+# EPEL required for haveged
+if [ "$PRETTY_NAME" = "CentOS Linux 8" ]; then
+	yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
+fi
+
 yum -y install \
 	$CC $TSS \
 	asciidoc \
@@ -39,7 +46,8 @@ yum -y install \
 	vim-common \
 	wget \
 	which \
-	curl
+	curl \
+	haveged
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index b6a42df7bfca..f12c41c43e1a 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -41,7 +41,8 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	wget \
 	which \
 	xsltproc \
-	curl
+	curl \
+	haveged
 
 if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
diff --git a/tests/functions.sh b/tests/functions.sh
index 91cd5d96ddc4..5893e6dc4931 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -272,3 +272,54 @@ _report_exit() {
   fi
 }
 
+# Syntax: _run_user_mode <UML binary> <init> <additional kernel parameters>
+_run_user_mode() {
+  if [ ! -f "$1" ]; then
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
+# Syntax: _cleanup_user_mode
+_cleanup_user_mode() {
+  if [ $$ -ne 1 ]; then
+    return
+  fi
+
+  umount /sys/kernel/security
+  umount /sys
+  umount /proc
+}
-- 
2.25.1

