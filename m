Return-Path: <linux-integrity+bounces-4840-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD5A38444
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9472D3B7EB8
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F021CC7D;
	Mon, 17 Feb 2025 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtPbUbq5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OHod0wQs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rtPbUbq5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OHod0wQs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1721CC7B
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797734; cv=none; b=XRUnmLGmAnp/7W++uB8VrwI2e2/SwBGrKHVPsChVZc0pCVjwr2gRlhBuXnM3vBPyO1vk1EC6lb/5F1zIdbl5a0Si1HoTqlBZ/O0v/DKTsnGMvw/NZajIp1Rna0uTk94ujW33CkpaNmzvWeywIKMvZ3mclBEXBfVcNSgjcmZWxqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797734; c=relaxed/simple;
	bh=ktIySu5RxbkcCZmBkJprQ/gJWehm+plt39yJ+JulSyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbyQVfo+WCZtV/zBbv6mJ3HZb7KZMBBhhMg0hsigLTsR2DgWVi/RKYOO/jfFGQAZoKFL2rGeXaQP+ybA4VILsjnPUNCtH2sWtGuugAV6fIQmr6SBxwYoWzfbm8YB96MWxJHVAseYRQGDWUiL+M0NY9t/WxIwgXUYLUzGwYLYHqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtPbUbq5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OHod0wQs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rtPbUbq5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OHod0wQs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C36321114;
	Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
	b=rtPbUbq5KWRpJlmRg2cV8myqojYTzVBJgMfftOZehjaL3VgOiXgzWMeonqik7ugM/QC5GB
	GFLxru3dg+J2aymnVNrR2AwkfoN8E/0A4WaSKlU3K0DbZ1xZaElFGTtHyo/xKJZXgvzgSm
	qpzoUyYFdzFqNi4uBctSMTqAPAI508A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739797730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
	b=OHod0wQs42y+kw7Opruz9Q/r4RoV5rKHYgGh9IUAwdm1uqU6QjMy3z080A7pZ5CzWqsQBo
	wMfkuhLHlgYTY9BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
	b=rtPbUbq5KWRpJlmRg2cV8myqojYTzVBJgMfftOZehjaL3VgOiXgzWMeonqik7ugM/QC5GB
	GFLxru3dg+J2aymnVNrR2AwkfoN8E/0A4WaSKlU3K0DbZ1xZaElFGTtHyo/xKJZXgvzgSm
	qpzoUyYFdzFqNi4uBctSMTqAPAI508A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739797730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
	b=OHod0wQs42y+kw7Opruz9Q/r4RoV5rKHYgGh9IUAwdm1uqU6QjMy3z080A7pZ5CzWqsQBo
	wMfkuhLHlgYTY9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58D441379D;
	Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZWaFOI0s2fvBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 13:08:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] tst_security.sh: Fix SELinux detection
Date: Mon, 17 Feb 2025 14:08:38 +0100
Message-ID: <20250217130839.2392666-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Some SLES15 versions create /selinux directory which fails the detection
if SELinux is actually not enabled. Therefore detect if directory
actually contains the 'enforce' file.

Also drop /selinux directory detection and detect only /sys/fs/selinux,
/sys/fs/selinux mount point was added in kernel 3.0 in commit
7a627e3b9a2b ("SELINUX: add /sys/fs/selinux mount point to put selinuxfs")
14 years is enough, kernel 3.0 is not even supported in current LTP and
we don't even support /selinux in C API (tst_security.c).

Fixes: e7b804df65 ("shell: Add tst_security.sh helper")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_security.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 05640234ea..356c28fc73 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -127,8 +127,7 @@ tst_get_selinux_dir()
 {
 	local dir="/sys/fs/selinux"
 
-	[ -d "$dir" ] || dir="/selinux"
-	[ -d "$dir" ] && echo "$dir"
+	[ -f "$dir/enforce" ] && echo "$dir"
 }
 
 # Get SELinux enforce file path
-- 
2.47.2


