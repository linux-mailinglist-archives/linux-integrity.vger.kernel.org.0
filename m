Return-Path: <linux-integrity+bounces-5280-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D3A611A9
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 13:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A617A0295
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2B1FA243;
	Fri, 14 Mar 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g74QYJBO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OMtas1SZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g74QYJBO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OMtas1SZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB11CD3F
	for <linux-integrity@vger.kernel.org>; Fri, 14 Mar 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956168; cv=none; b=hyI9bjNnOvXzWw8GnMctlyMDKEyy8v+gwtVo1JJqFYpM/Nes+u0PIsd4KaAILqLM3fgSR46oCp3S5yacU6/KCt3p9lLJH97dhRrnF6cvv32xECplJ0oJJx2V1g1vuwjtJVv0idnBcdFf75BYvI7kyQFrJh8qrhxhV5zAmFtJaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956168; c=relaxed/simple;
	bh=8gozoHtu+GmxkhOXrKZGaxecyQgfomTkdqvj6Xo6GCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnKXhkGA24xgm8UVRjxLGWzB91Sz1Zo85R7FFCLV6k6TBjSxUhjM1fCYQJKItnvZn5PvXLXohkgiZyUnitjwHztJYRhal4SYOvks5+toYqUfqELS+gFKkStHWUmyWVFckIhacljaNMwRPtUUVhoZ8JyBz19ANCFAD+n6hheSXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g74QYJBO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OMtas1SZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g74QYJBO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OMtas1SZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F18EA1F38E;
	Fri, 14 Mar 2025 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741956165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9LV6mPzGNpO3OLPnndLeEqRVGIYvZNpqHc6M3C7nxc=;
	b=g74QYJBOtAmqlQ+YVsIBPcp1RXtDX0GtE34AqAi9mY7IbWxW2nuVkUW/Pngr2fRa7LFtm6
	bq8rCVFtwpdSgdK+ttNNd8vN0RxuBD/2YAMp45Txm0lGFKpqF/ymsUi6xiTZVtuBO9Zvfw
	zDdRWyJjNs6IlUltfDm9kQSwmxsD8e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741956165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9LV6mPzGNpO3OLPnndLeEqRVGIYvZNpqHc6M3C7nxc=;
	b=OMtas1SZbBzp7vcLh/LCEsedYwaIM8fhLvbttCUA1hmfniaN8HzrlxFJwBrXfERqWDm9zY
	d+8ZuMTcrlmadqBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g74QYJBO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OMtas1SZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741956165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9LV6mPzGNpO3OLPnndLeEqRVGIYvZNpqHc6M3C7nxc=;
	b=g74QYJBOtAmqlQ+YVsIBPcp1RXtDX0GtE34AqAi9mY7IbWxW2nuVkUW/Pngr2fRa7LFtm6
	bq8rCVFtwpdSgdK+ttNNd8vN0RxuBD/2YAMp45Txm0lGFKpqF/ymsUi6xiTZVtuBO9Zvfw
	zDdRWyJjNs6IlUltfDm9kQSwmxsD8e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741956165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=t9LV6mPzGNpO3OLPnndLeEqRVGIYvZNpqHc6M3C7nxc=;
	b=OMtas1SZbBzp7vcLh/LCEsedYwaIM8fhLvbttCUA1hmfniaN8HzrlxFJwBrXfERqWDm9zY
	d+8ZuMTcrlmadqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1091132DD;
	Fri, 14 Mar 2025 12:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /KWkMUQk1Gd0EwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 14 Mar 2025 12:42:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] ima_violations.sh: Fix condition evaluation
Date: Fri, 14 Mar 2025 13:42:42 +0100
Message-ID: <20250314124242.459072-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F18EA1F38E
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
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Evaluation "-gt 0" needs to be together with expectation of empty
$expected_violations. Therefore use [ ... -a ... ] comparator to avoid
-eq comparison against empty $expected_violations.

    # LTPROOT=/opt/ltp PATH="/opt/ltp/testcases/bin:$PATH" LTP_IMA_LOAD_POLICY=1 ima_keys.sh
    ima_keys 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc3-1.gb6b4102-default security=apparmor ignore_loglevel ima_policy=tcb

    # LTPROOT=/opt/ltp PATH="/opt/ltp/testcases/bin:$PATH" ima_violations.sh
    ...
    /opt/ltp/testcases/bin/ima_violations.sh: line 95: [: 0: unary operator expected
    ima_violations 1 TFAIL: open_writers violation not added
    ima_violations 2 TINFO: verify ToMToU violation
    /opt/ltp/testcases/bin/ima_violations.sh: line 95: [: 0: unary operator expected
    ima_violations 2 TFAIL: ToMToU violation not added
    ima_violations 3 TINFO: verify open_writers using mmapped files
    tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
    tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
    tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
    ima_mmap.c:38: TINFO: sleep 3s
    /opt/ltp/testcases/bin/ima_violations.sh: line 95: [: 0: unary operator expected
    ima_violations 3 TFAIL: open_writers violation not added

NOTE: This does not fix ima_violations.sh fails after caused by user
defined policy loaded by ima_keys.sh (via LTP_IMA_LOAD_POLICY=1).

Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multiple violations")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh      | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 63346e9489..c6b929a233 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -90,8 +90,7 @@ validate()
 	for i in $(seq 1 $max_attempt); do
 		read num_violations_new < $IMA_VIOLATIONS
 		count2="$(get_count $search)"
-		if [ -z "$expected_violations" ] && \
-		   [ $(($num_violations_new - $num_violations)) -gt 0 ] || \
+		if [ -z "$expected_violations" -a $(($num_violations_new - $num_violations)) -gt 0 ] || \
 		   [ $(($num_violations_new - $num_violations)) -eq $expected_violations ]; then
 			[ -z "$expected_violations" ] && expected_violations=1
 			if [ $count2 -gt $count ]; then
-- 
2.47.2


