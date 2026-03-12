Return-Path: <linux-integrity+bounces-8981-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wceOJf1RsmkeLwAAu9opvQ
	(envelope-from <linux-integrity+bounces-8981-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 06:41:17 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9226D67E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 06:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5579230219CE
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 05:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA05282F38;
	Thu, 12 Mar 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3TBuOOO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6E1A3164;
	Thu, 12 Mar 2026 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294072; cv=none; b=XGhC8F+NZwu0zbCSGUQGCmTDuKGxE2FIUkSd55dipgiAjCUFMZoOk1x7O2qOVmuySKSctFa/H8NjMcWi61gaHdGZmJ9fKrRIoG4wiJtwkuBnDJBRuDax50wzoxpBsokJIfZnJZWDaE+dyuLaX8wyjXTi0wbNv8OqEwB5FVrFy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294072; c=relaxed/simple;
	bh=0mP9zcyq2Odfxy7AVHfeEDGQuu2HvlDWOMIsqmTepF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Az/xV/ZtZgghI8BSZ7g0QQGQTOqPfK4MjwYmEGWZkB2yTbLoJz5Pacc7Fz/DTN8v1oWJOIR3do0cPrVF9cefIBh95O+KyUSxxDFBD9gklsckO3VCcMMQNyxIUhIsmBJ/2eSQ1ApJIy6sywAEi2gyk5lXzQZ1h5Pia9+WOUc6ZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3TBuOOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E928C4CEF7;
	Thu, 12 Mar 2026 05:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773294072;
	bh=0mP9zcyq2Odfxy7AVHfeEDGQuu2HvlDWOMIsqmTepF0=;
	h=From:To:Cc:Subject:Date:From;
	b=G3TBuOOO1cV2YfddgV/4lzjlb/cdyS/LL1YpUiLpopkeg/2PJF9nMTGDq5lrR4bdz
	 ETvF01Z/GvVf66ZiV/rS68dOD1mc95LJ4Zq9v/NV7rSDhVYHPCfkMAcXmKqbkHZoSn
	 n4tVOKry0wAE/FTshdguYSp9qX2UhiHeQid1+JEasTf4hJ+gX1aKnxePhj9VQ/c+RV
	 SBJrQ4JKGht58tYjqacrnsniAhPONELS1b5cBzh7fQLj/7yc3I1lfpHIWwLJ4K+L48
	 zfU2PgbJjF5eX87RM8qeQwJl/5wYu+nG2rJXAiSHyC27/3UbyRVvkbDYtJbt+FZ1P8
	 WQsAR9y8YRDZQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] ima: remove buggy support for asynchronous hashes
Date: Wed, 11 Mar 2026 22:39:33 -0700
Message-ID: <20260312053933.53012-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8981-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CC9226D67E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IMA computes hashes using the crypto_shash or crypto_ahash API.  The
latter is used only when ima.ahash_minsize is set on the command line,
and its purpose is ostensibly to make the hash computation faster.

However, going off the CPU to a crypto engine and back again is actually
quite slow, especially compared with the acceleration that is built into
modern CPUs and the kernel now enables by default for most algorithms.
Typical performance results for SHA-256 on a modern platform can be
found at https://lore.kernel.org/linux-crypto/20250615184638.GA1480@sol/

Partly for this reason, several other kernel subsystems have already
dropped support for the crypto_ahash API.

The other problem with crypto_ahash is that bugs are also common, not
just in the underlying drivers, but also in the code using it, since it
is very difficult to use correctly.  Just from a quick review, here are
some of the bugs I noticed in IMA's ahash code:

- [Use after free] ima_alloc_atfm() isn't thread-safe and can trigger a
  use-after-free if multiple threads try to initialize the global
  ima_ahash_tfm at the same time.

- [Deadlock] If only one buffer is allocated and there is an error
  reading from the file, then ahash_wait() is executed twice, causing a
  deadlock in wait_for_completion().

- [Crash or incorrect hash computed] calc_buffer_ahash_atfm() is
  sometimes passed stack buffers which can be vmalloc addresses, but it
  puts them in a scatterlist assuming they are linear addresses.  This
  causes the hashing to be done on the wrong physical address.

