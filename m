Return-Path: <linux-integrity+bounces-3269-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2A9467E1
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 08:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27ED282728
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9795B153503;
	Sat,  3 Aug 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H6+LA1ib"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6A14C5AF;
	Sat,  3 Aug 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722665333; cv=none; b=G1O3u1IXKqQ1jpBnhl1FtNO8PDL/OsXnLGs9pwa0wh9BHWY4NkH5RcLOgvjOsJScdmfD0Z73orMjqzUX48LC1UBzAUH5qgnCedYeftid1o3nnVZX9mXDi42QOBcR781VESDPIZ7z4+0otoil4ffti9DE4t30ttRtklBxbT1RWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722665333; c=relaxed/simple;
	bh=SpeLY3QYrPLbzOwA/B5BeJ6wXSFfjK03mPw9BBljPGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V8kXOyVXXSgNX972HQFjrd33x3aoawO3+0LXKMJXUVvxq0ouJXRjVRmqwj+U7zrHmU1KPe4vqYlm7KSOfX1mOxIZWhf+KN14dFEHFsAolnXRZJVza9kxlAoUEMHKfrBQNfPsW5ND/4d45vGItLS+to2p41HbDIulw5g8hvoF/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H6+LA1ib; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id BFCC620B7404; Fri,  2 Aug 2024 23:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFCC620B7404
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722665320;
	bh=8NsYu1UcYZC/kqgFfh+6cO5zyAqSfnlh5D0qwSaBrTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H6+LA1ibEcYHuI7CB+EFnwO7WyrnzaFex41pjRy+d1zLez+EJMIjXHqdrwKEhe8lI
	 HIUNJblsQ6ATFqs1qaivqaK3GiO2BzEme7CEecs2lhdMUmQ/Uh6NR/2DWc7CwOgiDJ
	 OdYdeJVH/VlLuB8FNXmv4XOmw0i6/e1bqZOdWxIQ=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v20 12/20] dm verity: expose root hash digest and signature data to LSMs
Date: Fri,  2 Aug 2024 23:08:26 -0700
Message-Id: <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

From: Deven Bowers <deven.desai@linux.microsoft.com>

dm-verity provides a strong guarantee of a block device's integrity. As
a generic way to check the integrity of a block device, it provides
those integrity guarantees to its higher layers, including the filesystem
level.

However, critical security metadata like the dm-verity roothash and its
signing information are not easily accessible to the LSMs.
To address this limitation, this patch introduces a mechanism to store
and manage these essential security details within a newly added LSM blob
in the block_device structure.

This addition allows LSMs to make access control decisions on the integrity
data stored within the block_device, enabling more flexible security
policies. For instance, LSMs can now revoke access to dm-verity devices
based on their roothashes, ensuring that only authorized and verified
content is accessible. Additionally, LSMs can enforce policies to only
allow files from dm-verity devices that have a valid digital signature to
execute, effectively blocking any unsigned files from execution, thus
enhancing security against unauthorized modifications.

The patch includes new hook calls, `security_bdev_setintegrity()`, in
dm-verity to expose the dm-verity roothash and the roothash signature to
LSMs via preresume() callback. By using the preresume() callback, it
ensures that the security metadata is consistently in sync with the
metadata of the dm-verity target in the current active mapping table.
The hook calls are depended on CONFIG_SECURITY.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
---
v2:
  + No Changes

v3:
  + No changes

v4:
  + No changes

v5:
  + No changes

v6:
  + Fix an improper cleanup that can result in
    a leak

v7:
  + Squash patch 08/12, 10/12 to [11/16]
  + Use part0 for block_device, to retrieve the block_device, when
    calling security_bdev_setsecurity

