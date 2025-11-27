Return-Path: <linux-integrity+bounces-7685-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80FC8D566
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 09:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 078074E4292
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F6316909;
	Thu, 27 Nov 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a7SLQwtR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vjjfUcEG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a7SLQwtR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vjjfUcEG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65F32254E
	for <linux-integrity@vger.kernel.org>; Thu, 27 Nov 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232021; cv=none; b=PnwqYdQa9Oa1UQBjAalDDhxSqJlXnYP419C9Od2CoYafsx/MPhoUVNjQVdID254v4C/tIq5wt7GcSXvlJNMgtQLYpUhKOj3hcZfxU4atscNAXW0HRT8yH3U+8x6joRHh226MRbBksIzpWa7MLRgljtogoi5kE8TiIP2aei6lrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232021; c=relaxed/simple;
	bh=4bOUdXK93L/NVbod1HtXy4A3PG3KZHI2SNhVG6f6wUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4Kf5QiXU7Q1Gfpn2xqu0Ur5G37LMsIiM223ug+9zQgxv9NC1+mFhK2cyI+JphDFEDebfo1Wp2gEdnwxAIKn/QlgEU32lLjupx/402EqDfeUXpL9CJAXwAJ3ySB1XCD6eLdJiRAXgZl7xH3+dFtCJX4y5WTSe8xatKwauZP6roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a7SLQwtR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vjjfUcEG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a7SLQwtR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vjjfUcEG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DE985BCCF;
	Thu, 27 Nov 2025 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIlBchpQbXZ89iKnKd8UuiOm/SMhdzoYChEpFXYckhU=;
	b=a7SLQwtRXWA0LzQservSo0Zu3dmTyN6lszL8lr8Jo6B2ctySKED6k7on0SXnP1aHzOtMiP
	jr3txXKh62UtaM4+Cysj85NSNOlmNW2/9BG/VnLc7wtgOGQdMM7D2eMLhCZVK90bFcOjEy
	ClFcBOpX9Pn1qNBcG/BOmPQDKI6RTKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIlBchpQbXZ89iKnKd8UuiOm/SMhdzoYChEpFXYckhU=;
	b=vjjfUcEGfGxoXKppoTrz8mSrsMZVeMNYAGw2uBXRAZjqOzU5hiCSj7l8IoBWcVf+2IyQlc
	QDfygcXyQLKQPtBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a7SLQwtR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vjjfUcEG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764232005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIlBchpQbXZ89iKnKd8UuiOm/SMhdzoYChEpFXYckhU=;
	b=a7SLQwtRXWA0LzQservSo0Zu3dmTyN6lszL8lr8Jo6B2ctySKED6k7on0SXnP1aHzOtMiP
	jr3txXKh62UtaM4+Cysj85NSNOlmNW2/9BG/VnLc7wtgOGQdMM7D2eMLhCZVK90bFcOjEy
	ClFcBOpX9Pn1qNBcG/BOmPQDKI6RTKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764232005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIlBchpQbXZ89iKnKd8UuiOm/SMhdzoYChEpFXYckhU=;
	b=vjjfUcEGfGxoXKppoTrz8mSrsMZVeMNYAGw2uBXRAZjqOzU5hiCSj7l8IoBWcVf+2IyQlc
	QDfygcXyQLKQPtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E341C3EA67;
	Thu, 27 Nov 2025 08:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uI6vNkQLKGmNJgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 08:26:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v3 3/4] ima_{conditionals,measurements}.sh: Use tst_sudo
Date: Thu, 27 Nov 2025 09:26:37 +0100
Message-ID: <20251127082638.224110-4-pvorel@suse.cz>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2DE985BCCF
X-Rspamd-Action: no action
X-Spam-Flag: NO

Replace 'sudo' and 'sg' with 'tst_sudo'.

This not only removes 'sudo' external dependency, but it s required
because new releases of many distros (e.g. Debian, openSUSE Tumbleweed,
SLES, ...) switched shell for 'nobody' user from /bin/bash (or /bin/sh)
to /usr/sbin/nologin. That effectively disables using 'sudo', 'su', 'sg':

    ima_conditionals 1 TINFO: verify measuring user files when requested via uid
    sudo: Account expired or PAM config lacks an "account" section for sudo, contact your system administrator
    sudo: a password is required

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_conditionals.sh         | 13 ++++++-------
 .../integrity/ima/tests/ima_measurements.sh         | 11 ++---------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index ba19176039..e290dcdaaa 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -9,7 +9,7 @@
 # gid and fgroup options test kernel commit 40224c41661b ("ima: add gid
 # support") from v5.16.
 
-TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
+TST_NEEDS_CMDS="cat chgrp chown"
 TST_SETUP="setup"
 TST_CNT=1
 
@@ -27,8 +27,8 @@ verify_measurement()
 	local test_file="$PWD/test.txt"
 	local cmd="cat $test_file > /dev/null"
 
-	local value="$(id -u $user)"
-	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$(id -g $user)"
+	local value="$TST_USR_UID"
+	[ "$request" = 'gid' -o "$request" = 'fgroup' ] && value="$TST_USR_GID"
 
 	# needs to be checked each run (not in setup)
 	require_policy_writable
@@ -41,15 +41,14 @@ verify_measurement()
 
 	case "$request" in
 	fgroup)
-		chgrp $user $test_file
+		chgrp $TST_USR_GID $test_file
 		sh -c "$cmd"
 		;;
 	fowner)
-		chown $user $test_file
+		chown $TST_USR_UID $test_file
 		sh -c "$cmd"
 		;;
-	gid) sg $user "sh -c '$cmd'";;
-	uid) sudo -n -u $user sh -c "$cmd";;
+	gid|uid) tst_sudo sh -c "$cmd";;
 	*) tst_brk TBROK "Invalid res type '$1'";;
 	esac
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 60350f3926..30bfe3e629 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -68,30 +68,23 @@ test2()
 
 test3()
 {
-	local user="nobody"
 	local dir="$PWD/user"
 	local file="$dir/test.txt"
 	local cmd="grep $file $ASCII_MEASUREMENTS"
 
 	# Default policy does not measure user files
 	tst_res TINFO "verify not measuring user files"
-	tst_check_cmds sudo || return
 
 	if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
 		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
 		return
 	fi
 
-	if ! id $user >/dev/null 2>/dev/null; then
-		tst_res TCONF "missing system user $user (wrong installation)"
-		return
-	fi
-
 	[ -d "$dir" ] || mkdir -m 0700 $dir
-	chown $user $dir
+	chown $TST_USR_UID $dir
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
-	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
+	tst_sudo sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
 	if ! tst_rod "$cmd" 2> /dev/null; then
-- 
2.51.0


