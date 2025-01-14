Return-Path: <linux-integrity+bounces-4546-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ACBA1055F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E20F18835E1
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06249284A5A;
	Tue, 14 Jan 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpeN8EDg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6MWbL1tI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpeN8EDg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6MWbL1tI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046C24025B
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854168; cv=none; b=F4fsMcyw3NkJWF8TSIcsJ25NJP6eX3Jz4xsVoBfGB2wKnRPJEAUuxVE4GVOwzOcsfqTzV1H55OBRLeWPuhwEsm/LIa2OeS32gPLU623naV8X4K3MVAm+va8ZliecasOmDC35kiipynUfuHChYCxHG3hWVd/lHgYhPbmDXIp6X8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854168; c=relaxed/simple;
	bh=diVLOcmvehwxzrDGEckNGTdkpApjEIck7IloGFnp9Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L17skRhmxGhCdzoPhZmIYYYS3XF6DEwoAtaO3Xj74n34H5OX/xXireRXG6rXiDNH/LpFt29qtksRYlA9kxJBJsiqJ0SlZJMTMClMNU/CjvwOqFj2SX9HuoFHQD+qlF+hYYVrbGEKGIyZc800nQX0rqWp8wv0Hz6SPJVRiSbymVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpeN8EDg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6MWbL1tI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpeN8EDg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6MWbL1tI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC9B72117E;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrmAkrf9zSPs3YZrI4aN2+q55IQh2OjPjwxkARwftys=;
	b=vpeN8EDgtYdiFuXKzI00WYXTHrFFblYsaGIypPnLb6vTUj6tzvXiu0UBSPWPxVXfr5O85R
	n4l5vWiABiqx6Ldrpyis0gbDp67ysDLNCORvYhxdU+DtrxMNA/kqXgFudeL4F/rfH5jb3l
	Q7R3bdYc25pThS6sr6dGuJpRiv2YVhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrmAkrf9zSPs3YZrI4aN2+q55IQh2OjPjwxkARwftys=;
	b=6MWbL1tIlzLD/1xW/F/CDQ7BTVmkf1M3nl6RKj+t3eCUDQci1JFL/9ll5Zs5hOwjS2W+5U
	oTrvQzhg9AZoewBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrmAkrf9zSPs3YZrI4aN2+q55IQh2OjPjwxkARwftys=;
	b=vpeN8EDgtYdiFuXKzI00WYXTHrFFblYsaGIypPnLb6vTUj6tzvXiu0UBSPWPxVXfr5O85R
	n4l5vWiABiqx6Ldrpyis0gbDp67ysDLNCORvYhxdU+DtrxMNA/kqXgFudeL4F/rfH5jb3l
	Q7R3bdYc25pThS6sr6dGuJpRiv2YVhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrmAkrf9zSPs3YZrI4aN2+q55IQh2OjPjwxkARwftys=;
	b=6MWbL1tIlzLD/1xW/F/CDQ7BTVmkf1M3nl6RKj+t3eCUDQci1JFL/9ll5Zs5hOwjS2W+5U
	oTrvQzhg9AZoewBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BDA413A86;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJb/IJRKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 05/10] IMA: Read required policy from file
Date: Tue, 14 Jan 2025 12:29:10 +0100
Message-ID: <20250114112915.610297-6-pvorel@suse.cz>
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
X-Spam-Score: -6.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Previously snipped of required policy was as a string or regexp.
Loading required policy from file allows to move code to ima_setup.sh.
This is a preparation for loading IMA policy from file.

Check can be done on one or both:
1) IMA builtin policy (based on /proc/cmdline)
2) IMA policy content (actual content of /sys/kernel/security/ima/policy)

When missing CONFIG_IMA_READ_POLICY=y on required policy convert: test, but convert TFAIL => TCONF.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_kexec.sh | 19 ++----
 .../security/integrity/ima/tests/ima_keys.sh  | 47 ++++---------
 .../integrity/ima/tests/ima_measurements.sh   |  8 ++-
 .../integrity/ima/tests/ima_selinux.sh        | 22 +++---
 .../security/integrity/ima/tests/ima_setup.sh | 68 ++++++++++++++-----
 .../integrity/ima/tests/ima_violations.sh     |  8 ++-
 6 files changed, 92 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 3446bc24bf..95e6186bb5 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2020 Microsoft Corporation
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Lachlan Sneff <t-josne@linux.microsoft.com>
 #
 # Verify that kexec cmdline is measured correctly.
@@ -14,7 +14,7 @@ TST_SETUP="setup"
 TST_MIN_KVER="5.3"
 
 IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
