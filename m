Return-Path: <linux-integrity+bounces-9179-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPLRKf6I3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9179-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395C3F46EC
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F03493022CAE
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80E22FE0E;
	Tue, 14 Apr 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYpLIaFc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A232248A5
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126177; cv=none; b=cb0ROehFheoPgr35Iuevp5MvCNuBB/txgR2ui3qU6bvrcByqO1KzcF0TdK93C7OOnGkggl0Oy6PYJ+82sakfGTE3ArBwV1UqtL9BYsfFVXVjo6+Joy1v8VpX60lF/eOamHxdPMOE1v0F6TShv0MLyc5PqsSy5ViDDQ/OQ9mFfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126177; c=relaxed/simple;
	bh=GD1RUmOGEUvnzavlJnrwmpSKICC2xZtEWi0/jLRzcAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ3nyxiAp3DLshS0PDy1RBHpTb0p/tzVtvo6z2eVttedW3r0IxfUYZQ7fz/qu3sYae+82EDYSa3PJLvKix2WbtAWHFjvcfnTHO1AmPlKN8C3sVx6/YJcLtbKZAQxZJmXVF80k7QL+J10Crk5KtjqoatVJhtjd4z7jtT1DktknQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYpLIaFc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Re06n5CVO+KdnxI7mdtpLK6RyFic4ws8StTPtiPina8=;
	b=cYpLIaFcg3oyWEARZm4EQ0icaez6JHbWQ4XLXU/U7fqpTXRmHMyyE+DuS3z8+EWMK5tuwd
	GDGZVD09BrAyd0vPvjmti/2cWpFUoIDaYnpCZnuYg1N8w2tULo7SG3paW0a09k78YRG7ec
	qJkxFOWSIVSrMljhSX0+qYx6TuoOZEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-WiprYPvnMBOvQV2r0jSVUg-1; Mon,
 13 Apr 2026 20:22:49 -0400
X-MC-Unique: WiprYPvnMBOvQV2r0jSVUg-1
X-Mimecast-MFC-AGG-ID: WiprYPvnMBOvQV2r0jSVUg_1776126168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1D9A180062A;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADCEB1800357;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0MkaL1917506
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:46 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0MkmK1917505;
	Mon, 13 Apr 2026 20:22:46 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 10/10] dm-ima: use active table's size if available
Date: Mon, 13 Apr 2026 20:22:44 -0400
Message-ID: <20260414002244.1917447-11-bmarzins@redhat.com>
In-Reply-To: <20260414002244.1917447-1-bmarzins@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9179-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.955];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9395C3F46EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It is possible that the dm_ima_measure_on_* functions run at the same
time as a table is getting swapped, but before the md->ima.active_table
is updated by dm_ima_measure_on_device_resume(). Instead of using the
current device size, use the size of the active table that is being
measured (assuming there is one), so the information is consistent.
Also, don't allocate a separate string to hold the capactiy. Just
print it directly to the measurement buffer.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 79 +++++++++++----------------------------------
 drivers/md/dm-ima.h |  1 +
 2 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 45038bd65f7b..ca6a33a0275e 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -151,22 +151,10 @@ static void dm_ima_measure_data(const char *event_name, const void *buf, size_t
 		memalloc_noio_restore(noio_flag);
 }
 
