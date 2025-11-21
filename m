Return-Path: <linux-integrity+bounces-7657-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9839C7A915
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06F29364D5A
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC742DC790;
	Fri, 21 Nov 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSvpcKX6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhpnOIJ+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSvpcKX6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JhpnOIJ+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7D263F54
	for <linux-integrity@vger.kernel.org>; Fri, 21 Nov 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738492; cv=none; b=psnQe4+UZxa6raJMAfJ5AkNq+96JKgD77wZAwxQu/o7d1vqTO/uM0+Bxip+mrL5OJFBH0YE5ffDtZB+u4dwr14fCMsaPLX0ymtdsfDYC58QgRWYkfMkm0VhknMVR+7uM6XKhvuxbIHhGrUOUILGbYhd8kXA3sPH5sbC8XY6dVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738492; c=relaxed/simple;
	bh=c/u4yz0Rj5KOxEwC9kX+EU5gbjs1Um09kdZQ81Ad41s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8Wpf2W/zZOSJeZ8uL2ZA0owECGEIf+7cvmQw+Wib76IANeBGmXlCufd7bytER023F4AQ+cO2ZaItbXjEN8eDN24cPiqilbg/0xuKkve3YoEHF5F4ZZ8vbfRcd7v/+dSZmWwlcO6z/D8n0VMLwd9r5CuRvLUZq9kFltqx4ce6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSvpcKX6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhpnOIJ+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSvpcKX6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JhpnOIJ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 652892109F;
	Fri, 21 Nov 2025 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuxO8E1QS9u/Uj4ug5KaWxpFw7X4carQoOw+cH+qmII=;
	b=zSvpcKX61GhV3s4fBfv/3NUQHmPqk+gOqq8GvO0mwNIi04qjQIxrOKzxKQDZvsilWVKpov
	xkwn7fqLoNqIrf5DSaG1s/QrfhWSh2vqdgKtlkiS//hOW68Gn4SuUyXK5GU+BDvPg9Rj5D
	ueaSoRxkmHrzLdRd6rFYr7whuZdq8dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuxO8E1QS9u/Uj4ug5KaWxpFw7X4carQoOw+cH+qmII=;
	b=JhpnOIJ+CDCwowhVnj5NoKStngv71Bh37GtuhZysTDMJQgTlEvn9MqTP+PBDezye2PH+8J
	IexqvMkJuuhn2yAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuxO8E1QS9u/Uj4ug5KaWxpFw7X4carQoOw+cH+qmII=;
	b=zSvpcKX61GhV3s4fBfv/3NUQHmPqk+gOqq8GvO0mwNIi04qjQIxrOKzxKQDZvsilWVKpov
	xkwn7fqLoNqIrf5DSaG1s/QrfhWSh2vqdgKtlkiS//hOW68Gn4SuUyXK5GU+BDvPg9Rj5D
	ueaSoRxkmHrzLdRd6rFYr7whuZdq8dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuxO8E1QS9u/Uj4ug5KaWxpFw7X4carQoOw+cH+qmII=;
	b=JhpnOIJ+CDCwowhVnj5NoKStngv71Bh37GtuhZysTDMJQgTlEvn9MqTP+PBDezye2PH+8J
	IexqvMkJuuhn2yAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33B2D3EA64;
	Fri, 21 Nov 2025 15:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8M2kC2uDIGndSQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Nov 2025 15:21:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v2 4/4] ima_conditionals.sh: Split test by request
Date: Fri, 21 Nov 2025 16:21:11 +0100
Message-ID: <20251121152111.10419-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121152111.10419-1-pvorel@suse.cz>
References: <20251121152111.10419-1-pvorel@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This helps to run all testcases on systems without CONFIG_IMA_WRITE_POLICY=y
(disabled by default in mainline, therefore disabled for some distros,
e.g. openSUSE Tumbleweed), if SUT reboots.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v1.

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


