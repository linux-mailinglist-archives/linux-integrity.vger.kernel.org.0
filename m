Return-Path: <linux-integrity+bounces-9382-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DJlG5Jo8mkBqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9382-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:22:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0949A19E
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B33413062478
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 20:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC79392C3A;
	Wed, 29 Apr 2026 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExnOoilv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861A3932FA
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494080; cv=none; b=p7xjmh+4tvG0a1Laje2PoflTtFDQfW0L5nR5pxTBLJH/h31W0OWHiKdL48ocq7LxWenWVHxREkg4CewDELe2+cjmBZ9WUlycJ0+ntHUjQU1I0vNLFmlx5Tj/zanWVQoSZALU/82sgP+s9a+AyBmKQ30Hgqt7N5Ewo3QZSXWqwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494080; c=relaxed/simple;
	bh=SMTcW6mQxI8y93oCc+V/UUhsQZBKX/Zd1L8aqgFDV5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eScADtrd4ABxP7bsa78QSt/ORnNDvd6eG+RgnJqRwELzNieODF6F+0m2CbuB9004Rxd/Owq7B5Atnu1FTec14uX4PTYobYWpy14vRo1gE7LjnzLuZ2jBY/ojC/c+pYkRePNWdWCRiOKPBAmKr9mzQsP6CASZUT9cv/l5jk1e6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExnOoilv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777494078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QofwoMwxSCGblSWZLoeJ9G1stYebwuDx/UerX9q6nec=;
	b=ExnOoilvjC0EIOIf7BTiuRU5chIok54GW1i/P8d0tZoPd7V78/lmSkmjj4ydhCf19DVCmy
	Gse1ntrS5NZ5vBZQaxKWFLAaoP/ncW5+ylJiWctOtwY1fco2OKDvot+CZ/IXfDvUvn+KRS
	FJ9fgVhoPKFryKS5ggrH4Ceo1qoncOw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-JNke8-QsMkSa15wDqhYvQA-1; Wed,
 29 Apr 2026 16:21:14 -0400
X-MC-Unique: JNke8-QsMkSa15wDqhYvQA-1
X-Mimecast-MFC-AGG-ID: JNke8-QsMkSa15wDqhYvQA_1777494072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3305D195605E;
	Wed, 29 Apr 2026 20:21:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1A0D180045E;
	Wed, 29 Apr 2026 20:21:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TKLAMp2823316
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:21:11 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TKLA8s2823315;
	Wed, 29 Apr 2026 16:21:10 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen <chenste@linux.microsoft.com>
Subject: [PATCH v2 09/10] dm-ima: Fail more gracefully in dm_ima_measure_on_*
Date: Wed, 29 Apr 2026 16:21:07 -0400
Message-ID: <20260429202108.2823261-10-bmarzins@redhat.com>
In-Reply-To: <20260429202108.2823261-1-bmarzins@redhat.com>
References: <20260429202108.2823261-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 17B0949A19E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9382-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

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
index 47af99c9b79c..5e2efcd1de33 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -357,17 +357,6 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 
 	wait_to_measure(&md->ima, context->update_idx);
 
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
@@ -388,6 +377,17 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
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
@@ -621,11 +621,11 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md,
 
 	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
+error:
 	kfree(md->ima.inactive_table.hash);
 	kfree(md->ima.inactive_table.device_metadata);
 	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
-error:
 	kfree(capacity_str);
 	kfree(device_table_data);
 
@@ -649,6 +649,8 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 
 	wait_to_measure(&md->ima, context->update_idx);
 
+	fix_context_strings(context);
+
 	combined_device_data = dm_ima_alloc(DM_IMA_DEVICE_BUF_LEN * 2, noio);
 	if (!combined_device_data)
 		goto exit;
@@ -662,11 +664,15 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 		old_device_data = md->ima.inactive_table.device_metadata;
 	else
 		old_device_data = "device_rename=no_data;";
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
@@ -681,11 +687,5 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md,
 		table->device_metadata_len = strlen(table->device_metadata);
 	}
 
-	dm_ima_measure_data("dm_device_rename", combined_device_data, len, noio);
-
-exit:
-	kfree(capacity_str);
-	kfree(combined_device_data);
-
 	wake_next_measure(&md->ima);
 }
-- 
2.53.0