- [Truncation to 32-bit length] ima_alloc_pages() incorrectly assumes an
  loff_t value fits in an unsigned long.  calc_buffer_ahash_atfm()
  incorrectly assumes that a loff_t value fits in an unsigned int.

So, not exactly a great track record so far, even disregarding driver
bugs which are an even larger problem.  Fortunately, in practice it's
unlikely that many users are actually setting the ima.ahash_minsize
kernel command-line parameter which enables this code.  However, given
that this code is almost certainly no longer useful (if it ever was),
let's just remove it instead of attempting to fix all these issues.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  17 -
 security/integrity/ima/ima_crypto.c           | 382 +-----------------
 2 files changed, 9 insertions(+), 390 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 55ffc0f8858a..a6e75f0a293b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2393,27 +2393,10 @@ Kernel parameters
 
 	ima_template_fmt=
 			[IMA] Define a custom template format.
 			Format: { "field1|...|fieldN" }
 
-	ima.ahash_minsize= [IMA] Minimum file size for asynchronous hash usage
-			Format: <min_file_size>
-			Set the minimal file size for using asynchronous hash.
-			If left unspecified, ahash usage is disabled.
-
-			ahash performance varies for different data sizes on
-			different crypto accelerators. This option can be used
-			to achieve the best performance for a particular HW.
-
-	ima.ahash_bufsize= [IMA] Asynchronous hash buffer size
-			Format: <bufsize>
-			Set hashing buffer size. Default: 4k.
-
-			ahash performance varies for different chunk sizes on
-			different crypto accelerators. This option can be used
-			to achieve best performance for particular HW.
-
 	ima=		[IMA] Enable or disable IMA
 			Format: { "off" | "on" }
 			Default: "on"
 			Note that disabling IMA is limited to kdump kernel.
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index aff61643415d..d43ed65c8e07 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -9,55 +9,19 @@
  * File: ima_crypto.c
  *	Calculates md5/sha1 file hash, template hash, boot-aggreate hash
  */
 
 #include <linux/kernel.h>
-#include <linux/moduleparam.h>
-#include <linux/ratelimit.h>
 #include <linux/file.h>
 #include <linux/crypto.h>
-#include <linux/scatterlist.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <crypto/hash.h>
 
 #include "ima.h"
 
-/* minimum file size for ahash use */
-static unsigned long ima_ahash_minsize;
-module_param_named(ahash_minsize, ima_ahash_minsize, ulong, 0644);
-MODULE_PARM_DESC(ahash_minsize, "Minimum file size for ahash use");
-
-/* default is 0 - 1 page. */
-static int ima_maxorder;
-static unsigned int ima_bufsize = PAGE_SIZE;
-
-static int param_set_bufsize(const char *val, const struct kernel_param *kp)
-{
-	unsigned long long size;
-	int order;
-
-	size = memparse(val, NULL);
-	order = get_order(size);
-	if (order > MAX_PAGE_ORDER)
-		return -EINVAL;
-	ima_maxorder = order;
-	ima_bufsize = PAGE_SIZE << order;
-	return 0;
-}
-
-static const struct kernel_param_ops param_ops_bufsize = {
-	.set = param_set_bufsize,
-	.get = param_get_uint,
-};
-#define param_check_bufsize(name, p) __param_check(name, p, unsigned int)
-
-module_param_named(ahash_bufsize, ima_bufsize, bufsize, 0644);
-MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
-
 static struct crypto_shash *ima_shash_tfm;
