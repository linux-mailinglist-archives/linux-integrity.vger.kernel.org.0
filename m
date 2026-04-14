Return-Path: <linux-integrity+bounces-9170-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBeZIFaK3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9170-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FA3F479A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AB3307BC9D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F81EB5E3;
	Tue, 14 Apr 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtfW/Gg1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE81D435F
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126173; cv=none; b=Tqf2nJxazg3gRU5LT6mFqUtXhdIeVkUPBejFEf/f2WWsCrE90YtzpekoE2bQQMbZFHG59thvkywDLdOidC40J9T/hP5NPyVKIWnU8m1Re4goa1APAfqSKouFSolvI1Wi8OyuBgZ03G3s5xd9vRUJ1jVTS5dsWnkI4FmQuWEx62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126173; c=relaxed/simple;
	bh=oJqgsRVkN7UURay6artYs8hQLj3pGxKNJkWP7aSDqZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG5afX60x1AcGtuEx1goCHI8eD1Dp27udFyt00rA56vjsO6aRahRAtgdYPlM/GhNzRAcFEF+GtVQDF1NsGwc6RDZhH2kWAZCAGngRhrWXV6B8XZgMWSFRSFhROuL0X6rP/SorDgI4hVkcNbCHGbhfBv8uXILktlrDSnyGnR+//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtfW/Gg1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErntMWwTjWFjqXJ+IfC4avVFNuyBUNfcr2n7ZuWg/Ow=;
	b=LtfW/Gg1g6d0h1diS1UaaSjEiFV9MnlgMoA9vrbdRzdr3LUlAmurxYMVfcUUdNn51VqAIr
	q4IzgRzqUnh6I4kT2dOYBphc/x7dqOTmdi1z6538TI0ihlM7LlUSbKx47bBL1cUXXwoWyN
	3cqTl0dreRUVg6C+w03ZxxDDx8C9Q1g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-rdIWmFKKPSWoHWri1zTxBg-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: rdIWmFKKPSWoHWri1zTxBg-1
X-Mimecast-MFC-AGG-ID: rdIWmFKKPSWoHWri1zTxBg_1776126167
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34174195609F;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B628019560B1;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mjk91917486
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:45 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0MjBj1917485;
	Mon, 13 Apr 2026 20:22:45 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 05/10] dm-ima: Fix UAF errors and measuring incorrect context
Date: Mon, 13 Apr 2026 20:22:39 -0400
Message-ID: <20260414002244.1917447-6-bmarzins@redhat.com>
In-Reply-To: <20260414002244.1917447-1-bmarzins@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9170-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.960];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D69FA3F479A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

the dm-ima code did not keep the dm_ima_measure_on_* functions from
running at the same time. This could lead to various errors. If two
processes were updating the device state, one could update the state
first, but the other could measure the state first, causing the the
current device state to appear incorrect. If a table load happened while
a device was resuming, the IMA measurement could report the wrong table
being active. And if two dm_ima_measure_on_* functions ran at the same
time, one of them could free data that the other was accessing, causing
a crash.

All the core dm functions that call a dm_ima_measure_on_* function
update the device state they want to measure under the _hash_lock,
except for do_resume(). But holding the _hash_lock is not a good way to
synchronize these functions. It's a global mutex, that is needed in may
dm operations, and the dm_ima_measure_* functions can sleep, blocking
any dm operation on any device that needs the _hash_lock.

To serialize and order the IMA measurement functions, the
dm_ima_measurements now has two counters. One is updated while holding
the _hash_lock and stored, along with the device name and uuid, in a
dm_ima_context struct. Once the _hash_lock is dropped, the
dm_ima_measure_* function is called. It waits unit the other counter
matches the value it stored. Then it measures the device, updates second
counter, and wakes up any other functions waiting on that counter. This
makes sure that the measurements are serialized and done in the order
that the _hash_lock was acquired in. But they only block other
dm_ima_measure_* functions for the same device, which should happen only
rarely.

do_resume() is trickier, because it removes the inactive table while
holding the _hash_lock, but doesn't hold it while updating md->map. To
make sure it is also ordered, the IMA code grabs the _hash_lock after
md->map is updated. Then it makes sure that the device isn't being
removed and that another do_resume() hasn't already changed the active
table again, and serializes like the other functions do.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c   | 271 +++++++++++++++++++++++++-----------------
 drivers/md/dm-ima.h   |  64 ++++++++--
 drivers/md/dm-ioctl.c | 144 ++++++++++++++++++++--
 drivers/md/dm.c       |   2 +
 4 files changed, 350 insertions(+), 131 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index c141068bc6b4..e8fa049c6317 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -21,25 +21,32 @@
  * character, so that they don't interfere with the construction of key-value pairs,
  * and clients can split the key1=val1,key2=val2,key3=val3; pairs properly.
  */
