Return-Path: <linux-integrity+bounces-9176-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKSKJSuJ3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9176-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:24:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 983F53F4702
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E29813014294
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECAA1F8723;
	Tue, 14 Apr 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABYK/QK3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF51A6812
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126174; cv=none; b=DZyQ4rJjx4QDp9iRNfyTLa1CpTDFAiOdsLKbiGjglj4N9vHct6ALbZjYJ0gR27DM+KE/fPtpg0SOfnj4b1FykRLqbKe271BD3NvP7Ypb+jnQAs1Or/H3Z48UM8Hqwdge3hBG42VpWlZqlJ0WriZxB4rqSTy4SW+PpDyHh19f73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126174; c=relaxed/simple;
	bh=fYl0dNUrkENddoJE8YYPvrisUGYxeWIMpPZaOkPo280=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfjod7BctuPVBMXg/cCoEyzttaUzrKgZSoII3czcJsZu1w7E838mXgzLD+m2L6vobvfTLxDC/08p8YnIbGc4V/8Tx76BdCuloueuqA/69GveTUzdkxSj1a8IAeiSBxsfHJBnIO0P3ANX0vEqxcngaP7Kh4dLO/k7IhtI9cxwpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABYK/QK3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiZeeb8fpjk/LjmcQD7gF5BUa2dAANTNZdTJYpznuNE=;
	b=ABYK/QK3eaSu56+0fXXxCtuhTmQOa1xyVCTTCiq0Fr9g5lIdVFVe0bg/ERHXlntPFG9acU
	Dr1iqfWL5teJAqsWoXHu+7sZ8QG7Sfl30P6jBAyUVBosfHaaYSJGr/7PedN5KwOjUktV2f
	l6l4geSI/y4ozuKGLR1zVUaXcVKbwd4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-70Y_Nb6LMxGD6vJxmiuOSQ-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: 70Y_Nb6LMxGD6vJxmiuOSQ-1
X-Mimecast-MFC-AGG-ID: 70Y_Nb6LMxGD6vJxmiuOSQ_1776126167
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D31619560A2;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18CDA19560B7;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mk9W1917494
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:46 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0Mk5U1917493;
	Mon, 13 Apr 2026 20:22:46 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 07/10] dm-ima: Fix issues with dm_ima_measure_on_device_rename
Date: Mon, 13 Apr 2026 20:22:41 -0400
Message-ID: <20260414002244.1917447-8-bmarzins@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9176-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmarzins@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.958];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 983F53F4702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dm_ima_measure_on_device_rename() can be called on a device before it
ever loads a table, so it needs to handle the case where there is no
table metadata. Also, it was only updating the table_metadata on the
active table. If there was an inactive table when the device was
and that table was later swapped in as the active table, it would
still have the old name. dm_ima_measure_on_device_rename() was also
needlessly allocating new memory for the updated table metadata, instead
of just reusing the existing memory.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 69 ++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 317f6d7e0e5e..5c6f3f8761a8 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -119,22 +119,18 @@ void dm_ima_context_table_op(struct mapped_device *md,
 }
 
 /*
- * Internal function to allocate and copy device data for IMA measurements.
+ * Internal function to copy device data for IMA measurements.
  */
-static int dm_ima_alloc_and_copy_device_data(struct mapped_device *md, char **device_data,
-					     struct dm_ima_context *context,
-					     unsigned int num_targets, bool noio)
+static void dm_ima_copy_device_data(struct mapped_device *md, char *device_data,
+				    struct dm_ima_context *context,
+				    unsigned int num_targets)
 {
-	*device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
-	if (!(*device_data))
-		return -ENOMEM;
-
-	scnprintf(*device_data, DM_IMA_DEVICE_BUF_LEN,
+	memset(device_data, 0, DM_IMA_DEVICE_BUF_LEN);
+	scnprintf(device_data, DM_IMA_DEVICE_BUF_LEN,
 		  "name=%s,uuid=%s,major=%d,minor=%d,minor_count=%d,num_targets=%u;",
 		  context->dev_name, context->dev_uuid, md->disk->major,
 		  md->disk->first_minor, md->disk->minors, num_targets);
 
-	return 0;
 }
 
 /*
@@ -212,11 +208,14 @@ void dm_ima_measure_on_table_load(struct dm_table *table,
 
 	num_targets = table->num_targets;
 
-	fix_context_strings(context);
-	if (dm_ima_alloc_and_copy_device_data(table->md, &device_data_buf,
-					      context, num_targets, noio))
+	device_data_buf = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
+	if (!device_data_buf)
 		goto error;
 
+	fix_context_strings(context);
+	dm_ima_copy_device_data(table->md, device_data_buf, context,
+				num_targets);
+
 	sha256_init(&hash_ctx);
 
 	memcpy(ima_buf + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
@@ -631,10 +630,11 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 void dm_ima_measure_on_device_rename(struct mapped_device *md,
 				     struct dm_ima_context *context)
 {
-	char *old_device_data = NULL, *new_device_data = NULL;
+	char *old_device_data = NULL;
 	char *combined_device_data = NULL, *capacity_str = NULL;
 	bool noio = true;
 	int len;
+	struct dm_ima_device_table_metadata *table;
 
 	if (unlikely(!context))
 		return;
@@ -644,38 +644,43 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 		    context->update_idx));
 	smp_mb();
 
-	fix_context_strings(context);
-	if (dm_ima_alloc_and_copy_device_data(md, &new_device_data, context,
-					      md->ima.active_table.num_targets,
-					      noio))
-		goto error;
-
 	combined_device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN * 2, noio);
 	if (!combined_device_data)
-		goto error;
+		goto exit;
 
 	if (dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio) < 0)
-		goto error;
-
-	old_device_data = md->ima.active_table.device_metadata;
-
-	md->ima.active_table.device_metadata = new_device_data;
-	md->ima.active_table.device_metadata_len = strlen(new_device_data);
+		goto exit;
 
+	if (md->ima.active_table.device_metadata)
+		old_device_data = md->ima.active_table.device_metadata;
+	else if (md->ima.inactive_table.device_metadata)
+		old_device_data = md->ima.inactive_table.device_metadata;
+	else
+		old_device_data = "table_rename=no_data;";
+	fix_context_strings(context);
 	len = scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2,
 			"%s%snew_name=%s,new_uuid=%s;%s", DM_IMA_VERSION_STR, old_device_data,
 			context->dev_name, context->dev_uuid, capacity_str);
 
-	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
+	if (md->ima.active_table.device_metadata) {
+		table = &md->ima.active_table;
+		dm_ima_copy_device_data(md, table->device_metadata, context,
+					table->num_targets);
+		table->device_metadata_len = strlen(table->device_metadata);
+	}
 
-	goto exit;
+	if (md->ima.inactive_table.device_metadata) {
+		table = &md->ima.inactive_table;
+		dm_ima_copy_device_data(md, table->device_metadata, context,
+					table->num_targets);
+		table->device_metadata_len = strlen(table->device_metadata);
+	}
+
+	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
 
-error:
-	kfree(new_device_data);
 exit:
 	kfree(capacity_str);
 	kfree(combined_device_data);
-	kfree(old_device_data);
 
 	smp_mb__before_atomic();
 	atomic_inc(&md->ima.measure_idx);
-- 
2.53.0


