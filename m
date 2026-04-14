Return-Path: <linux-integrity+bounces-9178-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sABhG12K3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9178-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43F3F47A8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBA6307EB5C
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2991FF7C8;
	Tue, 14 Apr 2026 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tlbt/LTo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88D21D590
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126175; cv=none; b=mV2ZdzxzufLZEJw/5OsbXCGWXg2BvAFOaMTvKkr+79nM5GmI2VI70ZalJ07xgE3eVFbI1A3p1b4IK4AUS4iSfILvW1izyLkgniDF6JhRNMWyk3GDglAyFnfA9ROkS5ALnoXI9vBNkYnYSZ4ScsaOgtWgGqzBjxYQ10L4pFKBN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126175; c=relaxed/simple;
	bh=FhEQ6kO3b6LAjKUyVD2j7dR+0ivy3buI8Po9yZsBeZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To3Ayn/bNSvIE8jc7fHghafBQJdE9qNZbdQD+6M+FtM8US4xLmBWxcbXeWINgvrHw4UeGVSXfLPSrEyrvd+ZHomiYLPXvh7kBSyIazfWAqiNnaVNfywxg6WJteC9pCCKrzRP1h24NB0agLjhO134u9Hc38TRtY62UKhYxeH4Kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlbt/LTo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ow9dlW10/tlQES5/kiZlse5U/0qRpFUE3A6ttc28T3g=;
	b=Tlbt/LTo6MdZdChUVLKUMGLMbXdFvyEcSMt5ZkJ+OqWwzTlNOxJBnmr38z+JUKw611REi3
	aF0jzpLTKj2pTcwKFxo5aEFp6LQ+XlKgHKys8EpBlDM0sHRRTqgeu/9ycUnBxsxW/g7HYM
	rgFEbqfl8rZ0bUb2hj4ehCyw12UlF2E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-c7WZAyk2MdOC5q7G8KpXEw-1; Mon,
 13 Apr 2026 20:22:49 -0400
X-MC-Unique: c7WZAyk2MdOC5q7G8KpXEw-1
X-Mimecast-MFC-AGG-ID: c7WZAyk2MdOC5q7G8KpXEw_1776126167
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3A8E1956095;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D1243000C1F;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0MkNr1917502
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:46 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0Mkkm1917501;
	Mon, 13 Apr 2026 20:22:46 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 09/10] dm-ima: Fail more gracefully in dm_ima_measure_on_*
Date: Mon, 13 Apr 2026 20:22:43 -0400
Message-ID: <20260414002244.1917447-10-bmarzins@redhat.com>
In-Reply-To: <20260414002244.1917447-1-bmarzins@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	TAGGED_FROM(0.00)[bounces-9178-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.956];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0C43F3F47A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In all the dm_ima_measure_on_* functions besides
dm_ima_measure_on_table_load(), even if measuring the event fails, it's
still possible to update dm->ima, so that it continues to correctly
track the device state. This means that one measurement failure won't
cause future measurements to record the wrong data.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 4631dc2a6d4d..45038bd65f7b 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -351,17 +351,6 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 		    context->update_idx));
 	smp_mb();
 
-	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
-	if (!device_table_data)
-		goto error;
-
-	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
-	if (capacity_len < 0)
-		goto error;
-
-	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
-	l += strlen(DM_IMA_VERSION_STR);
-
 	if (swap) {
 		kfree(md->ima.active_table.hash);
 		kfree(md->ima.active_table.device_metadata);
@@ -382,6 +371,17 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 		}
 	}
 
+	device_table_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN, noio);
+	if (!device_table_data)
+		goto error;
+
+	capacity_len = dm_ima_alloc_and_copy_capacity_str(md, &capacity_str, noio);
+	if (capacity_len < 0)
+		goto error;
+
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
+	l += strlen(DM_IMA_VERSION_STR);
+
 	if (md->ima.active_table.device_metadata) {
 		memcpy(device_table_data + l, md->ima.active_table.device_metadata,
 		       md->ima.active_table.device_metadata_len);
@@ -624,11 +624,11 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 
 	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
+error:
 	kfree(md->ima.inactive_table.hash);
 	kfree(md->ima.inactive_table.device_metadata);
 	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
-error:
 	kfree(capacity_str);
 	kfree(device_table_data);
 
@@ -657,6 +657,8 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 		    context->update_idx));
 	smp_mb();
 
+	fix_context_strings(context);
+
 	combined_device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN * 2, noio);
 	if (!combined_device_data)
 		goto exit;
@@ -670,11 +672,15 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 		old_device_data = md->ima.inactive_table.device_metadata;
 	else
 		old_device_data = "table_rename=no_data;";
-	fix_context_strings(context);
 	len = scnprintf(combined_device_data, DM_IMA_DEVICE_BUF_LEN * 2,
 			"%s%snew_name=%s,new_uuid=%s;%s", DM_IMA_VERSION_STR, old_device_data,
 			context->dev_name, context->dev_uuid, capacity_str);
 
+	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
+exit:
+	kfree(capacity_str);
+	kfree(combined_device_data);
+
 	if (md->ima.active_table.device_metadata) {
 		table = &md->ima.active_table;
 		dm_ima_copy_device_data(md, table->device_metadata, context,
@@ -689,12 +695,6 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 		table->device_metadata_len = strlen(table->device_metadata);
 	}
 
-	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
-
-exit:
-	kfree(capacity_str);
-	kfree(combined_device_data);
-
 	smp_mb__before_atomic();
 	atomic_inc(&md->ima.measure_idx);
 	wake_up_all(&md->ima.ima_wq);
-- 
2.53.0


