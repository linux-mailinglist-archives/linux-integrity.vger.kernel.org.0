Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F683D6CE
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 21:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405428AbfFKTan (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 15:30:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404926AbfFKTam (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 15:30:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA8BDAE24;
        Tue, 11 Jun 2019 19:30:41 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 1/4] ima: Call test's cleanup inside ima_setup.sh cleanup
Date:   Tue, 11 Jun 2019 21:30:18 +0200
Message-Id: <20190611193021.17651-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611193021.17651-1-pvorel@suse.cz>
References: <20190611193021.17651-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

to work the same way as setup

Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh  | 6 +++++-
 .../kernel/security/integrity/ima/tests/ima_violations.sh   | 2 --
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 52551190a..cbded42c2 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -20,7 +20,8 @@
 TST_TESTFUNC="test"
 TST_SETUP_CALLER="$TST_SETUP"
 TST_SETUP="ima_setup"
-TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
+TST_CLEANUP_CALLER="$TST_CLEANUP"
+TST_CLEANUP="ima_cleanup"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 
@@ -95,6 +96,9 @@ ima_setup()
 ima_cleanup()
 {
 	local dir
+
+	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
+
 	for dir in $UMOUNT; do
 		umount $dir
 	done
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 74223c221..a44bd1230 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -51,8 +51,6 @@ cleanup()
 {
 	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
 		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
-
-	ima_cleanup
 }
 
 open_file_read()
-- 
2.21.0