-static void fix_separator_chars(char **buf)
+static void fix_separator_chars(char *buf)
 {
-	int l = strlen(*buf);
+	int l = strlen(buf);
 	int i, j, sp = 0;
 
 	for (i = 0; i < l; i++)
-		if ((*buf)[i] == '\\' || (*buf)[i] == ';' || (*buf)[i] == '=' || (*buf)[i] == ',')
+		if (buf[i] == '\\' || buf[i] == ';' || buf[i] == '=' || buf[i] == ',')
 			sp++;
 
 	if (!sp)
 		return;
 
+	buf[l + sp] = '\0';
 	for (i = l-1, j = i+sp; i >= 0; i--) {
-		(*buf)[j--] = (*buf)[i];
-		if ((*buf)[i] == '\\' || (*buf)[i] == ';' || (*buf)[i] == '=' || (*buf)[i] == ',')
-			(*buf)[j--] = '\\';
+		buf[j--] = buf[i];
+		if (buf[i] == '\\' || buf[i] == ';' || buf[i] == '=' || buf[i] == ',')
+			buf[j--] = '\\';
 	}
 }
 
+static void fix_context_strings(struct dm_ima_context *context)
+{
+	fix_separator_chars(context->dev_name);
+	fix_separator_chars(context->dev_uuid);
+}
+
 /*
  * Internal function to allocate memory for IMA measurements.
  */
@@ -59,68 +66,75 @@ static void *dm_ima_alloc(size_t len, bool noio)
 	return ptr;
 }
 
-/*
- * Internal function to allocate and copy name and uuid for IMA measurements.
- */
-static int dm_ima_alloc_and_copy_name_uuid(struct mapped_device *md, char **dev_name,
-					   char **dev_uuid, bool noio)
+void dm_ima_init(struct mapped_device *md)
 {
-	int r;
-	*dev_name = dm_ima_alloc(DM_NAME_LEN*2, noio);
-	if (!(*dev_name)) {
-		r = -ENOMEM;
-		goto error;
-	}
+	md->ima.update_idx = 0;
+	atomic_set(&md->ima.measure_idx, 0);
+	init_waitqueue_head(&md->ima.ima_wq);
+}
 
-	*dev_uuid = dm_ima_alloc(DM_UUID_LEN*2, noio);
-	if (!(*dev_uuid)) {
-		r = -ENOMEM;
-		goto error;
+void dm_ima_alloc_context(struct dm_ima_context **context, bool noio)
+{
+	*context = dm_ima_alloc(sizeof(struct dm_ima_context), noio);
+}
+
+void dm_ima_free_context(struct dm_ima_context *context)
+{
+	if (likely(context)) {
+		kfree(context->table.device_metadata);
+		kfree(context->table.hash);
+		kfree(context);
 	}
+}
 
-	r = dm_copy_name_and_uuid(md, *dev_name, *dev_uuid);
-	if (r)
-		goto error;
+/*
+ * Helper function for swapping the table, to make sure that the
+ * correct table metadata is saved and restored.
+ */
+void dm_ima_context_table_op(struct mapped_device *md,
+			     struct dm_ima_context *context,
+			     enum dm_ima_table_op op)
+{
+	struct dm_ima_measurements *ima = &md->ima;
 
-	fix_separator_chars(dev_name);
-	fix_separator_chars(dev_uuid);
+	if (unlikely(!context))
+		return;
 
-	return 0;
-error:
-	kfree(*dev_name);
-	kfree(*dev_uuid);
-	*dev_name = NULL;
-	*dev_uuid = NULL;
-	return r;
+	wait_event(ima->ima_wq,
+		   ((unsigned int)(atomic_read(&ima->measure_idx)) ==
+		    context->update_idx));
+	smp_mb();
+
+	if (op == DM_IMA_TABLE_SAVE) {
+		context->table = ima->inactive_table;
+		memset(&ima->inactive_table, 0, sizeof(ima->inactive_table));
+	} else {
+		ima->inactive_table = context->table;
+		memset(&context->table, 0, sizeof(context->table));
+	}
+
+	smp_mb__before_atomic();
+	atomic_inc(&ima->measure_idx);
+	wake_up_all(&ima->ima_wq);
 }
 
 /*
  * Internal function to allocate and copy device data for IMA measurements.
  */
 static int dm_ima_alloc_and_copy_device_data(struct mapped_device *md, char **device_data,
+					     struct dm_ima_context *context,
 					     unsigned int num_targets, bool noio)
 {
-	char *dev_name = NULL, *dev_uuid = NULL;
-	int r;
-
-	r = dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio);
-	if (r)
-		return r;
-
 	*device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
-	if (!(*device_data)) {
-		r = -ENOMEM;
-		goto error;
-	}
+	if (!(*device_data))
+		return -ENOMEM;
 
 	scnprintf(*device_data, DM_IMA_DEVICE_BUF_LEN,
 		  "name=%s,uuid=%s,major=%d,minor=%d,minor_count=%d,num_targets=%u;",
-		  dev_name, dev_uuid, md->disk->major, md->disk->first_minor,
-		  md->disk->minors, num_targets);
-error:
-	kfree(dev_name);
-	kfree(dev_uuid);
-	return r;
+		  context->dev_name, context->dev_uuid, md->disk->major,
+		  md->disk->first_minor, md->disk->minors, num_targets);
+
+	return 0;
 }
 
 /*
@@ -162,7 +176,8 @@ static int dm_ima_alloc_and_copy_capacity_str(struct mapped_device *md, char **c
 /*
  * Build up the IMA data for each target, and finally measure.
  */
