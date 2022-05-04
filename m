Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C451B3DC
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 02:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbiEEABd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 20:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385483AbiEDXZZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 19:25:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF184DF4A
        for <linux-integrity@vger.kernel.org>; Wed,  4 May 2022 16:21:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c9so2128090plh.2
        for <linux-integrity@vger.kernel.org>; Wed, 04 May 2022 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNIKKnjFfbyO6GIKZxv1cwlMsvlm06g9nZabLDog+Hw=;
        b=P2L3QfO0rVtWtrwK+DWAeDMoaee7pJPv+20By6GZRva1qmNW7T9ZTrdgxsnUvOYRTT
         F8ncmZ0p3mqxBKjNK/tEKSpKn3YeFp0iJ9iQ2dzUUeXszA4crqLMqt1pmqgiRTgRz3jC
         X9z45rJ2qsLfDFEU5xnc8m7JZo19xCo/KvjJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNIKKnjFfbyO6GIKZxv1cwlMsvlm06g9nZabLDog+Hw=;
        b=Zr690QE1iHICP3gwO4ByVWvHBYuSbGEwVXBghMfBCvoLP9A8uoXdabNR4rvv65bBhv
         8NSE5XqKuCyVhA660wxM7TNOfTUf+lVTewd6MU1KfoJ3c1ZVgfWEZ/0LvOhkFO63SXsX
         4kVD0/K8x3UVUTGbuhKI+lKy0mB1vDyzkvAxAuWZ+12VaxVJZwN7lNxp3BsuQ5UR6Te+
         IjxcXHx1v34JGyWWC/Oz0j8slZIzHRsM8/jhAZDku/ohXOj8HimUVHXQ/6Vw2dkg52lj
         WuBxKPXo9yHsc7PdaUrol1tnzY5blFm2OWtszIOShCCoZ/bw5BmNC9BbYDGMg5gPg7tu
         Ij8g==
X-Gm-Message-State: AOAM531wjYz6SGAc5tKSdCu92fvd7WBLHU+EeMzX7eOF3XHNRVjmAoVV
        1jVeTskHUgpPNyT215wurf9h3w==
X-Google-Smtp-Source: ABdhPJwKLS4W00NPlD53XayMBHEvEdGrWE4ak49ahAnNtY1iHBPvHHPZWIU2O7GwCTCvpT2bFSKfEA==
X-Received: by 2002:a17:902:f54a:b0:15e:a95a:c0a7 with SMTP id h10-20020a170902f54a00b0015ea95ac0a7mr15919068plf.134.1651706506376;
        Wed, 04 May 2022 16:21:46 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902f78c00b0015e8d4eb2d6sm1901pln.288.2022.05.04.16.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:21:46 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
