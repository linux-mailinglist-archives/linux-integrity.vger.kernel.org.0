Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242053C67A1
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 02:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhGMAwB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 20:52:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53338 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhGMAwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 20:52:01 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4539020B6C14;
        Mon, 12 Jul 2021 17:49:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4539020B6C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626137352;
        bh=ZmNwq3HvrwvHMoqAPe1EKNIzr6GyHLup10tmz7LYaqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIikIR7l6vRTqn+q+Meha1FHXOUFNytLUknJrVbVcbSKSN+zZpx5jcVWwCnt4j+ae
         OGLR9fBanRuv5fJawLUpDWiULVVOsEELP5g+J5+WWhMJQProCTGOI3MmiuF1rhKYJj
         UC6PX5okfK15OnS7QZcowLOH6v/kjPYUJwwcUOMk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com
Subject: [PATCH 1/7] dm: measure data on table load
Date:   Mon, 12 Jul 2021 17:48:58 -0700
Message-Id: <20210713004904.8808-2-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DM configures a block device with various target specific attributes
passed to it as a table.  DM loads the table, and calls each target’s
respective constructors with the attributes as input parameters.
Some of these attributes are critical to ensure the device meets
certain security bar.  Thus, IMA should measure these attributes, to
ensure they are not tampered with, during the lifetime of the device.
So that the external services can have high confidence in the
configuration of the block-devices on a given system.

Some devices may have large tables.  And a given device may change its
state (table-load, suspend, resume, rename, remove, table-clear etc.)
many times.  Measuring these attributes each time when the device 
changes its state will significantly increase the size of the IMA logs.
Further, once configured, these attributes are not expected to change
unless a new table is loaded, or a device is removed and recreated.
Therefore the clear-text of the attributes should only be measured
during table load, and the hash of the active/inactive table should be
measured for the remaining device state changes.

Measure device parameters, as well as target specific attributes, during
table load, using IMA function ima_measure_critical_data().  Compute the
hash of the inactive table and store it for measurements during future
state change.  If a load is called multiple times, update the inactive
table hash with the hash of the latest populated table.  So that the
correct inactive table hash is measured when the device transitions to
different states like resume, remove, rename etc.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/Makefile           |   2 +
 drivers/md/dm-core.h          |   5 +
 drivers/md/dm-ima.c           | 345 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h           |  50 +++++
 drivers/md/dm-ioctl.c         |   7 +-
 drivers/md/dm.c               |   3 +
 include/linux/device-mapper.h |   2 +-
 include/uapi/linux/dm-ioctl.h |   6 +
 8 files changed, 418 insertions(+), 2 deletions(-)
 create mode 100644 drivers/md/dm-ima.c
 create mode 100644 drivers/md/dm-ima.h

diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index ef7ddc27685c..af349b7cbf8b 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -92,6 +92,8 @@ ifeq ($(CONFIG_DM_UEVENT),y)
 dm-mod-objs			+= dm-uevent.o
 endif
 
+dm-mod-objs			+= dm-ima.o
+
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5953ff2bd260..f67f898803db 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -18,6 +18,7 @@
 #include <trace/events/block.h>
 
 #include "dm.h"
+#include "dm-ima.h"
 
 #define DM_RESERVED_MAX_IOS		1024
 
@@ -114,6 +115,10 @@ struct mapped_device {
 	bool init_tio_pdu:1;
 
 	struct srcu_struct io_barrier;
+
+#ifdef CONFIG_IMA
+	struct dm_ima_measurements ima;
+#endif
 };
 
 void disable_discard(struct mapped_device *md);
diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
new file mode 100644
index 000000000000..b752517380c3
--- /dev/null
+++ b/drivers/md/dm-ima.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Microsoft Corporation
+ *
+ * Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+ *
+ * File: dm-ima.c
+ *       Enables IMA measurements for DM targets
+ */
+
+#include "dm-core.h"
+#include "dm-ima.h"
+
+#include <linux/ima.h>
+#include <linux/device-mapper.h>
+#include <crypto/hash.h>
+#include <linux/crypto.h>
+#include <crypto/hash_info.h>
+
+#define DM_MSG_PREFIX "dm-ima"
+
+#ifdef CONFIG_IMA
+/*
+ * Internal function to prefix separator characters in input buffer with escape
+ * character, so that they don't interfere with the construction of key-value pairs,
+ * and clients can split the key1=val1,key2=val2,key3=val3; pairs properly.
+ */
+static void fix_separator_chars(char **buf)
+{
+	int l = strlen(*buf);
+	int i, j, sp = 0;
+
+	for (i = 0; i < l; i++)
+		if ((*buf)[i] == '\\' || (*buf)[i] == ';' || (*buf)[i] == '=' || (*buf)[i] == ',')
+			sp++;
+
+	if (!sp)
+		return;
+
+	for (i = l-1, j = i+sp; i >= 0; i--) {
+		(*buf)[j--] = (*buf)[i];
+		if ((*buf)[i] == '\\' || (*buf)[i] == ';' || (*buf)[i] == '=' || (*buf)[i] == ',')
+			(*buf)[j--] = '\\';
+	}
+}
+
+/*
+ * Internal function to allocate memory for IMA measurements.
+ */
+static void *dm_ima_alloc(size_t len, gfp_t flags, bool noio)
+{
+	unsigned int noio_flag;
+	void *ptr;
+
+	if (noio)
+		noio_flag = memalloc_noio_save();
+
+	ptr = kzalloc(len, flags);
+
+	if (noio)
+		memalloc_noio_restore(noio_flag);
+
+	return ptr;
+}
+
+/*
+ * Internal function to allocate and copy name and uuid for IMA measurements.
+ */
+static int dm_ima_alloc_and_copy_name_uuid(struct mapped_device *md, char **dev_name,
+					   char **dev_uuid, bool noio)
+{
+	int r;
+	*dev_name = dm_ima_alloc(DM_NAME_LEN*2, GFP_KERNEL, noio);
+	if (!(*dev_name)) {
+		r = -ENOMEM;
+		goto error;
+	}
+
+	*dev_uuid = dm_ima_alloc(DM_UUID_LEN*2, GFP_KERNEL, noio);
+	if (!(*dev_uuid)) {
+		r = -ENOMEM;
+		goto error;
+	}
+
+	r = dm_copy_name_and_uuid(md, *dev_name, *dev_uuid);
+	if (r)
+		goto error;
+
+	fix_separator_chars(dev_name);
+	fix_separator_chars(dev_uuid);
+
+	return 0;
+error:
+	kfree(*dev_name);
+	kfree(*dev_uuid);
+	*dev_name = NULL;
+	*dev_uuid = NULL;
+	return r;
+}
+
+/*
+ * Internal function to allocate and copy device data for IMA measurements.
+ */
+static int dm_ima_alloc_and_copy_device_data(struct mapped_device *md, char **device_data,
+					     unsigned int num_targets, bool noio)
+{
+	char *dev_name = NULL, *dev_uuid = NULL;
+	int r;
+
+	r = dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio);
+	if (r)
+		return r;
+
+	*device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, GFP_KERNEL, noio);
+	if (!(*device_data)) {
+		r = -ENOMEM;
+		goto error;
+	}
+
+	scnprintf(*device_data, DM_IMA_DEVICE_BUF_LEN,
+		  "name=%s,uuid=%s,major=%d,minor=%d,minor_count=%d,num_targets=%u;",
+		  dev_name, dev_uuid, md->disk->major, md->disk->first_minor,
+		  md->disk->minors, num_targets);
+
+error:
+	kfree(dev_name);
+	kfree(dev_uuid);
+	return r;
+}
+
+/*
+ * Internal wrapper function to call IMA to measure DM data.
+ */
+static void dm_ima_measure_data(const char *event_name, const void *buf, size_t buf_len,
+				bool noio)
+{
+	unsigned int noio_flag;
+
+	if (noio)
+		noio_flag = memalloc_noio_save();
+
+	ima_measure_critical_data(DM_NAME, event_name, buf, buf_len, false);
+
+	if (noio)
+		memalloc_noio_restore(noio_flag);
+}
+
+/*
+ * Initialize the dm ima related data structure variables.
+ */
+
+void dm_ima_reset_data(struct mapped_device *md)
+{
+	memset(&(md->ima), 0, sizeof(md->ima));
+}
+
+/*
+ * Build up the IMA data for each target, and finally measure.
+ */
+void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags)
+{
+	size_t device_data_buf_len, target_metadata_buf_len, target_data_buf_len, l = 0;
+	char *target_metadata_buf = NULL, *target_data_buf = NULL, *digest_buf = NULL;
+	char *ima_buf = NULL, *device_data_buf = NULL;
+	int digest_size, last_target_measured = -1, r;
+	status_type_t type = STATUSTYPE_IMA;
+	size_t cur_total_buf_len = 0;
+	unsigned int num_targets, i;
+	SHASH_DESC_ON_STACK(shash, NULL);
+	struct crypto_shash *tfm;
+	u8 *digest = NULL;
+	bool noio = false;
+
+	ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, GFP_KERNEL, noio);
+	if (!ima_buf)
+		return;
+
+	target_metadata_buf = dm_ima_alloc(DM_IMA_TARGET_METADATA_BUF_LEN, GFP_KERNEL, noio);
+	if (!target_metadata_buf)
+		goto error;
+
+	target_data_buf = dm_ima_alloc(DM_IMA_TARGET_DATA_BUF_LEN, GFP_KERNEL, noio);
+	if (!target_data_buf)
+		goto error;
+
+	num_targets = dm_table_get_num_targets(table);
+
+	if (dm_ima_alloc_and_copy_device_data(table->md, &device_data_buf, num_targets, noio))
+		goto error;
+
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm))
+		goto error;
+
+	shash->tfm = tfm;
+	digest_size = crypto_shash_digestsize(tfm);
+	digest = dm_ima_alloc(digest_size, GFP_KERNEL, noio);
+	if (!digest)
+		goto error;
+
+	r = crypto_shash_init(shash);
+	if (r)
+		return;
+
+	device_data_buf_len = strlen(device_data_buf);
+	memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
+	l += device_data_buf_len;
+
+	for (i = 0; i < num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(table, i);
+
+		if (!ti)
+			goto error;
+
+		last_target_measured = 0;
+
+		/*
+		 * First retrieve the target metadata.
+		 */
+		scnprintf(target_metadata_buf, DM_IMA_TARGET_METADATA_BUF_LEN,
+			  "target_index=%d,target_begin=%llu,target_len=%llu,",
+			  i, ti->begin, ti->len);
+		target_metadata_buf_len = strlen(target_metadata_buf);
+
+		/*
+		 * Then retrieve the actual target data.
+		 */
+		if (ti->type->status)
+			ti->type->status(ti, type, status_flags, target_data_buf,
+					 DM_IMA_TARGET_DATA_BUF_LEN);
+		else
+			target_data_buf[0] = '\0';
+
+		target_data_buf_len = strlen(target_data_buf);
+
+		/*
+		 * Check if the total data can fit into the IMA buffer.
+		 */
+		cur_total_buf_len = l + target_metadata_buf_len + target_data_buf_len;
+
+		/*
+		 * IMA measurements for DM targets are best-effort.
+		 * If the total data buffered so far, including the current target,
+		 * is too large to fit into DM_IMA_MEASUREMENT_BUF_LEN, measure what
+		 * we have in the current buffer, and continue measuring the remaining
+		 * targets by prefixing the device metadata again.
+		 */
+		if (unlikely(cur_total_buf_len >= DM_IMA_MEASUREMENT_BUF_LEN)) {
+			dm_ima_measure_data("table_load", ima_buf, l, noio);
+			r = crypto_shash_update(shash, (const u8 *)ima_buf, l);
+			if (r < 0)
+				goto error;
+
+			memset(ima_buf, 0, DM_IMA_MEASUREMENT_BUF_LEN);
+			l = 0;
+
+			/*
+			 * Each new "table_load" entry in IMA log should have device data prefix,
+			 * so that multiple records from the same table_load for a given device
+			 * can be linked together.
+			 */
+			memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
+			l += device_data_buf_len;
+
+			/*
+			 * If this iteration of the for loop turns out to be the last target in the
+			 * table, dm_ima_measure_data("table_load", ...) doesn't need to be called
+			 * again, just the hash needs to be finalized. "last_target_measured" tracks
+			 * this state.
+			 */
+			last_target_measured = 1;
+		}
+
+		/*
+		 * Fill-in all the target metadata, so that multiple targets for the same device
+		 * can be linked together.
+		 */
+
+		memcpy(ima_buf + l, target_metadata_buf, target_metadata_buf_len);
+		l += target_metadata_buf_len;
+
+		memcpy(ima_buf + l, target_data_buf, target_data_buf_len);
+		l += target_data_buf_len;
+	}
+
+
+	if (!last_target_measured) {
+		dm_ima_measure_data("table_load", ima_buf, l, noio);
+
+		r = crypto_shash_update(shash, (const u8 *)ima_buf, l);
+		if (r < 0)
+			goto error;
+
+	}
+
+	/*
+	 * Finalize the table hash, and store it in table->md->ima.inactive_table.hash,
+	 * so that the table data can be verified against the future device state change
+	 * events, e.g. resume, rename, remove, table-clear etc.
+	 */
+
+	r = crypto_shash_final(shash, digest);
+	if (r < 0)
+		goto error;
+
+	digest_buf = dm_ima_alloc((digest_size*2)+1, GFP_KERNEL, noio);
+	if (!digest_buf)
+		goto error;
+
+	for (i = 0; i < digest_size; i++)
+		snprintf((digest_buf+(i*2)), 3, "%02x", digest[i]);
+
+	if (table->md->ima.active_table.hash != table->md->ima.inactive_table.hash)
+		kfree(table->md->ima.inactive_table.hash);
+
+	table->md->ima.inactive_table.hash = digest_buf;
+	table->md->ima.inactive_table.hash_len = strlen(digest_buf);
+	table->md->ima.inactive_table.num_targets = num_targets;
+
+	if (table->md->ima.active_table.device_metadata !=
+	    table->md->ima.inactive_table.device_metadata)
+		kfree(table->md->ima.inactive_table.device_metadata);
+
+	table->md->ima.inactive_table.device_metadata = device_data_buf;
+	table->md->ima.inactive_table.device_metadata_len = device_data_buf_len;
+
+	goto exit;
+error:
+	kfree(digest_buf);
+	kfree(device_data_buf);
+exit:
+	kfree(digest);
+	crypto_free_shash(tfm);
+	kfree(ima_buf);
+	kfree(target_metadata_buf);
+	kfree(target_data_buf);
+}
+
+#else
+void dm_ima_reset_data(struct mapped_device *md) {}
+void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
+#endif
+MODULE_AUTHOR("Tushar Sugandhi <tusharsu@linux.microsoft.com>");
+MODULE_DESCRIPTION("Enables IMA measurements for DM targets");
+MODULE_LICENSE("GPL");
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
new file mode 100644
index 000000000000..3c92a2523284
--- /dev/null
+++ b/drivers/md/dm-ima.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2021 Microsoft Corporation
+ *
+ * Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+ *
+ * File: dm-ima.h
+ *       Header file for device mapper IMA measurements.
+ */
+
+#ifndef DM_IMA_H
+#define DM_IMA_H
+
+#define DM_IMA_MEASUREMENT_BUF_LEN	4096
+#define DM_IMA_DEVICE_BUF_LEN		1024
+#define DM_IMA_TARGET_METADATA_BUF_LEN	128
+#define DM_IMA_TARGET_DATA_BUF_LEN	2048
+
+struct dm_ima_device_table_metadata {
+	/*
+	 * Contains data specific to the device which is common across
+	 * all the targets in the table.e.g. name, uuid, major, minor etc.
+	 * The values are stored in comma separated list of key1=val1,key2=val2; pairs
+	 * delimited by a semicolon at the end of the list.
+	 */
+	char *device_metadata;
+	unsigned int device_metadata_len;
+	unsigned int num_targets;
+
+	/*
+	 * Contains the sha256 hashs of the IMA measurements of the
+	 * target attributes key-value pairs from the active/inactive tables.
+	 */
+	char *hash;
+	unsigned int hash_len;
+
+};
+
+/*
+ * This structure contains device metadata, and table hash for
+ * active and inactive tables for ima measurements.
+ */
+struct dm_ima_measurements {
+	struct dm_ima_device_table_metadata active_table;
+	struct dm_ima_device_table_metadata inactive_table;
+};
+
+void dm_ima_reset_data(struct mapped_device *md);
+void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags);
+#endif /*DM_IMA_H*/
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 2209cbcd84db..e6e9fe74baf9 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -6,7 +6,7 @@
  */
 
 #include "dm-core.h"
