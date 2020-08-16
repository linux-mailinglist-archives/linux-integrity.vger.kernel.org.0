Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39393245993
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Aug 2020 23:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgHPVDH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Aug 2020 17:03:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33740 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgHPVDB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Aug 2020 17:03:01 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 89E2620B490A;
        Sun, 16 Aug 2020 14:02:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89E2620B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597611778;
        bh=3F3pGwFs/FfHJdd+NYSJVt7BcPOG6KmXuIKFRxO8pkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JG/EE/jiEOFphl35wPpWa8252bqZrRemQoLD+otCXSvGYK4hofz2aYnAvenTfIIZ+
         gXDBqsegsI8F/+ZrbbuUuhZyWHuUGWd812twB9bViBwj9dmDyQz505KxOCTOquOXfU
         DGkvqMR6YH/bsA2GOVnxJRRXvhw6LiTUJWJdsKJw=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 1/2] dm-devel: collect target data and submit to IMA to measure
Date:   Sun, 16 Aug 2020 14:02:49 -0700
Message-Id: <20200816210250.11506-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200816210250.11506-1-tusharsu@linux.microsoft.com>
References: <20200816210250.11506-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For the device-mapper targets to take advantage of IMA's measuring and
quoting abilities, and for enabling remote attestation for device-mapper
targets, device-mapper needs to provide the functionality to
consistently measure target data using ima_measure_critical_data()
function provided by IMA. A generic set of functions at device-mapper
layer would enable the measurement structure to be uniform across
targets, and avoid code duplication. It will also make on-boarding
easier and faster for targets that want to use IMA infrastructure for
measurements, quoting, and remote attestation. The uniform measurement
structure across targets would also help the remote attestation services
to consistently process, across targets, the measurement to be attested.

Implement a set of functions at device-mapper layer to manage the data
coming from various device-mapper targets to be measured by IMA.

Provide the functionality for various tasks - initialize the necessary
data structures, add the data to the list of key-value pairs to be be
measured, reset the list if needed (e.g. in error/retry cases), and
finally pass it on to device-mapper layer, to be measured by IMA.

Ensure the functionality is generic and implemented at device-mapper
layer, so that any device-mapper target can use it to measure its data
through IMA.

Also make sure the functionality is non-intrusive/best effort for the
targets using it. The errors in managing the list to be measured, and
the actual errors in the measurement should not disrupt the core
functionality of the targets.

Protect the list of key value pairs to be measured for a given target,
by putting it under critical sections - so that multi-threaded targets
can safely use the list to append the data from different threads, for
measurements and quoting.

Compute the last measurement's hash and store it internally, so that
unnecessary duplicate data is not sent to IMA for measurements.

Divide the functionality into 5 main functions:
(1) dm_ima_init_measurements(): Use it to initialize device-mapper
target's ima measurement list. It should abstract the necessary data
initialization from the device-mapper target apps.

(2) dm_ima_append_measurement_list(): Use it to append the key-value
pair to the existing list of key-value pairs to measure.

(3) dm_ima_finalize_and_measure(): Use it to measure the key-value pair
list for a given target, and finally release the resources held by the
list for that specific target.

Note that the data given by the target for a given device would be
sent to IMA subsystem for measurement only if it has changed since the
last time it was measured.

(4) dm_ima_reset_measurement_list(): Use it to reset device-mapper
target's ima measurement list, by releasing the resources held by the
list. Use it if the measurements list need to be reset after
dm_ima_init_measurements() and before calling
dm_ima_finalize_and_measure().

This can be needed in scenarios like recovering from error paths and
retrying measurements and quoting again.

(5) dm_ima_exit_measurements(): Use it during the destruction of the
target - to release the resources held for measurement. This is useful
to protect the kernel from possible resource leaks when the target adds
data for measurements using dm_ima_append_measurement_list(), but gets
destroyed before calling dm_ima_finalize_and_measure().

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/Makefile           |   1 +
 drivers/md/dm-ima.c           | 296 ++++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  58 +++++++
 3 files changed, 355 insertions(+)
 create mode 100644 drivers/md/dm-ima.c

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 31840f95cd40..cedecddec7a2 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_DM_LOG_WRITES)	+= dm-log-writes.o
 obj-$(CONFIG_DM_INTEGRITY)	+= dm-integrity.o
 obj-$(CONFIG_DM_ZONED)		+= dm-zoned.o
 obj-$(CONFIG_DM_WRITECACHE)	+= dm-writecache.o