-void dm_ima_measure_on_table_load(struct dm_table *table)
+void dm_ima_measure_on_table_load(struct dm_table *table,
+				  struct dm_ima_context *context)
 {
 	size_t device_data_buf_len, target_metadata_buf_len, target_data_buf_len, l = 0;
 	char *target_metadata_buf = NULL, *target_data_buf = NULL, *digest_buf = NULL;
@@ -175,9 +190,17 @@ void dm_ima_measure_on_table_load(struct dm_table *table)
 	bool noio = false;
 	char table_load_event_name[] = "dm_table_load";
 
+	if (unlikely(!context))
+		return;
+
+	wait_event(table->md->ima.ima_wq,
+		   ((unsigned int)(atomic_read(&table->md->ima.measure_idx)) ==
+		    context->update_idx));
+	smp_mb();
+
 	ima_buf = dm_ima_alloc(DM_IMA_MEASUREMENT_BUF_LEN, noio);
 	if (!ima_buf)
-		return;
+		goto error;
 
 	target_metadata_buf = dm_ima_alloc(DM_IMA_TARGET_METADATA_BUF_LEN, noio);
 	if (!target_metadata_buf)
@@ -189,7 +212,9 @@ void dm_ima_measure_on_table_load(struct dm_table *table)
 
 	num_targets = table->num_targets;
 
-	if (dm_ima_alloc_and_copy_device_data(table->md, &device_data_buf, num_targets, noio))
+	fix_context_strings(context);
+	if (dm_ima_alloc_and_copy_device_data(table->md, &device_data_buf,
+					      context, num_targets, noio))
 		goto error;
 
 	sha256_init(&hash_ctx);
@@ -299,14 +324,19 @@ void dm_ima_measure_on_table_load(struct dm_table *table)
 	kfree(ima_buf);
 	kfree(target_metadata_buf);
 	kfree(target_data_buf);
+
+	smp_mb__before_atomic();
+	atomic_inc(&table->md->ima.measure_idx);
+	wake_up_all(&table->md->ima.ima_wq);
 }
 
 /*
  * Measure IMA data on device resume.
  */
-void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
+void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
+				     struct dm_ima_context *context)
 {
-	char *device_table_data, *dev_name = NULL, *dev_uuid = NULL, *capacity_str = NULL;
+	char *device_table_data = NULL, *capacity_str = NULL;
 	char active[] = "active_table_hash=";
 	unsigned int active_len = strlen(active);
 	unsigned int l = 0;
@@ -314,9 +344,17 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	bool nodata = true;
 	int capacity_len;
 
+	if (unlikely(!context))
+		return;
+
+	wait_event(md->ima.ima_wq,
+		   ((unsigned int)(atomic_read(&md->ima.measure_idx)) ==
+		    context->update_idx));
+	smp_mb();
+
 	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
 	if (!device_table_data)
-		return;
+		goto error;
 
 	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
 	if (capacity_len < 0)
@@ -328,25 +366,8 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	if (swap) {
 		kfree(md->ima.active_table.hash);
 		kfree(md->ima.active_table.device_metadata);
-		memset(&md->ima.active_table, 0, sizeof(md->ima.active_table));
-
-		if (md->ima.inactive_table.hash) {
-			md->ima.active_table.hash = md->ima.inactive_table.hash;
-			md->ima.active_table.hash_len = md->ima.inactive_table.hash_len;
-			md->ima.inactive_table.hash = NULL;
-			md->ima.inactive_table.hash_len = 0;
-		}
-
-		if (md->ima.inactive_table.device_metadata) {
-			md->ima.active_table.device_metadata =
-				md->ima.inactive_table.device_metadata;
-			md->ima.active_table.device_metadata_len =
-				md->ima.inactive_table.device_metadata_len;
-			md->ima.active_table.num_targets = md->ima.inactive_table.num_targets;
-			md->ima.inactive_table.device_metadata = NULL;
-			md->ima.inactive_table.device_metadata_len = 0;
-			md->ima.inactive_table.num_targets = 0;
-		}
+		md->ima.active_table = context->table;
+		memset(&context->table, 0, sizeof(context->table));
 	}
 
 	if (md->ima.active_table.device_metadata) {
@@ -372,12 +393,11 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	}
 
 	if (nodata) {
-		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
-			goto error;
-
+		fix_context_strings(context);
 		l = scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
 			      "%sname=%s,uuid=%s;device_resume=no_data;",
-			      DM_IMA_VERSION_STR, dev_name, dev_uuid);
+			      DM_IMA_VERSION_STR, context->dev_name,
+			      context->dev_uuid);
 	}
 
 	memcpy(device_table_data + l, capacity_str, capacity_len);
