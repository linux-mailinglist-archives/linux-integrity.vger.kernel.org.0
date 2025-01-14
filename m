Return-Path: <linux-integrity+bounces-4543-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEEBA1055C
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C3F1679BA
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EA5284A4C;
	Tue, 14 Jan 2025 11:29:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688522963F
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854167; cv=none; b=CR6IS0WcDnqjujgT56/GEeG2Rq35Z5U1ULnIaAfQ8H9shwAzp9CSUfHKaamZO9X21rJWivFjCI5qnR5JYTD3ohlzJWrw6uzaFNXAhZTMTvagGlcN+eUJ1ZigUNBhjwryLWWuelwBqhG4gLS479b5sIXfo0ohyR+s/R1XijR4FPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854167; c=relaxed/simple;
	bh=6xvNtCzW+/6cOMbTDmmQEuptcvwgsgB/5oEfh2v/ec8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLCiQpGuZvJ3iD8S1XNVVVq+QZEjxOB2Z+3BvBmUlXBEO/qDfjE0lsMQuCnF3TPJHmCzb2IgMXioFdowiz46jqxOJePJ5lUvV+TuzmQcuCHAQab8i8q9caI70gw8+vHJV0ZtDMvU+6zP2yHszu/+Oj5N2IvF1MqT8dAUoBtESw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C9A62117D;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED76213A86;
	Tue, 14 Jan 2025 11:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBdDOJNKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 03/10] IMA: Move requirement check to ima_setup.sh
Date: Tue, 14 Jan 2025 12:29:08 +0100
Message-ID: <20250114112915.610297-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3C9A62117D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/evm_overlay.sh      | 3 +--
 .../kernel/security/integrity/ima/tests/ima_measurements.sh | 6 +++---
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh  | 6 +++++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index 12b2a28c25..6a48f63aaa 100755
--- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -9,6 +9,7 @@
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
 TST_CNT=4
+REQUIRED_BUILTIN_POLICY="appraise_tcb"
 
 setup()
 {
@@ -17,8 +18,6 @@ setup()
 	[ -f "$EVM_FILE" ] || tst_brk TCONF "EVM not enabled in kernel"
 	[ $(cat $EVM_FILE) -eq 1 ] || tst_brk TCONF "EVM not enabled for this boot"
 
-	require_ima_policy_cmdline "appraise_tcb"
-
 	lower="$TST_MNTPOINT/lower"
 	upper="$TST_MNTPOINT/upper"
 	work="$TST_MNTPOINT/work"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1da2aa6a51..ca9d73b4aa 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -1,19 +1,19 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Verify that measurements are added to the measurement list based on policy.
+# Test requires ima_policy=tcb.
 
 TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
 TST_CNT=3
+REQUIRED_BUILTIN_POLICY="tcb"
 
 setup()
 {
-	require_ima_policy_cmdline "tcb"
-
 	TEST_FILE="$PWD/test.txt"
 	[ -f "$IMA_POLICY" ] || tst_res TINFO "not using default policy"
 }
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index fc0e769729..2a578ceb45 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 
 TST_TESTFUNC="test"
@@ -180,6 +180,10 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
+	if [ "$REQUIRED_BUILTIN_POLICY" ]; then
+		require_ima_policy_cmdline "$REQUIRED_BUILTIN_POLICY"
+	fi
+
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
-- 
2.47.1


