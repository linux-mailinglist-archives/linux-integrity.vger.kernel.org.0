Return-Path: <linux-integrity+bounces-8562-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGS8FeWkn2lfdAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8562-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 02:41:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED75819FE35
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 02:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2421E3031359
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 01:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D737107C;
	Thu, 26 Feb 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H53BGrd2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40602371067;
	Thu, 26 Feb 2026 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070115; cv=none; b=Yq+mtQDQCRg2ZGsDA8dXoipbVWwx2cecNrk4ypwSkDgbwo11lSNAlId1SFs9Px/IZ7MehY7PsU9npPqT+N0stGOVDGefEDPFqo9iLQgiBrJPntCrFpn8WqiAQhS3V4Q4pwXc/RLWNCP8MCfnZHtCls1fe3ADjupXaaLo3WPeCqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070115; c=relaxed/simple;
	bh=CfAYEd9U4HSw1/bmYpiEHbdxZ+wvqDZ8aVBkXZx6dkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onfyZzTXcY6LFw07601VM4Keek1wEK2aUbYnfynIJodPmyA455dqtLrrRdfjSKGRZ3L2ymTEBvuK6eK0foSdw6JJ18nACbljnQgiFJ6U4ZPTO2TRtXH5Fbblc6BuITjxcaM7+nRLxSVgFfO+wpSxtkaCS7Ezm5KNTgJtesGzy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H53BGrd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE0AC116D0;
	Thu, 26 Feb 2026 01:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772070114;
	bh=CfAYEd9U4HSw1/bmYpiEHbdxZ+wvqDZ8aVBkXZx6dkU=;
	h=From:To:Cc:Subject:Date:From;
	b=H53BGrd2Jugain5WpBIrTcN5iYco/wtxdQ1czG6LZmIRgWcSRT+cMyVtPC2C0wLAi
	 ukX2fn+giEXD/GWD+eFKH2XMMtDJA9JXtQoQ0VQyLr7t2XF/khLqloaUOLYxwwbSI2
	 +bkRNGZKOEj2Nv9rPGQX0N8Qhb04x65bbgPOIFG+twUTqicJu7IaceGFFKfwJSpvNO
	 bOPHwHmB77NHBCzrW9wWzq9cNPogZgfL0xLMx31cpQeGrPqwnvGq4WYhBUFLkQ9gLw
	 Hg0tNGX3DXf3j4kRCpe7w4xFvZeV+GB11W6biY0D79iO0pkcPhjladpvXQuLn7ywo+
	 w4tBht8QGUEzA==
From: Eric Biggers <ebiggers@kernel.org>
To: dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>
Cc: linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] dm-ima: use SHA-256 library
Date: Wed, 25 Feb 2026 17:39:15 -0800
Message-ID: <20260226013915.54873-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8562-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED75819FE35
X-Rspamd-Action: no action

Make dm_ima_measure_on_table_load() use the SHA-256 library API instead
of crypto_shash to calculate the SHA-256 hash value that it needs.  This
is simpler and more efficient.  It also ensures that SHA-256 is actually
available and doesn't fail due to the unreliable loading by name.

While doing this, also use kasprintf() to simplify building the string
version of the digest.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/md/Kconfig  |  1 +
 drivers/md/dm-ima.c | 54 +++++++++------------------------------------
 drivers/md/dm-ima.h |  1 -
 3 files changed, 11 insertions(+), 45 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c58a9a8ea54e..53351048d3ec 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -224,10 +224,11 @@ config BLK_DEV_DM_BUILTIN
 config BLK_DEV_DM
 	tristate "Device mapper support"
 	select BLOCK_HOLDER_DEPRECATED if SYSFS
 	select BLK_DEV_DM_BUILTIN
 	select BLK_MQ_STACKING
+	select CRYPTO_LIB_SHA256 if IMA
 	depends on DAX || DAX=n
 	help
 	  Device-mapper is a low level volume manager.  It works by allowing
 	  people to specify mappings for ranges of logical sectors.  Various
 	  mapping types are available, in addition people may write their own
diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index efb3cd4f9cd4..9495ca035056 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -10,13 +10,11 @@
 #include "dm-core.h"
 #include "dm-ima.h"
 
 #include <linux/ima.h>
 #include <linux/sched/mm.h>
-#include <crypto/hash.h>
-#include <linux/crypto.h>
-#include <crypto/hash_info.h>
+#include <crypto/sha2.h>
 
 #define DM_MSG_PREFIX "ima"
 
 /*
  * Internal function to prefix separator characters in input buffer with escape
@@ -176,23 +174,17 @@ void dm_ima_reset_data(struct mapped_device *md)
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags)
 {
 	size_t device_data_buf_len, target_metadata_buf_len, target_data_buf_len, l = 0;
 	char *target_metadata_buf = NULL, *target_data_buf = NULL, *digest_buf = NULL;
 	char *ima_buf = NULL, *device_data_buf = NULL;
-	int digest_size, last_target_measured = -1, r;
+	int last_target_measured = -1;
 	status_type_t type = STATUSTYPE_IMA;
 	size_t cur_total_buf_len = 0;
 	unsigned int num_targets, i;
-	SHASH_DESC_ON_STACK(shash, NULL);
-	struct crypto_shash *tfm = NULL;
-	u8 *digest = NULL;
+	struct sha256_ctx hash_ctx;
+	u8 digest[SHA256_DIGEST_SIZE];
 	bool noio = false;
-	/*
-	 * In below hash_alg_prefix_len assignment +1 is for the additional char (':'),
-	 * when prefixing the hash value with the hash algorithm name. e.g. sha256:<hash_value>.
-	 */
-	const size_t hash_alg_prefix_len = strlen(DM_IMA_TABLE_HASH_ALG) + 1;
 	char table_load_event_name[] = "dm_table_load";
 
 	ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, noio);
 	if (!ima_buf)
 		return;
