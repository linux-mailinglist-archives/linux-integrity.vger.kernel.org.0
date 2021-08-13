Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8B3EBDEE
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhHMVii (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:38:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44284 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHMVih (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:38:37 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4A5EB20C1717;
        Fri, 13 Aug 2021 14:38:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A5EB20C1717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628890690;
        bh=tNWD1zcn0XEY+kwErQDMwiisCxYmR+sgoDET9iuvCyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCBzAiIPxDQZeUy1SA5btJMC4dS9Gwtx8eAXWh3AtTebmp/XEmWKlt0RHtHZ8XUEV
         e+pEpVXifv6M7Eixvgs3vdTYilYg9VKE5auqsh90tBOYRjyKFE6jX8hhj7340w6lds
         C5LR2IPlTTkCSvkY5RMEHD163dJI9TjhF+zAaCFQ=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        sfr@canb.auug.org.au, public@thson.de, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com
Subject: [PATCH 2/6] dm ima: add version info to dm related events in ima log
Date:   Fri, 13 Aug 2021 14:37:57 -0700
Message-Id: <20210813213801.297051-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The DM events present in the ima log contain various attributes in the
key=value format.  The attributes' names/values may change in future,
and new attributes may also get added.  The attestation server needs
some versioning to determine which attributes are supported and are
expected in the ima log.

Add version information to the DM events present in the ima log to
help attestation servers to correctly process the attributes across
different versions.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/md/dm-ima.c | 60 ++++++++++++++++++++++++++++++++++++---------
 drivers/md/dm-ima.h |  9 +++++++
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 4bab35c8f0c7..458a3a1d78bc 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -168,6 +168,7 @@ static int dm_ima_alloc_and_copy_capacity_str(struct mapped_device *md, char **c
 void dm_ima_reset_data(struct mapped_device *md)
 {
 	memset(&(md->ima), 0, sizeof(md->ima));
+	md->ima.dm_version_str_len = strlen(DM_IMA_VERSION_STR);
 }
 
 /*
@@ -224,6 +225,9 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	if (r)
 		goto error;
 
+	memcpy(ima_buf + l, DM_IMA_VERSION_STR, table->md->ima.dm_version_str_len);
+	l += table->md->ima.dm_version_str_len;
+
 	device_data_buf_len = strlen(device_data_buf);
 	memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
 	l += device_data_buf_len;
@@ -281,6 +285,9 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 			 * prefix, so that multiple records from the same table_load for
 			 * a given device can be linked together.
 			 */
+			memcpy(ima_buf + l, DM_IMA_VERSION_STR, table->md->ima.dm_version_str_len);
+			l += table->md->ima.dm_version_str_len;
+
 			memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
 			l += device_data_buf_len;
 
@@ -368,6 +375,7 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	unsigned int active_len = strlen(active), capacity_len = 0;
 	unsigned int l = 0;
 	bool noio = true;
+	bool nodata = true;
 	int r;
 
 	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, GFP_KERNEL, noio);
@@ -378,6 +386,9 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	if (r)
 		goto error;
 
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
+	l += md->ima.dm_version_str_len;
+
 	if (swap) {
 		if (md->ima.active_table.hash != md->ima.inactive_table.hash)
 			kfree(md->ima.active_table.hash);
@@ -413,8 +424,11 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	}
 
 	if (md->ima.active_table.device_metadata) {
-		l = md->ima.active_table.device_metadata_len;
-		memcpy(device_table_data, md->ima.active_table.device_metadata, l);
+		memcpy(device_table_data + l, md->ima.active_table.device_metadata,
+		       md->ima.active_table.device_metadata_len);
+		l += md->ima.active_table.device_metadata_len;
+
+		nodata = false;
 	}
 
 	if (md->ima.active_table.hash) {
@@ -427,16 +441,18 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 
 		memcpy(device_table_data + l, ";", 1);
 		l++;
+
+		nodata = false;
 	}
 
-	if (!l) {
+	if (nodata) {
 		r = dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio);
 		if (r)
 			goto error;
 
 		scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
-			  "name=%s,uuid=%s;device_resume=no_data;",
-			  dev_name, dev_uuid);
+			  "%sname=%s,uuid=%s;device_resume=no_data;",
+			  DM_IMA_VERSION_STR, dev_name, dev_uuid);
 		l += strlen(device_table_data);
 
 	}
@@ -473,6 +489,7 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	unsigned int capacity_len = 0;
 	unsigned int l = 0;
 	bool noio = true;
+	bool nodata = true;
 	int r;
 
 	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN*2, GFP_KERNEL, noio);
