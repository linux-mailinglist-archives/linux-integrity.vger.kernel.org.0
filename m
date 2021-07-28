Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8FB3D9466
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhG1RiE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 13:38:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:32376 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhG1RiE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 13:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627493687;
    s=strato-dkim-0002; d=thson.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0VVX1JjgEJB0KavLR4tRRbuoJrmXR6RiTX6j9RujNx4=;
    b=DbK6sNdiwi3pYAMKjJv2mTkOjaHodTtRQpyGd+uvFAbK33ADDvjd68aePgVNTdBHWc
    aANd9JJP4cexZAJYvAXnzyKVk396thHBZY0HilbkJ2Ri9SrzIjSPRlZywwjjaz52TDf+
    se6soHGowqdMTAoURA2rpy1D/vJbytssR1dMV4jXSxJilKHuSaTbMgk8/vEfec2NbpTR
    o1CpLXaES8+ON4wScQy3Hz6bM478jCDI79r8pnTAbM+lFbX3iMXn+9aXyx0v18a/HUJn
    QS+l/Vj49KPp7PfPxVsrvovZGRMqof/0mwdl77d1xVZd7YRrLrhJ/TFAUORCoxp2cTP1
    zLjQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoau5J4Tj7+uA76w8eadkyoCWU/S6TOnfqgd7To/uJm/gTTBonpqa8ec="
X-RZG-CLASS-ID: mo00
Received: from USER-PC.fritz.box
    by smtp.strato.de (RZmta 47.28.1 AUTH)
    with ESMTPSA id t06ddcx6SHYlteJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Jul 2021 19:34:47 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     agk@redhat.com
Cc:     dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, public@thson.de, snitzer@redhat.com,
        tusharsu@linux.microsoft.com, zohar@linux.ibm.com
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using IMA
Date:   Wed, 28 Jul 2021 19:34:40 +0200
Message-Id: <20210728173440.1121652-1-public@thson.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727203337.GA81220@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
References: <20210727203337.GA81220@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alasdair,

thank you for answering my questions. The answers helped a lot.

> Having other triggering mechanisms - such as hooking into internal
> events when something unexpected happens - could be considered for
> follow-on patches.

I've written [1] a proof of concept implementation that provides a hook for
targets to remeasure their state. This was my first attempt at writing kernel
code, so there might be some serious bugs. With something like this implemented
remote attestation for state of dm-verity should be possible.

The output if a target calls that hook is:
device_update DEVICE_METADATA;TARGET_METADATA,TARGET_STATUS

Regards,
Thore

[1]
diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 2d796e439bee..b743a2e9add4 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -703,3 +703,84 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 	kfree(new_dev_name);
 	kfree(new_dev_uuid);
 }
+
+/*
+ * Give the option for targets to remeasure on state change.
+ */
+void dm_ima_measure_on_target_update(struct dm_target *ti){
+	char *ima_buf = NULL, *target_metadata_buf = NULL, *target_data_buf= NULL;
+	status_type_t type = STATUSTYPE_IMA;
+	size_t target_metadata_buf_len, target_data_buf_len;
+	unsigned int num_targets, i;
+	struct dm_table *table = ti->table;
+	struct mapped_device *md = table->md;
+	unsigned int  target_num = -1;
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
+
+	num_targets = dm_table_get_num_targets(table);
+
+	// Get target number
+	for (i = 0; i < num_targets; i++){
+		struct dm_target *ti2 = dm_table_get_target(table, i);
+		if (!ti)
+			goto exit;
+		if (ti == ti2){
+			target_num = i;
+			break;
+		}
+	}
+	if (target_num == -1)
+		goto exit;
+
+	/*
+	 * First retrieve the target metadata.
+	 */
+	scnprintf(target_metadata_buf, DM_IMA_TARGET_METADATA_BUF_LEN,
+			  "target_index=%d,target_begin=%llu,target_len=%llu,",
+			  target_num, ti->begin, ti->len);
+	target_metadata_buf_len = strlen(target_metadata_buf);
+
+	/*
+	 * Then retrieve the actual target data.
+	 */
+	if (ti->type->status)
+		ti->type->status(ti, type, STATUSTYPE_IMA, target_data_buf,
+					DM_IMA_TARGET_DATA_BUF_LEN);
+	else
+		target_data_buf[0] = '\0';
+	target_data_buf_len = strlen(target_data_buf);
+
+	// Add the device metadata
+	memcpy(ima_buf + l, md->ima.active_table.device_metadata, md->ima.active_table.device_metadata_len);
+	l += md->ima.active_table.device_metadata_len;
+
+	// Add the target metadata
+	memcpy(ima_buf + l, target_metadata_buf, target_metadata_buf_len);
+	l += target_metadata_buf_len;
+
+	// Add the new target state
+	memcpy(ima_buf + l, target_data_buf, target_data_buf_len);
+
+	dm_ima_measure_data("device_update", ima_buf, strlen(ima_buf), noio);
+
+exit:
+	kfree(ima_buf);
+	kfree(target_data_buf);
+	kfree(target_metadata_buf);
+}
+
+EXPORT_SYMBOL_GPL(dm_ima_measure_on_target_update);
\ No newline at end of file
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 6e6f18bf05b4..f90c4147277a 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -53,6 +53,7 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
 void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map);
 void dm_ima_measure_on_device_rename(struct mapped_device *md);
+void dm_ima_measure_on_target_update(struct dm_target *ti);
 
 #else
 
@@ -62,6 +63,7 @@ static inline void dm_ima_measure_on_device_resume(struct mapped_device *md, boo
 static inline void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
 static inline void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map) {}
 static inline void dm_ima_measure_on_device_rename(struct mapped_device *md) {}
+static inline void dm_ima_measure_on_target_update(struct dm_target *ti) {}
 
 #endif /* CONFIG_IMA */
 
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index bfefa100c265..f0764dd8bd4d 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -16,6 +16,7 @@
 #include "dm-verity.h"
 #include "dm-verity-fec.h"
 #include "dm-verity-verify-sig.h"
+#include "dm-ima.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
 
@@ -217,10 +218,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	char *envp[] = { verity_env, NULL };
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
+	int old_hash_failed = v->hash_failed;
 
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = 1;
 
+	if (!old_hash_failed){
+		dm_ima_measure_on_target_update(v->ti);
+	}
+
 	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
 		goto out;
 
-- 
