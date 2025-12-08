Return-Path: <linux-integrity+bounces-7853-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04109CAD725
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31356306B15C
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD203246EA;
	Mon,  8 Dec 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i5Q2bgKp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvbiiu4+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L2MGOa9P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6D27nCMG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBD322B92
	for <linux-integrity@vger.kernel.org>; Mon,  8 Dec 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203211; cv=none; b=pMDHcr5+Y3hSoiq5GGcl+k1/Difnty+MQxWHla9fMr69JF7JiesoAvvl7oadRwbjIa7RLzoKnxZIC872a0Itf5VY5IdUjG3LceShmsY9JdjYY7UFlVHPDAEStOiTp5zpOpaJEHkOtzqFvJB9ACq5kCvgvny87uSGMA80dG7dNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203211; c=relaxed/simple;
	bh=CkiLp8uORVTDTgSxdg0yAB9K2YCm0fxoJkT1pSblz54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/cnzdM1vNdLf3kAc0/bhBLbcOPYrbX0bQ8YyhwxHPQBOSIwUzvbVa5DfReAXV7QVn+8rFXFtaAHhehxyzcYJWkwU6VkMScHIfBv7uGt4sNeD+PytlDciGn+DFPy3KcQkgKgqBLZQg7H8Aajzvyhw7OuUXitRMERmA/v/lvIYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i5Q2bgKp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvbiiu4+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L2MGOa9P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6D27nCMG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E1F53391B;
	Mon,  8 Dec 2025 14:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765203205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
	b=i5Q2bgKpMu8ShKvEGoMUTPNvQ7dSxXz7bC7QZ6ZiyeC/TknrmW/WF3wSYijl7F+F67ErbH
	Bz9yEhn/sybOyvUQz0N0rEuu0JC4BB93c7UinBr6HX38JCVsn+tGlEG9ZbETGoKHLLjHrv
	Vx6EnSoL4LXVE5ud8sbH+wZUXnTZ3po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765203205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
	b=fvbiiu4+LeZvl/j224LVBDfvhPEwEutkN61uaphSe90VTTu1NWPYq3p1j9mrKn8m8qm2tH
	n6Inb1Gk90PbXIDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L2MGOa9P;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6D27nCMG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765203204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
	b=L2MGOa9PINGGsNw4W6vvVw89/A0dUejiyFUMDGGgRkWGbxCXlyNIRzOGfsgtCjZ0k3OdSg
	u470Lwkb2RWb/2ATzR7EhbVm1AJ7BP+bCajzPAYWACEMgGsuiXtcTHSRBujYYf2gp6DVeV
	IPeVZKT98rrk1uTy/6Ik/72he3qp3vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765203204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tjJaNWg3FwT2wxAWdSiZjUiaEGDtCtx66txb8BKbNIM=;
	b=6D27nCMG+phdksc5THYFexNtPCHNxm0RUCkkLBH0GkvI/CwES9xjw7XS05lqGyvHN22dLh
	Ha4mlsv+5OsrwhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AD063EA63;
	Mon,  8 Dec 2025 14:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5rkOGQTdNml8KAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 14:13:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] ima_selinux: Fix requirements
Date: Mon,  8 Dec 2025 15:13:21 +0100
Message-ID: <20251208141321.696537-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
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
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ima_selinux.sh:url,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 9E1F53391B
X-Spam-Flag: NO
X-Spam-Score: -3.01

"measure func=CRITICAL_DATA label=selinux" in selinux.policy LTP example
policy is a subset of "measure func=CRITICAL_DATA" loaded by
ima_policy=critical_data kernel command line option.

Therefore ima_selinux.sh require only one of them, not both.

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Thanks Mimi!

Kind regards,
Petr

 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 1a0de21efd..e64a7739f9 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -18,13 +18,12 @@ TST_SETUP="setup"
 TST_MIN_KVER="5.12"
 
 REQUIRED_POLICY_CONTENT='selinux.policy'
+REQUIRED_BUILTIN_POLICY='critical_data'
 
 setup()
 {
 	SELINUX_DIR=$(tst_get_selinux_dir)
 	[ "$SELINUX_DIR" ] || tst_brk TCONF "SELinux is not enabled"
-
-	require_ima_policy_cmdline "critical_data"
 }
 
 # Format of the measured SELinux state data.
-- 
2.51.0


