Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF372CEE5
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jun 2023 21:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjFLTBv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jun 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjFLTBu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jun 2023 15:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07748AD;
        Mon, 12 Jun 2023 12:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F72E6152F;
        Mon, 12 Jun 2023 19:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04BCC433EF;
        Mon, 12 Jun 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686596507;
        bh=Cs0cC8hkkl9w6qXQ4QfbT4wSoL2gZUERG5fe7FwYaXc=;
        h=From:To:Cc:Subject:Date:From;
        b=PXsMDebnC9rJwBHIJOAOq5AuJYQMoHn6+Ws/JouZWKngoxHRIUvYXSryge9bWe49Z
         RhyERIG/om08upLQQxAfTZp8efkP8ZI5l+splnoBj8FF6yfWRG5uFIGrPLyrlxIq+Y
         pYwB5wAovSRBxUbw0c2ADbpYmU1ZBXzqNEi5qtQtdloLhg7CCezK1REfiEJnLO5bac
         xaP8NH0lHKXnsb04yrl/DRESigaL1JPpdw0UehrZk+1DKAcUdfLCpyvXXA5f1uIjS9
         TRks4OW5+zOYvEiTggSFh82oq2TGZl2HL5j8EBs94nXcyGBWJcEoK7ounUWcumGHax
         dxGvn0nvf5ZQw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH] fsverity: rework fsverity_get_digest() again
Date:   Mon, 12 Jun 2023 12:00:47 -0700
Message-Id: <20230612190047.59755-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Address several issues with the calling convention and documentation of
fsverity_get_digest():

- Make it provide the hash algorithm as either a FS_VERITY_HASH_ALG_*
  value or HASH_ALGO_* value, at the caller's choice, rather than only a
  HASH_ALGO_* value as it did before.  This allows callers to work with
  the fsverity native algorithm numbers if they want to.  HASH_ALGO_* is
  what IMA uses, but other users (e.g. overlayfs) should use
  FS_VERITY_HASH_ALG_* to match fsverity-utils and the fsverity UAPI.

- Make it return the digest size so that it doesn't need to be looked up
  separately.  Use the return value for this, since 0 works nicely for
  the "file doesn't have fsverity enabled" case.  This also makes it
  clear that no other errors are possible.

- Rename the 'digest' parameter to 'raw_digest' and clearly document
  that it is only useful in combination with the algorithm ID.  This
  hopefully clears up a point of confusion.

- Export it to modules, since overlayfs will need it for checking the
  fsverity digests of lowerdata files
  (https://lore.kernel.org/r/dd294a44e8f401e6b5140029d8355f88748cd8fd.1686565330.git.alexl@redhat.com).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/measure.c              | 37 ++++++++++++++++++++++----------
 include/linux/fsverity.h         | 14 +++++++-----
 security/integrity/ima/ima_api.c | 31 +++++++++++---------------
 3 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 5c79ea1b24687..eec5956141da2 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -61,27 +61,42 @@ EXPORT_SYMBOL_GPL(fsverity_ioctl_measure);
 /**
  * fsverity_get_digest() - get a verity file's digest
  * @inode: inode to get digest of
- * @digest: (out) pointer to the digest
- * @alg: (out) pointer to the hash algorithm enumeration
+ * @raw_digest: (out) the raw file digest
+ * @alg: (out) the digest's algorithm, as a FS_VERITY_HASH_ALG_* value
+ * @halg: (out) the digest's algorithm, as a HASH_ALGO_* value
  *
- * Return the file hash algorithm and digest of an fsverity protected file.
- * Assumption: before calling this, the file must have been opened.
+ * Retrieves the fsverity digest of the given file.  The file must have been
+ * opened at least once since the inode was last loaded into the inode cache;
+ * otherwise this function will not recognize when fsverity is enabled.
  *
- * Return: 0 on success, -errno on failure
+ * The file's fsverity digest consists of @raw_digest in combination with either
+ * @alg or @halg.  (The caller can choose which one of @alg or @halg to use.)
+ *
+ * IMPORTANT: Callers *must* make use of one of the two algorithm IDs, since
+ * @raw_digest is meaningless without knowing which algorithm it uses!  fsverity
+ * provides no security guarantee for users who ignore the algorithm ID, even if
+ * they use the digest size (since algorithms can share the same digest size).
+ *
+ * Return: The size of the raw digest in bytes, or 0 if the file doesn't have
+ *	   fsverity enabled.
  */
 int fsverity_get_digest(struct inode *inode,
-			u8 digest[FS_VERITY_MAX_DIGEST_SIZE],
-			enum hash_algo *alg)
+			u8 raw_digest[FS_VERITY_MAX_DIGEST_SIZE],
+			u8 *alg, enum hash_algo *halg)
 {
 	const struct fsverity_info *vi;
 	const struct fsverity_hash_alg *hash_alg;
 
 	vi = fsverity_get_info(inode);
 	if (!vi)
-		return -ENODATA; /* not a verity file */
+		return 0; /* not a verity file */
 
 	hash_alg = vi->tree_params.hash_alg;
-	memcpy(digest, vi->file_digest, hash_alg->digest_size);
-	*alg = hash_alg->algo_id;
-	return 0;
+	memcpy(raw_digest, vi->file_digest, hash_alg->digest_size);
+	if (alg)
+		*alg = hash_alg - fsverity_hash_algs;
+	if (halg)
+		*halg = hash_alg->algo_id;
+	return hash_alg->digest_size;
 }