v8:
  + Undo squash of 08/12, 10/12 - separating drivers/md/ from
    security/ & block/
  + Use common-audit function for dmverity_signature.
  + Change implementation for storing the dm-verity digest to use the
    newly introduced dm_verity_digest structure introduced in patch
    14/20.
  + Create new structure, dm_verity_digest, containing digest algorithm,
    size, and digest itself to pass to the LSM layer. V7 was missing the
    algorithm.
  + Create an associated public header containing this new structure and
    the key values for the LSM hook, specific to dm-verity.
  + Additional information added to commit, discussing the layering of
    the changes and how the information passed will be used.

v9:
  + No changes

v10:
  + No changes

v11:
  + Add an optional field to save signature
  + Move the security hook call to the new finalize hook

v12:
  + No changes

v13:
  + No changes

v14:
  + Correct code format
  + Remove unnecessary header and switch to dm_disk()

v15:
  + Refactor security_bdev_setsecurity() to security_bdev_setintegrity()
  + Remove unnecessary headers

v16:
  + Use kmemdup to duplicate signature
  + Clean up lsm blob data in error case

v17:
  + Switch to depend on CONFIG_SECURITY
  + Use new enum name LSM_INT_DMVERITY_SIG_VALID

v18:
  + Amend commit title
  + Fix incorrect error handling
  + Make signature exposure depends on CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
  + Fix inaccurate comment
  + Remove include/linux/dm-verity.h
  + use crypto_ahash_alg_name(v->tfm) instead of v->alg_name

v19:
  + Drop finalize callback and switch to preresume callback
  + Adding NULL check to avoid kmemdup when sig is NULL

v20:
  + Adding more documentation regarding the new setintegrity hook call
  + Update the code for getting hash algorithm from either v->ahash_tfm
    or v->shash_tfm
---
 drivers/md/dm-verity-target.c | 118 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-verity.h        |   6 ++
 include/linux/security.h      |   9 ++-
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index cf659c8feb29..24ba9a10444c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/jump_label.h>
+#include <linux/security.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -930,6 +931,41 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	limits->dma_alignment = limits->logical_block_size - 1;
 }
 
