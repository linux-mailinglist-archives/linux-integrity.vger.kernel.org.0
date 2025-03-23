Return-Path: <linux-integrity+bounces-5396-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA0A6CFB5
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1603B189A80D
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B778139D0A;
	Sun, 23 Mar 2025 14:10:44 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CB136658
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739044; cv=none; b=ELhjF4Sp9gg3nbRuo8TsPhgXYD3LXK4V3d17KDc/X42iXUx5V7ZyCRJA6ZJ/rpuXiQNRQwyJ9tnMbNXjjz0zBieUovqWu5QapLufkPAHDZB5Z6Z857EI865JbTzusHhR2Pb/08hwRdLn+Z58KfTLTECtokmVqaAjhu26BujNUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739044; c=relaxed/simple;
	bh=Bnh0y4ehBp3MIlxHWbGU4cCavGIhNCtorFgrkVQGg+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npidDvEJns9SUcaDrEen1Q4/koFMq8PkOXi3JALqygGozLanmmsj9/21kFN9JeWps02b3UXDUZMTiNrQI9eZPSkJJBn3WIn+FVi5pkbUgIkha/kq+8fPWEmDKAquzrpMNfqxwLkVzjC/SqawO4v02n/Bdjg1HeAPR5+GA3hvHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FCB8211B8;
	Sun, 23 Mar 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 048261339F;
	Sun, 23 Mar 2025 14:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SeOOO1sW4GfKPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:35 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v2 12/13] ima: make ima_free_tfm()'s linkage extern
Date: Sun, 23 Mar 2025 15:09:10 +0100
Message-ID: <20250323140911.226137-13-nstange@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250323140911.226137-1-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 1FCB8211B8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Upon recognizing previously unmaintained PCR banks at __init after kexec,
a subsequent commit will make IMA to disable the corresponding hashes
for the current boot as well.

For this, access to ima_free_tfm() from outside its compilation unit is
needed. Make its linkage extern.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima.h        | 1 +
 security/integrity/ima/ima_crypto.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 67b78f5512f1..9bfe045ac9d5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -274,6 +274,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		       struct ima_iint_cache *iint, const char *op,
 		       const char *cause);
 int ima_init_crypto(void);
+void ima_free_tfm(struct crypto_shash *tfm);
 unsigned long ima_pcr_invalidated_banks(u32 pcr);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index c1d9cd85a66d..716bb302e75d 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -213,7 +213,7 @@ int __init ima_init_crypto(void)
 	return rc;
 }
 
-static void ima_free_tfm(struct crypto_shash *tfm)
+void ima_free_tfm(struct crypto_shash *tfm)
 {
 	int i;
 
-- 
2.49.0


