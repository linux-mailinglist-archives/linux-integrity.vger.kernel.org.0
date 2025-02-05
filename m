Return-Path: <linux-integrity+bounces-4732-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A57A29C3A
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB393A358A
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654F214A96;
	Wed,  5 Feb 2025 21:57:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FE21516D
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792641; cv=none; b=F0BJQ1C70L0q5t7Tr4XlFJjguF4/QbiUYW0tl4QaY0feELpqeI+lgau9V9IzSGb7eTrjnNP0xh41HmafXHJXp2WgM+CFQPF/SfmqopwXm/MOku80U7Ljm1T+KwGfDS/AYWjDXLrF4pJr0fmCTzETxJ6QiUazJIoFAlAcU8DKYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792641; c=relaxed/simple;
	bh=F/UUKjVUz5uldWJsilO4NCgC+6KkRX4LbnT6WSxvszw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K//hL7eWgALTkiRC6eZktrZTOVEYv6Zwm7BI0nAAlC92otrJs6UU9diofWEptvW0AH12MbmWdmWFDZ3+ov7kCKtqNT88+nSFRMicL/BFOcqSNrEqySYr+jXRclqCixuBnTsLF7Kw0LkeengLRueJymS6q3v4Nqs1jHdx7964UV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF1E621162;
	Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6295139D8;
	Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oMRaJ7zeo2eYEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 05 Feb 2025 21:57:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH COMMITTED 2/2] ima_setup.sh: Quit the test on unsuitable IMA policy
Date: Wed,  5 Feb 2025 22:57:08 +0100
Message-ID: <20250205215709.1526151-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205215709.1526151-1-pvorel@suse.cz>
References: <20250205215709.1526151-1-pvorel@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DF1E621162
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

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


