Return-Path: <linux-integrity+bounces-9172-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILA7K1WK3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9172-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159553F4793
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74123307BCBE
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AA1E9906;
	Tue, 14 Apr 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7LQRPgo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFE1F3BAC
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126173; cv=none; b=ZSvviof4HBAjvAB/pATF4x9W9QdKGWDTDZQslfHEtJhJrFE2cAH5IJ0SeblwAcNUTQCGbOwQaItanUnTjF37F7zUecCatkJm2t0XsGiOa/NelVFZ+RfmeXKPQbQ8I5ITOSPIS+vFT665veOUQ9K7mGfvc8UxZkcJO1tUwBBylWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126173; c=relaxed/simple;
	bh=ORIvckZt2jSkddDsux0hSRr+GV/AnGOc9Qvj7yYAm/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojuWdfX/iFaGc+c5qqQlQeXUuK5cZLXRwZQHG6q3FNzohblI4Tdd7rLPEa+57xCjKRwq85icGoD0j+S5d0cwdXF5M0Ea/qudz9RyLybjryP8o9p4Kbw4tgDXinOxX/tHZW4jzG/JpKy8C87SjVHA05QJS9ZYFSUCOOvc8erKlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7LQRPgo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oF+i8JGuoRRVgN4Ucsmr8gvo+be6kQhWhDQaarZPrg0=;
	b=h7LQRPgomFuCgIlTz5K2i4vtFGbePp9XKQDJ4+C4IdgI1R2L07L06ZVCDs72zUVZ7MGvpk
	s+WaYlUJzvm2qmHGT70RFM9lUPiQn0y7Bbd3KPx31/zhcwvR04QmtwfNma1thtHKFBDbKD
	J8bEXFm4QYZ+tMn8fl2jUjJe+D1Ouhk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-57xWp9rdOfGvz9HWnWHJwg-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: 57xWp9rdOfGvz9HWnWHJwg-1
X-Mimecast-MFC-AGG-ID: 57xWp9rdOfGvz9HWnWHJwg_1776126166
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5B91180034E;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5363E195608E;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mi9u1917470
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:45 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0Miid1917469;
	Mon, 13 Apr 2026 20:22:44 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 01/10] dm-ima: remove dm_ima_reset_data()
Date: Mon, 13 Apr 2026 20:22:35 -0400
Message-ID: <20260414002244.1917447-2-bmarzins@redhat.com>
In-Reply-To: <20260414002244.1917447-1-bmarzins@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9172-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.959];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 159553F4793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There's no point in saving the string length of DM_IMA_VERSION_STR. It's
a constant, so the compiler will precompute it. dm_create() will already
zero out the rest of dm->ima.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 32 ++++++++++++--------------------
 drivers/md/dm-ima.h |  3 ---
 drivers/md/dm.c     |  2 --
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 9495ca035056..a639bb0fe6c3 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -159,15 +159,6 @@ static int dm_ima_alloc_and_copy_capacity_str(struct mapped_device *md, char **c
 			 capacity);
 }
 
-/*
- * Initialize/reset the dm ima related data structure variables.
- */
-void dm_ima_reset_data(struct mapped_device *md)
-{
-	memset(&(md->ima), 0, sizeof(md->ima));
-	md->ima.dm_version_str_len = strlen(DM_IMA_VERSION_STR);
-}
-
 /*
  * Build up the IMA data for each target, and finally measure.
  */
@@ -204,8 +195,8 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 
 	sha256_init(&hash_ctx);
 
-	memcpy(ima_buf + l, DM_IMA_VERSION_STR, table->md->ima.dm_version_str_len);
-	l += table->md->ima.dm_version_str_len;
+	memcpy(ima_buf + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
+	l += strlen(DM_IMA_VERSION_STR);
 
 	device_data_buf_len = strlen(device_data_buf);
 	memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
@@ -260,8 +251,8 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 			 * prefix, so that multiple records from the same "dm_table_load" for
 			 * a given device can be linked together.
 			 */
-			memcpy(ima_buf + l, DM_IMA_VERSION_STR, table->md->ima.dm_version_str_len);
-			l += table->md->ima.dm_version_str_len;
+			memcpy(ima_buf + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
+			l += strlen(DM_IMA_VERSION_STR);
 
 			memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
 			l += device_data_buf_len;
@@ -349,8 +340,8 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	if (capacity_len < 0)
 		goto error;
 
-	memcpy(device_table_data + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
-	l += md->ima.dm_version_str_len;
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
+	l += strlen(DM_IMA_VERSION_STR);
 
 	if (swap) {
 		if (md->ima.active_table.hash != md->ima.inactive_table.hash)
@@ -460,8 +451,8 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 		goto exit;
 	}
 
-	memcpy(device_table_data + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
-	l += md->ima.dm_version_str_len;
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
+	l += strlen(DM_IMA_VERSION_STR);
 
 	if (md->ima.active_table.device_metadata) {
 		memcpy(device_table_data + l, device_active_str, device_active_len);
@@ -551,7 +542,8 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	if (md->ima.active_table.hash != md->ima.inactive_table.hash)
 		kfree(md->ima.inactive_table.hash);
 
-	dm_ima_reset_data(md);
+	memset(&md->ima.active_table, 0, sizeof(md->ima.active_table));
+	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
 	kfree(dev_name);
 	kfree(dev_uuid);
@@ -578,8 +570,8 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	if (capacity_len < 0)
 		goto error1;
 
-	memcpy(device_table_data + l, DM_IMA_VERSION_STR, md->ima.dm_version_str_len);
-	l += md->ima.dm_version_str_len;
+	memcpy(device_table_data + l, DM_IMA_VERSION_STR, strlen(DM_IMA_VERSION_STR));
+	l += strlen(DM_IMA_VERSION_STR);
 
 	if (md->ima.inactive_table.device_metadata_len &&
 	    md->ima.inactive_table.hash_len) {
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index a403deca6093..b0b166aa2283 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -52,10 +52,8 @@ struct dm_ima_device_table_metadata {
 struct dm_ima_measurements {
 	struct dm_ima_device_table_metadata active_table;
 	struct dm_ima_device_table_metadata inactive_table;
-	unsigned int dm_version_str_len;
 };
 
-void dm_ima_reset_data(struct mapped_device *md);
 void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags);
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
@@ -64,7 +62,6 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md);
 
 #else
 
-static inline void dm_ima_reset_data(struct mapped_device *md) {}
 static inline void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
 static inline void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
 static inline void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e178fe19973e..8b60c9804f5b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2546,8 +2546,6 @@ int dm_create(int minor, struct mapped_device **result)
 	if (!md)
 		return -ENXIO;
 
-	dm_ima_reset_data(md);
-
 	*result = md;
 	return 0;
 }
-- 
2.53.0