-REQUIRED_POLICY='^measure.*func=KEXEC_CMDLINE'
+REQUIRED_POLICY_CONTENT='kexec.policy'
 
 measure()
 {
@@ -46,11 +46,6 @@ setup()
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
 	fi
-
-	if check_policy_readable; then
-		require_ima_policy_content "$REQUIRED_POLICY"
-		policy_readable=1
-	fi
 }
 
 kexec_failure_hint()
@@ -79,7 +74,6 @@ kexec_test()
 {
 	local param="$1"
 	local cmdline="$2"
-	local res=TFAIL
 	local kexec_cmd
 
 	kexec_cmd="$param=$cmdline"
@@ -97,13 +91,10 @@ kexec_test()
 
 	ROD kexec -su
 	if ! measure "$cmdline"; then
-		if [ "$policy_readable" != 1 ]; then
-			tst_res TWARN "policy not readable, it might not contain required policy '$REQUIRED_POLICY'"
-			res=TBROK
-		fi
-		tst_brk $res "unable to find a correct measurement"
+		tst_res $IMA_FAIL "unable to find a correct measurement"
+	else
+		tst_res TPASS "kexec cmdline was measured correctly"
 	fi
-	tst_res TPASS "kexec cmdline was measured correctly"
 }
 
 test()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index ff32eb6c43..a2e9c77738 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2020 Microsoft Corporation
-# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Lachlan Sneff <t-josne@linux.microsoft.com>
 #
 # Verify that keys are measured correctly based on policy.
@@ -12,38 +12,24 @@ TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_MIN_KVER="5.6"
 
-FUNC_KEYCHECK='func=KEY_CHECK'
-REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
+REQUIRED_POLICY_CONTENT='keycheck.policy'
 
 setup()
 {
-	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
-	require_valid_policy_template
-}
+	local line
 
-cleanup()
-{
-	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
-}
+	require_policy_readable
 
-require_valid_policy_template()
-{
 	while read line; do
-	if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
-		tst_brk TCONF "only template=ima-buf can be specified for KEY_CHECK"
-	fi
-	done < $TST_TMPDIR/policy.txt
+		if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
+			tst_brk TCONF "only template=ima-buf can be specified for KEY_CHECK"
+		fi
+	done < $IMA_POLICY
 }
 