+EXPORT_SYMBOL_GPL(fsverity_get_digest);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index e76605d5b36ee..1eb7eae580be7 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -143,8 +143,8 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
 
 int fsverity_ioctl_measure(struct file *filp, void __user *arg);
 int fsverity_get_digest(struct inode *inode,
-			u8 digest[FS_VERITY_MAX_DIGEST_SIZE],
-			enum hash_algo *alg);
+			u8 raw_digest[FS_VERITY_MAX_DIGEST_SIZE],
+			u8 *alg, enum hash_algo *halg);
 
 /* open.c */
 
@@ -197,10 +197,14 @@ static inline int fsverity_ioctl_measure(struct file *filp, void __user *arg)
 }
 
 static inline int fsverity_get_digest(struct inode *inode,
-				      u8 digest[FS_VERITY_MAX_DIGEST_SIZE],
-				      enum hash_algo *alg)
+				      u8 raw_digest[FS_VERITY_MAX_DIGEST_SIZE],
+				      u8 *alg, enum hash_algo *halg)
 {
-	return -EOPNOTSUPP;
+	/*
+	 * fsverity is not enabled in the kernel configuration, so always report
+	 * that the file doesn't have fsverity enabled (digest size 0).
+	 */
+	return 0;
 }
 
 /* open.c */
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index d3662f4acadc1..ce541b0ee1d30 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -202,19 +202,19 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
 				allowed_algos);
 }
 
-static int ima_get_verity_digest(struct integrity_iint_cache *iint,
-				 struct ima_max_digest_data *hash)
+static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
+				  struct ima_max_digest_data *hash)
 {
-	enum hash_algo verity_alg;
-	int ret;
+	enum hash_algo alg;
+	int digest_len;
 
 	/*
 	 * On failure, 'measure' policy rules will result in a file data
 	 * hash containing 0's.
 	 */
-	ret = fsverity_get_digest(iint->inode, hash->digest, &verity_alg);
-	if (ret)
-		return ret;
+	digest_len = fsverity_get_digest(iint->inode, hash->digest, NULL, &alg);
+	if (digest_len == 0)
+		return false;
 
 	/*
 	 * Unlike in the case of actually calculating the file hash, in
@@ -223,9 +223,9 @@ static int ima_get_verity_digest(struct integrity_iint_cache *iint,
 	 * mismatch between the verity algorithm and the xattr signature
 	 * algorithm, if one exists, will be detected later.
 	 */
-	hash->hdr.algo = verity_alg;
-	hash->hdr.length = hash_digest_size[verity_alg];
-	return 0;
+	hash->hdr.algo = alg;
+	hash->hdr.length = digest_len;
+	return true;
 }
 
 /*
@@ -276,16 +276,9 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	memset(&hash.digest, 0, sizeof(hash.digest));
 
 	if (iint->flags & IMA_VERITY_REQUIRED) {
-		result = ima_get_verity_digest(iint, &hash);
-		switch (result) {
-		case 0:
-			break;
-		case -ENODATA:
+		if (!ima_get_verity_digest(iint, &hash)) {
 			audit_cause = "no-verity-digest";
-			break;
-		default:
-			audit_cause = "invalid-verity-digest";
-			break;
+			result = -ENODATA;
 		}
 	} else if (buf) {
 		result = ima_calc_buffer_hash(buf, size, &hash.hdr);

base-commit: 13e2408d02dd12a3b46bf8a29b3ae4f6119fc520
-- 
2.40.1