-/*
- * Internal function to allocate and copy current device capacity for IMA measurements.
- */
-static int dm_ima_alloc_and_copy_capacity_str(struct mapped_device *md, char **capacity_str,
-					      bool noio)
+static sector_t dm_ima_capacity(struct mapped_device *md)
 {
-	sector_t capacity;
-
-	capacity = get_capacity(md->disk);
-
-	*capacity_str = dm_ima_alloc(DM_IMA_DEVICE_CAPACITY_BUF_LEN, noio);
-	if (!(*capacity_str))
-		return -ENOMEM;
-
-	return scnprintf(*capacity_str, DM_IMA_DEVICE_BUF_LEN, "current_device_capacity=%llu;",
-			 capacity);
+	return (md->ima.active_table.device_metadata) ?
+		md->ima.active_table.capacity : get_capacity(md->disk);
 }
 
 /*
@@ -309,6 +297,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table,
 	table->md->ima.inactive_table.hash = digest_buf;
 	table->md->ima.inactive_table.hash_len = strlen(digest_buf);
 	table->md->ima.inactive_table.num_targets = num_targets;
+	table->md->ima.inactive_table.capacity = dm_table_get_size(table);
 
 
 	kfree(table->md->ima.inactive_table.device_metadata);
@@ -335,13 +324,12 @@ void dm_ima_measure_on_table_load(struct dm_table *table,
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 				     struct dm_ima_context *context)
 {
-	char *device_table_data = NULL, *capacity_str = NULL;
+	char *device_table_data = NULL;
 	char active[] = "active_table_hash=";
 	unsigned int active_len = strlen(active);
 	unsigned int l = 0;
 	bool noio = true;
 	bool nodata = true;
-	int capacity_len;
 
 	if (unlikely(!context))
 		return;
@@ -375,10 +363,6 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 	if (!device_table_data)
 		goto error;
 
-	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
-	if (capacity_len < 0)
-		goto error;
-
 	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
 	l += strlen(DM_IMA_VERSION_STR);
 
@@ -411,14 +395,12 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 			      DM_IMA_VERSION_STR, context->dev_name,
 			      context->dev_uuid);
 	}
-
-	memcpy(device_table_data + l, capacity_str, capacity_len);
-	l += capacity_len;
+	l += scnprintf(device_table_data + l, DM_IMA_DEVICE_BUF_LEN - l,
+		       "current_device_capacity=%llu;", dm_ima_capacity(md));
 
 	dm_ima_measure_data("dm_device_resume", device_table_data, l, noio);
 
 error:
-	kfree(capacity_str);
 	kfree(device_table_data);
 
 	smp_mb__before_atomic();
@@ -433,21 +415,18 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
 				     struct dm_ima_context *context,
 				     unsigned int idx)
 {
-	char *device_table_data, *capacity_str = NULL;
+	char *device_table_data;
 	char active_table_str[] = "active_table_hash=";
 	char inactive_table_str[] = "inactive_table_hash=";
 	char device_active_str[] = "device_active_metadata=";
 	char device_inactive_str[] = "device_inactive_metadata=";
-	char remove_all_str[] = "remove_all=";
 	unsigned int active_table_len = strlen(active_table_str);
 	unsigned int inactive_table_len = strlen(inactive_table_str);
 	unsigned int device_active_len = strlen(device_active_str);
 	unsigned int device_inactive_len = strlen(device_inactive_str);
-	unsigned int remove_all_len = strlen(remove_all_str);
 	unsigned int l = 0;
 	bool noio = true;
 	bool nodata = true;
-	int capacity_len;
 
 	wait_event(md->ima.ima_wq,
 		   ((unsigned int)(atomic_read(&md->ima.measure_idx)) == idx));
@@ -460,12 +439,6 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
 	if (!device_table_data)
 		goto exit;
 
-	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
-	if (capacity_len < 0) {
-		kfree(device_table_data);
-		goto exit;
-	}
-
 	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
 	l += strlen(DM_IMA_VERSION_STR);
 
@@ -531,18 +504,13 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
 			      context->dev_uuid);
 	}
 
-	memcpy(device_table_data + l, remove_all_str, remove_all_len);
-	l += remove_all_len;
-	memcpy(device_table_data + l, remove_all ? "y;" : "n;", 2);
-	l += 2;
-
-	memcpy(device_table_data + l, capacity_str, capacity_len);
-	l += capacity_len;
+	l += scnprintf(device_table_data + l, (DM_IMA_DEVICE_BUF_LEN * 2) - l,
+		       "remove_all=%c;current_device_capacity=%llu;",
+		       remove_all ? 'y' : 'n', dm_ima_capacity(md));
 
 	dm_ima_measure_data("dm_device_remove", device_table_data, l, noio);
 
 	kfree(device_table_data);
-	kfree(capacity_str);
 exit:
 	kfree(md->ima.active_table.device_metadata);
 	kfree(md->ima.inactive_table.device_metadata);
@@ -565,12 +533,11 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 				   struct dm_ima_context *context)
 {
 	unsigned int l = 0;
-	char *device_table_data = NULL, *capacity_str = NULL;
+	char *device_table_data = NULL;
 	char inactive_str[] = "inactive_table_hash=";
 	unsigned int inactive_len = strlen(inactive_str);
 	bool noio = true;
 	bool nodata = true;
-	int capacity_len;
 
 	if (unlikely(!context))
 		return;
@@ -584,10 +551,6 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 	if (!device_table_data)
 		goto error;
 
-	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
-	if (capacity_len < 0)
-		goto error;
-
 	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
 	l += strlen(DM_IMA_VERSION_STR);
 
@@ -619,8 +582,8 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 			      context->dev_uuid);
 	}
 
-	memcpy(device_table_data + l, capacity_str, capacity_len);
-	l += capacity_len;
+	l += scnprintf(device_table_data + l, DM_IMA_DEVICE_BUF_LEN - l,
+		       "current_device_capacity=%llu;", dm_ima_capacity(md));
 
 	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
@@ -629,7 +592,6 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 	kfree(md->ima.inactive_table.device_metadata);
 	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
-	kfree(capacity_str);
 	kfree(device_table_data);
 
 	smp_mb__before_atomic();
@@ -644,7 +606,7 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 				     struct dm_ima_context *context)
 {
 	char *old_device_data = NULL;
-	char *combined_device_data = NULL, *capacity_str = NULL;
+	char *combined_device_data = NULL;
 	bool noio = true;
 	int len;
 	struct dm_ima_device_table_metadata *table;
@@ -663,9 +625,6 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 	if (!combined_device_data)
 		goto exit;
 
-	if (dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio) < 0)
-		goto exit;
-
 	if (md->ima.active_table.device_metadata)
 		old_device_data = md->ima.active_table.device_metadata;
 	else if (md->ima.inactive_table.device_metadata)
@@ -673,14 +632,14 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 	else
 		old_device_data = "table_rename=no_data;";
 	len = scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2,
-			"%s%snew_name=%s,new_uuid=%s;%s", DM_IMA_VERSION_STR, old_device_data,
-			context->dev_name, context->dev_uuid, capacity_str);
+			"%s%snew_name=%s,new_uuid=%s;current_device_capacity=%llu;",
+			DM_IMA_VERSION_STR, old_device_data, context->dev_name,
+			context->dev_uuid, dm_ima_capacity(md));
 
 	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
-exit:
-	kfree(capacity_str);
 	kfree(combined_device_data);
 
+exit:
 	if (md->ima.active_table.device_metadata) {
 		table = &md->ima.active_table;
 		dm_ima_copy_device_data(md, table->device_metadata, context,
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 2f2ac69042f2..d8b2438f1571 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -41,6 +41,7 @@ struct dm_ima_device_table_metadata {
 	char *device_metadata;
 	unsigned int device_metadata_len;
 	unsigned int num_targets;
+	sector_t capacity;
 
 	/*
 	 * Contains the sha256 hashes of the IMA measurements of the target
-- 
2.53.0