Date:   Wed,  4 May 2022 16:21:00 -0700
Message-Id: <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Usermode may have their own data protection requirements when it comes
to encrypting the hibernate image. For example, users may want a policy
where the hibernate image is protected by a key derived both from
platform-level security as well as authentication data (such as a
password or PIN). This way, even if the platform is compromised (ie a
stolen laptop), sensitive data cannot be exfiltrated via the hibernate
image without additional data (like the user's password).

The kernel is already doing the encryption, but will be protecting its
key with the TPM alone. Allow usermode to mix in key content of their own
for the data portion of the hibernate image, so that the image
encryption key is determined both by a TPM-backed secret and
user-defined data.

To mix the user key in, we hash the kernel key followed by the user key,
and use the resulting hash as the new key. This allows usermode to mix
in its key material without giving it too much control over what key is
actually driving the encryption (which might be used to attack the
secret kernel key).

Limiting this to the data portion allows the kernel to receive the page
map and prepare its giant allocation even if this user key is not yet
available (ie the user has not yet finished typing in their password).
Once the user key becomes available, the data portion can be pushed
through to the kernel as well. This enables "preloading" scenarios,
where the hibernate image is loaded off of disk while the additional
key material (eg password) is being collected.

One annoyance of the "preloading" scheme is that hibernate image memory
is effectively double-allocated: first by the usermode process pulling
encrypted contents off of disk and holding it, and second by the kernel
in its giant allocation in prepare_image(). An interesting future
optimization would be to allow the kernel to accept and store encrypted
page data before the user key is available. This would remove the
double allocation problem, as usermode could push the encrypted pages
loaded from disk immediately without storing them. The kernel could defer
decryption of the data until the user key is available, while still
knowing the correct page locations to store the encrypted data in.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 include/uapi/linux/suspend_ioctls.h |  15 ++-
 kernel/power/power.h                |   1 +
 kernel/power/snapenc.c              | 187 ++++++++++++++++++++++++++--
 kernel/power/snapshot.c             |   5 +
 kernel/power/user.c                 |   4 +
 kernel/power/user.h                 |  12 ++
 6 files changed, 213 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/suspend_ioctls.h b/include/uapi/linux/suspend_ioctls.h
index b73026ef824bb9..c60b84cbb33ae1 100644
--- a/include/uapi/linux/suspend_ioctls.h
+++ b/include/uapi/linux/suspend_ioctls.h
@@ -25,6 +25,18 @@ struct uswsusp_key_blob {
 	__u8 nonce[USWSUSP_KEY_NONCE_SIZE];
 } __attribute__((packed));
 
+/*
+ * Allow user mode to fold in key material for the data portion of the hibernate
+ * image.
+ */
+struct uswsusp_user_key {
+	/* Kernel returns the metadata size. */
+	__kernel_loff_t meta_size;
+	__u32 key_len;
+	__u8 key[16];
+	__u32 pad;
+};
+
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
 #define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
@@ -42,6 +54,7 @@ struct uswsusp_key_blob {
 #define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 19, __kernel_loff_t)
 #define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 20, __kernel_loff_t)
 #define SNAPSHOT_ENABLE_ENCRYPTION	_IOWR(SNAPSHOT_IOC_MAGIC, 21, struct uswsusp_key_blob)
-#define SNAPSHOT_IOC_MAXNR	21
+#define SNAPSHOT_SET_USER_KEY		_IOWR(SNAPSHOT_IOC_MAGIC, 22, struct uswsusp_user_key)
+#define SNAPSHOT_IOC_MAXNR	22
 
 #endif /* _LINUX_SUSPEND_IOCTLS_H */
diff --git a/kernel/power/power.h b/kernel/power/power.h
index b4f43394320961..5955e5cf692302 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -151,6 +151,7 @@ struct snapshot_handle {
 
 extern unsigned int snapshot_additional_pages(struct zone *zone);
 extern unsigned long snapshot_get_image_size(void);
+extern unsigned long snapshot_get_meta_page_count(void);
 extern int snapshot_read_next(struct snapshot_handle *handle);
 extern int snapshot_write_next(struct snapshot_handle *handle);
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
index 2bd5fe05a321e7..067f49c05a4d54 100644
--- a/kernel/power/snapenc.c
+++ b/kernel/power/snapenc.c
@@ -6,6 +6,8 @@
 #include <crypto/gcm.h>
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 #include <linux/random.h>
 #include <linux/mm.h>
 #include <linux/tpm.h>
@@ -21,6 +23,66 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
 		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
 		   0x5f, 0x49}};
 
+/* Derive a key from the kernel and user keys for data encryption. */
+static int snapshot_use_user_key(struct snapshot_data *data)
+{
+	struct shash_desc *desc;
+	u8 digest[SHA256_DIGEST_SIZE];
+	struct trusted_key_payload *payload;
+	struct crypto_shash *tfm;
+	int ret;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = -EINVAL;
+		goto err_rel;
+	}
+
+	desc = kmalloc(sizeof(struct shash_desc) +
+		       crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err_rel;
+	}
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret != 0)
+		goto err_free;
+
+	/*
+	 * Hash the kernel key and the user key together. This folds in the user
+	 * key, but not in a way that gives the user mode predictable control
+	 * over the key bits. Hash in all 32 bytes of the key even though only 16
+	 * are in active use as extra salt.
+	 */
+	payload = data->key->payload.data[0];
+	crypto_shash_update(desc, payload->key, MIN_KEY_SIZE);
+	crypto_shash_update(desc, data->user_key, sizeof(data->user_key));
+	crypto_shash_final(desc, digest);
+	ret = crypto_aead_setkey(data->aead_tfm,
+				 digest,
+				 SNAPSHOT_ENCRYPTION_KEY_SIZE);
+
+err_free:
+	kfree(desc);
+
+err_rel:
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+/* Check to see if it's time to switch to the user key, and do it if so. */
+static int snapshot_check_user_key_switch(struct snapshot_data *data)
+{
+	if (data->user_key_valid && data->meta_size &&
+	    data->crypt_total == data->meta_size) {
+		return snapshot_use_user_key(data);
+	}
+
+	return 0;
+}
+
 /* Encrypt more data from the snapshot into the staging area. */
 static int snapshot_encrypt_refill(struct snapshot_data *data)
 {
@@ -32,6 +94,15 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 	DECLARE_CRYPTO_WAIT(wait);
 	size_t total = 0;
 
+	if (data->crypt_total == 0) {
+		data->meta_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+
+	} else {
+		res = snapshot_check_user_key_switch(data);
+		if (res)
+			return res;
+	}
+
 	/*
 	 * The first buffer is the associated data, set to the offset to prevent
 	 * attacks that rearrange chunks.
@@ -42,6 +113,11 @@ static int snapshot_encrypt_refill(struct snapshot_data *data)
 	for (pg_idx = 0; pg_idx < CHUNK_SIZE; pg_idx++) {
 		void *buf = data->crypt_pages[pg_idx];
 
+		/* Stop at the meta page boundary to potentially switch keys. */
+		if (total &&
+		    ((data->crypt_total + total) == data->meta_size))
+			break;
+
 		res = snapshot_read_next(&data->handle);
 		if (res < 0)
 			return res;
@@ -114,10 +190,10 @@ static int snapshot_decrypt_drain(struct snapshot_data *data)
 		sg_set_buf(&data->sg[1 + pg_idx], data->crypt_pages[pg_idx], PAGE_SIZE);
 
 	/*
-	 * It's possible this is the final decrypt, and there are fewer than
-	 * CHUNK_SIZE pages. If this is the case we would have just written the
-	 * auth tag into the first few bytes of a new page. Copy to the tag if
-	 * so.
+	 * It's possible this is the final decrypt, or the final decrypt of the
+	 * meta region, and there are fewer than CHUNK_SIZE pages. If this is
+	 * the case we would have just written the auth tag into the first few
+	 * bytes of a new page. Copy to the tag if so.
 	 */
 	if ((page_count < CHUNK_SIZE) &&
 	    (data->crypt_offset - total) == sizeof(data->auth_tag)) {
@@ -172,7 +248,14 @@ static int snapshot_decrypt_drain(struct snapshot_data *data)
 		total += PAGE_SIZE;
 	}
 
+	if (data->crypt_total == 0)
+		data->meta_size = snapshot_get_meta_page_count() << PAGE_SHIFT;
+
 	data->crypt_total += total;
+	res = snapshot_check_user_key_switch(data);
+	if (res)
+		return res;
+
 	return 0;
 }
 