-check_keys_policy()
+cleanup()
 {
-	local pattern="$1"
-
-	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
-		return 1
-	fi
-	return 0
+	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
 # Based on https://lkml.org/lkml/2019/12/13/564.
@@ -51,12 +37,10 @@ check_keys_policy()
 test1()
 {
 	local keycheck_lines i keyrings templates
-	local pattern='keyrings=[^[:space:]]+'
 	local test_file="file.txt" tmp_file="file2.txt"
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
-	check_keys_policy "$pattern" > $tmp_file || return
 	keycheck_lines=$(cat $tmp_file)
 	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
 		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
@@ -87,7 +71,7 @@ test1()
 		fi
 
 		if [ "$digest" != "$expected_digest" ]; then
-			tst_res TFAIL "incorrect digest was found for $keyring keyring"
+			tst_res $IMA_FAIL "incorrect digest was found for $keyring keyring"
 			return
 		fi
 	done
@@ -105,13 +89,10 @@ test2()
 
 	local cert_file="$TST_DATAROOT/x509_ima.der"
 	local keyring_name="key_import_test"
-	local pattern="keyrings=[^[:space:]]*$keyring_name"
 	local temp_file="file.txt"
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
-	check_keys_policy "$pattern" >/dev/null || return
-
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
 		tst_brk TBROK "unable to create a new keyring"
 
@@ -126,19 +107,19 @@ test2()
 		tst_hexdump -d > $temp_file
 
 	if [ ! -s $temp_file ]; then
-		tst_res TFAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
+		tst_res $IMA_FAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
 		return
 	fi
 
 	if ! openssl x509 -in $temp_file -inform der > /dev/null; then
-		tst_res TFAIL "logged certificate is not a valid x509 certificate"
+		tst_res $IMA_FAIL "logged certificate is not a valid x509 certificate"
 		return
 	fi
 
 	if cmp -s $temp_file $cert_file; then
 		tst_res TPASS "logged certificate matches the original"
 	else
-		tst_res TFAIL "logged certificate does not match original"
+		tst_res $IMA_FAIL "logged certificate does not match original"
 	fi
 }
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index ca9d73b4aa..41d53aa03b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -11,6 +11,7 @@ TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
 TST_CNT=3
 REQUIRED_BUILTIN_POLICY="tcb"
+REQUIRED_POLICY_CONTENT='tcb.policy'
 
 setup()
 {
@@ -70,6 +71,7 @@ test3()
 	local user="nobody"
 	local dir="$PWD/user"
 	local file="$dir/test.txt"
+	local cmd="grep $file $ASCII_MEASUREMENTS"
 
 	# Default policy does not measure user files
 	tst_res TINFO "verify not measuring user files"
@@ -87,7 +89,11 @@ test3()
 	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
-	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
+	if tst_rod "$cmd" 2> /dev/null; then
+		tst_res TPASS "$cmd failed as expected"
+	else
+		tst_res $IMA_FAIL "$cmd passed unexpectedly"
+	fi
 }
 
 . ima_setup.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 75f9ba84e4..45fd741b5f 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2021 Microsoft Corporation
+# Copyright (c) Linux Test Project, 2021-2025
 # Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
 #
 # Verify measurement of SELinux policy hash and state.
@@ -14,15 +15,12 @@ TST_CNT=2
 TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
-FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
-REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
+REQUIRED_POLICY_CONTENT='selinux.policy'
 
 setup()
 {
 	SELINUX_DIR=$(tst_get_selinux_dir)
 	[ "$SELINUX_DIR" ] || tst_brk TCONF "SELinux is not enabled"
-
-	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
 }
 
 # Format of the measured SELinux state data.
@@ -45,7 +43,7 @@ validate_policy_capabilities()
 		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
 		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
 		if [ "$measured_value" != "$expected_value" ]; then
-			tst_res TFAIL "$measured_cap: expected: $expected_value, got: $digest"
+			tst_res $IMA_FAIL "$measured_cap: expected: $expected_value, got: $digest"
 			return
 		fi
 
@@ -75,7 +73,7 @@ test1()
 	# in kernel memory for SELinux
 	line=$(grep -E "selinux-policy-hash" $ASCII_MEASUREMENTS | tail -1)
 	if [ -z "$line" ]; then
-		tst_res TFAIL "SELinux policy hash not measured"
+		tst_res $IMA_FAIL "SELinux policy hash not measured"
 		return
 	fi
 
@@ -86,7 +84,7 @@ test1()
 		tst_brk TCONF "cannot compute digest for $algorithm"
 
 	if [ "$policy_digest" != "$expected_policy_digest" ]; then
-		tst_res TFAIL "Digest mismatch: expected: $expected_policy_digest, got: $policy_digest"
+		tst_res $IMA_FAIL "Digest mismatch: expected: $expected_policy_digest, got: $policy_digest"
 		return
 	fi
 
@@ -116,7 +114,7 @@ test2()
 	# state matches that currently set for SELinux
 	line=$(grep -E "selinux-state" $ASCII_MEASUREMENTS | tail -1)
 	if [ -z "$line" ]; then
-		tst_res TFAIL "SELinux state not measured"
+		tst_res $IMA_FAIL "SELinux state not measured"
 		return
 	fi
 
@@ -129,7 +127,7 @@ test2()
 	tst_brk TCONF "cannot compute digest for $algorithm"
 
 	if [ "$digest" != "$expected_digest" ]; then
-		tst_res TFAIL "digest mismatch: expected: $expected_digest, got: $digest"
+		tst_res $IMA_FAIL "digest mismatch: expected: $expected_digest, got: $digest"
 		return
 	fi
 
@@ -146,20 +144,20 @@ test2()
 	enforced_value=$(echo $measured_data | awk -F'[=;]' '{print $4}')
 	expected_enforced_value=$(cat $SELINUX_DIR/enforce)
 	if [ "$expected_enforced_value" != "$enforced_value" ]; then
-		tst_res TFAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
+		tst_res $IMA_FAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
 		return
 	fi
 
 	checkreqprot_value=$(echo $measured_data | awk -F'[=;]' '{print $6}')
 	expected_checkreqprot_value=$(cat $SELINUX_DIR/checkreqprot)
 	if [ "$expected_checkreqprot_value" != "$checkreqprot_value" ]; then
-		tst_res TFAIL "checkreqprot: expected: $expected_checkreqprot_value, got: $checkreqprot_value"
+		tst_res $IMA_FAIL "checkreqprot: expected: $expected_checkreqprot_value, got: $checkreqprot_value"
 		return
 	fi
 
 	initialized_value=$(echo $measured_data | awk -F'[=;]' '{print $2}')
 	if [ "$initialized_value" != "1" ]; then
-		tst_res TFAIL "initialized: expected 1, got: $initialized_value"
+		tst_res $IMA_FAIL "initialized: expected 1, got: $initialized_value"
 		return
 	fi
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 2a578ceb45..af5584951c 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -19,6 +19,9 @@ SYSFS="/sys"
 UMOUNT=
 TST_FS_TYPE="ext3"
 
+IMA_FAIL="TFAIL"
+IMA_BROK="TBROK"
+
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
 compute_digest()
 {
@@ -85,21 +88,9 @@ require_policy_writable()
 check_ima_policy_content()
 {
 	local pattern="$1"
-	local grep_params="${2--q}"
 
 	check_policy_readable || return 1
-	grep $grep_params "$pattern" $IMA_POLICY
-}
-
-require_ima_policy_content()
-{
-	local pattern="$1"
-	local grep_params="${2--q}"
-
-	require_policy_readable
-	if ! grep $grep_params "$pattern" $IMA_POLICY; then
-		tst_brk TCONF "IMA policy does not specify '$pattern'"
-	fi
+	grep -q "$pattern" $IMA_POLICY
 }
 
 check_ima_policy_cmdline()
@@ -158,6 +149,51 @@ print_ima_config()
 	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
+# Check for required
+# 1) IMA builtin policy (based on /proc/cmdline)
+# 2) IMA policy content (actual content of /sys/kernel/security/ima/policy)
+# When missing CONFIG_IMA_READ_POLICY=y on required policy convert: test, but convert TFAIL => TCONF.
+# $REQUIRED_POLICY_CONTENT: file with required IMA policy
+# $REQUIRED_BUILTIN_POLICY: IMA policy specified as kernel cmdline
+verify_ima_policy()
+{
+	local check_content line
+	local file="$TST_DATAROOT/$REQUIRED_POLICY_CONTENT"
+
+	if [ -z "$REQUIRED_POLICY_CONTENT" -a -z "$REQUIRED_BUILTIN_POLICY" ]; then
+		return 0
+	fi
+
+	if [ -n "$REQUIRED_POLICY_CONTENT" ]; then
+		check_content=1
+		if [ -n "$REQUIRED_BUILTIN_POLICY" ] && check_ima_policy_cmdline "$REQUIRED_BUILTIN_POLICY"; then
+			tst_res TINFO "booted with IMA policy: $REQUIRED_BUILTIN_POLICY"
+			return 0
+		fi
+	elif [ -n "$REQUIRED_BUILTIN_POLICY" ]; then
+		require_ima_policy_cmdline "$REQUIRED_BUILTIN_POLICY"
+	fi
+
+	if [ "$check_content" = 1 ]; then
+		[ -e $file ] || tst_brk TBROK "policy file '$file' does not exist (LTPROOT=$LTPROOT)"
+		tst_res TINFO "test requires IMA policy:"
+		cat $file
+		if check_policy_readable; then
+			# check IMA policy content
+			while read line; do
+				if ! grep -q "$line" $IMA_POLICY; then
+					tst_brk TCONF "missing required policy '$line'"
+				fi
+				IMA_POLICY_CHECKED=1
+			done < $file
+		else
+			tst_res TINFO "policy is not readable, failure will be treated as TCONF"
+			IMA_FAIL="TCONF"
+			IMA_BROK="TCONF"
+		fi
+	fi
+}
+
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
@@ -180,9 +216,7 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
-	if [ "$REQUIRED_BUILTIN_POLICY" ]; then
-		require_ima_policy_cmdline "$REQUIRED_BUILTIN_POLICY"
-	fi
+	verify_ima_policy
 
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
@@ -290,7 +324,7 @@ ima_check()
 		algorithm=$(cat tmp | cut -d'|' -f1)
 		digest=$(cat tmp | cut -d'|' -f2)
 	else
-		tst_brk TBROK "failed to get algorithm/digest for '$test_file'"
+		tst_brk $IMA_BROK "failed to get algorithm/digest for '$test_file'"
 	fi
 
 	tst_res TINFO "computing digest for $algorithm algorithm"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index b2b597ad08..1852e8bc74 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2025 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
@@ -10,6 +10,8 @@ TST_SETUP="setup"
 TST_CLEANUP="cleanup"
 TST_CNT=3
 
+REQUIRED_POLICY_CONTENT='violations.policy'
+
 setup()
 {
 	FILE="test.txt"
@@ -83,11 +85,11 @@ validate()
 				tst_sleep 1s
 			fi
 		else
-			tst_res TFAIL "$search violation not added"
+			tst_res $IMA_FAIL "$search violation not added"
 			return
 		fi
 	done
-	tst_res TFAIL "$search not found in $LOG"
+	tst_res $IMA_FAIL "$search not found in $LOG"
 }
 
 test1()
-- 
2.47.1