+obj-$(CONFIG_IMA)		+= dm-ima.o
 
 ifeq ($(CONFIG_DM_INIT),y)
 dm-mod-objs			+= dm-init.o
diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
new file mode 100644
index 000000000000..81372caa6747
--- /dev/null
+++ b/drivers/md/dm-ima.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Microsoft Corporation
+ *
+ * Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+ *
+ * File: dm-ima.c
+ *       Enables IMA measurements for DM targets
+ */
+
+#include "dm-core.h"
+
+#include <linux/ima.h>
+#include <linux/device-mapper.h>
+#include <crypto/hash.h>
+#include <linux/crypto.h>
+#include <crypto/hash_info.h>
+
+#define DM_MSG_PREFIX "ima"
+
+static int dm_compute_buffer_hash(void *buf,
+				  size_t buf_len,
+				  void **buf_hash,
+				  int *buf_hash_len)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc = NULL;
+	void *digest = NULL;
+	int desc_size;
+	int digest_size;
+	int ret = 0;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+	digest_size = crypto_shash_digestsize(tfm);
+
+	digest = kmalloc(digest_size, GFP_KERNEL);
+	if (!digest) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	desc->tfm = tfm;
+
+	ret = crypto_shash_digest(desc, buf, buf_len, digest);
+	if (ret < 0)
+		goto error;
+
+	*buf_hash_len = digest_size;
+	*buf_hash = digest;
+	digest = NULL;
+
+error:
+	kfree(desc);
+	kfree(digest);
+
+	crypto_free_shash(tfm);
+
+	return ret;
+}
+
+static void dm_release_ima_measurements(struct list_head
+					*ima_kv_list)
+{
+	struct ima_keyval *cur_keyval, *tmp_keyval;
+
+	list_for_each_entry_safe(cur_keyval,
+				 tmp_keyval,
+				 ima_kv_list,
+				 kv_list) {
+
+		list_del(&cur_keyval->kv_list);
+		kzfree(cur_keyval->key);
+		kzfree(cur_keyval->val);
+		kfree(cur_keyval);
+	}
+}
+
+void dm_ima_init_measurements(struct target_type *tt)
+{
+	INIT_LIST_HEAD(&tt->ima_kv_list);
+	mutex_init(&tt->ima_lock);
+	tt->ima_last_buf_hash = NULL;
+	tt->ima_last_buf_hash_len = 0;
+}
+EXPORT_SYMBOL(dm_ima_init_measurements);
+
+void dm_ima_reset_measurement_list(struct target_type *tt)
+{
+	LIST_HEAD(temp_list);
+
+	if (!tt) {
+		DMERR("invalid argument, target_type");
+		return;
+	}
+
+	mutex_lock(&tt->ima_lock);
+	list_cut_before(&temp_list, &tt->ima_kv_list, &tt->ima_kv_list);
+	mutex_unlock(&tt->ima_lock);
+
+	dm_release_ima_measurements(&temp_list);
+}
+EXPORT_SYMBOL(dm_ima_reset_measurement_list);
+
+void dm_ima_append_measurement_list(struct target_type *tt,
+				  const char *key,
+				  const void *val,
+				  unsigned int val_len)
+{
+	struct ima_keyval *cur_keyval = NULL;
+	int r = 0;
+
+	if (!tt || !key || !val || val_len == 0) {
+		r = -EINVAL;
+		goto error;
+	}
+
+	cur_keyval = kzalloc(sizeof(*cur_keyval), GFP_KERNEL);
+	if (!cur_keyval) {
+		r = -ENOMEM;
+		goto error;
+	}
+
+	cur_keyval->key = kstrdup(key, GFP_KERNEL);
+	if (!cur_keyval->key) {
+		r = -ENOMEM;
+		goto error;
+	}
+
+	cur_keyval->val_len = val_len;
+	cur_keyval->val = kmemdup(val, val_len, GFP_KERNEL);
+	if (!cur_keyval->val) {
+		r = -ENOMEM;
+		goto error;
+	}
+
+	INIT_LIST_HEAD(&cur_keyval->kv_list);
+
+	mutex_lock(&tt->ima_lock);
+	list_add(&cur_keyval->kv_list, &tt->ima_kv_list);
+	mutex_unlock(&tt->ima_lock);
+
+	return;
+
+error:
+	if (cur_keyval) {
+		kzfree(cur_keyval->key);
+		kzfree(cur_keyval->val);
+	}
+	kfree(cur_keyval);
+
+	DMERR("failed to append IMA measurement list %d", r);
+}
+EXPORT_SYMBOL(dm_ima_append_measurement_list);
+
+void dm_ima_finalize_and_measure(struct target_type *tt,
+				 const char *buf_desc)
+{
+	char *evt_name = NULL, *evt_src = NULL, *equ = "=", *sep = ";";
+	void *buf = NULL, *buf_hash = NULL, *last_buf_hash = NULL;
+	struct ima_keyval *cur_keyval = NULL, *tmp_keyval = NULL;
+	int cursor = 0, buf_len = 0, cur_keyname_len = 0;
+	int l_sep = strlen(sep), l_equ = strlen(equ);
+	int r = 0, hr = 0, mr = 0;
+	int buf_hash_len = 0;
+	struct timespec64 ts;
+	LIST_HEAD(temp_list);
+
+
+	if (!tt) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	mutex_lock(&tt->ima_lock);
+	if (!list_empty(&tt->ima_kv_list))
+		list_cut_before(&temp_list,
+				&tt->ima_kv_list,
+				&tt->ima_kv_list);
+	else
+		r = -EINVAL;
+
+	last_buf_hash = tt->ima_last_buf_hash;
+	tt->ima_last_buf_hash = NULL;
+	tt->ima_last_buf_hash_len = 0;
+	mutex_unlock(&tt->ima_lock);
+
+	if (r)
+		goto out;
+
+	list_for_each_entry_safe(cur_keyval,
+				 tmp_keyval,
+				 &temp_list,
+				 kv_list)
+		buf_len += strlen(cur_keyval->key) + l_equ +
+			   cur_keyval->val_len + l_sep;
+
+	if (!buf_len) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	list_for_each_entry_safe(cur_keyval,
+				 tmp_keyval,
+				 &temp_list,
+				 kv_list) {
+		cur_keyname_len = strlen(cur_keyval->key);
+		memcpy(buf+cursor, cur_keyval->key, cur_keyname_len);
+		cursor += cur_keyname_len;
+		memcpy(buf+cursor, equ, l_equ);
+		cursor += l_equ;
+		memcpy(buf+cursor, cur_keyval->val, cur_keyval->val_len);
+		cursor += cur_keyval->val_len;
+		memcpy(buf+cursor, sep, l_sep);
+		cursor += l_sep;
+	}
+
+	hr = dm_compute_buffer_hash(buf, buf_len, &buf_hash, &buf_hash_len);
+
+	if (!hr && buf_hash && last_buf_hash)
+		mr = memcmp(buf_hash, last_buf_hash, buf_hash_len);
+
+	if (hr || mr || !last_buf_hash) {
+		ktime_get_real_ts64(&ts);
+
+		evt_src = kasprintf(GFP_KERNEL, "dm-%s", tt->name);
+		if (!evt_src) {
+			r = -ENOMEM;
+			goto out;
+		}
+
+		evt_name = kasprintf(GFP_KERNEL, "%lld:%09ld:%s%s%s",
+				     ts.tv_sec,
+				     ts.tv_nsec,
+				     evt_src,
+				     buf_desc ? ":" : "",
+				     buf_desc ? buf_desc : "");
+
+		if (!evt_name) {
+			r = -ENOMEM;
+			goto out;
+		}
+
+		ima_measure_critical_data((const char *)evt_name,
+					  (const char *)evt_src,
+					  (const void *)buf,
+					  buf_len);
+
+		kzfree(last_buf_hash);
+
+		mutex_lock(&tt->ima_lock);
+		tt->ima_last_buf_hash = buf_hash;
+		tt->ima_last_buf_hash_len = buf_hash_len;
+		mutex_unlock(&tt->ima_lock);
+
+		buf_hash = NULL;
+	}
+
+	dm_release_ima_measurements(&temp_list);
+out:
+	if (r)
+		DMERR("failed to measure DM target data through IMA %d", r);
+
+	kfree(evt_src);
+	kzfree(evt_name);
+	kzfree(buf);
+	kzfree(buf_hash);
+}
+EXPORT_SYMBOL(dm_ima_finalize_and_measure);
+
+void dm_ima_exit_measurements(struct target_type *tt)
+{
+	dm_ima_reset_measurement_list(tt);
+	kzfree(tt->ima_last_buf_hash);
+	mutex_destroy(&tt->ima_lock);
+}
+EXPORT_SYMBOL(dm_ima_exit_measurements);
+
+MODULE_AUTHOR("Tushar Sugandhi <tusharsu@linux.microsoft.com>");
+MODULE_DESCRIPTION("Enables IMA measurements for DM targets");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 8750f2dc5613..5bdd5ed1c17f 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -164,6 +164,18 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		  struct dm_dev **result);
 void dm_put_device(struct dm_target *ti, struct dm_dev *d);
 
