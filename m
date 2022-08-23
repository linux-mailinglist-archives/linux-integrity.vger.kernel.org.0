Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7A59EF15
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiHWW1R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiHWW0c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242A688DDE
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so13452027pgb.4
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CjxJi9TTVzrhKmR0dMDUFi/aZbnZh7uPhnmy0S+xHdc=;
        b=QFszdE5Wy3Dr50V8t8pXzFM0sp22mLURcuz9K3HPyNHCu0xRIHcrs/tld6X8vPwWIL
         8na3dT9/hizlNOnmuu5L7404SkmzwN1xPmrDZJO1AmVMXtHBAFYtBOpAK/bpIF/RNdcG
         qvRkqYsR1UuXsLbXE2YImebuI9j0M+7XnIodk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CjxJi9TTVzrhKmR0dMDUFi/aZbnZh7uPhnmy0S+xHdc=;
        b=rguAUUvvG7GHMmRsP2QoTa0KBX9Bezsuibd3mc59NIOv5nnp/4FelsLtt9zfQ9eiI1
         4ILHo9R7phtajjXcd36WIeFi4q2QEVk/Cy6Z0cnEHA+9O5S5GHIVfT4TiRfASM9Dn/XT
         66gfDWO3Fy5R0WNR7tbMNT/hU52dqNev72Z+dPoa1fLsQaL0ivmacdVTlA18FHlJ0Z5r
         WBfXLsfNQWbolwr9US8jzvZcud9SeatxpqaxLuH/KBqsDU+2sNSeomCRM3DhSxtIfwR/
         ZRRT/NKmb8WvC52r7ERDgwNG7lWRXp2H5tBBBOWoxxS9L59y35U8W8/3SCcDKL4B2G4A
         UKww==
X-Gm-Message-State: ACgBeo14PbIqqEjoku05p1zjNZjO2j59H/akS+L5+dsy+nLT+mPx6S3o
        yxNzSRypQs9dg1betvcQLntPZA==
X-Google-Smtp-Source: AA6agR7ZgA60OpCrE0PJSW682FCZasL0ll6+eSPXlpbjkTdjeSClPUzZjxsc2O7rkXGoCxuKuB0T9Q==
X-Received: by 2002:a63:3586:0:b0:42a:20f7:a5d8 with SMTP id c128-20020a633586000000b0042a20f7a5d8mr20372699pga.4.1661293575424;
        Tue, 23 Aug 2022 15:26:15 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b0052f20d70845sm11256292pfa.150.2022.08.23.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 15:26:15 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Evan Green <evgreen@chromium.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 06/10] PM: hibernate: Add kernel-based encryption
Date:   Tue, 23 Aug 2022 15:25:22 -0700
Message-Id: <20220823152108.v2.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220823222526.1524851-1-evgreen@chromium.org>
References: <20220823222526.1524851-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Enabling the kernel to be able to do encryption and integrity checks on
the hibernate image prevents a malicious userspace from escalating to
kernel execution via hibernation resume. As a first step toward this, add
the scaffolding needed for the kernel to do AEAD encryption on the
hibernate image, giving us both secrecy and integrity.

We currently hardwire the encryption to be gcm(aes) in 16-page chunks.
This strikes a balance between minimizing the authentication tag
overhead on storage, and keeping a modest sized staging buffer. With
this chunk size, we'd generate 2MB of authentication tag data on an 8GB
hiberation image.

The encryption currently sits on top of the core snapshot functionality,
wired up only if requested in the uswsusp path. This could potentially
be lowered into the common snapshot code given a mechanism to stitch the
key contents into the image itself.

To avoid forcing usermode to deal with sequencing the auth tags in with
the data, we stitch the auth tags in to the snapshot after each chunk of
pages. This complicates the read and write functions, as we roll through
the flow of (for read) 1) fill the staging buffer with encrypted data,
2) feed the data pages out to user mode, 3) feed the tag out to user
mode. To avoid having each syscall return a small and variable amount
of data, the encrypted versions of read and write operate in a loop,
allowing an arbitrary amount of data through per syscall.