@@ -221,8 +304,26 @@ static ssize_t snapshot_write_next_encrypted(struct snapshot_data *data,
 	if (data->crypt_offset < (PAGE_SIZE * CHUNK_SIZE)) {
 		size_t pg_idx = data->crypt_offset >> PAGE_SHIFT;
 		size_t pg_off = data->crypt_offset & (PAGE_SIZE - 1);
+		size_t size_avail = PAGE_SIZE;
 		*buf = data->crypt_pages[pg_idx] + pg_off;
-		return PAGE_SIZE - pg_off;
+
+		/*
+		 * If this is the boundary where the meta pages end, then just
+		 * return enough for the auth tag.
+		 */
+		if (data->meta_size && (data->crypt_total < data->meta_size)) {
+			uint64_t total_done =
+				data->crypt_total + data->crypt_offset;
+
+			if ((total_done >= data->meta_size) &&
+			    (total_done <
+			     (data->meta_size + SNAPSHOT_AUTH_TAG_SIZE))) {
+
+				size_avail = SNAPSHOT_AUTH_TAG_SIZE;
+			}
+		}
+
+		return size_avail - pg_off;
 	}
 
 	/* Use offsets just beyond the size to return the tag. */
@@ -303,9 +404,15 @@ ssize_t snapshot_write_encrypted(struct snapshot_data *data,
 			break;
 		}
 
-		/* Drain the encrypted buffer if it's full. */
+		/*
+		 * Drain the encrypted buffer if it's full, or if we hit the end
+		 * of the meta pages and need a key change.
+		 */
 		if ((data->crypt_offset >=
-		    ((PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE))) {
+		    ((PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE)) ||
+		    (data->meta_size && (data->crypt_total < data->meta_size) &&
+		     ((data->crypt_total + data->crypt_offset) ==
+		      (data->meta_size + SNAPSHOT_AUTH_TAG_SIZE)))) {
 
 			int rc;
 
@@ -345,6 +452,8 @@ void snapshot_teardown_encryption(struct snapshot_data *data)
 			data->crypt_pages[i] = NULL;
 		}
 	}
+
+	memset(data->user_key, 0, sizeof(data->user_key));
 }
 
 static int snapshot_setup_encryption_common(struct snapshot_data *data)
@@ -354,6 +463,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
 	data->crypt_total = 0;
 	data->crypt_offset = 0;
 	data->crypt_size = 0;
+	data->user_key_valid = false;
 	memset(data->crypt_pages, 0, sizeof(data->crypt_pages));
 	/* This only works once per hibernate. */
 	if (data->aead_tfm)
