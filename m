Return-Path: <linux-integrity+bounces-7359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E1BB34D0
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Oct 2025 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4617388107
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Oct 2025 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC792E8897;
	Thu,  2 Oct 2025 08:37:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D82EACE1
	for <linux-integrity@vger.kernel.org>; Thu,  2 Oct 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394250; cv=none; b=FjPPK/RGIL4iyaa8nEWuoCajfKmBOpbPoS4r9f8e0wW0Ia8TWuSk7MbIR5SSRNE2YB7YJp9gYANcvAZsYQCWM3PRG6KgUKpH5+h91Lpt9up84YZUNlYe5CsNIgDStOiDvwKSrXgQpqQQ+IJJN08m6QsHxtRgyIzWfiw0F7zAEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394250; c=relaxed/simple;
	bh=qvp4m0EjIHEcA/thal0ThFTgJEhgqqCULYNR6sXPsR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBxcdPVDuLAO3qGlg2Iuf7Z98YmL40ncRc3qwFMc03KS40ZcrE/Sp1cvr5kLModU7siD4puRM3DIfuz+VhBvWGejuOBSXsad4APHTUSgGZlxhoI0wJPOmqoKmiZ+aAsAKDdYLLwm9IfmYeYQtcQJ6Q/b73dHBkq8f27RTC567qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEAC13382B;
	Thu,  2 Oct 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2028413990;
	Thu,  2 Oct 2025 08:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QDmuBbI53miCWQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 02 Oct 2025 08:37:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH 4/4] ima_{conditionals,measurements}.sh: Use 'su' instead of 'sudo'
Date: Thu,  2 Oct 2025 10:37:01 +0200
Message-ID: <20251002083701.315334-5-pvorel@suse.cz>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CEAC13382B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

'su' is simpler than 'sudo' (fewer configuration files, less libraries)
and it's usually installed (part of util-linux or busybox). This also
helps to test with initramfs based rapido-linux.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
https://github.com/rapido-linux/rapido

 .../kernel/security/integrity/ima/tests/ima_conditionals.sh   | 4 ++--
 .../kernel/security/integrity/ima/tests/ima_measurements.sh   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index f4ee79b2bc..4eca0e88b9 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -9,7 +9,7 @@
 # gid and fgroup options test kernel commit 40224c41661b ("ima: add gid
 # support") from v5.16.
 
-TST_NEEDS_CMDS="cat chgrp chown id sg sudo useradd userdel"
+TST_NEEDS_CMDS="cat chgrp chown id sg su useradd userdel"
 TST_SETUP="setup"
 TST_TESTFUNC="test"
 REQUIRE_TMP_USER=1
@@ -82,7 +82,7 @@ test()
 		sh -c "$cmd"
 		;;
 	gid) sg $IMA_USER "sh -c '$cmd'";;
-	uid) sudo -n -u $IMA_USER sh -c "$cmd";;
+	uid) su - $IMA_USER sh -c "$cmd";;
 	esac
 
 	ima_check $test_file
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index e92f3efb95..404b63d99f 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -75,7 +75,7 @@ test3()
 
 	# Default policy does not measure user files
 	tst_res TINFO "verify not measuring user files"
-	tst_check_cmds sudo || return
+	tst_check_cmds su || return
 
 	if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
 		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
@@ -86,7 +86,7 @@ test3()
 	chown $IMA_USER $dir
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
-	sudo -n -u $IMA_USER sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
+	su - $IMA_USER sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
 	if ! tst_rod "$cmd" 2> /dev/null; then
-- 
2.51.0


