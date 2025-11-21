Return-Path: <linux-integrity+bounces-7655-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1BC7A8E8
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B61A4EF04E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E9AD51;
	Fri, 21 Nov 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9+dYMEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvqs3f7G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9+dYMEO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dvqs3f7G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB75285CA3
	for <linux-integrity@vger.kernel.org>; Fri, 21 Nov 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738485; cv=none; b=ej/OzTkDUuCFiT0HVZ8vdGkpysHiozZpDd+shtQ9rSpjSqR2ywQ5avNEpBOAUgXxGJld6nYXZY20m4IVS5Pft895eYVj76wG4L3+PGPQAoPZIf/ufbpbBMVarDmt9njOoGncwizUNqza5CNxC8NT2ckcgFafoRLR5G5UdsxvHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738485; c=relaxed/simple;
	bh=MgUFwMoVbD+6Zx3CxRPG65g7+xR5/FQlI7ScFxAS4ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfO20hJHsm4bk5H9ZfQqdIJo/7Qj3cOWV9ZsPFcs2DvPifoD2p4ISeEdlF+3ufAoM86Y4+U7pveeashXLmwJ1uzyK47DKwgOgoBUqO9tMM4cShMDZaXnZFa1EgbyOk9jwMNs9CTniIGoMICDXeDNS1gNvhHHHQMSvdJ+Wxu7FCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y9+dYMEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvqs3f7G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y9+dYMEO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dvqs3f7G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40B432109E;
	Fri, 21 Nov 2025 15:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT3bUNCiPmNFMmIsZ0unLGRIg/SsM9bJ0iYEjr5WFWc=;
	b=Y9+dYMEO8C1a2RYKpWpDMoBWpE3xfZsLCzg5Y2vkP0FuBvztLgc67B79gxOZtgjLuGlKlI
	T7XWaTyO6NxOQzZ8pWWnBibp+b1ETKuflJ+I5G06dS2Zhocwh8UEdyQMPoKqwB4kt5vHZQ
	0vm0eYLanSXumydbHNEAznB2+HU7rOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT3bUNCiPmNFMmIsZ0unLGRIg/SsM9bJ0iYEjr5WFWc=;
	b=dvqs3f7G72xs7E64YvXKvE8QPtNFbSB7Cga6xmImyxTbNc0UfLQ7YKvH+KCJUnNGp5j/Dk
	m+wcE61rkuv+SjDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763738475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT3bUNCiPmNFMmIsZ0unLGRIg/SsM9bJ0iYEjr5WFWc=;
	b=Y9+dYMEO8C1a2RYKpWpDMoBWpE3xfZsLCzg5Y2vkP0FuBvztLgc67B79gxOZtgjLuGlKlI
	T7XWaTyO6NxOQzZ8pWWnBibp+b1ETKuflJ+I5G06dS2Zhocwh8UEdyQMPoKqwB4kt5vHZQ
	0vm0eYLanSXumydbHNEAznB2+HU7rOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763738475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT3bUNCiPmNFMmIsZ0unLGRIg/SsM9bJ0iYEjr5WFWc=;
	b=dvqs3f7G72xs7E64YvXKvE8QPtNFbSB7Cga6xmImyxTbNc0UfLQ7YKvH+KCJUnNGp5j/Dk
	m+wcE61rkuv+SjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F274D3EA61;
	Fri, 21 Nov 2025 15:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Lg8OmqDIGndSQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 21 Nov 2025 15:21:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Jan Stancek <jstancek@redhat.com>,
	Li Wang <liwang@redhat.com>
Subject: [PATCH v2 3/4] ima_{conditionals,measurements}.sh: Use tst_sudo
Date: Fri, 21 Nov 2025 16:21:10 +0100
Message-ID: <20251121152111.10419-4-pvorel@suse.cz>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
Changes v1->v2:
* Use tst_sudo instead of sudo and sg.

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


