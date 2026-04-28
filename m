Return-Path: <linux-integrity+bounces-9354-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMURCyLe8Gn3aQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9354-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 18:19:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB45488B66
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 18:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656293044F15
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2026 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB9A3F6615;
	Tue, 28 Apr 2026 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SLqZUTui";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4bxaCBe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SLqZUTui";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D4bxaCBe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2A3FA5C2
	for <linux-integrity@vger.kernel.org>; Tue, 28 Apr 2026 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392646; cv=none; b=WrHDvBLNH6i8p6UcFYzG4Q3tHFmNEXjQYJOzZV6oH8MSSdDOAVPfFVE99jHH0SNRjQzJWHrn5O4fA7dKYBBMxJSos5q7WEpGaRaMGvwTKSPtNjowVmiZ33ERpl94Jf12QwqZxHpzcSI/UzQ/oCM0y8lmurJkeAhZVLf7bdii5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392646; c=relaxed/simple;
	bh=rf3n7vt/VuF6mNghu6dJi8RNlKRuigtJTyqfm0xMC7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKikTYepAm2w+ONc9Z/uRM52Re846o0Ini1JIfpPR5uhPIXhQGWyzQ9+xlF0eHJO4VOiemFuBajK6IsFE6se403754Bg9c4CPRpyHyC2VISRM+9r48W8B8O4V5u7dpp8kYe0b9FF3uBeYKmvEX6mYvgp6FHFaaQHDO7Sz9QCs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SLqZUTui; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4bxaCBe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SLqZUTui; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D4bxaCBe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 727F86A833;
	Tue, 28 Apr 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777392643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
	b=SLqZUTuiRnkvt1+LYmjen9bfwFzz1c9DH1XkZRTn9F+5jufVi2StfiYOlkzp+jQtCj6ksu
	A9N6r4n9ANCj1mlGCaLTKGZgt0LHGVj0O7Q5XRrVH4rCmHISR0EpbqSpXR+XH6oXiE9ii8
	+/GvWKElwlzDjl5Az9ABKD3i15JXeDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777392643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
	b=D4bxaCBetY0m1Nl7eCJYcCsIlxeIQ6LiVMNNXCbCl/EL4L11V8staXnd6AgXxN3fy5Mri9
	qgxIkaCWUfVY+QDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SLqZUTui;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D4bxaCBe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777392643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
	b=SLqZUTuiRnkvt1+LYmjen9bfwFzz1c9DH1XkZRTn9F+5jufVi2StfiYOlkzp+jQtCj6ksu
	A9N6r4n9ANCj1mlGCaLTKGZgt0LHGVj0O7Q5XRrVH4rCmHISR0EpbqSpXR+XH6oXiE9ii8
	+/GvWKElwlzDjl5Az9ABKD3i15JXeDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777392643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1xV7DDZIuIIxYt9BG5ciACxK28I59uva7lZ9KtUJeIE=;
	b=D4bxaCBetY0m1Nl7eCJYcCsIlxeIQ6LiVMNNXCbCl/EL4L11V8staXnd6AgXxN3fy5Mri9
	qgxIkaCWUfVY+QDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0159E593B0;
	Tue, 28 Apr 2026 16:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NoI0OQLc8Gm6EgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 28 Apr 2026 16:10:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>,
	Avinesh Kumar <avinesh.kumar@suse.com>,
	Wei Gao <wegao@suse.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH 1/2] ima_violations.sh: Wait for ima_mmap to exit
Date: Tue, 28 Apr 2026 18:10:33 +0200
Message-ID: <20260428161034.947614-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 7BB45488B66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9354-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]

This fixes a race when even 2 sec sleep is not enough (f26399583e was
a wrong approach).

While at it, check for ima_mmap exit code (missing since ever).

Fixes: f26399583e ("ima/{ima_measurements,ima_violations}.sh: Avoid running on tmpfs")
Fixes: 3a8efbcc46 ("This patch adds Integrity Measurement Architecture(IMA) testing support ...")
Reported-by: Martin Doucha <mdoucha@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_violations.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 13cc9d804d..0c03c30786 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -157,6 +157,8 @@ test2()
 
 test3()
 {
+	local pid
+
 	tst_res TINFO "verify open_writers using mmapped files"
 
 	local search="open_writers"
@@ -168,6 +170,7 @@ test3()
 	echo 'testing testing' > $FILE
 
 	ima_mmap -f $FILE &
+	pid=$!
 	# wait for violations appear in logs
 	tst_sleep 1s
 
@@ -177,7 +180,10 @@ test3()
 	validate $num_violations $count $search
 
 	# wait for ima_mmap to exit, so we can umount
-	tst_sleep 2s
+	wait $pid
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "failed to execute ima_mmap"
+	fi
 }
 
 test4()
-- 
2.54.0