@@ -385,19 +405,23 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 
 	dm_ima_measure_data("dm_device_resume", device_table_data, l, noio);
 
-	kfree(dev_name);
-	kfree(dev_uuid);
 error:
 	kfree(capacity_str);
 	kfree(device_table_data);
+
+	smp_mb__before_atomic();
+	atomic_inc(&md->ima.measure_idx);
+	wake_up_all(&md->ima.ima_wq);
 }
 
 /*
  * Measure IMA data on remove.
  */
-void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
+void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
+				     struct dm_ima_context *context,
+				     unsigned int idx)
 {
-	char *device_table_data, *dev_name = NULL, *dev_uuid = NULL, *capacity_str = NULL;
+	char *device_table_data, *capacity_str = NULL;
 	char active_table_str[] = "active_table_hash=";
 	char inactive_table_str[] = "inactive_table_hash=";
 	char device_active_str[] = "device_active_metadata=";
@@ -413,6 +437,13 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	bool nodata = true;
 	int capacity_len;
 
+	wait_event(md->ima.ima_wq,
+		   ((unsigned int)(atomic_read(&md->ima.measure_idx)) == idx));
+	smp_mb();
+
+	if (unlikely(!context))
+		goto exit;
+
 	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN*2, noio);
 	if (!device_table_data)
 		goto exit;
@@ -481,12 +512,11 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	 * in IMA measurements.
 	 */
 	if (nodata) {
-		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
-			goto error;
-
+		fix_context_strings(context);
 		l = scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
 			      "%sname=%s,uuid=%s;device_remove=no_data;",
-			      DM_IMA_VERSION_STR, dev_name, dev_uuid);
+			      DM_IMA_VERSION_STR, context->dev_name,
+			      context->dev_uuid);
 	}
 
 	memcpy(device_table_data + l, remove_all_str, remove_all_len);
@@ -499,7 +529,6 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 
 	dm_ima_measure_data("dm_device_remove", device_table_data, l, noio);
 
-error:
 	kfree(device_table_data);
 	kfree(capacity_str);
 exit:
@@ -512,30 +541,40 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	memset(&md->ima.active_table, 0, sizeof(md->ima.active_table));
 	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
-	kfree(dev_name);
-	kfree(dev_uuid);
+	smp_mb__before_atomic();
+	atomic_inc(&md->ima.measure_idx);
+	wake_up_all(&md->ima.ima_wq);
 }
 
 /*
  * Measure ima data on table clear.
  */
-void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
+void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
+				   struct dm_ima_context *context)
 {
 	unsigned int l = 0;
-	char *device_table_data = NULL, *dev_name = NULL, *dev_uuid = NULL, *capacity_str = NULL;
+	char *device_table_data = NULL, *capacity_str = NULL;
 	char inactive_str[] = "inactive_table_hash=";
 	unsigned int inactive_len = strlen(inactive_str);
 	bool noio = true;
 	bool nodata = true;
 	int capacity_len;
 
+	if (unlikely(!context))
+		return;
+
+	wait_event(md->ima.ima_wq,
+		   ((unsigned int)(atomic_read(&md->ima.measure_idx)) ==
+		    context->update_idx));
+	smp_mb();
+
 	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
 	if (!device_table_data)
-		return;
+		goto error;
 
 	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
 	if (capacity_len < 0)
-		goto error1;
+		goto error;
 
 	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
 	l += strlen(DM_IMA_VERSION_STR);
@@ -561,12 +600,11 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	}
 
 	if (nodata) {
-		if (dm_ima_alloc_and_copy_name_uuid(md, &dev_name, &dev_uuid, noio))
-			goto error2;
-
+		fix_context_strings(context);
 		l = scnprintf(device_table_data, DM_IMA_DEVICE_BUF_LEN,
 			      "%sname=%s,uuid=%s;table_clear=no_data;",
-			      DM_IMA_VERSION_STR, dev_name, dev_uuid);
+			      DM_IMA_VERSION_STR, context->dev_name,
+			      context->dev_uuid);
 	}
 
 	memcpy(device_table_data + l, capacity_str, capacity_len);
@@ -580,29 +618,38 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 		memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 	}
 
-	kfree(dev_name);
-	kfree(dev_uuid);
-error2:
+error:
 	kfree(capacity_str);
-error1:
 	kfree(device_table_data);
+
+	smp_mb__before_atomic();
+	atomic_inc(&md->ima.measure_idx);
+	wake_up_all(&md->ima.ima_wq);
 }
 
 /*
  * Measure IMA data on device rename.
  */