One alternative that would simplify things here would be a streaming
interface to AEAD. Then we could just stream the entire hibernate image
through directly, and handle a single tag at the end. However there is a
school of thought that suggests a streaming interface to AEAD represents
a loaded footgun, as it tempts the caller to act on the decrypted but
not yet verified data, defeating the purpose of AEAD.

With this change alone, we don't actually protect ourselves from
malicious userspace at all, since we kindly hand the key in plaintext
to usermode. In later changes, we'll seal the key with the TPM
before handing it back to usermode, so they can't decrypt or tamper with
the key themselves.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

(no changes since v1)

 Documentation/power/userland-swsusp.rst |   8 +
 include/uapi/linux/suspend_ioctls.h     |  15 +-
 kernel/power/Kconfig                    |  13 +
 kernel/power/Makefile                   |   1 +
 kernel/power/snapenc.c                  | 491 ++++++++++++++++++++++++
 kernel/power/user.c                     |  40 +-
 kernel/power/user.h                     | 101 +++++
 7 files changed, 657 insertions(+), 12 deletions(-)
 create mode 100644 kernel/power/snapenc.c
 create mode 100644 kernel/power/user.h

diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 1cf62d80a9ca10..f759915a78ce98 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -115,6 +115,14 @@ SNAPSHOT_S2RAM
 	to resume the system from RAM if there's enough battery power or restore
 	its state on the basis of the saved suspend image otherwise)
 
+SNAPSHOT_ENABLE_ENCRYPTION
+	Enables encryption of the hibernate image within the kernel. Upon suspend
+	(ie when the snapshot device was opened for reading), returns a blob
+	representing the random encryption key the kernel created to encrypt the
+	hibernate image with. Upon resume (ie when the snapshot device was opened
+	for writing), receives a blob from usermode containing the key material
+	previously returned during hibernate.
+
 The device's read() operation can be used to transfer the snapshot image from
 the kernel.  It has the following limitations:
 
diff --git a/include/uapi/linux/suspend_ioctls.h b/include/uapi/linux/suspend_ioctls.h
index bcce04e21c0dce..b73026ef824bb9 100644
--- a/include/uapi/linux/suspend_ioctls.h
+++ b/include/uapi/linux/suspend_ioctls.h
@@ -13,6 +13,18 @@ struct resume_swap_area {
 	__u32 dev;
 } __attribute__((packed));
 
+#define USWSUSP_KEY_NONCE_SIZE 16
+
+/*
+ * This structure is used to pass the kernel's hibernate encryption key in
+ * either direction.
+ */
+struct uswsusp_key_blob {
+	__u32 blob_len;
+	__u8 blob[512];
+	__u8 nonce[USWSUSP_KEY_NONCE_SIZE];
+} __attribute__((packed));
+
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
 #define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
