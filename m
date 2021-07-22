Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362513D2B40
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhGVQzY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:55:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3456 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGVQzX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:55:23 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzsK5DRKz6DHLN;
        Fri, 23 Jul 2021 01:27:01 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:35:57 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 5/7] Signal failures of tests executed by UML kernel with unclean shutdown
Date:   Thu, 22 Jul 2021 19:34:12 +0200
Message-ID: <20210722173414.1738041-6-roberto.sassu@huawei.com>
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

With a UML kernel, test errors must be handled in a different way. Since
the tests are executed by the UML kernel, the parent does not know which
exit code it should return.

The solution is to consider the executions of the UML kernel as tests (by
using the existing testing API, expect_pass and expect_fail), and to signal
to the launching environment, with the exit code of the UML kernel, whether
or not the tests executed by the UML kernel were successful. With a clean
shutdown, the UML kernel returns zero, with an unclean shutdown the UML
kernel returns a non-zero exit code.

This patch checks if the number of tests failed is greater than zero and,
in this case, it does not perform a clean shutdown. By adding expect_pass
to the command line of the UML kernel, the testing infrastructure in the
launching environment will know if one or multiple tests in an execution
of the UML kernel failed.

This can be seen in the following output:

--
Test: check_ima_sig_appraisal (evm_value: 0)
[...]
PASS: 9 SKIP: 1 FAIL: 0

Powering off.
reboot: System halted
[...]
Test: check_evm_revalidate (evm_value: 6)
PASS: 1 SKIP: 9 FAIL: 0

Powering off.
reboot: System halted
PASS: 2 SKIP: 0 FAIL: 0

PASS portable_signatures.test (exit status: 0)
--

Two groups of tests, launched by the UML kernel, have been executed
successfully and a clean shutdown has been performed for each group.
'PASS: 2 SKIP: 0 FAIL: 0' is the summary of the UML kernel executions, not
of the tests.

--
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 0 PID: 1 Comm: portable_signat Not tainted 5.14.0-rc2-dont-use #1
[...]
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 0 PID: 1 Comm: portable_signat Not tainted 5.14.0-rc2-dont-use #1
[...]

 PASS: 0 SKIP: 0 FAIL: 2

FAIL portable_signatures.test (exit status: 1)
--

In this case, the two groups of tests both failed and the message
'PASS: 0 SKIP: 0 FAIL: 2' reflects that.

Lastly, this patch adds the package containing the poweroff command as
software dependency.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ci/alpine.sh       | 3 ++-
 ci/debian.sh       | 3 ++-
 ci/fedora.sh       | 3 ++-
 ci/tumbleweed.sh   | 3 ++-
 tests/functions.sh | 4 ++++
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index a6db9271b28f..a074ea0e841c 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -44,7 +44,8 @@ apk add \
 	which \
 	xxd \
 	curl \
-	haveged
+	haveged \
+	openrc
 
 if [ ! "$TSS" ]; then
 	apk add git
diff --git a/ci/debian.sh b/ci/debian.sh
index 13127b16d2d8..58004a0bc028 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -51,7 +51,8 @@ $apt \
 	xsltproc \
 	curl \
 	ca-certificates \
-	haveged
+	haveged \
+	systemd-sysv
 
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 5808e65fde3a..6cc3cb46fb56 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -47,7 +47,8 @@ yum -y install \
 	wget \
 	which \
 	curl \
-	haveged
+	haveged \
+	systemd
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index f12c41c43e1a..a7039129d02f 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -42,7 +42,8 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	which \
 	xsltproc \
 	curl \
-	haveged
+	haveged \
+	systemd-sysvinit
 
 if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
diff --git a/tests/functions.sh b/tests/functions.sh
index 5893e6dc4931..9f05429d47ce 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -263,6 +263,10 @@ _report_exit() {
   [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
   echo " FAIL: $testsfail"
   echo "$NORM"
+  # Signal failure to UML caller with an unclean shutdown.
+  if [ $$ -eq 1 ] && [ "$(which poweroff)" ] && [ $testsfail -eq 0 ]; then
+    poweroff -f
+  fi
   if [ $testsfail -gt 0 ]; then
     exit "$FAIL"
   elif [ $testspass -gt 0 ]; then
-- 
2.25.1

