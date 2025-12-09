Return-Path: <linux-integrity+bounces-7882-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0037CB0E13
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 19:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B01630164F5
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E61303A35;
	Tue,  9 Dec 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ul/7Vakv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ogeN12a9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ul/7Vakv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ogeN12a9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A6303C97
	for <linux-integrity@vger.kernel.org>; Tue,  9 Dec 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765306573; cv=none; b=jmP7G6McWQgBMPxlG7jRCBjkbtlxuL52cHPTGQPCUIbura/3ZmQItHlZ1bo3Y75kBiT48SUikI5W/HhSCwp2QVGuSwX1Iq1y0P/KD2F0N0O/jhi6+bT8lJbc02P6Xp+SeoHZMSFqsqQSXkHqxqFhzekLcSMuNW8b+7P+OshD0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765306573; c=relaxed/simple;
	bh=jyfFoUqmcg4OFFfqd8JKvsgcfYR+D61GFQE4kBam+X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC2GjpjbEqVaj9i7JGP+EpxMoso37RyvvFk/dCFE219zfOpjhrq0AN1U4jWEa1gFkRBHmIdWc+Hf/DBN8dprtId70WBXhckvbJEIs74br24Kpot4dUhLggyB2rxm7Q+VfXBAdKRCC3REQYKJ+ResXY2F9Qumi8VoiYQxsYvtcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ul/7Vakv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ogeN12a9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ul/7Vakv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ogeN12a9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFE205BE04;
	Tue,  9 Dec 2025 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWzXBqqsBzyC6V6+innjZprFWwu67gqwMZx0ey6N3fA=;
	b=Ul/7VakvSDY6pnn4avh8kl+Qw7AUO5k1+2QLQMv50xeMrRyTuURgVdxTIMLAFLmkKpj6XF
	bVEX0/vU3aJ1hXCZXipWcDHNQDCzQW5hDxtflw1EPgPW01zTV8pJsbQG38ocXZFGc5ko/P
	8PVHJorSRzbqSgbRVsraBw2PxtwixPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765306562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWzXBqqsBzyC6V6+innjZprFWwu67gqwMZx0ey6N3fA=;
	b=ogeN12a9XnROv07+NQBxyiitgzi6iZn4spxAneaglU/DJTOdoiIpQkRcBWvG/uT5OH/Jri
	xolluEhCZhCyl+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWzXBqqsBzyC6V6+innjZprFWwu67gqwMZx0ey6N3fA=;
	b=Ul/7VakvSDY6pnn4avh8kl+Qw7AUO5k1+2QLQMv50xeMrRyTuURgVdxTIMLAFLmkKpj6XF
	bVEX0/vU3aJ1hXCZXipWcDHNQDCzQW5hDxtflw1EPgPW01zTV8pJsbQG38ocXZFGc5ko/P
	8PVHJorSRzbqSgbRVsraBw2PxtwixPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765306562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWzXBqqsBzyC6V6+innjZprFWwu67gqwMZx0ey6N3fA=;
	b=ogeN12a9XnROv07+NQBxyiitgzi6iZn4spxAneaglU/DJTOdoiIpQkRcBWvG/uT5OH/Jri
	xolluEhCZhCyl+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CD4A3EA66;
	Tue,  9 Dec 2025 18:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OKRVGcJwOGnSSAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:56:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v4 4/4] ima_conditionals.sh: Split test by request
Date: Tue,  9 Dec 2025 19:55:57 +0100
Message-ID: <20251209185557.20598-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209185557.20598-1-pvorel@suse.cz>
References: <20251209185557.20598-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
(disabled by default in mainline, therefore disabled for some distros,
e.g. openSUSE Tumbleweed), if SUT reboots.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 67 ++++++++++++-------
 2 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/runtest/ima b/runtest/ima
index 01942eefa3..c8d0c6801e 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -6,5 +6,8 @@ ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
 ima_selinux ima_selinux.sh
-ima_conditionals ima_conditionals.sh
+ima_conditionals_uid ima_conditionals.sh -r uid
+ima_conditionals_fowner ima_conditionals.sh -r fowner
+ima_conditionals_gid ima_conditionals.sh -r gid
+ima_conditionals_fgroup ima_conditionals.sh -r fgroup
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index ae947db1e9..7dd37373cd 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -11,35 +11,66 @@
 
 TST_NEEDS_CMDS="cat chgrp chown"
 TST_SETUP="setup"
-TST_CNT=1
+TST_OPTS="r:"
+TST_USAGE="usage"
+TST_PARSE_ARGS="parse_args"
+REQUEST="uid"
+
+parse_args()
+{
+	REQUEST="$2"
+}
+
+usage()
+{
+	cat << EOF
+usage: $0 [-r <uid|fowner|gid|fgroup>]
+
+OPTIONS
+-r	Specify the request to be measured. One of:
+	uid, fowner, gid, fgroup
+	Default: uid
+EOF
+}
 
 setup()
 {
+	case "$REQUEST" in
+	fgroup|fowner|gid|uid)
+		tst_res TINFO "request '$REQUEST'"
+		;;
+	*) tst_brk TBROK "Invalid -r '$REQUEST', use: -r <uid|fowner|gid|fgroup>";;
+	esac
+
 	if check_need_signed_policy; then
 		tst_brk TCONF "policy have to be signed"
 	fi
 }
 
-verify_measurement()
+test()
 {
+	# needs to be checked each run (not in setup)
+	require_policy_writable
+
 	local request="$1"
-	local user="nobody"
 	local test_file="$PWD/test.txt"
 	local cmd="cat $test_file > /dev/null"
-
 	local value="$TST_USR_UID"
-	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$TST_USR_GID"
 
-	# needs to be checked each run (not in setup)
-	require_policy_writable
+	if [ "$REQUEST" = 'gid' -o "$REQUEST" = 'fgroup' ]; then
+		if tst_kvcmp -lt 5.16; then
+			tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+		fi
+		value="$TST_USR_GID"
+	fi
 
 	ROD rm -f $test_file
 
-	tst_res TINFO "verify measuring user files when requested via $request"
-	ROD echo "measure $request=$value" \> $IMA_POLICY
-	ROD echo "$(cat /proc/uptime) $request test" \> $test_file
+	tst_res TINFO "verify measuring user files when requested via $REQUEST"
+	ROD echo "measure $REQUEST=$value" \> $IMA_POLICY
+	ROD echo "$(cat /proc/uptime) $REQUEST test" \> $test_file
 
-	case "$request" in
+	case "$REQUEST" in
 	fgroup)
 		chgrp $TST_USR_GID $test_file
 		sh -c "$cmd"
@@ -49,24 +80,10 @@ verify_measurement()
 		sh -c "$cmd"
 		;;
 	gid|uid) tst_runas sh -c "$cmd";;
-	*) tst_brk TBROK "Invalid res type '$1'";;
 	esac
 
 	ima_check $test_file
 }
 
-test1()
-{
-	verify_measurement uid
-	verify_measurement fowner
-
-	if tst_kvcmp -lt 5.16; then
-		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
-	fi
-
-	verify_measurement gid
-	verify_measurement fgroup
-}
-
 . ima_setup.sh
 tst_run
-- 
2.51.0


