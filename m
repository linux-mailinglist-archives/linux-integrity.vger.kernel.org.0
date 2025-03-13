Return-Path: <linux-integrity+bounces-5279-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38202A5FDF8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF3919C55AF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174FB1D63F8;
	Thu, 13 Mar 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y1NGj7YI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0CctoGQm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y1NGj7YI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0CctoGQm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2341EE7BD
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887337; cv=none; b=HJZLY5YU4KrEVGIE/GpbnlMsGaQ26DXbav6N8y0d3DZdWYExL8L4wPzbalXX/kcu422BvkOrXHr2VdPvcyoKpQECeMGCgv+tUY6rtkFLCIeVYAJ3HBskNIE+LFxaRp2RqcUW2zFoe1WnelsEAWjERT9aSxErftGY4UuCJXZIgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887337; c=relaxed/simple;
	bh=vQdoq9CEvtCoxe0/XgIj7OuZW3qXJ4NL8kAMzq1rRbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui9ZhmuiA4owNlrHcL31gRUyRXcPXQCrbieFrM0cdAKevj4qTxSwvAy48RKzkI6cHGeUPxGAGVw4q5hc2GZSHerWgA59naCZlU9WyU8RUSlDCR97upp6YX9CxjO6lJTWy+vLHwXzFYjgXUwlUHTAAOAOvQQg4JdhAgcJBIf5o2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y1NGj7YI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0CctoGQm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y1NGj7YI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0CctoGQm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 712A01F76B;
	Thu, 13 Mar 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AssL4APWosYRwux5Sl/5PXBGFriuHOGNHF7c4W1mHz4=;
	b=y1NGj7YI236QfMjWfjyv7LrwSGiLStdfqnuRlM/CfAdhXKWKN4iTh2TRCrHzstePyZi12z
	+jPHKtd85Q3xbppcEPJoFHJ0lt4wfypY2T3zUTirUov+7hJc6c1pcTe1z9M99oouxg3cE+
	33y7xP7FMuqZBEhC8J2ZIqGLP+JiiAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AssL4APWosYRwux5Sl/5PXBGFriuHOGNHF7c4W1mHz4=;
	b=0CctoGQmht81QUlHsTv3wXnswkFWaKpZaDxclDD902ge4IuSoD8+Egh84CnLffg3g3M+9p
	gGX9yD+fq9CwKVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741887332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AssL4APWosYRwux5Sl/5PXBGFriuHOGNHF7c4W1mHz4=;
	b=y1NGj7YI236QfMjWfjyv7LrwSGiLStdfqnuRlM/CfAdhXKWKN4iTh2TRCrHzstePyZi12z
	+jPHKtd85Q3xbppcEPJoFHJ0lt4wfypY2T3zUTirUov+7hJc6c1pcTe1z9M99oouxg3cE+
	33y7xP7FMuqZBEhC8J2ZIqGLP+JiiAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741887332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AssL4APWosYRwux5Sl/5PXBGFriuHOGNHF7c4W1mHz4=;
	b=0CctoGQmht81QUlHsTv3wXnswkFWaKpZaDxclDD902ge4IuSoD8+Egh84CnLffg3g3M+9p
	gGX9yD+fq9CwKVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6105E137BA;
	Thu, 13 Mar 2025 17:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uzqGFmQX02cwQwAAD6G6ig
	(envelope-from <nstange@suse.de>); Thu, 13 Mar 2025 17:35:32 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nstange@suse.de>
Subject: [RFC PATCH v1 7/7] ima: make SHA1 non-mandatory
Date: Thu, 13 Mar 2025 18:33:39 +0100
Message-ID: <20250313173339.3815589-8-nstange@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313173339.3815589-1-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.30
X-Spam-Flag: NO

For CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND=n, SHA-1 is not a hard
requirement anymore. Make ima_init_crypto() continue on SHA-1
instantiation errors.

Note that the configure ima_hash must still be available. If that
happened to be set to SHA-1 and SHA-1 was missing, then IMA would
still fail to initialize.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 security/integrity/ima/ima_crypto.c | 60 ++++++++++++++---------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 118ea15d737b..f68435f2679f 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -147,56 +147,51 @@ int __init ima_init_crypto(void)
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
+			ima_unsupported_tpm_banks_mask |= BIT(ima_sha1_idx);
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
 		if (algo == HASH_ALGO__LAST) {
 			ima_unsupported_tpm_banks_mask |= BIT(i);
 			continue;
 		}
 
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
 			ima_unsupported_tpm_banks_mask |= BIT(i);
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
@@ -206,6 +201,7 @@ int __init ima_init_crypto(void)
 		crypto_free_shash(ima_algo_array[i].tfm);
 	}
 	kfree(ima_algo_array);
+#endif
 out:
 	crypto_free_shash(ima_shash_tfm);
 	return rc;
-- 
2.47.1


