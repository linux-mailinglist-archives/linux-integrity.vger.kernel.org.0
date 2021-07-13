Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC16B3C67A0
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 02:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhGMAwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 20:52:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53344 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhGMAwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 20:52:01 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A5E520B6AEE;
        Mon, 12 Jul 2021 17:49:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A5E520B6AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626137352;
        bh=WTJbIOUU6rc3ewh7w87j7bCNOQAmeac+9xuKkw7CM8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URpwwvg9t8DWUJEFpQv6K3WKc9L65IaTdHc1yZR6pUpo4T/Hxo9DeiE2IZEV7zPTJ
         MJ3qmHjrRSGx4nkVIiR8P67GGC3KQVGB+7k5g7cpoqaFD+lWKaBRP9nRaDeAxLZ1fi
         MZBxkL/BGdFsfqR9WbGBcOHBH8MarjwjgAMvHUdw=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com
Subject: [PATCH 2/7] dm: measure data on device resume
Date:   Mon, 12 Jul 2021 17:48:59 -0700
Message-Id: <20210713004904.8808-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A given block device can load a table multiple times, with different
input parameters, before eventually resuming it.  Further, a device may
be suspended and then resumed.  The device may never resume after a
table-load.  Because of the above valid scenarios for a given device,
it is important to measure and log the device resume event using IMA.

Also, if the table is large, measuring it in clear-text each time the
device changes state, will unnecessarily increase the size of IMA log.
Since the table clear-text is already measured during table-load event,
measuring the hash during resume should be sufficient to validate the
table contents.

Measure the device parameters, and hash of the active table, when the
device is resumed.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/dm-ima.c   | 118 ++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h   |   2 +
 drivers/md/dm-ioctl.c |   8 ++-
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index b752517380c3..1c545717adf4 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -145,6 +145,27 @@ static void dm_ima_measure_data(const char *event_name, const void *buf, size_t
 		memalloc_noio_restore(noio_flag);
 }
 
+/*
+ * Internal function to allocate and copy current device capacity for IMA measurements.
+ */
+
+static int dm_ima_alloc_and_copy_capacity_str(struct mapped_device *md, char **capacity_str,
+					      bool noio)
+{
+	sector_t capacity;
+
+	capacity = get_capacity(md->disk);
+
+	*capacity_str = dm_ima_alloc(DM_IMA_DEVICE_CAPACITY_BUF_LEN, GFP_KERNEL, noio);
+	if (!(*capacity_str))
+		return -ENOMEM;
+
+	scnprintf(*capacity_str, DM_IMA_DEVICE_BUF_LEN, "current_device_capacity=%llu;",
+		  capacity);
+
+	return 0;
+}
+
 /*
  * Initialize the dm ima related data structure variables.
  */
@@ -336,9 +357,106 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	kfree(target_data_buf);
 }
 
+/*
+ * Measure IMA data on device resume.
+ */
+void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
+{
+	char *device_table_data, *dev_name = NULL, *dev_uuid = NULL, *capacity_str = NULL;
+	char active[] = "active_table_hash=";
+	unsigned int active_len = strlen(active), capacity_len = 0;
+	unsigned int l = 0;
+	bool noio = true;
+	int r;
+
+	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, GFP_KERNEL, noio);
+	if (!device_table_data)
+		return;
+
+	r = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
+	if (r)
+		goto error;
+
+	if (swap) {
+		if (md->ima.active_table.hash != md->ima.inactive_table.hash)
+			kfree(md->ima.active_table.hash);
+
+		md->ima.active_table.hash = NULL;
+		md->ima.active_table.hash_len = 0;
+
+		if (md->ima.active_table.device_metadata !=
+		    md->ima.inactive_table.device_metadata)
+			kfree(md->ima.active_table.device_metadata);
+
+		md->ima.active_table.device_metadata = NULL;
+		md->ima.active_table.device_metadata_len = 0;
+		md->ima.active_table.num_targets = 0;
+
+		if (md->ima.inactive_table.hash) {
+			md->ima.active_table.hash = md->ima.inactive_table.hash;
+			md->ima.active_table.hash_len = md->ima.inactive_table.hash_len;
+			md->ima.inactive_table.hash = NULL;
+			md->ima.inactive_table.hash_len = 0;
+		}
+
+		if (md->ima.inactive_table.device_metadata) {
+			md->ima.active_table.device_metadata =
+				md->ima.inactive_table.device_metadata;
+			md->ima.active_table.device_metadata_len =
+				md->ima.inactive_table.device_metadata_len;
+			md->ima.active_table.num_targets = md->ima.inactive_table.num_targets;
+			md->ima.inactive_table.device_metadata = NULL;
+			md->ima.inactive_table.device_metadata_len = 0;
+			md->ima.inactive_table.num_targets = 0;
+		}
+	}
+
+	if (md->ima.active_table.device_metadata) {
+		l = md->ima.active_table.device_metadata_len;
+		memcpy(device_table_data, md->ima.active_table.device_metadata, l);
+	}
+
+	if (md->ima.active_table.hash) {
+		memcpy(device_table_data + l, active, active_len);
+		l += active_len;
+
+		memcpy(device_table_data + l, md->ima.active_table.hash,
+		       md->ima.active_table.hash_len);
+		l += md->ima.active_table.hash_len;
+
+		memcpy(device_table_data + l, ";", 1);
+		l++;
+	}
+
+	if (!l) {
+		r = dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio);
+		if (r)
+			goto error;
+
+		scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
+			  "name=%s,uuid=%s;device_resume=no_data;",
+			  dev_name, dev_uuid);
+		l += strlen(device_table_data);
+
+	}
+
+	capacity_len = strlen(capacity_str);
+	memcpy(device_table_data + l, capacity_str, capacity_len);
+	l += capacity_len;
+
+	dm_ima_measure_data("device_resume", device_table_data, l, noio);
+
+	kfree(dev_name);
+	kfree(dev_uuid);
+error:
+	kfree(capacity_str);
+	kfree(device_table_data);
+}
+
 #else
 void dm_ima_reset_data(struct mapped_device *md) {}
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
+void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
 #endif
 MODULE_AUTHOR("Tushar Sugandhi <tusharsu@linux.microsoft.com>");
 MODULE_DESCRIPTION("Enables IMA measurements for DM targets");
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 3c92a2523284..cafdcf5064c7 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -15,6 +15,7 @@
 #define DM_IMA_DEVICE_BUF_LEN		1024
 #define DM_IMA_TARGET_METADATA_BUF_LEN	128
 #define DM_IMA_TARGET_DATA_BUF_LEN	2048
+#define DM_IMA_DEVICE_CAPACITY_BUF_LEN	128
 
 struct dm_ima_device_table_metadata {
 	/*
@@ -47,4 +48,5 @@ struct dm_ima_measurements {
 
 void dm_ima_reset_data(struct mapped_device *md);
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags);
+void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 #endif /*DM_IMA_H*/
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index e6e9fe74baf9..11af40f9b9c0 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1160,8 +1160,12 @@ static int do_resume(struct dm_ioctl *param)
 
 	if (dm_suspended_md(md)) {
 		r = dm_resume(md);
-		if (!r && !dm_kobject_uevent(md, KOBJ_CHANGE, param->event_nr))
-			param->flags |= DM_UEVENT_GENERATED_FLAG;
+		if (!r) {
+			dm_ima_measure_on_device_resume(md, new_map ? true : false);
+
+			if (!dm_kobject_uevent(md, KOBJ_CHANGE, param->event_nr))
+				param->flags |= DM_UEVENT_GENERATED_FLAG;
+		}
 	}
 
 	/*
-- 
2.25.1

