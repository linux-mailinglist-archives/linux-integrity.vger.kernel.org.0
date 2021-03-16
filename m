Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49BA33D678
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhCPPGR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 11:06:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhCPPGH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 11:06:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C28FAE89;
        Tue, 16 Mar 2021 15:06:06 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] IMA: Move check_evmctl to setup, add require_evmctl()
Date:   Tue, 16 Mar 2021 16:05:59 +0100
Message-Id: <20210316150600.16461-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Helper functions can be reused in other tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_setup.sh | 43 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 33 --------------
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 59a7ffeac..565f0bc3e 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -269,6 +269,49 @@ get_algorithm_digest()
 	echo "$algorithm|$digest"
 }
 
+# check_evmctl REQUIRED_TPM_VERSION
+# return: 0: evmctl is new enough, 1: version older than required (or version < v0.9)
+check_evmctl()
+{
+	local required="$1"
+
+	local r1="$(echo $required | cut -d. -f1)"
+	local r2="$(echo $required | cut -d. -f2)"
+	local r3="$(echo $required | cut -d. -f3)"
+	[ -z "$r3" ] && r3=0
+
+	tst_is_int "$r1" || tst_brk TBROK "required major version not int ($v1)"
+	tst_is_int "$r2" || tst_brk TBROK "required minor version not int ($v2)"
+	tst_is_int "$r3" || tst_brk TBROK "required patch version not int ($v3)"
+
+	tst_check_cmds evmctl || return 1
+
+	local v="$(evmctl --version | cut -d' ' -f2)"
+	[ -z "$v" ] && return 1
+	tst_res TINFO "evmctl version: $v"
+
+	local v1="$(echo $v | cut -d. -f1)"
+	local v2="$(echo $v | cut -d. -f2)"
+	local v3="$(echo $v | cut -d. -f3)"
+	[ -z "$v3" ] && v3=0
+
+	if [ $v1 -lt $r1 ] || [ $v1 -eq $r1 -a $v2 -lt $r2 ] || \
+		[ $v1 -eq $r1 -a $v2 -eq $r2 -a $v3 -lt $r3 ]; then
+		return 1
+	fi
+	return 0
+}
+
+# require_evmctl REQUIRED_TPM_VERSION
+require_evmctl()
+{
+	local required="$1"
+
+	if ! check_evmctl $required; then
+		tst_brk TCONF "evmctl >= $required required"
+	fi
+}
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 1cc34ddda..71083efd8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -52,39 +52,6 @@ setup()
 	fi
 }
 
-# check_evmctl REQUIRED_TPM_VERSION
-# return: 0: evmctl is new enough, 1: version older than required (or version < v0.9)
-check_evmctl()
-{
-	local required="$1"
-
-	local r1="$(echo $required | cut -d. -f1)"
-	local r2="$(echo $required | cut -d. -f2)"
-	local r3="$(echo $required | cut -d. -f3)"
-	[ -z "$r3" ] && r3=0
-
-	tst_is_int "$r1" || tst_brk TBROK "required major version not int ($v1)"
-	tst_is_int "$r2" || tst_brk TBROK "required minor version not int ($v2)"
-	tst_is_int "$r3" || tst_brk TBROK "required patch version not int ($v3)"
-
-	tst_check_cmds evmctl || return 1
-
-	local v="$(evmctl --version | cut -d' ' -f2)"
-	[ -z "$v" ] && return 1
-	tst_res TINFO "evmctl version: $v"
-
-	local v1="$(echo $v | cut -d. -f1)"
-	local v2="$(echo $v | cut -d. -f2)"
-	local v3="$(echo $v | cut -d. -f3)"
-	[ -z "$v3" ] && v3=0
-
-	if [ $v1 -lt $r1 ] || [ $v1 -eq $r1 -a $v2 -lt $r2 ] || \
-		[ $v1 -eq $r1 -a $v2 -eq $r2 -a $v3 -lt $r3 ]; then
-		return 1
-	fi
-	return 0
-}
-
 # prints major version: 1: TPM 1.2, 2: TPM 2.0
 # or nothing on TPM-bypass (no TPM device)
 # WARNING: Detecting TPM 2.0 can fail due kernel not exporting TPM 2.0 files.
-- 
2.30.1

