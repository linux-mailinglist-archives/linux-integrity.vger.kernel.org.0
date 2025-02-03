Return-Path: <linux-integrity+bounces-4701-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2613A26538
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 22:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A553A37EB
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82797082B;
	Mon,  3 Feb 2025 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KwBOLN4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JjF1T9uW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KwBOLN4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JjF1T9uW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27814414
	for <linux-integrity@vger.kernel.org>; Mon,  3 Feb 2025 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616561; cv=none; b=eWZHpMo9+oQda2A6I3BsEaW1cRsWyG8G8cf2+hfvRW4bfx4U2pV0dJJPo4bROxs+Ui94h0cS8ZkZP9233WgWM6xuCoiA+xvcbm5DfztdRUe4wI1s++Ax8C06ddTf4hxotZz32fkkzNs++s39l8rL31K81RtjE468eo2HTO+oKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616561; c=relaxed/simple;
	bh=/jtCJvRyjVBsoyMP7FOvL0VKk0W2vl+csKq5sWXsWmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KeE6uoUE2KiYCyjdb0aKU/r+azDA4OQ+oQhAnghDGz8/zFGkVI6XDuoXFSfxv+I3Z2HOVDwLgBaoqsfxje5UqcdgWkEociv70Z8q5opF0Cit8zLAtgLC9dRi5nAbAGRARa47g7XYb7MHxzmN5hK0qD/b+3r2aJfL3GcXToDoQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KwBOLN4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JjF1T9uW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KwBOLN4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JjF1T9uW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7F3E1F381;
	Mon,  3 Feb 2025 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738616557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
	b=KwBOLN4zPfkBTD8wnGTE+DNlEI8LzHYPsvUnVLW0PBeUT8gPWJEUAla84gkmvZgVyfVIO+
	nLMTvNzNnxl2g0TaBcj7k4WXucl4+o+pVcS7Ar5hUEWN1phWhJvyFxZkN8IXbJuPOL731y
	TzkJTbl6qZWmOFcOKty6Dla9S033A/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738616557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
	b=JjF1T9uW14iLbkYTaPlUonguQ0RKXOaw/4p070szSyU7/q/YYT+Wcukr+piwzFSYXOFi4c
	ZFwh1tQH8gYv1HAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KwBOLN4z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JjF1T9uW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738616557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
	b=KwBOLN4zPfkBTD8wnGTE+DNlEI8LzHYPsvUnVLW0PBeUT8gPWJEUAla84gkmvZgVyfVIO+
	nLMTvNzNnxl2g0TaBcj7k4WXucl4+o+pVcS7Ar5hUEWN1phWhJvyFxZkN8IXbJuPOL731y
	TzkJTbl6qZWmOFcOKty6Dla9S033A/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738616557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gLxzwgBHzYgiD3SLge84bxTTGCKKHZsRNmfmfnMgEd8=;
	b=JjF1T9uW14iLbkYTaPlUonguQ0RKXOaw/4p070szSyU7/q/YYT+Wcukr+piwzFSYXOFi4c
	ZFwh1tQH8gYv1HAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4173913A78;
	Mon,  3 Feb 2025 21:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VA4HC+0uoWfXMwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 03 Feb 2025 21:02:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] IMA: measure.policy: limit dont_measure tmpfs policy to func=FILE_CHECK
Date: Mon,  3 Feb 2025 22:02:33 +0100
Message-ID: <20250203210233.1407530-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7F3E1F381
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

add func=FILE_CHECK to dont_measure tmpfs

Similarly to tcb.policy limit dont_measure tmpfs policy to func=FILE_CHECK.
This allows to do extra measurements, e.g. kexec boot command line, see
kernel commit

7eef7c8bac9a ("ima: limit the builtin 'tcb' dont_measure tmpfs policy rule")

Also remove leading 0 from tmpfs magic (to match IMA docs and tcb.policy).

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/datafiles/ima_policy/measure.policy  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
index 9976ddf2de..8abd05fb1a 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
@@ -8,7 +8,7 @@ dont_measure fsmagic=0x62656572
 # DEBUGFS_MAGIC
 dont_measure fsmagic=0x64626720
 # TMPFS_MAGIC
-dont_measure fsmagic=0x01021994
+dont_measure fsmagic=0x1021994 func=FILE_CHECK
 # SECURITYFS_MAGIC
 dont_measure fsmagic=0x73636673
 measure func=FILE_MMAP mask=MAY_EXEC
-- 
2.47.2


