Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06153EBDF0
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhHMVii (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:38:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44298 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhHMVii (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:38:38 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA2B220C171A;
        Fri, 13 Aug 2021 14:38:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA2B220C171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628890690;
        bh=mUT0Jx6cKjcUIcrKeW65+2LTgqveBTVLDqMe9OBdGiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6wLKubiikv2zlfQI6EqoYZM8eWGKDywOKGeScFeti0yTztXkFEtMS0F4/9K2D8/B
         5TgZcvGYuWAe4ELrRTI3NDKN6fyHaBqgEOuzYw7M4XzSC4OVIA5D4Tp/IeH8OXFAH/
         YaN/g/NUztQvzMBX662CnGlMbDkxw+iTyV9Nb0e4=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        sfr@canb.auug.org.au, public@thson.de, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com
Subject: [PATCH 3/6] dm ima: prefix ima event name related to device mapper with dm_
Date:   Fri, 13 Aug 2021 14:37:58 -0700
Message-Id: <20210813213801.297051-4-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The event names for the DM events recorded in the ima log do not contain
any information to indicate the events are part of the DM devices/targets.

Prefix the event names for DM events with "dm_" to indicate that they
are part of device-mapper.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Suggested-by: Thore Sommer <public@thson.de>
---
 drivers/md/dm-ima.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 458a3a1d78bc..81a574129a80 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -193,6 +193,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 				 * the hash value with the hash algorithm name.
 				 * e.g. sha256:<hash_value>.
 				 */
+	char table_load_event_name[] = "dm_table_load";
 
 	ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, GFP_KERNEL, noio);
 	if (!ima_buf)
@@ -272,7 +273,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 		 * targets by prefixing the device metadata again.
 		 */
 		if (unlikely(cur_total_buf_len >= DM_IMA_MEASUREMENT_BUF_LEN)) {
-			dm_ima_measure_data("table_load", ima_buf, l, noio);
+			dm_ima_measure_data(table_load_event_name, ima_buf, l, noio);
 			r = crypto_shash_update(shash, (const u8 *)ima_buf, l);
 			if (r < 0)
 				goto error;
@@ -281,8 +282,8 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 			l = 0;
 
 			/*
-			 * Each new "table_load" entry in IMA log should have device data
-			 * prefix, so that multiple records from the same table_load for
+			 * Each new "dm_table_load" entry in IMA log should have device data
+			 * prefix, so that multiple records from the same "dm_table_load" for
 			 * a given device can be linked together.
 			 */
 			memcpy(ima_buf + l, DM_IMA_VERSION_STR, table->md->ima.dm_version_str_len);
@@ -293,7 +294,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 
 			/*
 			 * If this iteration of the for loop turns out to be the last target
-			 * in the table, dm_ima_measure_data("table_load", ...) doesn't need
+			 * in the table, dm_ima_measure_data("dm_table_load", ...) doesn't need
 			 * to be called again, just the hash needs to be finalized.
 			 * "last_target_measured" tracks this state.
 			 */
@@ -312,7 +313,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	}
 
 	if (!last_target_measured) {
-		dm_ima_measure_data("table_load", ima_buf, l, noio);
+		dm_ima_measure_data(table_load_event_name, ima_buf, l, noio);
 
 		r = crypto_shash_update(shash, (const u8 *)ima_buf, l);
 		if (r < 0)
@@ -461,7 +462,7 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	memcpy(device_table_data + l, capacity_str, capacity_len);
 	l += capacity_len;
 
-	dm_ima_measure_data("device_resume", device_table_data, l, noio);
+	dm_ima_measure_data("dm_device_resume", device_table_data, l, noio);
 
 	kfree(dev_name);
 	kfree(dev_uuid);
@@ -578,7 +579,7 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	memcpy(device_table_data + l, capacity_str, capacity_len);
 	l += capacity_len;
 
-	dm_ima_measure_data("device_remove", device_table_data, l, noio);
+	dm_ima_measure_data("dm_device_remove", device_table_data, l, noio);
 
 error:
 	kfree(device_table_data);
@@ -659,7 +660,7 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	memcpy(device_table_data + l, capacity_str, capacity_len);
 	l += capacity_len;
 
-	dm_ima_measure_data("table_clear", device_table_data, l, noio);
+	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
 	if (new_map) {
 		if (md->ima.inactive_table.hash &&
@@ -734,7 +735,7 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 		  "%s%snew_name=%s,new_uuid=%s;%s", DM_IMA_VERSION_STR, old_device_data,
 		  new_dev_name, new_dev_uuid, capacity_str);
 
-	dm_ima_measure_data("device_rename", combined_device_data, strlen(combined_device_data),
+	dm_ima_measure_data("dm_device_rename", combined_device_data, strlen(combined_device_data),
 			    noio);
 
 	goto exit;
-- 
2.32.0