+/*
+ * Information about IMA measurement data entry
+ */
+#ifdef CONFIG_IMA
+struct ima_keyval {
+	char *key;
+	void *val;
+	unsigned int val_len;
+	struct list_head kv_list;
+};
+#endif
+
 /*
  * Information about a target type
  */
@@ -199,6 +211,13 @@ struct target_type {
 	dm_dax_copy_iter_fn dax_copy_to_iter;
 	dm_dax_zero_page_range_fn dax_zero_page_range;
 
+#ifdef CONFIG_IMA
+	/* For ima measurements*/
+	struct list_head ima_kv_list;
+	void *ima_last_buf_hash;
+	int ima_last_buf_hash_len;
+	struct mutex ima_lock;
+#endif
 	/* For internal device-mapper use. */
 	struct list_head list;
 };
@@ -543,6 +562,45 @@ struct dm_table *dm_swap_table(struct mapped_device *md,
  */
 void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
 
+/*-----------------------------------------------------------------
+ * Functions for ima measurements.
+ *-----------------------------------------------------------------
+ */
+#ifdef CONFIG_IMA
+void dm_ima_init_measurements(struct target_type *tt);
+
+/*
+ * Reset device mapper target's ima measurement list.
+ * If the measurements list need to be reset after dm_ima_init_measurements()
+ * and before calling dm_ima_finalize_and_measure(), this function should
+ * be called. This can be needed in scenarios like recovering from error
+ * paths and retrying measurements again.
+ */
+void dm_ima_reset_measurement_list(struct target_type *tt);
+
+void dm_ima_append_measurement_list(struct target_type *tt,
+				    const char *key,
+				    const void *val,
+				    unsigned int val_length);
+
+void dm_ima_finalize_and_measure(struct target_type *tt,
+				 const char *buf_desc);
+
+void dm_ima_exit_measurements(struct target_type *tt);
+#else
+static inline void dm_ima_init_measurements(struct target_type *tt) {}
+
+static inline void dm_ima_reset_measurement_list(struct target_type *tt) {}
+
+static inline void dm_ima_append_measurement_list(struct target_type *tt,
+						  const char *key,
+						  const void *val,
+						  unsigned int val_length) {}
+
+static inline void dm_ima_finalize_and_measure(struct target_type *tt,
+					       const char *buf_desc) {}
+static inline void dm_ima_exit_measurements(struct target_type *tt) {}
+#endif /* CONFIG_IMA */
 /*-----------------------------------------------------------------
  * Macros.
  *---------------------------------------------------------------*/
-- 
2.17.1