+#ifdef CONFIG_SECURITY
+
+static int verity_init_sig(struct dm_verity *v, const void *sig,
+			   size_t sig_size)
+{
+	v->sig_size = sig_size;
+
+	if (sig) {
+		v->root_digest_sig = kmemdup(sig, v->sig_size, GFP_KERNEL);
+		if (!v->root_digest_sig)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void verity_free_sig(struct dm_verity *v)
+{
+	kfree(v->root_digest_sig);
+}
+
+#else
+
+static inline int verity_init_sig(struct dm_verity *v, const void *sig,
+				  size_t sig_size)
+{
+	return 0;
+}
+
+static inline void verity_free_sig(struct dm_verity *v)
+{
+}
+
+#endif /* CONFIG_SECURITY */
+
 static void verity_dtr(struct dm_target *ti)
 {
 	struct dm_verity *v = ti->private;
@@ -949,6 +985,7 @@ static void verity_dtr(struct dm_target *ti)
 	kfree(v->initial_hashstate);
 	kfree(v->root_digest);
 	kfree(v->zero_digest);
+	verity_free_sig(v);
 
 	if (v->ahash_tfm) {
 		static_branch_dec(&ahash_enabled);
@@ -1418,6 +1455,13 @@ static int verity_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->error = "Root hash verification failed";
 		goto bad;
 	}
+
+	r = verity_init_sig(v, verify_args.sig, verify_args.sig_size);
+	if (r < 0) {
+		ti->error = "Cannot allocate root digest signature";
+		goto bad;
+	}
+
 	v->hash_per_block_bits =
 		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
 
@@ -1559,8 +1603,79 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY
+
+#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
+
+static int verity_security_set_signature(struct block_device *bdev,
+					 struct dm_verity *v)
+{
+	/*
+	 * if the dm-verity target is unsigned, v->root_digest_sig will
+	 * be NULL, and the hook call is still required to let LSMs mark
+	 * the device as unsigned. This information is crucial for LSMs to
+	 * block operations such as execution on unsigned files
+	 */
+	return security_bdev_setintegrity(bdev,
+					  LSM_INT_DMVERITY_SIG_VALID,
+					  v->root_digest_sig,
+					  v->sig_size);
+}
+
+#else
+
+static inline int verity_security_set_signature(struct block_device *bdev,
+						struct dm_verity *v)
+{
+	return 0;
+}
+
+#endif /* CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG */
+
+/*
+ * Expose verity target's root hash and signature data to LSMs before resume.
+ *
+ * Returns 0 on success, or -ENOMEM if the system is out of memory.
+ */
+static int verity_preresume(struct dm_target *ti)
+{
+	struct block_device *bdev;
+	struct dm_verity_digest root_digest;
+	struct dm_verity *v;
+	int r;
+
+	v = ti->private;
+	bdev = dm_disk(dm_table_get_md(ti->table))->part0;
+	root_digest.digest = v->root_digest;
+	root_digest.digest_len = v->digest_size;
+	if (static_branch_unlikely(&ahash_enabled) && !v->shash_tfm)
+		root_digest.alg = crypto_ahash_alg_name(v->ahash_tfm);
+	else
+		root_digest.alg = crypto_shash_alg_name(v->shash_tfm);
+
+	r = security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, &root_digest,
+				       sizeof(root_digest));
+	if (r)
+		return r;
+
+	r =  verity_security_set_signature(bdev, v);
+	if (r)
+		goto bad;
+
+	return 0;
+
+bad:
+
+	security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL, 0);
+
+	return r;
+}
+
+#endif /* CONFIG_SECURITY */
+
 static struct target_type verity_target = {
 	.name		= "verity",
+/* Note: the LSMs depend on the singleton and immutable features */
 	.features	= DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
 	.version	= {1, 10, 0},
 	.module		= THIS_MODULE,
@@ -1571,6 +1686,9 @@ static struct target_type verity_target = {
 	.prepare_ioctl	= verity_prepare_ioctl,
 	.iterate_devices = verity_iterate_devices,
 	.io_hints	= verity_io_hints,
+#ifdef CONFIG_SECURITY
+	.preresume	= verity_preresume,
+#endif /* CONFIG_SECURITY */
 };
 module_dm(verity);
 
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index aac3a1b1d94a..ea2da450f173 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -45,6 +45,9 @@ struct dm_verity {
 	u8 *salt;		/* salt: its size is salt_size */
 	u8 *initial_hashstate;	/* salted initial state, if shash_tfm is set */
 	u8 *zero_digest;	/* digest for a zero block */
+#ifdef CONFIG_SECURITY
+	u8 *root_digest_sig;	/* signature of the root digest */
+#endif /* CONFIG_SECURITY */
 	unsigned int salt_size;
 	sector_t data_start;	/* data offset in 512-byte sectors */
 	sector_t hash_start;	/* hash start in blocks */
@@ -58,6 +61,9 @@ struct dm_verity {
 	bool hash_failed:1;	/* set if hash of any block failed */
 	bool use_bh_wq:1;	/* try to verify in BH wq before normal work-queue */
 	unsigned int digest_size;	/* digest size for the current hash algorithm */
+#ifdef CONFIG_SECURITY
+	unsigned int sig_size;	/* root digest signature size */
+#endif /* CONFIG_SECURITY */
 	unsigned int hash_reqsize; /* the size of temporary space for crypto */
 	enum verity_mode mode;	/* mode for handling verification errors */
 	unsigned int corrupted_errs;/* Number of errors for corrupted blocks */
diff --git a/include/linux/security.h b/include/linux/security.h
index 39aec1c96d6a..0604893f2f9e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -83,8 +83,15 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+struct dm_verity_digest {
+	const char *alg;
+	const u8 *digest;
+	size_t digest_len;
+};
+
 enum lsm_integrity_type {
-	__LSM_INT_MAX
+	LSM_INT_DMVERITY_SIG_VALID,
+	LSM_INT_DMVERITY_ROOTHASH,
 };
 
 /*
-- 
2.44.0


