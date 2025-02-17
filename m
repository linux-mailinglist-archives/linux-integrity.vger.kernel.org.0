Return-Path: <linux-integrity+bounces-4853-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E825DA38B50
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 19:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86453A69BC
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809B235BF4;
	Mon, 17 Feb 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JrAOlgsU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k6f4SKwq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljaZ9XhE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="99h0b/VG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D021D3F4
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817213; cv=none; b=eOBm/xuFAWkjEDbYJeaEf7mgbSIiJpZthyZkIrFlZSo9AQyekHMfPC/GfCE5PRNoDK4kzMNP4UlQB/xA3oWKl7sCTlN9Dl/E41VtbpHHAaZX26uAQroo+Y/wUl7RQ5VicKijXOLlcuMJ41t7fvSIni8ptqne2mIyGb4TENU0Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817213; c=relaxed/simple;
	bh=F/UUKjVUz5uldWJsilO4NCgC+6KkRX4LbnT6WSxvszw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYCty/EiUVfdWmxMfMn/u+0ywB921dEq6JL9kMjY4eKpLxBDiFZYdt+m0oTPoygvQqy7ml6Rp4F8Q6ky7HjdW1FzDubv0YRVUr36g+jCYvPLxlS2Y/lgsuco+xF/kZsW4pAKSFcbm0P87JZiwdgnCTq+CNIMfq1MnrgxUTYXP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JrAOlgsU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k6f4SKwq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljaZ9XhE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=99h0b/VG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1DC61F443;
	Mon, 17 Feb 2025 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739817210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
	b=JrAOlgsUCz2E7jGyfyR3RtV5YXUrU9rq084ATTwIutW41tQ7IuxLXpntnsnpO890+cd1QQ
	+KqRiFXCm+PsjqdlhBoY9vHzrEdOQ5bYx53EeMFfQwRA3jDElBDTBSmeXMNeAdo+ZsdRMQ
	Ba5AUhhaO4Kc0DcwtKKeX+xGLZbVbHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739817210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
	b=k6f4SKwqcrFEq8BafM+PwcRe4Fcf/+vgPvQaXzf1SFrG3gK5D5+ngruYoHl5YalyAtCZkw
	NNnQEizdgpaJ5WAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ljaZ9XhE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="99h0b/VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739817209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
	b=ljaZ9XhEmIaeYmksiA8MnmMlFQ/1RdphYNhILxXRwpN3k2DHFsqjpNDRZzUjPJeMBkk4fH
	FuUvQWD37w830lDyMZf/sddAhgNR4NitOtIqBptQ59WPWrNRkRZxw+X6Z57PlEAsVsq9CZ
	jURTolag9qNAbQtbWoD5M6WO0W6kaxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739817209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
	b=99h0b/VGzz77lqGNkRs6UmOF9OQTsTUdbbTMTnXlxe2rJM2ErlYn8jD7OVqrugL+6MS27Z
	HDE7QiwoTK70aTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 500B5133F9;
	Mon, 17 Feb 2025 18:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z7saEfmAs2c0eAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 18:33:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH COMMITTED] ima_setup.sh: Quit the test on unsuitable IMA policy
Date: Mon, 17 Feb 2025 19:33:22 +0100
Message-ID: <20250217183322.2429271-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C1DC61F443
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Fixing 2 bug:

1) Test wrongly continued testing on SUT with unsuitable IMA policy when
LTP_IMA_LOAD_POLICY=1 was *not* set.  That caused ima_keys.sh and
ima_kexec.sh TFAIL instead of TCONF.

2) Also don't attempt to load policy when needed but LTP_IMA_LOAD_POLICY=1
was *not* set.

This also reverts a5c47143b5 ("ima_measurements.sh: Check policy for test3")
which required the previous behavior. To restore behavior in the future
loading policy will need to be rewritten to allow check only for a
particular test or ima_measurements.sh can be split to require TCB
policy only for 3rd test.

Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh        |  2 +-
 .../security/integrity/ima/tests/ima_setup.sh      | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index d1e41b789a..60350f3926 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -77,7 +77,7 @@ test3()
 	tst_res TINFO "verify not measuring user files"
 	tst_check_cmds sudo || return
 
-	if [ "$IMA_POLICY_CHECKED" != 1 ]; then
+	if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
 		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
 		return
 	fi
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 69ee5a3d65..366e1257dc 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -190,10 +190,10 @@ verify_ima_policy()
 			while read line; do
 				if ! grep -q "$line" $IMA_POLICY; then
 					tst_res TINFO "WARNING: missing required policy content: '$line'"
+					IMA_MISSING_POLICY_CONTENT=1
 					return 1
 				fi
 			done < $file
-			IMA_POLICY_CHECKED=1
 		else
 			tst_res TINFO "policy is not readable, failure will be treated as TCONF"
 			IMA_FAIL="TCONF"
@@ -208,13 +208,11 @@ load_ima_policy()
 {
 	local file="$TST_DATAROOT/$REQUIRED_POLICY_CONTENT"
 
-	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$IMA_POLICY_CHECKED" != 1 ]; then
-		tst_res TCONF "missing required policy, example policy can be loaded with LTP_IMA_LOAD_POLICY=1"
-		return 0
-	fi
-
-	if [ "$IMA_POLICY_CHECKED" = 1 ]; then
-		tst_res TINFO "valid policy already loaded, ignore LTP_IMA_LOAD_POLICY=1"
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 ]; then
+		if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
+			tst_brk TCONF "missing required policy, example policy can be loaded with LTP_IMA_LOAD_POLICY=1"
+		fi
+		return
 	fi
 
 	tst_res TINFO "trying to load '$file' policy:"
-- 
2.47.2