@@ -208,23 +200,11 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	num_targets = table->num_targets;
 
 	if (dm_ima_alloc_and_copy_device_data(table->md, &device_data_buf, num_targets, noio))
 		goto error;
 
-	tfm = crypto_alloc_shash(DM_IMA_TABLE_HASH_ALG, 0, 0);
-	if (IS_ERR(tfm))
-		goto error;
-
-	shash->tfm = tfm;
-	digest_size = crypto_shash_digestsize(tfm);
-	digest = dm_ima_alloc(digest_size, noio);
-	if (!digest)
-		goto error;
-
-	r = crypto_shash_init(shash);
-	if (r)
-		goto error;
+	sha256_init(&hash_ctx);
 
 	memcpy(ima_buf + l, DM_IMA_VERSION_STR, table->md->ima.dm_version_str_len);
 	l += table->md->ima.dm_version_str_len;
 
 	device_data_buf_len = strlen(device_data_buf);
@@ -268,13 +248,11 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 		 * we have in the current buffer, and continue measuring the remaining
 		 * targets by prefixing the device metadata again.
 		 */
 		if (unlikely(cur_total_buf_len >= DM_IMA_MEASUREMENT_BUF_LEN)) {
 			dm_ima_measure_data(table_load_event_name, ima_buf, l, noio);
-			r = crypto_shash_update(shash, (const u8 *)ima_buf, l);
-			if (r < 0)
-				goto error;
+			sha256_update(&hash_ctx, (const u8 *)ima_buf, l);
 
 			memset(ima_buf, 0, DM_IMA_MEASUREMENT_BUF_LEN);
 			l = 0;
 
 			/*
@@ -309,34 +287,25 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	}
 
 	if (!last_target_measured) {
 		dm_ima_measure_data(table_load_event_name, ima_buf, l, noio);
 
-		r = crypto_shash_update(shash, (const u8 *)ima_buf, l);
-		if (r < 0)
-			goto error;
+		sha256_update(&hash_ctx, (const u8 *)ima_buf, l);
 	}
 
 	/*
 	 * Finalize the table hash, and store it in table->md->ima.inactive_table.hash,
 	 * so that the table data can be verified against the future device state change
 	 * events, e.g. resume, rename, remove, table-clear etc.
 	 */
-	r = crypto_shash_final(shash, digest);
-	if (r < 0)
-		goto error;
-
-	digest_buf = dm_ima_alloc((digest_size*2) + hash_alg_prefix_len + 1, noio);
+	sha256_final(&hash_ctx, digest);
 
+	digest_buf = kasprintf(GFP_KERNEL, "sha256:%*phN", SHA256_DIGEST_SIZE,
+			       digest);
 	if (!digest_buf)
 		goto error;
 
-	snprintf(digest_buf, hash_alg_prefix_len + 1, "%s:", DM_IMA_TABLE_HASH_ALG);
-
-	for (i = 0; i < digest_size; i++)
-		snprintf((digest_buf + hash_alg_prefix_len + (i*2)), 3, "%02x", digest[i]);
-
 	if (table->md->ima.active_table.hash != table->md->ima.inactive_table.hash)
 		kfree(table->md->ima.inactive_table.hash);
 
 	table->md->ima.inactive_table.hash = digest_buf;
 	table->md->ima.inactive_table.hash_len = strlen(digest_buf);
@@ -352,13 +321,10 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	goto exit;
 error:
 	kfree(digest_buf);
 	kfree(device_data_buf);
 exit:
-	kfree(digest);
-	if (tfm)
-		crypto_free_shash(tfm);
 	kfree(ima_buf);
 	kfree(target_metadata_buf);
 	kfree(target_data_buf);
 }
 
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 568870a1a145..a403deca6093 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -13,11 +13,10 @@
 #define DM_IMA_MEASUREMENT_BUF_LEN	4096
 #define DM_IMA_DEVICE_BUF_LEN		1024
 #define DM_IMA_TARGET_METADATA_BUF_LEN	128
 #define DM_IMA_TARGET_DATA_BUF_LEN	2048
 #define DM_IMA_DEVICE_CAPACITY_BUF_LEN	128
-#define DM_IMA_TABLE_HASH_ALG		"sha256"
 
 #define __dm_ima_stringify(s) #s
 #define __dm_ima_str(s) __dm_ima_stringify(s)
 
 #define DM_IMA_VERSION_STR "dm_version="	\

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.53.0


