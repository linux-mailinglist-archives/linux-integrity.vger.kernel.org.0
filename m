Return-Path: <linux-integrity+bounces-4387-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC699F1904
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD7F16087B
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2024 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867B1A8F96;
	Fri, 13 Dec 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NEGP9VdU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4Arjtvi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdXnf2Qm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AP4jDfkD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD61A8F91
	for <linux-integrity@vger.kernel.org>; Fri, 13 Dec 2024 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128422; cv=none; b=Uhwabt5a3lU6jAr6vdHJzZQujb9dUu/APeQGnSrNCCTFCSuIFrWsqE9khneT3dubQyINtAW5eA5EaxKBOhLSHLpR6H2STo9Wj57017DAArrsGIwoI7sWSVDFWX/dkHzF8+wyf8ZucxrsGQ2tyj8W0xmEmyUq9gwz+yyIQjhKxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128422; c=relaxed/simple;
	bh=x48c2tzlRe2VEMfLEc0kC1+QC2kWZtX1sJ+I5IeGda4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REjObHzgRL46Uc3BzrEQH2bFDLcOwFRfA62cJniQ6vvSosZ+WP0F5q84NLYOyY/sSC+HffVW5S4ZzzVYir0oE1JrZfT0/0BCtsoFj/GBFrfnLlYoG5HS6BXQQK/Kyw7w2tVt3lSEfr1MOh9AxmIkzQc4kzbiryK2+gqscyA4q4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NEGP9VdU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4Arjtvi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdXnf2Qm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AP4jDfkD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8E261F442;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
	b=NEGP9VdUj0w+mMwgt9PlRrfV4U7PGMkeHA8K8lu/WqilLUsEkmBE61B4dkX3evrsz5Kf/5
	K+XuTCmNL01dQfnyATxOZEu3S5q8avAealNQs8xgnWiOL16I3JGEaVJMqoVU5JWZuNQDfk
	YPFYSifoAN9SzZ1SP4n7wNm79JmRjks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
	b=D4Arjtvi3PYkklusRyvADw1BodlallmbdGyxfV8XGUpZvqnVE1OGcFOuTW/dDLhjOTDxd/
	djk4yRvYDWFCdcDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734128417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
	b=qdXnf2Qm8EGlqjDCmCI44pC4hZzx+YHgs9+ppZDTtrDM/oFaPvc1bKOVA+nFkFORRea6dB
	kUACUa/v74p0LiQCqLf1bpiYpB5bQwfRPthIr7KTn62mE2HGRZvoFsYyINrzs2Fdww9Jyl
	kPRFQgz8qQHOyEEh9JRQydaDA7ZQtKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734128417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuiiUtJ1LIssrkXNjvaHrB/KOqTnvtCiuvZnB1bzDN0=;
	b=AP4jDfkDOaxX0/IW/odjqu3QVRrLQotPgOB+y6qT4fiqWaeJ8CATRIE4VsAfcFgeTHWn3m
	DfTwiqtx3u/TUrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DF1613A52;
	Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4FHYHSGzXGf5QQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v2 2/8] ima_setup.sh: Allow to load predefined policy
Date: Fri, 13 Dec 2024 23:20:08 +0100
Message-ID: <20241213222014.1580991-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
if available. This should be used only if tooling running LTP tests
allows to reboot afterwards because policy may be writable only once,
e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
other.

Loading may fail due various reasons (e.g. previously mentioned missing
CONFIG_IMA_WRITE_POLICY=y and policy already loaded or when secure boot is
enabled and the kernel is configured with CONFIG_IMA_ARCH_POLICY enabled, an
appraise func=POLICY_CHECK appraise_type=imasig rule is loaded, requiring the
IMA policy itself to be signed).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/README.md   | 12 +++++
 .../integrity/ima/tests/ima_measurements.sh   | 17 +++++-
 .../security/integrity/ima/tests/ima_setup.sh | 54 ++++++++++++++++---
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 5b261a1914..c5b3db1a5a 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -8,6 +8,18 @@ CONFIG_INTEGRITY=y
 CONFIG_IMA=y
 ```
 
+### Loading policy for testing (optional)
+Setting environment variable `LTP_IMA_LOAD_POLICY=1` tries to load example
+policy if available. This should be used only if tooling running LTP tests
+allows to reboot afterwards because policy may be writable only once, e.g.
+missing `CONFIG_IMA_WRITE_POLICY=y`, or policies can influence each other.
+
+Loading may fail due various reasons (e.g. previously mentioned missing
+`CONFIG_IMA_WRITE_POLICY=y` and policy already loaded or when secure boot is
+enabled and the kernel is configured with `CONFIG_IMA_ARCH_POLICY` enabled, an
+`appraise func=POLICY_CHECK appraise_type=imasig` rule is loaded, requiring the
+IMA policy itself to be signed).
+
 ### IMA measurement tests
 `ima_measurements.sh` require builtin IMA tcb policy to be loaded
 (`ima_policy=tcb` kernel parameter).
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1da2aa6a51..2c95aeb990 100755
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
+			tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter) or it's equivalent (try LTP_IMA_LOAD_POLICY=1)"
+	fi
 }
 
 check_iversion_support()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index df3fc5603f..7afb1a0967 100644
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
@@ -158,6 +164,34 @@ print_ima_config()
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
+		LTP_IMA_LOAD_POLICY=
+		return
+	fi
+
+	tst_res TINFO "trying to load '$policy' policy:"
+	cat $policy
+	if ! check_policy_writable; then
+		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
+		LTP_IMA_LOAD_POLICY=
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
@@ -180,6 +214,8 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
+	load_ima_policy
+
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
@@ -192,6 +228,10 @@ ima_cleanup()
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
2.47.1


