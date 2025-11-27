Return-Path: <linux-integrity+bounces-7686-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD7C8D56F
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 09:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0584E216B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD312DA755;
	Thu, 27 Nov 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oFSbET6+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3DtPwX6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yic4SqC5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwrv650K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAD31D374
	for <linux-integrity@vger.kernel.org>; Thu, 27 Nov 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232027; cv=none; b=l73qbQTdw0kUHLBOK1gCTtTbzwH7KEvAqxGXJhxNdKn4gutMw2pnbamzdBukSw8oBjfAVz1C7VAFbWbhNygmr7tC/UL0hChj2wGGgJMCj07BukSenG68Oef91jwFQxRwjst6ozBWnr3uvp0dWBFwhPkLNRRka0DkJJTENCbmyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232027; c=relaxed/simple;
	bh=/mUWgxkL9+sCjuwadgrhOcFRWKcOSSnc8D8i2xja2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUV6Jt5WhTmxzBQphnDNVGB3s+FX81FXhNWNC8weOYVZ4tGgCExX3RMP7xbyLv3uXgdtFdpbfnLCUGKOELSB0/AlFk/qIbIjA5lWP2PVdZ3nZb+mmgNBDK9f781Z26xEHo+82h9d4Kx0TLuXtr8J1E2EhtBW+dH8k+0V8N30k8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oFSbET6+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3DtPwX6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yic4SqC5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwrv650K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AD665BCD0;
	Thu, 27 Nov 2025 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
	b=oFSbET6+KY7ojFpPIjhYdMUPDPdvHCnBkCKhdVArtUcAyM3ehZPXxHHRdjOVeY+pjAwEvn
	y3ads3JZvEz2qXBFdoPZOKvth9/BUigvmOm0THMWvdNYsYlMgI5hNHAynKgWxz3+QTW9Bs
	36N8gFaHLt6imevEqB0i03zn+8kBrzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
	b=z3DtPwX62c/mYydZVrGKBSH26D18EY7YXxlWzLlL7WCcrveHKhF8kgUGggX39IJz2IAz50
	GMZ91HIvQMcp9KCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
	b=yic4SqC5nhjkLjpBuG3m2+KFXCffDkumGlBmVLYnlXxRCZHabgpuvdpcbGxLys02jg/QS8
	zpTevFJMHEoCsYAtPCBmRDjwX9Z+upihN0poTx6aRWbixT35SFSNRfJVHa2BLZ/zW6sJx+
	PkSMDa1FW2kIAL+ayyE6yVTrpm3mF4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44PQYSarwQ70kFnpNKxwf8Ea202qaPQUdfXBtkV9La0=;
	b=uwrv650Kvrf2cQw4UCdFwIV8NzrGm6akeMgUsJsQ5MbEVWBcmG7TO30ZR7oBNXuu7iJhmG
	6s1WVf0usjHeO0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23C523EA68;
	Thu, 27 Nov 2025 08:26:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YJvyB0ULKGmNJgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v3 4/4] ima_conditionals.sh: Split test by request
Date: Thu, 27 Nov 2025 09:26:38 +0100
Message-ID: <20251127082638.224110-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127082638.224110-1-pvorel@suse.cz>
References: <20251127082638.224110-1-pvorel@suse.cz>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ima_keys.sh:url,ima_selinux.sh:url,imap1.dmz-prg2.suse.org:helo,ima_violations.sh:url,suse.cz:mid,suse.cz:email,ima_conditionals.sh:url];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
index e290dcdaaa..8eed0b6a9d 100755
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
 	gid|uid) tst_sudo sh -c "$cmd";;
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


