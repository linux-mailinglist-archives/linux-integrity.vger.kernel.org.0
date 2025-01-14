Return-Path: <linux-integrity+bounces-4551-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3548A10564
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C877167A44
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA28284A7C;
	Tue, 14 Jan 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eQEtm93f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1MUiR3fa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eQEtm93f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1MUiR3fa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA52309AC
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854170; cv=none; b=PYu5K+xVNdULHySDU0i2gyANUMwoHdwaK48wR6khNR0YAXNrfwQ/nby2Gn2KXTmO25WaAjdqITCnipvHGyhEHGE2eBt8yTLfAeQil4ps40sJmw2OgGvX5pwKU2l0ABVz4NwLCBwsjyGmYGVUHcyjw4sFhWMnJ5ojtBbo2fo22eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854170; c=relaxed/simple;
	bh=n3Vk6Fmu+kXL5EqrrlCgq8n71wU1lWMcwS2MYdgcGYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwLbFmz7KH+q1ON1TxVrw+DZvHjiXw8LozquI3Wh1ezcOaDwgPvSc65n08g4d5mWGcXke/StphywtAgpgcl5xfNlAuKSI9iFzGfMgkc9/rGvktzXd36UY86BGFqnu0p6FpUyP3A3UygIGPsOmV+C1Sa4LRd6d4CC4kothZGsvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eQEtm93f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1MUiR3fa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eQEtm93f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1MUiR3fa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F40A721180;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//+rR0W3ziSksdffU+7ZMDZ1TdJIydRw9gp0mH52+Fc=;
	b=eQEtm93fSJLJj5Yh8gtAZBxg4kHDCnai1ogFmv2BdEe2OIkvWBKLh34dp9g6EgpBSKg9Fx
	x/g8L6T5tEXClAGNwp4zbpnjWq9bNqpBxl/WDvCESQ0Tc0j99W08Wc2ifROgdW6+HpaT1r
	8TpBbnmY1M/UOiU+olcV1ngCcytJPGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//+rR0W3ziSksdffU+7ZMDZ1TdJIydRw9gp0mH52+Fc=;
	b=1MUiR3faXvdGMWQnOHKi/g+IEX1moUnCPqXFrbJWrHkIdq+5QKTq4ByNif3fQo/LtycJ/W
	9jrxHaOFEIRlSDCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736854165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//+rR0W3ziSksdffU+7ZMDZ1TdJIydRw9gp0mH52+Fc=;
	b=eQEtm93fSJLJj5Yh8gtAZBxg4kHDCnai1ogFmv2BdEe2OIkvWBKLh34dp9g6EgpBSKg9Fx
	x/g8L6T5tEXClAGNwp4zbpnjWq9bNqpBxl/WDvCESQ0Tc0j99W08Wc2ifROgdW6+HpaT1r
	8TpBbnmY1M/UOiU+olcV1ngCcytJPGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736854165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//+rR0W3ziSksdffU+7ZMDZ1TdJIydRw9gp0mH52+Fc=;
	b=1MUiR3faXvdGMWQnOHKi/g+IEX1moUnCPqXFrbJWrHkIdq+5QKTq4ByNif3fQo/LtycJ/W
	9jrxHaOFEIRlSDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6252139CB;
	Tue, 14 Jan 2025 11:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gGnELpRKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 06/10] ima_violations.sh: Declare tcb builtin policy
Date: Tue, 14 Jan 2025 12:29:11 +0100
Message-ID: <20250114112915.610297-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

IMA builtin policy contains required rules, allow using it.
This helps more reliable results on kernels without
CONFIG_IMA_READ_POLICY=y.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 1852e8bc74..37d8d473c2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -10,6 +10,7 @@ TST_SETUP="setup"
 TST_CLEANUP="cleanup"
 TST_CNT=3
 
+REQUIRED_BUILTIN_POLICY="tcb"
 REQUIRED_POLICY_CONTENT='violations.policy'
 
 setup()
-- 
2.47.1