-void dm_ima_measure_on_device_rename(struct mapped_device *md)
+void dm_ima_measure_on_device_rename(struct mapped_device *md,
+				     struct dm_ima_context *context)
 {
-	char *old_device_data = NULL, *new_device_data = NULL, *combined_device_data = NULL;
-	char *new_dev_name = NULL, *new_dev_uuid = NULL, *capacity_str = NULL;
+	char *old_device_data = NULL, *new_device_data = NULL;
+	char *combined_device_data = NULL, *capacity_str = NULL;
 	bool noio = true;
 	int len;
 
-	if (dm_ima_alloc_and_copy_device_data(md, &new_device_data,
-					      md->ima.active_table.num_targets, noio))
+	if (unlikely(!context))
 		return;
 
-	if (dm_ima_alloc_and_copy_name_uuid(md, &new_dev_name, &new_dev_uuid, noio))
+	wait_event(md->ima.ima_wq,
+		   ((unsigned int)(atomic_read(&md->ima.measure_idx)) ==
+		    context->update_idx));
+	smp_mb();
+
+	fix_context_strings(context);
+	if (dm_ima_alloc_and_copy_device_data(md, &new_device_data, context,
+					      md->ima.active_table.num_targets,
+					      noio))
 		goto error;
 
 	combined_device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN * 2, noio);
@@ -619,7 +666,7 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 
 	len = scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2,
 			"%s%snew_name=%s,new_uuid=%s;%s", DM_IMA_VERSION_STR, old_device_data,
-			new_dev_name, new_dev_uuid, capacity_str);
+			context->dev_name, context->dev_uuid, capacity_str);
 
 	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
 
@@ -631,6 +678,8 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md)
 	kfree(capacity_str);
 	kfree(combined_device_data);
 	kfree(old_device_data);
-	kfree(new_dev_name);
-	kfree(new_dev_uuid);
+
+	smp_mb__before_atomic();
+	atomic_inc(&md->ima.measure_idx);
+	wake_up_all(&md->ima.ima_wq);
 }
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index c0548492bef0..9e1b654867d9 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -24,6 +24,11 @@
 	__dm_ima_str(DM_VERSION_MINOR) "."	\
 	__dm_ima_str(DM_VERSION_PATCHLEVEL) ";"
 
+enum dm_ima_table_op {
+	DM_IMA_TABLE_SAVE,
+	DM_IMA_TABLE_RESTORE,
+};
+
 #ifdef CONFIG_IMA
 
 struct dm_ima_device_table_metadata {
@@ -45,28 +50,67 @@ struct dm_ima_device_table_metadata {
 	unsigned int hash_len;
 };
 
+struct dm_ima_context {
+	struct dm_ima_device_table_metadata table;
+	unsigned int update_idx;
+	char dev_name[DM_NAME_LEN*2];
+	char dev_uuid[DM_UUID_LEN*2];
+};
+
 /*
  * This structure contains device metadata, and table hash for
  * active and inactive tables for ima measurements.
  */
 struct dm_ima_measurements {
+	unsigned int update_idx;
+	atomic_t measure_idx;
+	struct wait_queue_head ima_wq;
 	struct dm_ima_device_table_metadata active_table;
 	struct dm_ima_device_table_metadata inactive_table;
 };
 
-void dm_ima_measure_on_table_load(struct dm_table *table);
-void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
-void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
-void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map);
-void dm_ima_measure_on_device_rename(struct mapped_device *md);
+void dm_ima_init(struct mapped_device *md);
+void dm_ima_alloc_context(struct dm_ima_context **context, bool noio);
+void dm_ima_free_context(struct dm_ima_context *context);
+void dm_ima_context_table_op(struct mapped_device *md,
+			     struct dm_ima_context *context,
+			     enum dm_ima_table_op op);
+void dm_ima_measure_on_table_load(struct dm_table *table,
+				  struct dm_ima_context *context);
+void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
+				     struct dm_ima_context *context);
+void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
+				     struct dm_ima_context *context,
+				     unsigned int idx);
+void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
+				   struct dm_ima_context *context);
+void dm_ima_measure_on_device_rename(struct mapped_device *md,
+				     struct dm_ima_context *context);
 
 #else
 
-static inline void dm_ima_measure_on_table_load(struct dm_table *table) {}
-static inline void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
-static inline void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
-static inline void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map) {}
-static inline void dm_ima_measure_on_device_rename(struct mapped_device *md) {}
+struct dm_ima_context;
+
+static inline void dm_ima_init(struct mapped_device *md) {}
+static inline void dm_ima_alloc_context(struct dm_ima_context **context, bool noio) {}
+static inline void dm_ima_free_context(struct dm_ima_context *context) {}
+static inline void dm_ima_context_table_op(struct mapped_device *md,
+					   struct dm_ima_context *context,
+					   enum dm_ima_table_op op) {}
+static inline void dm_ima_measure_on_table_load(struct dm_table *table,
+						struct dm_ima_context *context) {}
+static inline void dm_ima_measure_on_device_resume(struct mapped_device *md,
+						   bool swap,
+						   struct dm_ima_context *context) {}
+static inline void dm_ima_measure_on_device_remove(struct mapped_device *md,
+						   bool remove_all,
+						   struct dm_ima_context *context,
+						   unsigned int idx) {}
+static inline void dm_ima_measure_on_table_clear(struct mapped_device *md,
+						 bool new_map,
+						 struct dm_ima_context *context) {}
+static inline void dm_ima_measure_on_device_rename(struct mapped_device *md,
+						   struct dm_ima_context *context) {}
 
 #endif /* CONFIG_IMA */
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 1a0dd4981d03..16609882aa92 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -259,6 +259,80 @@ static void free_cell(struct hash_cell *hc)
 	}
 }
 
