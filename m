Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A32486B41
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jan 2022 21:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiAFUex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 15:34:53 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:45015 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiAFUex (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 15:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641501292;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Gw9uGHd8kShMn9q0DWe+3Hm/MOu0N2IHugHMPsF3NHU=;
    b=GBGeEOjDcOl8Jr5zw7j/85r2/KKQXcDq1ukvJpuhw2FqbejInumyv0haZhnwu/WIqJ
    Hv1/isyU3QUf1u2pJDiONsO4VuYmoLitqSOCAEyPp1NnANB9M1RU3CgaG86ccOii8yyI
    2KVFm0IkuwfakAN6MEs9+40jtbPSICuwwWu8HXKhT5SlXBRMmLTGXqeyh+TdqFvLVxHS
    FaK9xMrd/lozz3wD1gQZwdHI9R/XEyudfBNdczvZUoyRnCJ+tB2X+5OcrCaX8Ws/V8DA
    zlyhlQTCsoXet0tPearKoMdY/1GsjUlrxR+Q0i72Zpb1+2Dj548/hfDw9mbx6afDCw/Y
    qkKg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoauycprg5uef7cgCEpy7sPc="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.37.6 DYNA|AUTH)
    with ESMTPSA id k3f463y06KYp05f
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Jan 2022 21:34:51 +0100 (CET)
From:   Thore Sommer <public@thson.de>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Thore Sommer <public@thson.de>
Subject: [RFC PATCH 1/3] dm ima: allow targets to remeasure their table entry
Date:   Thu,  6 Jan 2022 21:34:34 +0100
Message-Id: <20220106203436.281629-2-public@thson.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106203436.281629-1-public@thson.de>
References: <20220106203436.281629-1-public@thson.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new DM event dm_target_update is introduced for targets to remeasure
their table entry. This is intended for targets that indicate security
relevant events by updating one of their table entries (e.g. verity for
corruption).

In the event the dm version, device metadata and target data gets
measured.

This does not update the hash of the active table because it would require
to rehash the whole table with all the other targets entries.

Signed-off-by: Thore Sommer <public@thson.de>
---
 drivers/md/dm-ima.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-ima.h |  2 ++
 2 files changed, 78 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 957999998d70..3b1bb97263d9 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -750,3 +750,79 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 	kfree(new_dev_name);
 	kfree(new_dev_uuid);
 }
+
+/*
+ * Give the option for targets to remeasure on state change.
+ */
+void dm_ima_measure_on_target_update(struct dm_target *ti)
+{
+	char *ima_buf = NULL, *target_metadata_buf = NULL, *target_data_buf = NULL;
+	struct dm_target *ti2;
+	size_t target_metadata_buf_len, target_data_buf_len;
+	unsigned int num_targets, target_index;
+	struct dm_table *table = ti->table;
+	struct mapped_device *md = table->md;
+	bool found = false;
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
+		if (!ti)
+			goto exit;
+		if (ti == ti2) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		goto exit;
+
+	scnprintf(target_metadata_buf, DM_IMA_TARGET_METADATA_BUF_LEN,
+			  "target_index=%d,target_begin=%llu,target_len=%llu,",
+			  target_index, ti->begin, ti->len);
+	target_metadata_buf_len = strlen(target_metadata_buf);
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
2.34.1

