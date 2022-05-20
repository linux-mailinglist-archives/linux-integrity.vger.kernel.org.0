Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950B152EE1C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiETO0W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiETO0T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 10:26:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7325B3524F
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653056775;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0ZjTH9EydthIdiRbYOjbjiwaRe+7TWxB0BDThVI+jpU=;
    b=iSjK8sDbkxEKE2pOJbmajgoWFrOvwZ+AuOIAXmJH8pO7RIZZOKzb0999mF4lI3KBf/
    yreQCdFurYfy7yniOjB79Ctb7fc3TD2HCyINFo5U29HOHF71oM44hNphoTopzBoIbjXU
    zZoWK30xj2Kt1xwfJJK1GB8GeVSB1sVZf4bTXwgyIqFL6eyNFMSKhDmePuRiloPGoad+
    HN7vLzLT8iGPZZEaMZUAISjONcfj4/ZlcgHSWQKjUYAD9Utu/TB5AGIj5CsB8ClDKkl+
    zqjvxMmud8PkLDp+zCXY3seZ971qhe/8BWoX9sYkZGeywLfT47OTA+EbZho2kPbyOv58
    3X3Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id Y03eaey4KEQEQD5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 16:26:14 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com,
        nramas@linux.microsoft.com
Cc:     linux-integrity@vger.kernel.org, Thore Sommer <public@thson.de>
Subject: [PATCH 1/3] dm ima: allow targets to remeasure their table entry
Date:   Fri, 20 May 2022 16:26:03 +0200
Message-Id: <20220520142605.270625-2-public@thson.de>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520142605.270625-1-public@thson.de>
References: <20220520142605.270625-1-public@thson.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The existing device mapper IMA measurements only measure the table content
on target creation. This is fine for targets that do not change their table
during runtime, but some targets like verity use the table to display state
changes. Those changes are not visible through the existing device mapper
integration.

A new DM event "dm_target_update" is introduced for targets to remeasure
their table entry. This event is intended to be used by targets that change
their table entries to indicate potential security relevant information.
This allows for a more complete Remote Attestation of device mapper
targets.

For example a verity target is never marked as corrupted during creation,
because it only happens when a corrupted block is read. Using the new event
the table entry change will be visible in the IMA log.

In the event the dm version, device metadata and target data gets measured.

The hash of the active table is not updated because it would require to
rehash the whole table with all the other targets entries.

Signed-off-by: Thore Sommer <public@thson.de>
---
 - v1: 
    - do not initialize ima_buf with NULL
    - use return value of scnprintf for target_metadata_buf_len
	- rewrite target_index calculation to use less variables
	- remove unnecessary NULL check for ti2 

 drivers/md/dm-ima.c | 70 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h |  2 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 1842d3a958ef..bac217440853 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -750,3 +750,73 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 	kfree(new_dev_name);
 	kfree(new_dev_uuid);
 }
+
+/*
+ * Give the option for targets to remeasure on state change.
+ */
+void dm_ima_measure_on_target_update(struct dm_target *ti)
+{
+	char *ima_buf, *target_metadata_buf = NULL, *target_data_buf = NULL;
+	struct dm_target *ti2;
+	size_t target_metadata_buf_len, target_data_buf_len;
+	unsigned int num_targets, target_index;
+	struct dm_table *table = ti->table;
+	struct mapped_device *md = table->md;
+	bool noio = true;
+	int l = 0;
+
+	ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, GFP_KERNEL, noio);
+	if (!ima_buf)
+		return;
+
+	target_metadata_buf = dm_ima_alloc(DM_IMA_TARGET_METADATA_BUF_LEN, GFP_KERNEL, noio);
+	if (!target_metadata_buf)
+		goto exit;
+
+	target_data_buf = dm_ima_alloc(DM_IMA_TARGET_DATA_BUF_LEN, GFP_KERNEL, noio);
+	if (!target_data_buf)
+		goto exit;
+
+	/*
+	 * Get the index of the target in the table.
+	 */
+	num_targets = dm_table_get_num_targets(table);
+	for (target_index = 0; target_index < num_targets; target_index++) {
+		ti2 = dm_table_get_target(table, target_index);
+		if (ti == ti2)
+			break;
+	}
+	if (target_index == num_targets)
+		goto exit;
+
+	target_metadata_buf_len = scnprintf(target_metadata_buf, DM_IMA_TARGET_METADATA_BUF_LEN,
+			  "target_index=%d,target_begin=%llu,target_len=%llu,",
+			  target_index, ti->begin, ti->len);
+
+	if (ti->type->status)
+		ti->type->status(ti, STATUSTYPE_IMA, STATUSTYPE_IMA, target_data_buf,
+					DM_IMA_TARGET_DATA_BUF_LEN);
+	else
+		target_data_buf[0] = '\0';
+	target_data_buf_len = strlen(target_data_buf);
+
+	memcpy(ima_buf + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
+	l += md->ima.dm_version_str_len;
+
+	memcpy(ima_buf + l, md->ima.active_table.device_metadata,
+	       md->ima.active_table.device_metadata_len);
+	l += md->ima.active_table.device_metadata_len;
+
+	memcpy(ima_buf + l, target_metadata_buf, target_metadata_buf_len);
+	l += target_metadata_buf_len;
+
+	memcpy(ima_buf + l, target_data_buf, target_data_buf_len);
+
+	dm_ima_measure_data("dm_target_update", ima_buf, strlen(ima_buf), noio);
+
+exit:
+	kfree(ima_buf);
+	kfree(target_data_buf);
+	kfree(target_metadata_buf);
+}
+EXPORT_SYMBOL_GPL(dm_ima_measure_on_target_update);
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index b8c3b614670b..281a8b65f8a9 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -63,6 +63,7 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
 void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map);
 void dm_ima_measure_on_device_rename(struct mapped_device *md);
+void dm_ima_measure_on_target_update(struct dm_target *ti);
 
 #else
 
@@ -72,6 +73,7 @@ static inline void dm_ima_measure_on_device_resume(struct mapped_device *md, boo
 static inline void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
 static inline void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map) {}
 static inline void dm_ima_measure_on_device_rename(struct mapped_device *md) {}
+static inline void dm_ima_measure_on_target_update(struct dm_target *ti) {}
 
 #endif /* CONFIG_IMA */
 
-- 
2.36.0