-
+#include "dm-ima.h"
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/miscdevice.h>
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 
 #include <linux/uaccess.h>
+#include <linux/ima.h>
 
 #define DM_MSG_PREFIX "ioctl"
 #define DM_DRIVER_EMAIL "dm-devel@redhat.com"
@@ -1224,6 +1225,8 @@ static void retrieve_status(struct dm_table *table,
 
 	if (param->flags & DM_STATUS_TABLE_FLAG)
 		type = STATUSTYPE_TABLE;
+	else if (param->flags & DM_IMA_MEASUREMENT_FLAG)
+		type = STATUSTYPE_IMA;
 	else
 		type = STATUSTYPE_INFO;
 
@@ -1425,6 +1428,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (r)
 		goto err_unlock_md_type;
 
+	dm_ima_measure_on_table_load(t, STATUSTYPE_IMA);
+
 	immutable_target_type = dm_get_immutable_target_type(md);
 	if (immutable_target_type &&
 	    (immutable_target_type != dm_table_get_immutable_target_type(t)) &&
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ca2aedd8ee7d..63c83f213fd4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -8,6 +8,7 @@
 #include "dm-core.h"
 #include "dm-rq.h"
 #include "dm-uevent.h"
+#include "dm-ima.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -2109,6 +2110,8 @@ int dm_create(int minor, struct mapped_device **result)
 		return r;
 	}
 
+	dm_ima_reset_data(md);
+
 	*result = md;
 	return 0;
 }
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index ff700fb6ce1d..738a7d023650 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -31,7 +31,7 @@ enum dm_queue_mode {
 	DM_TYPE_DAX_BIO_BASED	 = 3,
 };
 
-typedef enum { STATUSTYPE_INFO, STATUSTYPE_TABLE } status_type_t;
+typedef enum { STATUSTYPE_INFO, STATUSTYPE_TABLE, STATUSTYPE_IMA } status_type_t;
 
 union map_info {
 	void *ptr;
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index e5c6e458bdf7..c12ce30b52df 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -376,4 +376,10 @@ enum {
  */
 #define DM_INTERNAL_SUSPEND_FLAG	(1 << 18) /* Out */
 
+/*
+ * If set, returns in the in buffer passed by UM, the raw table information
+ * that would be measured by IMA subsystem on device state change.
+ */
+#define DM_IMA_MEASUREMENT_FLAG	(1 << 19) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
2.25.1