+#ifdef CONFIG_IMA
+
+/*
+ * Called while holding to _hash_lock, to guarantee the ordering of the
+ * following dm_ima_measure_on_* functions, which should be called
+ * right after dropping the _hash_lock
+ */
+static unsigned int dm_ima_init_context(struct hash_cell *hc,
+					struct dm_ima_context *context,
+				        bool need_idx)
+{
+	lockdep_assert_held(&_hash_lock);
+
+	if (unlikely(!context))
+		return need_idx ? hc->md->ima.update_idx++ : 0;
+
+	context->update_idx = hc->md->ima.update_idx++;
+	strcpy(context->dev_name, hc->name);
+	strcpy(context->dev_uuid, hc->uuid ? : "");
+
+	return context->update_idx;
+}
+
+/*
+ * Called by do_resume() to guarantee that correct ordering, since
+ * it do_resume() does not grab the _hash_lock, either when the table
+ * is not getting swapped, or when swapping the active table
+ */
+static bool dm_ima_need_measure(struct mapped_device *md,
+				struct dm_table *table,
+				struct dm_ima_context *context)
+{
+	int srcu_idx;
+	struct hash_cell *hc;
+	bool need_measure = false;
+
+	if (unlikely(!context))
+		return false;
+
+	down_write(&_hash_lock);
+	/* Check if the device has been removed */
+	hc = dm_get_mdptr(md);
+	if (hc) {
+		/*
+		 * If we have a table, we need to make sure that it's the
+		 * active table. Otherwise we raced with another process
+		 * setting the active table and it will do the measurement
+		 */
+		if (!table || dm_get_live_table(md, &srcu_idx) == table) {
+			dm_ima_init_context(hc, context, false);
+			need_measure = true;
+		}
+		if (table)
+			dm_put_live_table(md, srcu_idx);
+	}
+	up_write(&_hash_lock);
+
+	return need_measure;
+}
+#else
+static inline unsigned int dm_ima_init_context(struct hash_cell *hc,
+					       struct dm_ima_context *context,
+					       bool neex_idx)
+{
+	return 0;
+}
+static inline bool dm_ima_need_measure(struct mapped_device *md,
+				       struct dm_table *table,
+				       struct dm_ima_context *context)
+{
+	return false;
+}
+#endif
+
 /*
  * The kdev_t and uuid of a device can never change once it is
  * initially inserted.
@@ -344,7 +418,10 @@ static int dm_hash_remove_all(unsigned flags)
 	struct hash_cell *hc;
 	struct mapped_device *md;
 	struct dm_table *t;
+	struct dm_ima_context *ima_context = NULL;
+	unsigned int ima_idx;
 
+	dm_ima_alloc_context(&ima_context, true);
 retry:
 	dev_skipped = 0;
 
@@ -353,6 +430,7 @@ static int dm_hash_remove_all(unsigned flags)
 	for (n = rb_first(&name_rb_tree); n; n = rb_next(n)) {
 		if (flags & DM_REMOVE_INTERRUPTIBLE && fatal_signal_pending(current)) {
 			up_write(&_hash_lock);
+			dm_ima_free_context(ima_context);
 			return -EINTR;
 		}
 
@@ -367,6 +445,7 @@ static int dm_hash_remove_all(unsigned flags)
 			continue;
 		}
 
+		ima_idx = dm_ima_init_context(hc, ima_context, true);
 		t = __hash_remove(hc);
 
 		up_write(&_hash_lock);
@@ -375,7 +454,7 @@ static int dm_hash_remove_all(unsigned flags)
 			dm_sync_table(md);
 			dm_table_destroy(t);
 		}
-		dm_ima_measure_on_device_remove(md, true);
+		dm_ima_measure_on_device_remove(md, true, ima_context, ima_idx);
 		dm_put(md);
 		if (likely(flags & DM_REMOVE_KEEP_OPEN_DEVICES))
 			dm_destroy(md);
@@ -396,6 +475,7 @@ static int dm_hash_remove_all(unsigned flags)
 	if (dev_skipped && !(flags & DM_REMOVE_ONLY_DEFERRED))
 		DMWARN("remove_all left %d open device(s)", dev_skipped);
 
+	dm_ima_free_context(ima_context);
 	return 0;
 }
 
@@ -443,6 +523,7 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 	struct mapped_device *md;
 	unsigned int change_uuid = (param->flags & DM_UUID_FLAG) ? 1 : 0;
 	int srcu_idx;
+	struct dm_ima_context *ima_context = NULL;
 
 	/*
 	 * duplicate new.
@@ -451,6 +532,7 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 	if (!new_data)
 		return ERR_PTR(-ENOMEM);
 
+	dm_ima_alloc_context(&ima_context, true);
 	down_write(&_hash_lock);
 
 	/*
@@ -467,6 +549,7 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 		      param->name, new);
 		dm_put(hc->md);
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		kfree(new_data);
 		return ERR_PTR(-EBUSY);
 	}
@@ -479,6 +562,7 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 		DMERR("Unable to rename non-existent device, %s to %s%s",
 		      param->name, change_uuid ? "uuid " : "", new);
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		kfree(new_data);
 		return ERR_PTR(-ENXIO);
 	}
@@ -492,6 +576,7 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 		      param->name, new, hc->uuid);
 		dm_put(hc->md);
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		kfree(new_data);
 		return ERR_PTR(-EINVAL);
 	}
@@ -514,9 +599,11 @@ static struct mapped_device *dm_hash_rename(struct dm_ioctl *param,
 
 	md = hc->md;
 
-	dm_ima_measure_on_device_rename(md);
+	dm_ima_init_context(hc, ima_context, false);
 
 	up_write(&_hash_lock);
+	dm_ima_measure_on_device_rename(md, ima_context);
+	dm_ima_free_context(ima_context);
 	kfree(old_name);
 
 	return md;
@@ -995,13 +1082,17 @@ static int dev_remove(struct file *filp, struct dm_ioctl *param, size_t param_si
 	struct mapped_device *md;
 	int r;
 	struct dm_table *t;
+	struct dm_ima_context *ima_context = NULL;
+	unsigned int ima_idx;
 
+	dm_ima_alloc_context(&ima_context, true);
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
 
 	if (!hc) {
 		DMDEBUG_LIMIT("device doesn't appear to be in the dev hash table.");
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		return -ENXIO;
 	}
 
@@ -1015,14 +1106,17 @@ static int dev_remove(struct file *filp, struct dm_ioctl *param, size_t param_si
 		if (r == -EBUSY && param->flags & DM_DEFERRED_REMOVE) {
 			up_write(&_hash_lock);
 			dm_put(md);
+			dm_ima_free_context(ima_context);
 			return 0;
 		}
 		DMDEBUG_LIMIT("unable to remove open device %s", hc->name);
 		up_write(&_hash_lock);
 		dm_put(md);
+		dm_ima_free_context(ima_context);
 		return r;
 	}
 
+	ima_idx = dm_ima_init_context(hc, ima_context, true);
 	t = __hash_remove(hc);
 	up_write(&_hash_lock);
 
@@ -1033,7 +1127,8 @@ static int dev_remove(struct file *filp, struct dm_ioctl *param, size_t param_si
 
 	param->flags &= ~DM_DEFERRED_REMOVE;
 
-	dm_ima_measure_on_device_remove(md, false);
+	dm_ima_measure_on_device_remove(md, false, ima_context, ima_idx);
+	dm_ima_free_context(ima_context);
 
 	if (!dm_kobject_uevent(md, KOBJ_REMOVE, param->event_nr, false))
 		param->flags |= DM_UEVENT_GENERATED_FLAG;
@@ -1169,13 +1264,16 @@ static int do_resume(struct dm_ioctl *param)
 	struct mapped_device *md;
 	struct dm_table *new_map, *old_map = NULL;
 	bool need_resize_uevent = false;
+	struct dm_ima_context *ima_context = NULL;
 
+	dm_ima_alloc_context(&ima_context, true);
 	down_write(&_hash_lock);
 
 	hc = __find_device_hash_cell(param);
 	if (!hc) {
 		DMDEBUG_LIMIT("device doesn't appear to be in the dev hash table.");
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		return -ENXIO;
 	}
 
@@ -1184,13 +1282,15 @@ static int do_resume(struct dm_ioctl *param)
 	new_map = hc->new_map;
 	hc->new_map = NULL;
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
+	if (new_map)
+		dm_ima_init_context(hc, ima_context, false);
 	up_write(&_hash_lock);
 
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
 
+		dm_ima_context_table_op(md, ima_context, DM_IMA_TABLE_SAVE);
 		/* Suspend if it isn't already suspended */
 		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