@@ -485,6 +502,9 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 		goto exit;
 	}
 
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
+	l += md->ima.dm_version_str_len;
+
 	if (md->ima.active_table.device_metadata) {
 		memcpy(device_table_data + l, device_active_str, device_active_len);
 		l += device_active_len;
@@ -492,6 +512,8 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 		memcpy(device_table_data + l, md->ima.active_table.device_metadata,
 		       md->ima.active_table.device_metadata_len);
 		l += md->ima.active_table.device_metadata_len;
+
+		nodata = false;
 	}
 
 	if (md->ima.inactive_table.device_metadata) {
@@ -501,6 +523,8 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 		memcpy(device_table_data + l, md->ima.inactive_table.device_metadata,
 		       md->ima.inactive_table.device_metadata_len);
 		l += md->ima.inactive_table.device_metadata_len;
+
+		nodata = false;
 	}
 
 	if (md->ima.active_table.hash) {
@@ -513,6 +537,8 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 
 		memcpy(device_table_data + l, ",", 1);
 		l++;
+
+		nodata = false;
 	}
 
 	if (md->ima.inactive_table.hash) {
@@ -525,19 +551,21 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 
 		memcpy(device_table_data + l, ",", 1);
 		l++;
+
+		nodata = false;
 	}
 	/*
 	 * In case both active and inactive tables, and corresponding
 	 * device metadata is cleared/missing - record the name and uuid
 	 * in IMA measurements.
 	 */
-	if (!l) {
+	if (nodata) {
 		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
 			goto error;
 
 		scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
-			  "name=%s,uuid=%s;device_remove=no_data;",
-			  dev_name, dev_uuid);
+			  "%sname=%s,uuid=%s;device_remove=no_data;",
+			  DM_IMA_VERSION_STR, dev_name, dev_uuid);
 		l += strlen(device_table_data);
 	}
 
@@ -583,6 +611,7 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	char inactive_str[] = "inactive_table_hash=";
 	unsigned int inactive_len = strlen(inactive_str);
 	bool noio = true;
+	bool nodata = true;
 	int r;
 
 	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, GFP_KERNEL, noio);
@@ -593,6 +622,9 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	if (r)
 		goto error1;
 
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
+	l += md->ima.dm_version_str_len;
+
 	if (md->ima.inactive_table.device_metadata_len &&
 	    md->ima.inactive_table.hash_len) {
 		memcpy(device_table_data + l, md->ima.inactive_table.device_metadata,
@@ -609,14 +641,17 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 
 		memcpy(device_table_data + l, ";", 1);
 		l++;
+
+		nodata = false;
 	}
 
-	if (!l) {
+	if (nodata) {
 		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
 			goto error2;
 
 		scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
-			  "name=%s,uuid=%s;table_clear=no_data;", dev_name, dev_uuid);
+			  "%sname=%s,uuid=%s;table_clear=no_data;",
+			   DM_IMA_VERSION_STR, dev_name, dev_uuid);
 		l += strlen(device_table_data);
 	}
 
@@ -695,8 +730,9 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 	md->ima.active_table.device_metadata = new_device_data;
 	md->ima.active_table.device_metadata_len = strlen(new_device_data);
 
-	scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2, "%snew_name=%s,new_uuid=%s;%s",
-		  old_device_data, new_dev_name, new_dev_uuid, capacity_str);
+	scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2,
+		  "%s%snew_name=%s,new_uuid=%s;%s", DM_IMA_VERSION_STR, old_device_data,
+		  new_dev_name, new_dev_uuid, capacity_str);
 
 	dm_ima_measure_data("device_rename", combined_device_data, strlen(combined_device_data),
 			    noio);
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 0731a51565d6..b8c3b614670b 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -18,6 +18,14 @@
 #define DM_IMA_DEVICE_CAPACITY_BUF_LEN	128
 #define DM_IMA_TABLE_HASH_ALG		"sha256"
 
+#define __dm_ima_stringify(s) #s
+#define __dm_ima_str(s) __dm_ima_stringify(s)
+
+#define DM_IMA_VERSION_STR "dm_version="	\
+	__dm_ima_str(DM_VERSION_MAJOR) "."	\
+	__dm_ima_str(DM_VERSION_MINOR) "."	\
+	__dm_ima_str(DM_VERSION_PATCHLEVEL) ";"
+
 #ifdef CONFIG_IMA
 
 struct dm_ima_device_table_metadata {
@@ -46,6 +54,7 @@ struct dm_ima_device_table_metadata {
 struct dm_ima_measurements {
 	struct dm_ima_device_table_metadata active_table;
 	struct dm_ima_device_table_metadata inactive_table;
+	unsigned int dm_version_str_len;
 };
 
 void dm_ima_reset_data(struct mapped_device *md);
-- 
2.32.0

