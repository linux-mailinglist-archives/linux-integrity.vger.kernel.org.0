Return-Path: <linux-integrity+bounces-4213-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70969D9CB3
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49D85B21C26
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928101DC04B;
	Tue, 26 Nov 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4jw3cxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ci7LcNko";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x4jw3cxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ci7LcNko"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7D1DAC88
	for <linux-integrity@vger.kernel.org>; Tue, 26 Nov 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642717; cv=none; b=GEmJCyHCtfIoK6M6OHXFF0KUhh8w25DsO9F+WcLu2BG2EtllKVvUbbVDyLcr4Q7uOl769kZxmvfow2Gw7GHrW2h6uBuaYXb0I6YdNriCVC6dWqWMRRsWB5EeifMDd6JOqWuOLlUoIBNbYf/FZYrr3nmdkLNSDd3k36BVWMJeq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642717; c=relaxed/simple;
	bh=FhFq3zNl2d0xQsSQp29x/nsFrrHE/Pq5QUm1OgdNTiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvaTA2WmSAlZpUkP85LAcQAMWARw2WsNesnY+vqIO+T2ygv5peJ9C9WfhR4klzQqjFDDenw6XDaRgUSltc4yJ6kRIBzJjkm3SCN3iB+m79Oc0OvdixH7WLBfKQ03NWInRuCWrs89IWVwaZuU8caUnLP7mQsNazbxnqo74meU8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4jw3cxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ci7LcNko; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x4jw3cxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ci7LcNko; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 554F71F766;
	Tue, 26 Nov 2024 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732642713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrWank4tcr+vU8qiBUPC/7ef67hJYayhhGjGbPCpZ/s=;
	b=x4jw3cxdzDrJq+sUZly+hbHZnp/OYZiGAcvnDRY4jP6zOu78OY5ppH/GdsJEsDL2HpAjJV
	liBXvATqXtFZHYunYKjXgz4QP0H07VxHIK+ythwZeCdgGFjMIN/wwBduqUJM+pmb5wBqjS
	XI8Pp7ZuFqGWHnz5b/x0WagjMAoYs7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732642713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrWank4tcr+vU8qiBUPC/7ef67hJYayhhGjGbPCpZ/s=;
	b=ci7LcNkoiyOFBaNWD+Wm3ctjrUTDNtMjk4oAANK33r3+2XyZPIRdG776VhBIFhwKPdpX4L
	TLmO1L+mm8wTLiDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732642713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrWank4tcr+vU8qiBUPC/7ef67hJYayhhGjGbPCpZ/s=;
	b=x4jw3cxdzDrJq+sUZly+hbHZnp/OYZiGAcvnDRY4jP6zOu78OY5ppH/GdsJEsDL2HpAjJV
	liBXvATqXtFZHYunYKjXgz4QP0H07VxHIK+ythwZeCdgGFjMIN/wwBduqUJM+pmb5wBqjS
	XI8Pp7ZuFqGWHnz5b/x0WagjMAoYs7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732642713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrWank4tcr+vU8qiBUPC/7ef67hJYayhhGjGbPCpZ/s=;
	b=ci7LcNkoiyOFBaNWD+Wm3ctjrUTDNtMjk4oAANK33r3+2XyZPIRdG776VhBIFhwKPdpX4L
	TLmO1L+mm8wTLiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28CFC13890;
	Tue, 26 Nov 2024 17:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4H/7CJkHRmf2OAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 17:38:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
Date: Tue, 26 Nov 2024 18:38:29 +0100
Message-ID: <20241126173830.98960-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126173830.98960-1-pvorel@suse.cz>
References: <20241126173830.98960-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
if available. This should be used only if tooling running LTP tests
allows to reboot afterwards (because policy may be writable only once,
e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
other).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/README.md   |  6 +++
 .../integrity/ima/tests/ima_measurements.sh   | 17 +++++-
 .../security/integrity/ima/tests/ima_setup.sh | 52 ++++++++++++++++---
 3 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 5b261a1914..a00b01b5fe 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -8,6 +8,12 @@ CONFIG_INTEGRITY=y
 CONFIG_IMA=y
 ```
 
+### Loading policy for testing (optional)
+Setting environment variable `LTP_IMA_LOAD_POLICY=1` tries to load example
+policy if available. This should be used only if tooling running LTP tests
+allows to reboot afterwards (because policy may be writable only once, e.g.
+missing `CONFIG_IMA_WRITE_POLICY=y`, or policies can influence each other).
+
 ### IMA measurement tests
 `ima_measurements.sh` require builtin IMA tcb policy to be loaded
 (`ima_policy=tcb` kernel parameter).
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1da2aa6a51..b4205ab95f 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Verify that measurements are added to the measurement list based on policy.
@@ -12,10 +12,23 @@ TST_CNT=3
 
 setup()
 {
-	require_ima_policy_cmdline "tcb"
+	local policy="tcb"
 
 	TEST_FILE="$PWD/test.txt"
 	[ -f "$IMA_POLICY" ] || tst_res TINFO "not using default policy"
+
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 ]; then
+		require_ima_policy_cmdline $policy
+		return
+	elif check_ima_policy_cmdline $policy; then
+		return
+	fi
+
+	if ! check_ima_policy_cmdline $policy &&
+		! require_ima_policy_content '^measure func=FILE_CHECK mask=^MAY_READ uid=0' &&
+		! require_ima_policy_content 'measure func=POLICY_CHECK'; then
+		tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter or it's equivalent)"
+	fi
 }
 
 check_iversion_support()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index df3fc5603f..e585418c17 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 
 TST_TESTFUNC="test"
@@ -72,14 +72,20 @@ require_policy_readable()
 	fi
 }
 
-require_policy_writable()
+check_policy_writable()
 {
-	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
-
-	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
-	# CONFIG_IMA_READ_POLICY
+	[ -f $IMA_POLICY ] || return 1
+	# workaround for kernels < v4.18 without fix
+	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
 	echo "" 2> log > $IMA_POLICY
-	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
+	grep -q "Device or resource busy" log && return 1
+	return 0
+}
+
+require_policy_writable()
+{
+	check_policy_writable || tst_brk TCONF \
+		"IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
 }
 
 check_ima_policy_content()
@@ -158,6 +164,32 @@ print_ima_config()
 	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
+load_ima_policy()
+{
+	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
+
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
+		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
+		return
+	fi
+
+	if [ -z "$policy" -o ! -f "$policy" ]; then
+		tst_res TINFO "no policy for this test"
+		return
+	fi
+
+	tst_res TINFO "trying to load '$policy' policy:"
+	cat $policy
+	if ! check_policy_writable; then
+		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
+		return
+	fi
+
+	cat "$policy" 2> log > $IMA_POLICY
+	if grep -q "Device or resource busy" log; then
+		tst_brk TBROK "Loading policy failed"
+	fi
+}
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
@@ -180,6 +212,8 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
+	load_ima_policy
+
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
@@ -192,6 +226,10 @@ ima_cleanup()
 	for dir in $UMOUNT; do
 		umount $dir
 	done
+
+	if [ "$LTP_IMA_LOAD_POLICY" = 1 ]; then
+		tst_res TINFO "WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended"
+	fi
 }
 
 set_digest_index()
-- 
2.45.2