@@ -29,6 +41,7 @@ struct resume_swap_area {
 #define SNAPSHOT_PREF_IMAGE_SIZE	_IO(SNAPSHOT_IOC_MAGIC, 18)
 #define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 19, __kernel_loff_t)
 #define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 20, __kernel_loff_t)
-#define SNAPSHOT_IOC_MAXNR	20
+#define SNAPSHOT_ENABLE_ENCRYPTION	_IOWR(SNAPSHOT_IOC_MAGIC, 21, struct uswsusp_key_blob)
+#define SNAPSHOT_IOC_MAXNR	21
 
 #endif /* _LINUX_SUSPEND_IOCTLS_H */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 60a1d3051cc79a..cd574af0b43379 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -92,6 +92,19 @@ config HIBERNATION_SNAPSHOT_DEV
 
 	  If in doubt, say Y.
 
+config ENCRYPTED_HIBERNATION
+	bool "Encryption support for userspace snapshots"
+	depends on HIBERNATION_SNAPSHOT_DEV
+	depends on CRYPTO_AEAD2=y
+	default n
+	help
+	  Enable support for kernel-based encryption of hibernation snapshots
+	  created by uswsusp tools.
+
+	  Say N if userspace handles the image encryption.
+
+	  If in doubt, say N.
+
 config PM_STD_PARTITION
 	string "Default resume partition"
 	depends on HIBERNATION
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 874ad834dc8daf..7be08f2e0e3b68 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o
 obj-$(CONFIG_HIBERNATION_SNAPSHOT_DEV) += user.o
+obj-$(CONFIG_ENCRYPTED_HIBERNATION) += snapenc.o
 obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
 obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 
diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
new file mode 100644
index 00000000000000..cb90692d6ab83a
--- /dev/null
+++ b/kernel/power/snapenc.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* This file provides encryption support for system snapshots. */
+
+#include <linux/crypto.h>
+#include <crypto/aead.h>
+#include <crypto/gcm.h>
+#include <linux/random.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+
+#include "power.h"
+#include "user.h"
+
+/* Encrypt more data from the snapshot into the staging area. */
+static int snapshot_encrypt_refill(struct snapshot_data *data)
+{
+
+	u8 nonce[GCM_AES_IV_SIZE];
+	int pg_idx;
+	int res;
+	struct aead_request *req = data->aead_req;
+	DECLARE_CRYPTO_WAIT(wait);
+	size_t total = 0;
+
+	/*
+	 * The first buffer is the associated data, set to the offset to prevent
+	 * attacks that rearrange chunks.
+	 */
+	sg_set_buf(&data->sg[0], &data->crypt_total, sizeof(data->crypt_total));
+
+	/* Load the crypt buffer with snapshot pages. */
+	for (pg_idx = 0; pg_idx < CHUNK_SIZE; pg_idx++) {
+		void *buf = data->crypt_pages[pg_idx];
+
+		res = snapshot_read_next(&data->handle);
+		if (res < 0)
+			return res;
+		if (res == 0)
+			break;
+
+		WARN_ON(res != PAGE_SIZE);
+
+		/*
+		 * Copy the page into the staging area. A future optimization
+		 * could potentially skip this copy for lowmem pages.
+		 */
+		memcpy(buf, data_of(data->handle), PAGE_SIZE);
+		sg_set_buf(&data->sg[1 + pg_idx], buf, PAGE_SIZE);
+		total += PAGE_SIZE;
+	}
+
+	sg_set_buf(&data->sg[1 + pg_idx], &data->auth_tag, SNAPSHOT_AUTH_TAG_SIZE);
+	aead_request_set_callback(req, 0, crypto_req_done, &wait);
+	/*
+	 * Use incrementing nonces for each chunk, since a 64 bit value won't
+	 * roll into re-use for any given hibernate image.
+	 */
+	memcpy(&nonce[0], &data->nonce_low, sizeof(data->nonce_low));
+	memcpy(&nonce[sizeof(data->nonce_low)],
+	       &data->nonce_high,
+	       sizeof(nonce) - sizeof(data->nonce_low));
+
+	data->nonce_low += 1;
+	/* Total does not include AAD or the auth tag. */
+	aead_request_set_crypt(req, data->sg, data->sg, total, nonce);
+	res = crypto_wait_req(crypto_aead_encrypt(req), &wait);
+	if (res)
+		return res;
+
+	data->crypt_size = total;
+	data->crypt_total += total;
+	return 0;
+}
+
+/* Decrypt data from the staging area and push it to the snapshot. */
+static int snapshot_decrypt_drain(struct snapshot_data *data)
+{
+	u8 nonce[GCM_AES_IV_SIZE];
+	int page_count;
+	int pg_idx;
+	int res;
+	struct aead_request *req = data->aead_req;
+	DECLARE_CRYPTO_WAIT(wait);
+	size_t total;
+
+	/* Set up the associated data. */
+	sg_set_buf(&data->sg[0], &data->crypt_total, sizeof(data->crypt_total));
+
+	/*
+	 * Get the number of full pages, which could be short at the end. There
+	 * should also be a tag at the end, so the offset won't be an even page.
+	 */
+	page_count = data->crypt_offset >> PAGE_SHIFT;
+	total = page_count << PAGE_SHIFT;
+	if ((total == 0) || (total == data->crypt_offset))
+		return -EINVAL;
+
+	/*
+	 * Load the sg list with the crypt buffer. Inline decrypt back into the
+	 * staging buffer. A future optimization could decrypt directly into
+	 * lowmem pages.
+	 */
+	for (pg_idx = 0; pg_idx < page_count; pg_idx++)
+		sg_set_buf(&data->sg[1 + pg_idx], data->crypt_pages[pg_idx], PAGE_SIZE);
+
+	/*
+	 * It's possible this is the final decrypt, and there are fewer than
+	 * CHUNK_SIZE pages. If this is the case we would have just written the
+	 * auth tag into the first few bytes of a new page. Copy to the tag if
+	 * so.
+	 */
+	if ((page_count < CHUNK_SIZE) &&
+	    (data->crypt_offset - total) == sizeof(data->auth_tag)) {
+
+		memcpy(data->auth_tag,
+			data->crypt_pages[pg_idx],
+			sizeof(data->auth_tag));
+
+	} else if (data->crypt_offset !=
+		   ((CHUNK_SIZE << PAGE_SHIFT) + SNAPSHOT_AUTH_TAG_SIZE)) {
+
+		return -EINVAL;
+	}
+
+	sg_set_buf(&data->sg[1 + pg_idx], &data->auth_tag, SNAPSHOT_AUTH_TAG_SIZE);
+	aead_request_set_callback(req, 0, crypto_req_done, &wait);
+	memcpy(&nonce[0], &data->nonce_low, sizeof(data->nonce_low));
+	memcpy(&nonce[sizeof(data->nonce_low)],
+	       &data->nonce_high,
+	       sizeof(nonce) - sizeof(data->nonce_low));
+
+	data->nonce_low += 1;
+	aead_request_set_crypt(req, data->sg, data->sg, total + SNAPSHOT_AUTH_TAG_SIZE, nonce);
+	res = crypto_wait_req(crypto_aead_decrypt(req), &wait);
+	if (res)
+		return res;
+
+	data->crypt_size = 0;
+	data->crypt_offset = 0;
+
+	/* Push the decrypted pages further down the stack. */
+	total = 0;
+	for (pg_idx = 0; pg_idx < page_count; pg_idx++) {
+		void *buf = data->crypt_pages[pg_idx];
+
+		res = snapshot_write_next(&data->handle);
+		if (res < 0)
+			return res;
+		if (res == 0)
+			break;
+
+		if (!data_of(data->handle))
+			return -EINVAL;
+
+		WARN_ON(res != PAGE_SIZE);
+
+		/*
+		 * Copy the page into the staging area. A future optimization
+		 * could potentially skip this copy for lowmem pages.
+		 */
+		memcpy(data_of(data->handle), buf, PAGE_SIZE);
+		total += PAGE_SIZE;
+	}
+
+	data->crypt_total += total;
+	return 0;
+}
+
+static ssize_t snapshot_read_next_encrypted(struct snapshot_data *data,
+					    void **buf)
+{
+	size_t tag_off;
+
+	/* Refill the encrypted buffer if it's empty. */
+	if ((data->crypt_size == 0) ||
+	    (data->crypt_offset >=
+	     (data->crypt_size + SNAPSHOT_AUTH_TAG_SIZE))) {
+
+		int rc;
+
+		data->crypt_size = 0;
+		data->crypt_offset = 0;
+		rc = snapshot_encrypt_refill(data);
+		if (rc < 0)
+			return rc;
+	}
+
+	/* Return data pages if the offset is in that region. */
+	if (data->crypt_offset < data->crypt_size) {
+		size_t pg_idx = data->crypt_offset >> PAGE_SHIFT;
+		size_t pg_off = data->crypt_offset & (PAGE_SIZE - 1);
+		*buf = data->crypt_pages[pg_idx] + pg_off;
+		return PAGE_SIZE - pg_off;
+	}
+
+	/* Use offsets just beyond the size to return the tag. */
+	tag_off = data->crypt_offset - data->crypt_size;
+	if (tag_off > SNAPSHOT_AUTH_TAG_SIZE)
+		tag_off = SNAPSHOT_AUTH_TAG_SIZE;
+
+	*buf = data->auth_tag + tag_off;
+	return SNAPSHOT_AUTH_TAG_SIZE - tag_off;
+}
+
+static ssize_t snapshot_write_next_encrypted(struct snapshot_data *data,
+					     void **buf)
+{
+	size_t tag_off;
+
+	/* Return data pages if the offset is in that region. */
+	if (data->crypt_offset < (PAGE_SIZE * CHUNK_SIZE)) {
+		size_t pg_idx = data->crypt_offset >> PAGE_SHIFT;
+		size_t pg_off = data->crypt_offset & (PAGE_SIZE - 1);
+		*buf = data->crypt_pages[pg_idx] + pg_off;
+		return PAGE_SIZE - pg_off;
+	}
+
+	/* Use offsets just beyond the size to return the tag. */
+	tag_off = data->crypt_offset - (PAGE_SIZE * CHUNK_SIZE);
+	if (tag_off > SNAPSHOT_AUTH_TAG_SIZE)
+		tag_off = SNAPSHOT_AUTH_TAG_SIZE;
+
+	*buf = data->auth_tag + tag_off;
+	return SNAPSHOT_AUTH_TAG_SIZE - tag_off;
+}
+
+ssize_t snapshot_read_encrypted(struct snapshot_data *data,
+	char __user *buf, size_t count, loff_t *offp)
+{
+	ssize_t total = 0;
+
+	/* Loop getting buffers of varying sizes and copying to userspace. */
+	while (count) {
+		size_t copy_size;
+		size_t not_done;
+		void *src;
+		ssize_t src_size = snapshot_read_next_encrypted(data, &src);
+
+		if (src_size <= 0) {
+			if (total == 0)
+				return src_size;
+
+			break;
+		}
+
+		copy_size = min(count, (size_t)src_size);
+		not_done = copy_to_user(buf + total, src, copy_size);
+		copy_size -= not_done;
+		total += copy_size;
+		count -= copy_size;
+		data->crypt_offset += copy_size;
+		if (copy_size == 0) {
+			if (total == 0)
+				return -EFAULT;
+
+			break;
+		}
+	}
+
+	*offp += total;
+	return total;
+}
+
+ssize_t snapshot_write_encrypted(struct snapshot_data *data,
+	const char __user *buf, size_t count, loff_t *offp)
+{
+	ssize_t total = 0;
+
+	/* Loop getting buffers of varying sizes and copying from. */
+	while (count) {
+		size_t copy_size;
+		size_t not_done;
+		void *dst;
+		ssize_t dst_size = snapshot_write_next_encrypted(data, &dst);
+
+		if (dst_size <= 0) {
+			if (total == 0)
+				return dst_size;
+
+			break;
+		}
+
+		copy_size = min(count, (size_t)dst_size);
+		not_done = copy_from_user(dst, buf + total, copy_size);
+		copy_size -= not_done;
+		total += copy_size;
+		count -= copy_size;
+		data->crypt_offset += copy_size;
+		if (copy_size == 0) {
+			if (total == 0)
+				return -EFAULT;
+
+			break;
+		}
+
+		/* Drain the encrypted buffer if it's full. */
+		if ((data->crypt_offset >=
+		    ((PAGE_SIZE * CHUNK_SIZE) + SNAPSHOT_AUTH_TAG_SIZE))) {
+
+			int rc;
+
+			rc = snapshot_decrypt_drain(data);
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	*offp += total;
+	return total;
+}
+
+void snapshot_teardown_encryption(struct snapshot_data *data)
+{
+	int i;
+
+	if (data->aead_req) {
+		aead_request_free(data->aead_req);
+		data->aead_req = NULL;
+	}
+
+	if (data->aead_tfm) {
+		crypto_free_aead(data->aead_tfm);
+		data->aead_tfm = NULL;
+	}
+
+	for (i = 0; i < CHUNK_SIZE; i++) {
+		if (data->crypt_pages[i]) {
+			free_page((unsigned long)data->crypt_pages[i]);
+			data->crypt_pages[i] = NULL;
+		}
+	}
+}
+
+static int snapshot_setup_encryption_common(struct snapshot_data *data)
+{
+	int i, rc;
+
+	data->crypt_total = 0;
+	data->crypt_offset = 0;
+	data->crypt_size = 0;
+	memset(data->crypt_pages, 0, sizeof(data->crypt_pages));
+	/* This only works once per hibernate. */
+	if (data->aead_tfm)
+		return -EINVAL;
+
+	/* Set up the encryption transform */
+	data->aead_tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+	if (IS_ERR(data->aead_tfm)) {
+		rc = PTR_ERR(data->aead_tfm);
+		data->aead_tfm = NULL;
+		return rc;
+	}
+
+	rc = -ENOMEM;
+	data->aead_req = aead_request_alloc(data->aead_tfm, GFP_KERNEL);
+	if (data->aead_req == NULL)
+		goto setup_fail;
+
+	/* Allocate the staging area */
+	for (i = 0; i < CHUNK_SIZE; i++) {
+		data->crypt_pages[i] = (void *)__get_free_page(GFP_ATOMIC);
+		if (data->crypt_pages[i] == NULL)
+			goto setup_fail;
+	}
+
+	sg_init_table(data->sg, CHUNK_SIZE + 2);
+
+	/*
+	 * The associated data will be the offset so that blocks can't be
+	 * rearranged.
+	 */
+	aead_request_set_ad(data->aead_req, sizeof(data->crypt_total));
+	rc = crypto_aead_setauthsize(data->aead_tfm, SNAPSHOT_AUTH_TAG_SIZE);
+	if (rc)
+		goto setup_fail;
+
+	return 0;
+
+setup_fail:
+	snapshot_teardown_encryption(data);
+	return rc;
+}
+
+int snapshot_get_encryption_key(struct snapshot_data *data,
+	struct uswsusp_key_blob __user *key)
+{
+	u8 aead_key[SNAPSHOT_ENCRYPTION_KEY_SIZE];
+	u8 nonce[USWSUSP_KEY_NONCE_SIZE];
+	int rc;
+	/* Don't pull a random key from a world that can be reset. */
+	if (data->ready)
+		return -EPIPE;
+
+	rc = snapshot_setup_encryption_common(data);
+	if (rc)
+		return rc;
+
+	/* Build a random starting nonce. */
+	get_random_bytes(nonce, sizeof(nonce));
+	memcpy(&data->nonce_low, &nonce[0], sizeof(data->nonce_low));
+	memcpy(&data->nonce_high, &nonce[8], sizeof(data->nonce_high));
+	/* Build a random key */
+	get_random_bytes(aead_key, sizeof(aead_key));
+	rc = crypto_aead_setkey(data->aead_tfm, aead_key, sizeof(aead_key));
+	if (rc)
+		goto fail;
+
+	/* Hand the key back to user mode (to be changed!) */
+	rc = put_user(sizeof(struct uswsusp_key_blob), &key->blob_len);
+	if (rc)
+		goto fail;
+
+	rc = copy_to_user(&key->blob, &aead_key, sizeof(aead_key));
+	if (rc)
+		goto fail;
+
+	rc = copy_to_user(&key->nonce, &nonce, sizeof(nonce));
+	if (rc)
+		goto fail;
+
+	return 0;
+
+fail:
+	snapshot_teardown_encryption(data);
+	return rc;
+}
+
+int snapshot_set_encryption_key(struct snapshot_data *data,
+	struct uswsusp_key_blob __user *key)
+{
+	struct uswsusp_key_blob blob;
+	int rc;
+
+	/* It's too late if data's been pushed in. */
+	if (data->handle.cur)
+		return -EPIPE;
+
+	rc = snapshot_setup_encryption_common(data);
+	if (rc)
+		return rc;
+
+	/* Load the key from user mode. */
+	rc = copy_from_user(&blob, key, sizeof(struct uswsusp_key_blob));
+	if (rc)
+		goto crypto_setup_fail;
+
+	if (blob.blob_len != sizeof(struct uswsusp_key_blob)) {
+		rc = -EINVAL;
+		goto crypto_setup_fail;
+	}
+
+	rc = crypto_aead_setkey(data->aead_tfm,
+				blob.blob,
+				SNAPSHOT_ENCRYPTION_KEY_SIZE);
+
+	if (rc)
+		goto crypto_setup_fail;
+
+	/* Load the starting nonce. */
+	memcpy(&data->nonce_low, &blob.nonce[0], sizeof(data->nonce_low));
+	memcpy(&data->nonce_high, &blob.nonce[8], sizeof(data->nonce_high));
+	return 0;
+
+crypto_setup_fail:
+	snapshot_teardown_encryption(data);
+	return rc;
+}
+
+loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+{
+	loff_t pages = raw_size >> PAGE_SHIFT;
+	loff_t chunks = (pages + (CHUNK_SIZE - 1)) / CHUNK_SIZE;
+	/*
+	 * The encrypted size is the normal size, plus a stitched in
+	 * authentication tag for every chunk of pages.
+	 */
+	return raw_size + (chunks * SNAPSHOT_AUTH_TAG_SIZE);
+}
+
+int snapshot_finalize_decrypted_image(struct snapshot_data *data)
+{
+	int rc;
+
+	if (data->crypt_offset != 0) {
+		rc = snapshot_decrypt_drain(data);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d43c2aa583b26b..348e55f623b7e1 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -25,19 +25,10 @@
 #include <linux/uaccess.h>
 
 #include "power.h"
+#include "user.h"
 
 static bool need_wait;
-
-static struct snapshot_data {
-	struct snapshot_handle handle;
-	int swap;
-	int mode;
-	bool frozen;
-	bool ready;
-	bool platform_support;
-	bool free_bitmaps;
-	dev_t dev;
-} snapshot_state;
+struct snapshot_data snapshot_state;
 
 int is_hibernate_resume_dev(dev_t dev)
 {
@@ -120,6 +111,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	} else if (data->free_bitmaps) {
 		free_basic_memory_bitmaps();
 	}
+	snapshot_teardown_encryption(data);
 	pm_notifier_call_chain(data->mode == O_RDONLY ?
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	hibernate_release();
@@ -143,6 +135,12 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		res = -ENODATA;
 		goto Unlock;
 	}
+
+	if (snapshot_encryption_enabled(data)) {
+		res = snapshot_read_encrypted(data, buf, count, offp);
+		goto Unlock;
+	}
+
 	if (!pg_offp) { /* on page boundary? */
 		res = snapshot_read_next(&data->handle);
 		if (res <= 0)
@@ -178,6 +176,11 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	data = filp->private_data;
 
+	if (snapshot_encryption_enabled(data)) {
+		res = snapshot_write_encrypted(data, buf, count, offp);
+		goto unlock;
+	}
+
 	if (!pg_offp) {
 		res = snapshot_write_next(&data->handle);
 		if (res <= 0)
@@ -313,6 +316,12 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
+		if (snapshot_encryption_enabled(data)) {
+			error = snapshot_finalize_decrypted_image(data);
+			if (error)
+				break;
+		}
+
 		snapshot_write_finalize(&data->handle);
 		if (data->mode != O_WRONLY || !data->frozen ||
 		    !snapshot_image_loaded(&data->handle)) {
@@ -348,6 +357,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		}
 		size = snapshot_get_image_size();
 		size <<= PAGE_SHIFT;
+		if (snapshot_encryption_enabled(data))
+			size = snapshot_get_encrypted_image_size(size);
 		error = put_user(size, (loff_t __user *)arg);
 		break;
 
@@ -405,6 +416,13 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		error = snapshot_set_swap_area(data, (void __user *)arg);
 		break;
 
+	case SNAPSHOT_ENABLE_ENCRYPTION:
+		if (data->mode == O_RDONLY)
+			error = snapshot_get_encryption_key(data, (void __user *)arg);
+		else
+			error = snapshot_set_encryption_key(data, (void __user *)arg);
+		break;
+
 	default:
 		error = -ENOTTY;
 
diff --git a/kernel/power/user.h b/kernel/power/user.h
new file mode 100644
index 00000000000000..6823e2eba7ec53
--- /dev/null
+++ b/kernel/power/user.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/crypto.h>
+#include <crypto/aead.h>
+#include <crypto/aes.h>
+
+#define SNAPSHOT_ENCRYPTION_KEY_SIZE AES_KEYSIZE_128
+#define SNAPSHOT_AUTH_TAG_SIZE 16
+
+/* Define the number of pages in a single AEAD encryption chunk. */
+#define CHUNK_SIZE 16
+
+struct snapshot_data {
+	struct snapshot_handle handle;
+	int swap;
+	int mode;
+	bool frozen;
+	bool ready;
+	bool platform_support;
+	bool free_bitmaps;
+	dev_t dev;
+
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+	struct crypto_aead *aead_tfm;
+	struct aead_request *aead_req;
+	void *crypt_pages[CHUNK_SIZE];
+	u8 auth_tag[SNAPSHOT_AUTH_TAG_SIZE];
+	struct scatterlist sg[CHUNK_SIZE + 2]; /* Add room for AD and auth tag. */
+	size_t crypt_offset;
+	size_t crypt_size;
+	uint64_t crypt_total;
+	uint64_t nonce_low;
+	uint64_t nonce_high;
+#endif
+
+};
+
+extern struct snapshot_data snapshot_state;
+
+/* kernel/power/swapenc.c routines */
+#if defined(CONFIG_ENCRYPTED_HIBERNATION)
+
+ssize_t snapshot_read_encrypted(struct snapshot_data *data,
+	char __user *buf, size_t count, loff_t *offp);
+
+ssize_t snapshot_write_encrypted(struct snapshot_data *data,
+	const char __user *buf, size_t count, loff_t *offp);
+
+void snapshot_teardown_encryption(struct snapshot_data *data);
+int snapshot_get_encryption_key(struct snapshot_data *data,
+	struct uswsusp_key_blob __user *key);
+
+int snapshot_set_encryption_key(struct snapshot_data *data,
+	struct uswsusp_key_blob __user *key);
+
+loff_t snapshot_get_encrypted_image_size(loff_t raw_size);
+
+int snapshot_finalize_decrypted_image(struct snapshot_data *data);
+
+#define snapshot_encryption_enabled(data) (!!(data)->aead_tfm)
+
+#else
+
+ssize_t snapshot_read_encrypted(struct snapshot_data *data,
+	char __user *buf, size_t count, loff_t *offp)
+{
+	return -ENOTTY;
+}
+
+ssize_t snapshot_write_encrypted(struct snapshot_data *data,
+	const char __user *buf, size_t count, loff_t *offp)
+{
+	return -ENOTTY;
+}
+
+static void snapshot_teardown_encryption(struct snapshot_data *data) {}
+static int snapshot_get_encryption_key(struct snapshot_data *data,
+	struct uswsusp_key_blob __user *key)
+{
+	return -ENOTTY;
+}
+
+static int snapshot_set_encryption_key(struct snapshot_data *data,
+	struct uswsusp_key_blob __user *key)
+{
+	return -ENOTTY;
+}
+
+static loff_t snapshot_get_encrypted_image_size(loff_t raw_size)
+{
+	return raw_size;
+}
+
+static int snapshot_finalize_decrypted_image(struct snapshot_data *data)
+{
+	return -ENOTTY;
+}
+
+#define snapshot_encryption_enabled(data) (0)
+
+#endif
-- 
2.31.0

