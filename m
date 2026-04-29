Return-Path: <linux-integrity+bounces-9384-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANXMIUlo8mkBqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9384-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:21:29 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603A49A137
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4C0330117D8
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B32BE033;
	Wed, 29 Apr 2026 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw51bgoa"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E2392838
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494083; cv=none; b=Coe7tTAfTr9lg4eceUCWEj7FcVX9WESWVtDAv6f8YPS98kj/OUshgfNuyOXhSv0UUiwAH+Y3pkxsk8aVvSTXrWhLPZlktcWKcYXXhuDvBjgrRw0k/yB9IcQloIgb5vEvY4/nhi0T7rEGlaUzmmx0Iyl++ne99k4H4IiJRsi6QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494083; c=relaxed/simple;
	bh=3FxO1iDgb4mxw+gAkK3tavJ9IdmxxEkQ5MUdaG6Vrf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWVujkAPS8nwshj+tgN+yPXQaIG7zoyQZ8X4GWak/zAPZPDpbdsHltLhrXTAmKyTV0UH0gvnluUXTv1ElFFejOVOoH1+Dx9/+MXbnlcp4fVFoqw438YyCHSQ1R1LdMV1kQE+WUYijbM5KslRWeROoLpi8FTCh2+PTNdBB0C7zDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nw51bgoa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777494079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7U6Ubq0Pg8aoyDkNV5MNRlvVVrUWnndqdlDiAOuAX38=;
	b=Nw51bgoagoCdtqk0OnMIVWbQuTK/Ft1T3k4JaBQusmIP+Z4hzjRMVJ84LKAJv5wpv49d5L
	E/raWNwcL3RkKW7B6Hjqjt98+YzWzxBBlrXMA0vXrzbv15SOArdkCiNe8A3EcL4wvgCFv+
	kBgcvgsWwMYNW9kB/hDx6mknz+gGYzc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-9tcjfy1_OAKZwxdCM1kCww-1; Wed,
 29 Apr 2026 16:21:13 -0400
X-MC-Unique: 9tcjfy1_OAKZwxdCM1kCww-1
X-Mimecast-MFC-AGG-ID: 9tcjfy1_OAKZwxdCM1kCww_1777494072
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 606D919560B8;
	Wed, 29 Apr 2026 20:21:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28717195608E;
	Wed, 29 Apr 2026 20:21:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TKLBGg2823320
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:21:11 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TKLBxg2823319;
	Wed, 29 Apr 2026 16:21:11 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen <chenste@linux.microsoft.com>
Subject: [PATCH v2 10/10] dm-ima: use active table's size if available
Date: Wed, 29 Apr 2026 16:21:08 -0400
Message-ID: <20260429202108.2823261-11-bmarzins@redhat.com>
In-Reply-To: <20260429202108.2823261-1-bmarzins@redhat.com>
References: <20260429202108.2823261-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 6603A49A137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9384-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

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
index 5e2efcd1de33..5e7232582feb 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -165,22 +165,10 @@ static void dm_ima_measure_data(const char *event_name, const void *buf, size_t
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
@@ -320,6 +308,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table,
 	table->md->ima.inactive_table.hash = digest_buf;
 	table->md->ima.inactive_table.hash_len = strlen(digest_buf);
 	table->md->ima.inactive_table.num_targets = num_targets;
+	table->md->ima.inactive_table.capacity = dm_table_get_size(table);
 
 
 	kfree(table->md->ima.inactive_table.device_metadata);
@@ -344,13 +333,12 @@ void dm_ima_measure_on_table_load(struct dm_table *table,
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
@@ -381,10 +369,6 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 	if (!device_table_data)
 		goto error;
 
-	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
-	if (capacity_len < 0)
-		goto error;
-
 	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
 	l += strlen(DM_IMA_VERSION_STR);
 
@@ -417,14 +401,12 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
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
 
 	wake_next_measure(&md->ima);
@@ -437,21 +419,18 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
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
 
 	wait_to_measure(&md->ima, idx);
 
@@ -462,12 +441,6 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
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
 
@@ -533,18 +506,13 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
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
@@ -581,10 +548,6 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 	if (!device_table_data)
 		goto error;
 
-	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
-	if (capacity_len < 0)
-		goto error;
-
 	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
 	l += strlen(DM_IMA_VERSION_STR);
 
@@ -616,8 +579,8 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 			      context->dev_uuid);
 	}
 
-	memcpy(device_table_data + l, capacity_str, capacity_len);
-	l += capacity_len;
+	l += scnprintf(device_table_data + l, DM_IMA_DEVICE_BUF_LEN - l,
+		       "current_device_capacity=%llu;", dm_ima_capacity(md));
 
 	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
@@ -626,7 +589,6 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 	kfree(md->ima.inactive_table.device_metadata);
 	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
-	kfree(capacity_str);
 	kfree(device_table_data);
 
 	wake_next_measure(&md->ima);
@@ -639,7 +601,7 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 				     struct dm_ima_context *context)
 {
 	char *old_device_data = NULL;
-	char *combined_device_data = NULL, *capacity_str = NULL;
+	char *combined_device_data = NULL;
 	bool noio = true;
 	int len;
 	struct dm_ima_device_table_metadata *table;
@@ -655,9 +617,6 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 	if (!combined_device_data)
 		goto exit;
 
-	if (dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio) < 0)
-		goto exit;
-
 	if (md->ima.active_table.device_metadata)
 		old_device_data = md->ima.active_table.device_metadata;
 	else if (md->ima.inactive_table.device_metadata)
@@ -665,14 +624,14 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 	else
 		old_device_data = "device_rename=no_data;";
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
index b240e0e4b6a1..0ec013d1545c 100644
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