@@ -1204,6 +1304,8 @@ static int do_resume(struct dm_ioctl *param)
 				if (hc && !hc->new_map) {
 					hc->new_map = new_map;
 					new_map = NULL;
+					dm_ima_init_context(hc, ima_context,
+							    false);
 				} else {
 					r = -ENXIO;
 				}
@@ -1211,7 +1313,9 @@ static int do_resume(struct dm_ioctl *param)
 				if (new_map) {
 					dm_sync_table(md);
 					dm_table_destroy(new_map);
-				}
+				} else
+					dm_ima_context_table_op(md, ima_context, DM_IMA_TABLE_RESTORE);
+				dm_ima_free_context(ima_context);
 				dm_put(md);
 				return r;
 			}
@@ -1222,9 +1326,12 @@ static int do_resume(struct dm_ioctl *param)
 		if (IS_ERR(old_map)) {
 			dm_sync_table(md);
 			dm_table_destroy(new_map);
+			dm_ima_free_context(ima_context);
 			dm_put(md);
 			return PTR_ERR(old_map);
 		}
+		if (dm_ima_need_measure(md, new_map, ima_context))
+			dm_ima_measure_on_device_resume(md, true, ima_context);
 		new_size = dm_get_size(md);
 		if (old_size && new_size && old_size != new_size)
 			need_resize_uevent = true;