@@ -643,15 +753,72 @@ int snapshot_set_encryption_key(struct snapshot_data *data,
 	return rc;
 }
 
-loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+loff_t snapshot_encrypted_byte_count(loff_t plain_size)
 {
-	loff_t pages = raw_size >> PAGE_SHIFT;
+	loff_t pages = plain_size >> PAGE_SHIFT;
 	loff_t chunks = (pages + (CHUNK_SIZE - 1)) / CHUNK_SIZE;
 	/*
 	 * The encrypted size is the normal size, plus a stitched in
 	 * authentication tag for every chunk of pages.
 	 */
-	return raw_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
+	return plain_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
+}
+
+static loff_t snapshot_get_meta_data_size(void)
+{
+	loff_t pages = snapshot_get_meta_page_count();
+
+	return snapshot_encrypted_byte_count(pages << PAGE_SHIFT);
+}
+
+int snapshot_set_user_key(struct snapshot_data *data,
+	struct uswsusp_user_key __user *key)
+{
+	struct uswsusp_user_key user_key;
+	unsigned int key_len;
+	int rc;
+	loff_t size;
+
+	/*
+	 * Return the metadata size, the number of bytes that can be fed in before
+	 * the user data key is needed at resume time.
+	 */
+	size = snapshot_get_meta_data_size();
+	rc = put_user(size, &key->meta_size);
+	if (rc)
+		return rc;
+
+	rc = copy_from_user(&user_key, key, sizeof(struct uswsusp_user_key));
+	if (rc)
+		return rc;
+
+	key_len = min_t(__u32, user_key.key_len, sizeof(data->user_key));
+	if (key_len < 8)
+		return -EINVAL;
+
+	/* Don't allow it if it's too late. */
+	if (data->crypt_total > data->meta_size)
+		return -EBUSY;
+
+	memset(data->user_key, 0, sizeof(data->user_key));
+	memcpy(data->user_key, user_key.key, key_len);
+	data->user_key_valid = true;
+	/* Install the key if the user is just under the wire. */
+	rc = snapshot_check_user_key_switch(data);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+{
+	loff_t pages = raw_size >> PAGE_SHIFT;
+	loff_t meta_size;
+
+	pages -= snapshot_get_meta_page_count();
+	meta_size = snapshot_get_meta_data_size();
+	return snapshot_encrypted_byte_count(pages << PAGE_SHIFT) + meta_size;
 }
 
 int snapshot_finalize_decrypted_image(struct snapshot_data *data)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2a406753af9049..026ee511633bc9 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2083,6 +2083,11 @@ unsigned long snapshot_get_image_size(void)
 	return nr_copy_pages + nr_meta_pages + 1;
 }
 
+unsigned long snapshot_get_meta_page_count(void)
+{
+	return nr_meta_pages + 1;
+}
+
 static int init_header(struct swsusp_info *info)
 {
 	memset(info, 0, sizeof(struct swsusp_info));
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 52ad25df4518dc..f35263e6724975 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -412,6 +412,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = snapshot_set_encryption_key(data, (void __user *)arg);
 		break;
 
+	case SNAPSHOT_SET_USER_KEY:
+		error = snapshot_set_user_key(data, (void __user *)arg);
+		break;
+
 	default:
 		error = -ENOTTY;
 
diff --git a/kernel/power/user.h b/kernel/power/user.h
index 591b30bb213349..1b0743b36eee14 100644
--- a/kernel/power/user.h
+++ b/kernel/power/user.h
@@ -32,6 +32,9 @@ struct snapshot_data {
 	uint64_t nonce_low;
 	uint64_t nonce_high;
 	struct key *key;
+	u8 user_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
+	bool user_key_valid;
+	uint64_t meta_size;
 #endif
 
 };
@@ -54,6 +57,9 @@ int snapshot_get_encryption_key(struct snapshot_data *data,
 int snapshot_set_encryption_key(struct snapshot_data *data,
 	struct uswsusp_key_blob __user *key);
 
+int snapshot_set_user_key(struct snapshot_data *data,
+	struct uswsusp_user_key __user *key);
+
 loff_t snapshot_get_encrypted_image_size(loff_t raw_size);
 
 int snapshot_finalize_decrypted_image(struct snapshot_data *data);
@@ -87,6 +93,12 @@ static int snapshot_set_encryption_key(struct snapshot_data *data,
 	return -ENOTTY;
 }
 
+static int snapshot_set_user_key(struct snapshot_data *data,
+	struct uswsusp_user_key __user *key)
+{
+	return -ENOTTY;
+}
+
 static loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
 {
 	return raw_size;
-- 
2.31.0

