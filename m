Return-Path: <linux-integrity+bounces-7355-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE725BB34CA
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Oct 2025 10:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78331563170
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Oct 2025 08:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E6313281;
	Thu,  2 Oct 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YKY8lXJT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4tjeRiNx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D8WOO+kV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zYCOMGTf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA772DC772
	for <linux-integrity@vger.kernel.org>; Thu,  2 Oct 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394229; cv=none; b=P+CQbEh5UE9/0PViQA4SAtG3/gEKn6RfiVpDdrWTMlXw0aIfORppc9wIrHAFE+r1ZbW5qDXL7RQuhvCt724RVeZqIbn5TsmKN6espJW/i0f9cADEbt/lXZpX7kNxQYfRdYDl69aS+FnpsV8HaWaQHCBrFxXVEy9SI8nqfT5VhBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394229; c=relaxed/simple;
	bh=YYGmzgL9OiWnonmOsiKl5gDIlaNavRbEI4ILkAXzkLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPZ8nZ3ei15H4tiBGjjzqjJ8u4So5xVkgts1+0Mz8vm3lJ9XMjc+fQI36jCNCPOD3HUSAJY5QCVXi4uRaRUZG8TLh2Y7UuxEUvHKVXcGCPN7pG28T6Fh8E3RhEwzHB3DgACpzZpZbKqlvTs7/LkhA+zUNaWdrN1tj3nhHgGkPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YKY8lXJT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4tjeRiNx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D8WOO+kV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zYCOMGTf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 025571F44F;
	Thu,  2 Oct 2025 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759394226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXimOCxNSQuQuW278faeH086+58QW1WTzAyZDQKGTB8=;
	b=YKY8lXJTicesDZm55U6A0Pt46Or6K7E40KYJMjLansykUXndMV+5l7YXndR/VMnlhJE9dy
	bAc99v56aDhz5wB4jqe2LONvsqUs0p6V4N+gkNGl9MMtEcfIRpvpvYTGWY2PdLmEWYEyRz
	DXRd9FdZjL+REXP2NFpPUYnwGkkp0qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759394226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXimOCxNSQuQuW278faeH086+58QW1WTzAyZDQKGTB8=;
	b=4tjeRiNxIVVAkzj3wXfIokKOp1G7/HyP4SAtB3oEUjGVlN2fpyHJCU2Bme5Ynhbs8qwGfD
	4Vd6KKRPex9qftCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759394225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXimOCxNSQuQuW278faeH086+58QW1WTzAyZDQKGTB8=;
	b=D8WOO+kVZZOCmaUMnrGNGlRWbCAvhwRS3ZZp5nekeXM+0U3PyTxSVuR0KRfhoyiMmhPYHV
	utv2VerdOuSd/U0n7axzwfrkQRzhQ0p00xJvmu2kfKh57/cWA+IEaPg08ieMRjO57n1fyc
	8eOMeLfxbktDe9eBM0lTJnC+W8wWT1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759394225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXimOCxNSQuQuW278faeH086+58QW1WTzAyZDQKGTB8=;
	b=zYCOMGTf6L9Ygamch7JoT0WgxvUVci3aKdDU/euTS6HJPrFm1KfKrmn8sY2mkBGaFoGkbD
	Qwpy7txHlotBVuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7761613A85;
	Thu,  2 Oct 2025 08:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KN3UFrA53miCWQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 02 Oct 2025 08:37:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH 1/4] ima_{conditionals,measurements}.sh: Add temporary user
Date: Thu,  2 Oct 2025 10:36:58 +0200
Message-ID: <20251002083701.315334-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002083701.315334-1-pvorel@suse.cz>
References: <20251002083701.315334-1-pvorel@suse.cz>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

This is required because new releases of many distros (e.g. Debian,
openSUSE Tumbleweed, SLES, ...) switched shell for 'nobody' user from
/bin/bash (or /bin/sh) to /usr/sbin/nologin. That effectively disables
using 'sudo' or 'su':

    ima_conditionals 1 TINFO: verify measuring user files when requested via uid
    sudo: Account expired or PAM config lacks an "account" section for sudo, contact your system administrator
    sudo: a password is required

Creating a temporary user is the best approach (no setup needed to be
done by testers).