@@ -1238,7 +1345,10 @@ static int do_resume(struct dm_ioctl *param)
 	if (dm_suspended_md(md)) {
 		r = dm_resume(md);
 		if (!r) {
-			dm_ima_measure_on_device_resume(md, new_map ? true : false);
+			if (!new_map && dm_ima_need_measure(md, NULL,
+							    ima_context))
+				dm_ima_measure_on_device_resume(md, false,
+								ima_context);
 
 			if (!dm_kobject_uevent(md, KOBJ_CHANGE, param->event_nr, need_resize_uevent))
 				param->flags |= DM_UEVENT_GENERATED_FLAG;
@@ -1255,6 +1365,7 @@ static int do_resume(struct dm_ioctl *param)
 	if (!r)
 		__dev_status(md, param);
 
+	dm_ima_free_context(ima_context);
 	dm_put(md);
 	return r;
 }
@@ -1528,11 +1639,12 @@ static bool is_valid_type(enum dm_queue_mode cur, enum dm_queue_mode new)
 
 static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_size)
 {
-	int r;
+	int r, srcu_idx;
 	struct hash_cell *hc;
 	struct dm_table *t, *old_map = NULL;
 	struct mapped_device *md;
 	struct target_type *immutable_target_type;
+	struct dm_ima_context *ima_context = NULL;
 
 	md = find_device(param);
 	if (!md)
@@ -1548,8 +1660,6 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (r)
 		goto err_unlock_md_type;
 
-	dm_ima_measure_on_table_load(t);
-
 	immutable_target_type = dm_get_immutable_target_type(md);
 	if (immutable_target_type &&
 	    (immutable_target_type != dm_table_get_immutable_target_type(t)) &&
@@ -1576,12 +1686,14 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 
 	dm_unlock_md_type(md);
 
+	dm_ima_alloc_context(&ima_context, false);
 	/* stage inactive table */
 	down_write(&_hash_lock);
 	hc = dm_get_mdptr(md);
 	if (!hc) {
 		DMERR("device has been removed from the dev hash table.");
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		r = -ENXIO;
 		goto err_destroy_table;
 	}
@@ -1589,8 +1701,15 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (hc->new_map)
 		old_map = hc->new_map;
 	hc->new_map = t;
+	dm_ima_init_context(hc, ima_context, false);
+	/* Make sure new_map doesn't get freed before we measure it*/
+	dm_get_live_table(md, &srcu_idx);
 	up_write(&_hash_lock);
 
+	dm_ima_measure_on_table_load(t, ima_context);
+	dm_ima_free_context(ima_context);
+	dm_put_live_table(md, srcu_idx);
+
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
 	__dev_status(md, param);
 
@@ -1619,13 +1738,16 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 	struct mapped_device *md;
 	struct dm_table *old_map = NULL;
 	bool has_new_map = false;
+	struct dm_ima_context *ima_context = NULL;
 
+	dm_ima_alloc_context(&ima_context, true);
 	down_write(&_hash_lock);
 
 	hc = __find_device_hash_cell(param);
 	if (!hc) {
 		DMDEBUG_LIMIT("device doesn't appear to be in the dev hash table.");
 		up_write(&_hash_lock);
+		dm_ima_free_context(ima_context);
 		return -ENXIO;
 	}
 
@@ -1635,8 +1757,11 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 		has_new_map = true;
 	}
 
+	dm_ima_init_context(hc, ima_context, false);
 	md = hc->md;
 	up_write(&_hash_lock);
+	dm_ima_measure_on_table_clear(md, has_new_map, ima_context);
+	dm_ima_free_context(ima_context);
 
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 	__dev_status(md, param);
@@ -1645,7 +1770,6 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 		dm_sync_table(md);
 		dm_table_destroy(old_map);
 	}
-	dm_ima_measure_on_table_clear(md, has_new_map);
 	dm_put(md);
 
 	return 0;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 8b60c9804f5b..87011c41ef7b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2546,6 +2546,8 @@ int dm_create(int minor, struct mapped_device **result)
 	if (!md)
 		return -ENXIO;
 
+	dm_ima_init(md);
+
 	*result = md;
 	return 0;
 }
-- 
2.53.0


