Return-Path: <linux-integrity+bounces-4841-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05241A38428
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B2C188DE25
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB1C21CC7B;
	Mon, 17 Feb 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qaoVWmK6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5v58MuGD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qaoVWmK6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5v58MuGD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77B21CC7C
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797735; cv=none; b=as0FkV+C3xPH7MlhM+/InA0gCwd2tLJ8YIm8RuWLCGhbotycVJtJtGC0ZeyyhiTccddK5gH47ou5niCbkx5nPB1n0jGaeLMCpKq2tQU1aiNlRxYOHIxoJxnSTFNLJK5oJclqcW5UknTvLF76ABLCe3LpHU3a39O5egy4b5XOt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797735; c=relaxed/simple;
	bh=b9ihhgbHiGDew2oyNLxSFRNcG3EK7b+0Oqs9apX3c5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz/f4x+9NuDVX7wA6uT4TjlFS4s9t9dCtIopMPhIDWNPKV1n1N1/0gQkfksN2E74FIqnjnDI/STw3qNfREP19+VHL5XFUgz3zgap4UpEubkb/G3nzldqsZgCDFrAAwbZmHQYqKmtoqcCKy6/jDoN9oenaFNVqy5SGnnRHXYWb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qaoVWmK6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5v58MuGD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qaoVWmK6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5v58MuGD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B77981F396;
	Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
	b=qaoVWmK6zCW742FpD3fnQrSSZZH19Mni6CVAUBZ5txWrlgq0/Sv2Cd53EaiotWqeq/A9U3
	pN7ASEWAneUqG0AiOUuXbgE08s8lIqYfznhAN2lY+rleX/Zo/hF0rOsyow9uAvCnrpBYv+
	k0pJj9KKz47dx0/t1PYckzi5AioJmdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739797730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
	b=5v58MuGDTP4x24Hdp5PPcN2bfOs8Jm0tID2x+e0GvMXFJVWoz6Jff8oGz0ymqRIAPmH/Nl
	1CMo9IfXF6KfPyCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
	b=qaoVWmK6zCW742FpD3fnQrSSZZH19Mni6CVAUBZ5txWrlgq0/Sv2Cd53EaiotWqeq/A9U3
	pN7ASEWAneUqG0AiOUuXbgE08s8lIqYfznhAN2lY+rleX/Zo/hF0rOsyow9uAvCnrpBYv+
	k0pJj9KKz47dx0/t1PYckzi5AioJmdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739797730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+vk1zGqFcAxauQY/eFo8O/efhYFBkrHgWq57pwTyHU=;
	b=5v58MuGDTP4x24Hdp5PPcN2bfOs8Jm0tID2x+e0GvMXFJVWoz6Jff8oGz0ymqRIAPmH/Nl
	1CMo9IfXF6KfPyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80AC413AC1;
	Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHU3HuI0s2fvBwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 13:08:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading policy
Date: Mon, 17 Feb 2025 14:08:39 +0100
Message-ID: <20250217130839.2392666-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217130839.2392666-1-pvorel@suse.cz>
References: <20250217130839.2392666-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Adding TST_SETUP_EARLY to run test specific setup before loading policy.
That allows to avoid loading IMA policy (which usually request reboot)
if the test would be skipped anyway.

Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 97c5d64ec5..577f7c2aca 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -13,9 +13,10 @@
 
 TST_NEEDS_CMDS="awk cut grep tail"
 TST_CNT=2
-TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
+TST_SETUP_EARLY="setup"
+
 REQUIRED_POLICY_CONTENT='selinux.policy'
 
 setup()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1f1c267c4b..2a9f64978e 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -265,6 +265,8 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
+	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
+
 	if ! verify_ima_policy; then
 		load_ima_policy
 	fi
-- 
2.47.2


