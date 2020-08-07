Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D821A23F3F2
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHGUrB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 16:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgHGUrB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 16:47:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3252AC50;
        Fri,  7 Aug 2020 20:47:17 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 1/4] IMA/ima_keys.sh Fix policy content check usage
Date:   Fri,  7 Aug 2020 22:46:49 +0200
Message-Id: <20200807204652.5928-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807204652.5928-1-pvorel@suse.cz>
References: <20200807204652.5928-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

require_ima_policy_content cannot be used in subshell $() evaluation,
because tst_brk does not quit the test. It calls cleanup for the
subshell process and main process then continue:

ima_keys 1 TCONF: IMA policy does not specify 'func=KEY_CHECK'
=> Here it's running first cleanup. umount errors are because parent
shell process still has $PWD in directory to be unmounted:
umount: /tmp/LTP_ima_keys.0dIVrwJKIG/mntpoint: target is busy.
ima_keys 1 TINFO: umount(/dev/loop0) failed, try 1 ...
ima_keys 1 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
umount: /tmp/LTP_ima_keys.0dIVrwJKIG/mntpoint: target is busy.
...
ima_keys 1 TINFO: umount(/dev/loop0) failed, try 50 ...
ima_keys 1 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
ima_keys 1 TWARN: Failed to umount(/dev/loop0) after 50 retries
tst_device.c:222: WARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

Usage: tst_device acquire [size [filename]]
   or: tst_device release /path/to/device

ima_keys 1 TWARN: Failed to release device '/dev/loop0'
rm: cannot remove '/tmp/LTP_ima_keys.0dIVrwJKIG/mntpoint': Device or resource busy
ima_keys 1 TINFO: AppArmor enabled, this may affect test results
ima_keys 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
ima_keys 1 TINFO: loaded AppArmor profiles: none
/opt/ltp/testcases/bin/ima_keys.sh: line 25:  6166 Terminated              sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid  (wd: ~)

=> Here it should quit after running cleanup, but instead continue running:
ima_keys 1 TCONF: ima policy does not specify a keyrings to check

Fixes: f20f44d72 ("IMA/ima_keys.sh: Fix policy readability check")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Originally sent as
https://patchwork.ozlabs.org/project/ltp/patch/20200807112929.8984-1-pvorel@suse.cz/

 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 3aea26056..53c289054 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -16,11 +16,14 @@ TST_NEEDS_DEVICE=1
 # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
 test1()
 {
-	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
+	local keyrings keycheck_lines keycheck_line templates
+	local pattern="func=KEY_CHECK"
+	local test_file="file.txt"
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
+	require_ima_policy_content "$pattern"
+	keycheck_lines=$(check_ima_policy_content "$pattern" "")
 	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
 
 	if [ -z "$keycheck_line" ]; then
-- 
2.28.0

