Return-Path: <linux-integrity+bounces-8192-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A52CFEBA5
	for <lists+linux-integrity@lfdr.de>; Wed, 07 Jan 2026 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D5683001189
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jan 2026 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7C638806A;
	Wed,  7 Jan 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUctFvKX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJTnjI7P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JUctFvKX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJTnjI7P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215038807A
	for <linux-integrity@vger.kernel.org>; Wed,  7 Jan 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801466; cv=none; b=UgBZYxaXhPD5+gjcnTQzwZWqL8wlnhx5ZwEKxoDeHLJgjMS1T1uvl8bagJ+eko6/uix2U/kQcjCtvvNTq/YcpV0CROWsmp0uk2+p1regdWPuwzDHGcOjncRFAqfxQCWxSoeVRXTktMt/GZMFeBUxhIp8lxvI/Qk29EfJzV+rOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801466; c=relaxed/simple;
	bh=kFpGiTpESuFEA2zUYyAN1AgJE/6PJlhdY1pbnZDT1TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9TiCuuDem4zsrUyAXILqyW+nm84BCvPcq+9Wu/fO0Jn0kbd9ttnZMXQfXoyZGVP8wpdIqGs5DMr6uMhQua6R0tgJb/dke3RlL1VIFsbBcDCKcV4jvlAAaW6gntwzOgCdOos3tAq9XpjnvWT7uX98tPB09HT9ujr6pCZicyjIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUctFvKX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wJTnjI7P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JUctFvKX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wJTnjI7P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B81A833BE7;
	Wed,  7 Jan 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
	b=JUctFvKXZoIpT9VvUQkussD1OkVNW3IIHw7fVvBiGcYdOT5d12iF+b2uzHziZCpqSkCAVn
	ewlpTIAFHdlGxtGbbJ8MRSGP+s59ZWBizE7R1F2uyaei/7mDzvLiXZ0Hp2OSiOivLoIEB0
	tRoSEcwGjDPP4wW04BN2BiCNgZNIwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767801460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
	b=wJTnjI7PoZCW6Hn2A+22X8LcOFwTNxxIlY5WoBc3mWCqgQ4jW42HlyvGK1DpFvkhkCFSkw
	K+Uj4eF1d7amEFDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JUctFvKX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wJTnjI7P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
	b=JUctFvKXZoIpT9VvUQkussD1OkVNW3IIHw7fVvBiGcYdOT5d12iF+b2uzHziZCpqSkCAVn
	ewlpTIAFHdlGxtGbbJ8MRSGP+s59ZWBizE7R1F2uyaei/7mDzvLiXZ0Hp2OSiOivLoIEB0
	tRoSEcwGjDPP4wW04BN2BiCNgZNIwIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767801460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h753lh0IfA1INWdbSt/afBGkR8ljC2rlzZ2c1c5/New=;
	b=wJTnjI7PoZCW6Hn2A+22X8LcOFwTNxxIlY5WoBc3mWCqgQ4jW42HlyvGK1DpFvkhkCFSkw
	K+Uj4eF1d7amEFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E8EC3EA65;
	Wed,  7 Jan 2026 15:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDl+G3SCXmm9HQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 15:57:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima_kexec.sh: Document kernel config dependencies
Date: Wed,  7 Jan 2026 16:57:36 +0100
Message-ID: <20260107155737.791588-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107155737.791588-1-pvorel@suse.cz>
References: <20260107155737.791588-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: B81A833BE7
X-Spam-Flag: NO
X-Spam-Score: -3.01

CONFIG_HAVE_IMA_KEXEC=y is enough for test, ie. test is working with:

    # CONFIG_IMA_KEXEC is not set
    CONFIG_HAVE_IMA_KEXEC=y

Probably obvious as CONFIG_HAVE_IMA_KEXEC is arch specific and
CONFIG_IMA_KEXEC is "TPM PCRs are only reset on a hard reboot."
and ima_kexec.c requires CONFIG_HAVE_IMA_KEXEC (only parts are skipped
when CONFIG_IMA_KEXEC not set) but better to clarify for users.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 7688690af2..de595fcdd7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -6,8 +6,11 @@
 #
 # Verify that kexec cmdline is measured correctly.
 # Test attempts to kexec the existing running kernel image.
+#
 # To kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
 # Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
+#
+# Test requires CONFIG_HAVE_IMA_KEXEC=y (CONFIG_IMA_KEXEC is not mandatory).
 
 TST_NEEDS_CMDS="grep kexec sed"
 TST_CNT=3
-- 
2.51.0


