Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403E13C67A2
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 02:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhGMAwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 20:52:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53352 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhGMAwC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 20:52:02 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id EB43720B800A;
        Mon, 12 Jul 2021 17:49:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB43720B800A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626137353;
        bh=/MGSrfdce2V8Anslf0KacplwJRXj4xOe5aauSUE5tTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsep1/HLauIMqLWBMYtUcot0WtYJbbD2kpXTW9WrdxDzZ9L9/Mo4iEipcuUwkvcj0
         /869i4UV857DTl9qmJDIzj1Myta9KlUbodDGO7c7EXNexwCnWHhrVl5OFy8RhP+9L3
         Gm31C8BBrAaKdIZXKZgUwgJggLnMp4614n00a7HY=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com
Subject: [PATCH 3/7] dm: measure data on device remove
Date:   Mon, 12 Jul 2021 17:49:00 -0700
Message-Id: <20210713004904.8808-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Presence of an active block-device, configured with expected parameters,
is important for an external attestation service to determine if a system
meets the attestation requirements.  Therefore it is important for DM to
measure the device remove events.

Measure device parameters and table hashes when the device is removed,
using either remove or remove_all.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/dm-ima.c   | 120 ++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h   |   1 +
 drivers/md/dm-ioctl.c |   3 ++
 3 files changed, 124 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 1c545717adf4..47eca432a21a 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -453,10 +453,130 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	kfree(device_table_data);
 }
 
+/*
+ * Measure IMA data on remove.
+ */
+void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
+{
+	char *device_table_data, *dev_name = NULL, *dev_uuid = NULL, *capacity_str = NULL;
+	char active_table_str[] = "active_table_hash=";
+	char inactive_table_str[] = "inactive_table_hash=";
+	char device_active_str[] = "device_active_metadata=";
+	char device_inactive_str[] = "device_inactive_metadata=";
+	char remove_all_str[] = "remove_all=";
+	unsigned int active_table_len = strlen(active_table_str);
+	unsigned int inactive_table_len = strlen(inactive_table_str);
+	unsigned int device_active_len = strlen(device_active_str);
+	unsigned int device_inactive_len = strlen(device_inactive_str);
+	unsigned int remove_all_len = strlen(remove_all_str);
+	unsigned int capacity_len = 0;
+	unsigned int l = 0;
+	bool noio = true;
+	int r;
+
+	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN*2, GFP_KERNEL, noio);
+	if (!device_table_data)
+		goto exit;
+
+	r = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
+	if (r) {
+		kfree(device_table_data);
+		goto exit;
+	}
+
+	if (md->ima.active_table.device_metadata) {
+		memcpy(device_table_data + l, device_active_str, device_active_len);
+		l += device_active_len;
+
+		memcpy(device_table_data + l, md->ima.active_table.device_metadata,
+		       md->ima.active_table.device_metadata_len);
+		l += md->ima.active_table.device_metadata_len;
+	}
+
+	if (md->ima.inactive_table.device_metadata) {
+		memcpy(device_table_data + l, device_inactive_str, device_inactive_len);
+		l += device_inactive_len;
+
+		memcpy(device_table_data + l, md->ima.inactive_table.device_metadata,
+		       md->ima.inactive_table.device_metadata_len);
+		l += md->ima.inactive_table.device_metadata_len;
+	}
+
+	if (md->ima.active_table.hash) {
+		memcpy(device_table_data + l, active_table_str, active_table_len);
+		l += active_table_len;
+
+		memcpy(device_table_data + l, md->ima.active_table.hash,
+			   md->ima.active_table.hash_len);
+		l += md->ima.active_table.hash_len;
+
+		memcpy(device_table_data + l, ",", 1);
+		l++;
+	}
+
+	if (md->ima.inactive_table.hash) {
+		memcpy(device_table_data + l, inactive_table_str, inactive_table_len);
+		l += inactive_table_len;
+
+		memcpy(device_table_data + l, md->ima.inactive_table.hash,
+		       md->ima.inactive_table.hash_len);
+		l += md->ima.inactive_table.hash_len;
+
+		memcpy(device_table_data + l, ",", 1);
+		l++;
+	}
+	/*
+	 * In case both active and inactive tables, and corresponding
+	 * device metadata is cleared/missing - record the name and uuid
+	 * in IMA measurements.
+	 */
+	if (!l) {
+		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
+			goto error;
+
+		scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
+			  "name=%s,uuid=%s;device_remove=no_data;",
+			  dev_name, dev_uuid);
+		l += strlen(device_table_data);
+	}
+
+	memcpy(device_table_data + l, remove_all_str, remove_all_len);
+	l += remove_all_len;
+	memcpy(device_table_data + l, remove_all ? "y;" : "n;", 2);
+	l += 2;
+
+	capacity_len = strlen(capacity_str);
+	memcpy(device_table_data + l, capacity_str, capacity_len);
+	l += capacity_len;
+
+	dm_ima_measure_data("device_remove", device_table_data, l, noio);
+
+error:
+	kfree(device_table_data);
+	kfree(capacity_str);
+exit:
+	kfree(md->ima.active_table.device_metadata);
+
+	if (md->ima.active_table.device_metadata !=
+	    md->ima.inactive_table.device_metadata)
+		kfree(md->ima.inactive_table.device_metadata);
+
+	kfree(md->ima.active_table.hash);
+
+	if (md->ima.active_table.hash != md->ima.inactive_table.hash)
+		kfree(md->ima.inactive_table.hash);
+
+	dm_ima_reset_data(md);
+
+	kfree(dev_name);
+	kfree(dev_uuid);
+}
+
 #else
 void dm_ima_reset_data(struct mapped_device *md) {}
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
+void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
 #endif
 MODULE_AUTHOR("Tushar Sugandhi <tusharsu@linux.microsoft.com>");
 MODULE_DESCRIPTION("Enables IMA measurements for DM targets");
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index cafdcf5064c7..cb7b883ed35b 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -49,4 +49,5 @@ struct dm_ima_measurements {
 void dm_ima_reset_data(struct mapped_device *md);
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags);
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
+void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
 #endif /*DM_IMA_H*/
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 11af40f9b9c0..2d4475f6de7d 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -348,6 +348,7 @@ static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool
 			dm_sync_table(md);
 			dm_table_destroy(t);
 		}
+		dm_ima_measure_on_device_remove(md, true);
 		dm_put(md);
 		if (likely(keep_open_devices))
 			dm_destroy(md);
@@ -982,6 +983,8 @@ static int dev_remove(struct file *filp, struct dm_ioctl *param, size_t param_si
 
 	param->flags &= ~DM_DEFERRED_REMOVE;
 
+	dm_ima_measure_on_device_remove(md, false);
+
 	if (!dm_kobject_uevent(md, KOBJ_REMOVE, param->event_nr))
 		param->flags |= DM_UEVENT_GENERATED_FLAG;
 
-- 
2.25.1