-static struct crypto_ahash *ima_ahash_tfm;
 
 int ima_sha1_idx __ro_after_init;
 int ima_hash_algo_idx __ro_after_init;
 /*
  * Additional number of slots reserved, as needed, for SHA1
@@ -218,238 +182,10 @@ static void ima_free_tfm(struct crypto_shash *tfm)
 			return;
 
 	crypto_free_shash(tfm);
 }
 
-/**
- * ima_alloc_pages() - Allocate contiguous pages.
- * @max_size:       Maximum amount of memory to allocate.
- * @allocated_size: Returned size of actual allocation.
- * @last_warn:      Should the min_size allocation warn or not.
- *
- * Tries to do opportunistic allocation for memory first trying to allocate
- * max_size amount of memory and then splitting that until zero order is
- * reached. Allocation is tried without generating allocation warnings unless
- * last_warn is set. Last_warn set affects only last allocation of zero order.
- *
- * By default, ima_maxorder is 0 and it is equivalent to kmalloc(GFP_KERNEL)
- *
- * Return pointer to allocated memory, or NULL on failure.
- */
-static void *ima_alloc_pages(loff_t max_size, size_t *allocated_size,
-			     int last_warn)
-{
-	void *ptr;
-	int order = ima_maxorder;
-	gfp_t gfp_mask = __GFP_RECLAIM | __GFP_NOWARN | __GFP_NORETRY;
-
-	if (order)
-		order = min(get_order(max_size), order);
-
-	for (; order; order--) {
-		ptr = (void *)__get_free_pages(gfp_mask, order);
-		if (ptr) {
-			*allocated_size = PAGE_SIZE << order;
-			return ptr;
-		}
-	}
-
-	/* order is zero - one page */
-
-	gfp_mask = GFP_KERNEL;
-
-	if (!last_warn)
-		gfp_mask |= __GFP_NOWARN;
-
-	ptr = (void *)__get_free_pages(gfp_mask, 0);
-	if (ptr) {
-		*allocated_size = PAGE_SIZE;
-		return ptr;
-	}
-
-	*allocated_size = 0;
-	return NULL;
-}
-
-/**
- * ima_free_pages() - Free pages allocated by ima_alloc_pages().
- * @ptr:  Pointer to allocated pages.
- * @size: Size of allocated buffer.
- */
-static void ima_free_pages(void *ptr, size_t size)
-{
-	if (!ptr)
-		return;
-	free_pages((unsigned long)ptr, get_order(size));
-}
-
-static struct crypto_ahash *ima_alloc_atfm(enum hash_algo algo)
-{
-	struct crypto_ahash *tfm = ima_ahash_tfm;
-	int rc;
-
-	if (algo < 0 || algo >= HASH_ALGO__LAST)
-		algo = ima_hash_algo;
-
-	if (algo != ima_hash_algo || !tfm) {
-		tfm = crypto_alloc_ahash(hash_algo_name[algo], 0, 0);
-		if (!IS_ERR(tfm)) {
-			if (algo == ima_hash_algo)
-				ima_ahash_tfm = tfm;
-		} else {
-			rc = PTR_ERR(tfm);
-			pr_err("Can not allocate %s (reason: %d)\n",
-			       hash_algo_name[algo], rc);
-		}
-	}
-	return tfm;
-}
-
-static void ima_free_atfm(struct crypto_ahash *tfm)
-{
-	if (tfm != ima_ahash_tfm)
-		crypto_free_ahash(tfm);
-}
-
-static inline int ahash_wait(int err, struct crypto_wait *wait)
-{
-
-	err = crypto_wait_req(err, wait);
-
-	if (err)
-		pr_crit_ratelimited("ahash calculation failed: err: %d\n", err);
-
-	return err;
-}
-
-static int ima_calc_file_hash_atfm(struct file *file,
-				   struct ima_digest_data *hash,
-				   struct crypto_ahash *tfm)
-{
-	loff_t i_size, offset;
-	char *rbuf[2] = { NULL, };
-	int rc, rbuf_len, active = 0, ahash_rc = 0;
-	struct ahash_request *req;
-	struct scatterlist sg[1];
-	struct crypto_wait wait;
-	size_t rbuf_size[2];
-
-	hash->length = crypto_ahash_digestsize(tfm);
-
-	req = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	crypto_init_wait(&wait);
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
-				   CRYPTO_TFM_REQ_MAY_SLEEP,
-				   crypto_req_done, &wait);
-
-	rc = ahash_wait(crypto_ahash_init(req), &wait);
-	if (rc)
-		goto out1;
-
-	i_size = i_size_read(file_inode(file));
-
-	if (i_size == 0)
-		goto out2;
-
-	/*
-	 * Try to allocate maximum size of memory.
-	 * Fail if even a single page cannot be allocated.
-	 */
-	rbuf[0] = ima_alloc_pages(i_size, &rbuf_size[0], 1);
-	if (!rbuf[0]) {
-		rc = -ENOMEM;
-		goto out1;
-	}
-
-	/* Only allocate one buffer if that is enough. */
-	if (i_size > rbuf_size[0]) {
-		/*
-		 * Try to allocate secondary buffer. If that fails fallback to
-		 * using single buffering. Use previous memory allocation size
-		 * as baseline for possible allocation size.
-		 */
-		rbuf[1] = ima_alloc_pages(i_size - rbuf_size[0],
-					  &rbuf_size[1], 0);
-	}
-
-	for (offset = 0; offset < i_size; offset += rbuf_len) {
-		if (!rbuf[1] && offset) {
-			/* Not using two buffers, and it is not the first
-			 * read/request, wait for the completion of the
-			 * previous ahash_update() request.
-			 */
-			rc = ahash_wait(ahash_rc, &wait);
-			if (rc)
-				goto out3;
-		}
-		/* read buffer */
-		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
-		rc = integrity_kernel_read(file, offset, rbuf[active],
-					   rbuf_len);
-		if (rc != rbuf_len) {
-			if (rc >= 0)
-				rc = -EINVAL;
-			/*
-			 * Forward current rc, do not overwrite with return value
-			 * from ahash_wait()
-			 */
-			ahash_wait(ahash_rc, &wait);
-			goto out3;
-		}
-
-		if (rbuf[1] && offset) {
-			/* Using two buffers, and it is not the first
-			 * read/request, wait for the completion of the
-			 * previous ahash_update() request.
-			 */
-			rc = ahash_wait(ahash_rc, &wait);
-			if (rc)
-				goto out3;
-		}
-
-		sg_init_one(&sg[0], rbuf[active], rbuf_len);
-		ahash_request_set_crypt(req, sg, NULL, rbuf_len);
-
-		ahash_rc = crypto_ahash_update(req);
-
-		if (rbuf[1])
-			active = !active; /* swap buffers, if we use two */
-	}
-	/* wait for the last update request to complete */
-	rc = ahash_wait(ahash_rc, &wait);
-out3:
-	ima_free_pages(rbuf[0], rbuf_size[0]);
-	ima_free_pages(rbuf[1], rbuf_size[1]);
-out2:
-	if (!rc) {
-		ahash_request_set_crypt(req, NULL, hash->digest, 0);
-		rc = ahash_wait(crypto_ahash_final(req), &wait);
-	}
-out1:
-	ahash_request_free(req);
-	return rc;
-}
-
-static int ima_calc_file_ahash(struct file *file, struct ima_digest_data *hash)
-{
-	struct crypto_ahash *tfm;
-	int rc;
-
-	tfm = ima_alloc_atfm(hash->algo);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	rc = ima_calc_file_hash_atfm(file, hash, tfm);
-
-	ima_free_atfm(tfm);
-
-	return rc;
-}
-
 static int ima_calc_file_hash_tfm(struct file *file,
 				  struct ima_digest_data *hash,
 				  struct crypto_shash *tfm)
 {
 	loff_t i_size, offset = 0;
@@ -497,45 +233,19 @@ static int ima_calc_file_hash_tfm(struct file *file,
 	if (!rc)
 		rc = crypto_shash_final(shash, hash->digest);
 	return rc;
 }
 
-static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
-{
-	struct crypto_shash *tfm;
-	int rc;
-
-	tfm = ima_alloc_tfm(hash->algo);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	rc = ima_calc_file_hash_tfm(file, hash, tfm);
-
-	ima_free_tfm(tfm);
-
-	return rc;
-}
-
 /*
  * ima_calc_file_hash - calculate file hash
- *
- * Asynchronous hash (ahash) allows using HW acceleration for calculating
- * a hash. ahash performance varies for different data sizes on different
- * crypto accelerators. shash performance might be better for smaller files.
- * The 'ima.ahash_minsize' module parameter allows specifying the best
- * minimum file size for using ahash on the system.
- *
- * If the ima.ahash_minsize parameter is not specified, this function uses
- * shash for the hash calculation.  If ahash fails, it falls back to using
- * shash.
  */
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 {
-	loff_t i_size;
 	int rc;
 	struct file *f = file;
 	bool new_file_instance = false;
+	struct crypto_shash *tfm;
 
 	/*
 	 * For consistency, fail file's opened with the O_DIRECT flag on
 	 * filesystems mounted with/without DAX option.
 	 */
@@ -555,20 +265,17 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 			return PTR_ERR(f);
 
 		new_file_instance = true;
 	}
 
-	i_size = i_size_read(file_inode(f));
-
-	if (ima_ahash_minsize && i_size >= ima_ahash_minsize) {
-		rc = ima_calc_file_ahash(f, hash);
-		if (!rc)
-			goto out;
+	tfm = ima_alloc_tfm(hash->algo);
+	if (IS_ERR(tfm)) {
+		rc = PTR_ERR(tfm);
+	} else {
+		rc = ima_calc_file_hash_tfm(f, hash, tfm);
+		ima_free_tfm(tfm);
 	}
-
-	rc = ima_calc_file_shash(f, hash);
-out:
 	if (new_file_instance)
 		fput(f);
 	return rc;
 }
 
@@ -653,67 +360,10 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			return rc;
 	}
 	return rc;
 }
 
