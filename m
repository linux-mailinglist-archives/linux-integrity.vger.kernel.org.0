Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4E27911A
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgIYSul (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 14:50:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbgIYSul (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 14:50:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AD6EAC97;
        Fri, 25 Sep 2020 18:50:39 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 0/4] TPM 2.0 fixes in IMA tests
Date:   Fri, 25 Sep 2020 20:50:30 +0200
Message-Id: <20200925185034.24155-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

v2 to fix bugs related to legacy ima_boot_aggregate:
* exit with TPASS to keep API happy
* add missing ! in algorithm condition
* missing -f $tpm_bios parameter
* reintroduce check for ima_boot_aggregate presence

Sorry for the noise

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 318d9c299..67f97ea04 100644
--- testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -117,8 +117,9 @@ static void do_test(void)
 	}
 	SHA1_Final(boot_aggregate, &c);
 
-	printf("boot_aggregate:");
+	printf("sha1:");
 	display_sha1_digest(boot_aggregate);
+	tst_res(TPASS, "found sha1 hash");
 }
 
 static struct tst_option options[] = {
diff --git testcases/kernel/security/integrity/ima/tests/ima_tpm.sh testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 300c96f64..78e81ed64 100755
--- testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -31,7 +31,7 @@ setup()
 
 	if ! check_evmctl $EVMCTL_REQUIRED; then
 		MISSING_EVMCTL=1
-		if [ "$ALGORITHM" = "sha1" ]; then
+		if [ "$ALGORITHM" != "sha1" ]; then
 			tst_brk TCONF "algorithm not sha1 ($ALGORITHM), $ERRMSG_EVMCTL"
 		fi
 	fi
@@ -159,7 +159,8 @@ test1()
 			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
 			return
 		fi
-		cmd="ima_boot_aggregate"
+		tst_check_cmds ima_boot_aggregate || return
+		cmd="ima_boot_aggregate -f $tpm_bios"
 	fi
 	tst_res TINFO "using command: $cmd"
 

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++-----
 .../integrity/ima/tests/ima_measurements.sh   |  62 +----
 .../security/integrity/ima/tests/ima_setup.sh |  70 +++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 239 +++++++++++++-----
 4 files changed, 314 insertions(+), 170 deletions(-)

-- 
2.28.0

