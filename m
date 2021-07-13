Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890303C67A3
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 02:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhGMAwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 20:52:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53362 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhGMAwC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 20:52:02 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 44CBB20B8010;
        Mon, 12 Jul 2021 17:49:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44CBB20B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626137353;
        bh=/l31ufbAiB7frLCvxnEGR33q8h5cqsq1tZNnteHdz14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcK5NapSCXywo3SS7SytSt+/cWmCSkRCZNswCKF9H16DyEFBQpgPS7In1j6dbEcY7
         H0qRGUK1mf5DkKpqmRQft7Hi1ODaBPsqGG0W2hIw61M9TVsLE/U2wV9DY5FuJwZJyq
         uxsHFYUaJ2Oj5HoQcWJNJlTjWzEPx6T/bxMzxfvE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com
Subject: [PATCH 4/7] dm: measure data on table clear
Date:   Mon, 12 Jul 2021 17:49:01 -0700
Message-Id: <20210713004904.8808-5-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For a given block device, an inactive table slot contains the parameters
to configure the device with.  The inactive table can be cleared
multiple times, accidentally or maliciously, which may impact the
functionality of the device, and compromise the system.  Therefore it is
important to measure and log the event when a table is cleared.

Measure device parameters, and table hashes when the inactive table slot
is cleared.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 drivers/md/dm-ima.c   | 93 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h   |  2 +
 drivers/md/dm-ioctl.c |  3 ++
 3 files changed, 98 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 47eca432a21a..b1e1cf6bb4e7 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -572,11 +572,104 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	kfree(dev_uuid);
 }
 
+/*
+ * Measure ima data on table clear.
+ */
+void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
+{
+	unsigned int l = 0, capacity_len = 0;
+	char *device_table_data = NULL, *dev_name = NULL, *dev_uuid = NULL, *capacity_str = NULL;
+	char inactive_str[] = "inactive_table_hash=";
+	unsigned int inactive_len = strlen(inactive_str);
+	bool noio = true;
+	int r;
+
+	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, GFP_KERNEL, noio);
+	if (!device_table_data)
+		return;
+
+	r = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
+	if (r)
+		goto error1;
+
+	if (md->ima.inactive_table.device_metadata_len &&
+	    md->ima.inactive_table.hash_len) {
+		memcpy(device_table_data + l, md->ima.inactive_table.device_metadata,
+		       md->ima.inactive_table.device_metadata_len);
+		l += md->ima.inactive_table.device_metadata_len;
+
+		memcpy(device_table_data + l, inactive_str, inactive_len);
+		l += inactive_len;
+
+		memcpy(device_table_data + l, md->ima.inactive_table.hash,
+			   md->ima.inactive_table.hash_len);
+
+		l += md->ima.inactive_table.hash_len;
+
+		memcpy(device_table_data + l, ";", 1);
+		l++;
+	}
+
+	if (!l) {
+		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
+			goto error2;
+
+		scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
+			  "name=%s,uuid=%s;table_clear=no_data;", dev_name, dev_uuid);
+		l += strlen(device_table_data);
+	}
+
+	capacity_len = strlen(capacity_str);
+	memcpy(device_table_data + l, capacity_str, capacity_len);
+	l += capacity_len;
+
+	dm_ima_measure_data("table_clear", device_table_data, l, noio);
+
+	if (new_map) {
+		if (md->ima.inactive_table.hash &&
+		    md->ima.inactive_table.hash != md->ima.active_table.hash)
+			kfree(md->ima.inactive_table.hash);
+
+		md->ima.inactive_table.hash = NULL;
+		md->ima.inactive_table.hash_len = 0;
+
+		if (md->ima.inactive_table.device_metadata &&
+		    md->ima.inactive_table.device_metadata != md->ima.active_table.device_metadata)
+			kfree(md->ima.inactive_table.device_metadata);
+
+		md->ima.inactive_table.device_metadata = NULL;
+		md->ima.inactive_table.device_metadata_len = 0;
+		md->ima.inactive_table.num_targets = 0;
+
+		if (md->ima.active_table.hash) {
+			md->ima.inactive_table.hash = md->ima.active_table.hash;
+			md->ima.inactive_table.hash_len = md->ima.active_table.hash_len;
+		}
+
+		if (md->ima.active_table.device_metadata) {
+			md->ima.inactive_table.device_metadata =
+				md->ima.active_table.device_metadata;
+			md->ima.inactive_table.device_metadata_len =
+				md->ima.active_table.device_metadata_len;
+			md->ima.inactive_table.num_targets =
+				md->ima.active_table.num_targets;
+		}
+	}
+
+	kfree(dev_name);
+	kfree(dev_uuid);
+error2:
+	kfree(capacity_str);
+error1:
+	kfree(device_table_data);
+}
+
 #else
 void dm_ima_reset_data(struct mapped_device *md) {}
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
+void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map) {}
 #endif
 MODULE_AUTHOR("Tushar Sugandhi <tusharsu@linux.microsoft.com>");
 MODULE_DESCRIPTION("Enables IMA measurements for DM targets");
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index cb7b883ed35b..a17ae953dc67 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -50,4 +50,6 @@ void dm_ima_reset_data(struct mapped_device *md);
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags);
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
+void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map);
+
 #endif /*DM_IMA_H*/
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 2d4475f6de7d..b07c19037c7c 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1508,6 +1508,7 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 	struct hash_cell *hc;
 	struct mapped_device *md;
 	struct dm_table *old_map = NULL;
+	bool has_new_map = false;
 
 	down_write(&_hash_lock);
 
@@ -1521,6 +1522,7 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 	if (hc->new_map) {
 		old_map = hc->new_map;
 		hc->new_map = NULL;
+		has_new_map = true;
 	}
 
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
@@ -1532,6 +1534,7 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 		dm_sync_table(md);
 		dm_table_destroy(old_map);
 	}
+	dm_ima_measure_on_table_clear(md, has_new_map);
 	dm_put(md);
 
 	return 0;
-- 
2.25.1