-static int calc_buffer_ahash_atfm(const void *buf, loff_t len,
-				  struct ima_digest_data *hash,
-				  struct crypto_ahash *tfm)
-{
-	struct ahash_request *req;
-	struct scatterlist sg;
-	struct crypto_wait wait;
-	int rc, ahash_rc = 0;
-
-	hash->length = crypto_ahash_digestsize(tfm);
-
-	req = ahash_request_alloc(tfm, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	crypto_init_wait(&wait);
-	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
-				   CRYPTO_TFM_REQ_MAY_SLEEP,
-				   crypto_req_done, &wait);
-
-	rc = ahash_wait(crypto_ahash_init(req), &wait);
-	if (rc)
-		goto out;
-
-	sg_init_one(&sg, buf, len);
-	ahash_request_set_crypt(req, &sg, NULL, len);
-
-	ahash_rc = crypto_ahash_update(req);
-
-	/* wait for the update request to complete */
-	rc = ahash_wait(ahash_rc, &wait);
-	if (!rc) {
-		ahash_request_set_crypt(req, NULL, hash->digest, 0);
-		rc = ahash_wait(crypto_ahash_final(req), &wait);
-	}
-out:
-	ahash_request_free(req);
-	return rc;
-}
-
-static int calc_buffer_ahash(const void *buf, loff_t len,
-			     struct ima_digest_data *hash)
-{
-	struct crypto_ahash *tfm;
-	int rc;
-
-	tfm = ima_alloc_atfm(hash->algo);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	rc = calc_buffer_ahash_atfm(buf, len, hash, tfm);
-
-	ima_free_atfm(tfm);
-
-	return rc;
-}
-
 static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 				struct ima_digest_data *hash,
 				struct crypto_shash *tfm)
 {
 	SHASH_DESC_ON_STACK(shash, tfm);
@@ -740,12 +390,12 @@ static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 	if (!rc)
 		rc = crypto_shash_final(shash, hash->digest);
 	return rc;
 }
 
-static int calc_buffer_shash(const void *buf, loff_t len,
-			     struct ima_digest_data *hash)
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash)
 {
 	struct crypto_shash *tfm;
 	int rc;
 
 	tfm = ima_alloc_tfm(hash->algo);
@@ -756,24 +406,10 @@ static int calc_buffer_shash(const void *buf, loff_t len,
 
 	ima_free_tfm(tfm);
 	return rc;
 }
 
-int ima_calc_buffer_hash(const void *buf, loff_t len,
-			 struct ima_digest_data *hash)
-{
-	int rc;
-
-	if (ima_ahash_minsize && len >= ima_ahash_minsize) {
-		rc = calc_buffer_ahash(buf, len, hash);
-		if (!rc)
-			return 0;
-	}
-
-	return calc_buffer_shash(buf, len, hash);
-}
-
 static void ima_pcrread(u32 idx, struct tpm_digest *d)
 {
 	if (!ima_tpm_chip)
 		return;
 

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.53.0