Follow usual LTP approach to create user in setup(), delete in cleanup().
A small disadvantage of that approach is that whole ima_measurements.sh
is skipped if missing useradd or userdel while it's used only in
test3().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_conditionals.sh      | 16 ++++++++--------
 .../integrity/ima/tests/ima_measurements.sh      | 13 ++++---------
 .../security/integrity/ima/tests/ima_setup.sh    | 12 ++++++++++++
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index 9125616890..a8b2e1015a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -9,9 +9,10 @@
 # gid and fgroup options test kernel commit 40224c41661b ("ima: add gid
 # support") from v5.16.
 
-TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
+TST_NEEDS_CMDS="cat chgrp chown id sg sudo useradd userdel"
 TST_SETUP="setup"
 TST_CNT=1
+REQUIRE_TMP_USER=1
 
 setup()
 {
@@ -23,12 +24,11 @@ setup()
 verify_measurement()
 {
 	local request="$1"
-	local user="nobody"
 	local test_file="$PWD/test.txt"
 	local cmd="cat $test_file > /dev/null"
 
-	local value="$(id -u $user)"
-	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
+	local value="$(id -u $IMA_USER)"
+	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $IMA_USER)"
 
 	# needs to be checked each run (not in setup)
 	require_policy_writable
@@ -41,15 +41,15 @@ verify_measurement()
 
 	case "$request" in
 	fgroup)
-		chgrp $user $test_file
+		chgrp $IMA_USER $test_file
 		sh -c "$cmd"
 		;;
 	fowner)
-		chown $user $test_file
+		chown $IMA_USER $test_file
 		sh -c "$cmd"
 		;;
-	gid) sudo sg $user "sh -c '$cmd'";;
-	uid) sudo -n -u $user sh -c "$cmd";;
+	gid) sudo sg $IMA_USER "sh -c '$cmd'";;
+	uid) sudo -n -u $IMA_USER sh -c "$cmd";;
 	*) tst_brk TBROK "Invalid res type '$1'";;
 	esac
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 60350f3926..e92f3efb95 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -7,11 +7,12 @@
 # Verify that measurements are added to the measurement list based on policy.
 # Test requires either ima_policy=tcb or example policy loadable with LTP_IMA_LOAD_POLICY=1.
 
-TST_NEEDS_CMDS="awk cut sed"
+TST_NEEDS_CMDS="awk cut sed useradd userdel"
 TST_SETUP="setup"
 TST_CNT=3
 REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='tcb.policy'
+REQUIRE_TMP_USER=1
 
 setup()
 {
@@ -68,7 +69,6 @@ test2()
 
 test3()
 {
-	local user="nobody"
 	local dir="$PWD/user"
 	local file="$dir/test.txt"
 	local cmd="grep $file $ASCII_MEASUREMENTS"
@@ -82,16 +82,11 @@ test3()
 		return
 	fi
 
-	if ! id $user >/dev/null 2>/dev/null; then
-		tst_res TCONF "missing system user $user (wrong installation)"
-		return
-	fi
-
 	[ -d "$dir" ] || mkdir -m 0700 $dir
-	chown $user $dir
+	chown $IMA_USER $dir
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
-	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
+	sudo -n -u $IMA_USER sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
 	if ! tst_rod "$cmd" 2> /dev/null; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 2a7d651818..23400a0fde 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -22,6 +22,7 @@ TST_FS_TYPE="ext3"
 
 IMA_FAIL="TFAIL"
 IMA_BROK="TBROK"
+IMA_USER="ltp_ima_$$"
 
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
 compute_digest()
@@ -283,12 +284,23 @@ ima_setup()
 		load_ima_policy
 	fi
 
+	if [ "$REQUIRE_TMP_USER" = 1 ]; then
+		tst_require_cmds useradd userdel
+		tst_res TINFO "adding temporary user $IMA_USER"
+		id "$IMA_USER" 2>/dev/null || ROD useradd --no-create-home "$IMA_USER"
+		USER_ADDED=1
+	fi
 }
 
 ima_cleanup()
 {
 	local dir
 
+	if [ "$USER_ADDED" = 1 ]; then
+		tst_res TINFO "removing user $IMA_USER"
+		userdel "$IMA_USER"
+	fi
+
 	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
 
 	for dir in $UMOUNT; do
-- 
2.51.0


