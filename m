Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3613EBDED
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhHMVih (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:38:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhHMVih (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:38:37 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id DBDE320C1715;
        Fri, 13 Aug 2021 14:38:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBDE320C1715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628890690;
        bh=4csy5b5kiyoZxFENmB5VxSl1SoTC8baiBFdwBVsH09s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqaHLW8ZfSOM4G0OTmNyN53qJ5vl/AAAV3yaE2pTG+vJr45/zbr5fjVnox4t7WiHU
         cTWrIkDAdpH5FBWWso1KOneZPSJhHe7xcBZ8NH9kn7TW5lHnne9hWKVT3gKmcSSYFL
         Tc7H+Qq0JYq5pvybWLAFjNTLFAQ62jIE69ZDRdZE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        sfr@canb.auug.org.au, public@thson.de, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com
Subject: [PATCH 1/6] dm ima: prefix dm table hashes in ima log with hash algorithm
Date:   Fri, 13 Aug 2021 14:37:56 -0700
Message-Id: <20210813213801.297051-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The active/inactive table hashes measured in the ima log do not contain
the information about hash algorithm.  This information is useful for the
attestation servers to recreate the hashes and compare them with the ones
present in the ima log to verify the table contents.

Prefix the table hashes in various DM events in ima log with the hash
algorithm used to compute those hashes.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/md/dm-ima.c | 15 ++++++++++++---
 drivers/md/dm-ima.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 91ea4a7202ab..4bab35c8f0c7 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -186,6 +186,12 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	struct crypto_shash *tfm = NULL;
 	u8 *digest = NULL;
 	bool noio = false;
+	const size_t hash_alg_prefix_len = strlen(DM_IMA_TABLE_HASH_ALG) + 1;
+				/*
+				 * +1 for the additional char (':'), when prefixing
+				 * the hash value with the hash algorithm name.
+				 * e.g. sha256:<hash_value>.
+				 */
 
 	ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, GFP_KERNEL, noio);
 	if (!ima_buf)
@@ -204,7 +210,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	if (dm_ima_alloc_and_copy_device_data(table->md, &device_data_buf, num_targets, noio))
 		goto error;
 
-	tfm = crypto_alloc_shash("sha256", 0, 0);
+	tfm = crypto_alloc_shash(DM_IMA_TABLE_HASH_ALG, 0, 0);
 	if (IS_ERR(tfm))
 		goto error;
 
@@ -315,12 +321,15 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	if (r < 0)
 		goto error;
 
-	digest_buf = dm_ima_alloc((digest_size*2)+1, GFP_KERNEL, noio);
+	digest_buf = dm_ima_alloc((digest_size*2) + hash_alg_prefix_len + 1, GFP_KERNEL, noio);
+
 	if (!digest_buf)
 		goto error;
 
+	snprintf(digest_buf, hash_alg_prefix_len + 1, "%s:", DM_IMA_TABLE_HASH_ALG);
+
 	for (i = 0; i < digest_size; i++)
-		snprintf((digest_buf+(i*2)), 3, "%02x", digest[i]);
+		snprintf((digest_buf + hash_alg_prefix_len + (i*2)), 3, "%02x", digest[i]);
 
 	if (table->md->ima.active_table.hash != table->md->ima.inactive_table.hash)
 		kfree(table->md->ima.inactive_table.hash);
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 6e6f18bf05b4..0731a51565d6 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -16,6 +16,7 @@
 #define DM_IMA_TARGET_METADATA_BUF_LEN	128
 #define DM_IMA_TARGET_DATA_BUF_LEN	2048
 #define DM_IMA_DEVICE_CAPACITY_BUF_LEN	128
+#define DM_IMA_TABLE_HASH_ALG		"sha256"
 
 #ifdef CONFIG_IMA
 
-- 
2.32.0

