Return-Path: <linux-integrity+bounces-5387-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C9A6CF92
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 15:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D7416B4D3
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Mar 2025 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AD2134AB;
	Sun, 23 Mar 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGDiMxfG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zRiN7euq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGDiMxfG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zRiN7euq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466921BC3C
	for <linux-integrity@vger.kernel.org>; Sun, 23 Mar 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742739013; cv=none; b=Iqd/WCj6g8L7Cn2DQQyZ9ZSVcF4iD6VXMSnM5Mz8fq/1gkx3qhemKShAYRsqEfTSY48IiTe0YgpOylRhXoLyNmsCkqIymzMnDWq2PWGw3U8lKXX4v/AJz75ZBNxYCyZLGC79PUs3hRBgzXb8xT0jZ6uoToMLirpMnuZ0gJWwTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742739013; c=relaxed/simple;
	bh=E5xHeWqwEMBWbhWZ6KioF73ArpDp2/VqSRyTVBw53Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaYtECONKXGXC7d+rh8h88pn/UrP8nw+f3l8AMIDh5k9O6Q1JZv4efli5dsDkpJuweE013Y2Gap8YUgaDqAs2/rBNpP1/4YHA6T36Of5nDHRlifVb/NgJxpKmxHgsz7/gZ7XBOO6aviwFtE6mIZEKgnoDvcBT0GhwJs+60844e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGDiMxfG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zRiN7euq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGDiMxfG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zRiN7euq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85741211AA;
	Sun, 23 Mar 2025 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNQMJd6JsgYTvQGaU1pBMeiOJcpneqS16mWiPW6rVgE=;
	b=jGDiMxfGQKUvTIA53UPRdNpQzHhW9nVEaWWRUMHc1VNmBdhZqZSwD/lBFnmHhKRD2Gnc/h
	snBZdFtY7QGx3dQSB42H8ya1J3l4Q1dnon3ABEG5cvCroktLNS+MNQKJ4WqPxUCJ+ljD4x
	Eh6fV6nZYX1PvKt1HqamTroMESeupck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNQMJd6JsgYTvQGaU1pBMeiOJcpneqS16mWiPW6rVgE=;
	b=zRiN7euq4QOwNdUB/+VK52HcxGVbdofHxABT5LYX+o9389/3DVQecExFd6raYqQ2/mXeIu
	TOFT7XpPI3GWEuDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742739007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNQMJd6JsgYTvQGaU1pBMeiOJcpneqS16mWiPW6rVgE=;
	b=jGDiMxfGQKUvTIA53UPRdNpQzHhW9nVEaWWRUMHc1VNmBdhZqZSwD/lBFnmHhKRD2Gnc/h
	snBZdFtY7QGx3dQSB42H8ya1J3l4Q1dnon3ABEG5cvCroktLNS+MNQKJ4WqPxUCJ+ljD4x
	Eh6fV6nZYX1PvKt1HqamTroMESeupck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742739007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNQMJd6JsgYTvQGaU1pBMeiOJcpneqS16mWiPW6rVgE=;
	b=zRiN7euq4QOwNdUB/+VK52HcxGVbdofHxABT5LYX+o9389/3DVQecExFd6raYqQ2/mXeIu
	TOFT7XpPI3GWEuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7278B1339F;
	Sun, 23 Mar 2025 14:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v/HnGj8W4GebPAAAD6G6ig
	(envelope-from <nstange@suse.de>); Sun, 23 Mar 2025 14:10:07 +0000
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
Subject: [RFC PATCH v2 04/13] ima: make SHA1 non-mandatory
Date: Sun, 23 Mar 2025 15:09:02 +0100
Message-ID: <20250323140911.226137-5-nstange@suse.de>
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
X-Spam-Score: -5.30
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6owce66jwsk5yhus1j8gn7jo)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

For CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND=n, SHA-1 is not a hard
requirement anymore. Make ima_init_crypto() continue on SHA-1
instantiation errors.

Note that the configured ima_hash must still be available. If that
happened to be set to SHA-1 and SHA-1 was missing, then IMA would
still fail to initialize.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima_crypto.c | 59 +++++++++++++----------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index a43080fb8edc..4ac4138d98de 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -145,53 +145,47 @@ int __init ima_init_crypto(void)
 		goto out;
 	}
 
+	ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
+	ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
+
+	if (ima_hash_algo != HASH_ALGO_SHA1) {
+		ima_algo_array[ima_sha1_idx].tfm =
+			ima_alloc_tfm(HASH_ALGO_SHA1);
+		if (IS_ERR(ima_algo_array[ima_sha1_idx].tfm)) {
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
+			/*
+			 * For backwards compatible fallback PCR
+			 * extension, SHA1 is the fallback for missing
+			 * algos.
+			 */
+			rc = PTR_ERR(ima_algo_array[ima_sha1_idx].tfm);
+			goto out_array;
+#endif
+			ima_algo_array[ima_sha1_idx].tfm = NULL;
+		}
+		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
+	}
+
 	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
 		ima_algo_array[i].algo = algo;
 
+		/* Initialized separately above. */
+		if (i == ima_hash_algo_idx || i == ima_sha1_idx)
+			continue;
+
 		/* unknown TPM algorithm */
 		if (algo == HASH_ALGO__LAST)
 			continue;
 
-		if (algo == ima_hash_algo) {
-			ima_algo_array[i].tfm = ima_shash_tfm;
-			continue;
-		}
-
 		ima_algo_array[i].tfm = ima_alloc_tfm(algo);
 		if (IS_ERR(ima_algo_array[i].tfm)) {
-			if (algo == HASH_ALGO_SHA1) {
-				rc = PTR_ERR(ima_algo_array[i].tfm);
-				ima_algo_array[i].tfm = NULL;
-				goto out_array;
-			}
-
 			ima_algo_array[i].tfm = NULL;
 		}
 	}
 
-	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip)) {
-		if (ima_hash_algo == HASH_ALGO_SHA1) {
-			ima_algo_array[ima_sha1_idx].tfm = ima_shash_tfm;
-		} else {
-			ima_algo_array[ima_sha1_idx].tfm =
-						ima_alloc_tfm(HASH_ALGO_SHA1);
-			if (IS_ERR(ima_algo_array[ima_sha1_idx].tfm)) {
-				rc = PTR_ERR(ima_algo_array[ima_sha1_idx].tfm);
-				goto out_array;
-			}
-		}
-
-		ima_algo_array[ima_sha1_idx].algo = HASH_ALGO_SHA1;
-	}
-
-	if (ima_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
-	    ima_hash_algo_idx != ima_sha1_idx) {
-		ima_algo_array[ima_hash_algo_idx].tfm = ima_shash_tfm;
-		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
-	}
-
 	return 0;
+#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
 out_array:
 	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
 		if (!ima_algo_array[i].tfm ||
@@ -201,6 +195,7 @@ int __init ima_init_crypto(void)
 		crypto_free_shash(ima_algo_array[i].tfm);
 	}
 	kfree(ima_algo_array);
+#endif
 out:
 	crypto_free_shash(ima_shash_tfm);
 	return rc;
-- 
2.49.0


