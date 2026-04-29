Return-Path: <linux-integrity+bounces-9378-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGJyO3Zo8mkBqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9378-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:22:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607349A163
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D7E302F9A7
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0AA3939AC;
	Wed, 29 Apr 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwYDmCuV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6238A29A
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494079; cv=none; b=rzNYPDtevHply37JQy8IljnbCi59WFurXx8f3TWkwFFYAj2BiKYCiqH+I3WHpCylWdA30vwUyRbWtaMMn2DJPb3zmHQCp461VTpBJnJqy0wRZXk4xE9PUXyAKeKBKlK8Tcg77Ji5zhAaTWWQLM+Sze/BgMRM/Nm0C3ClXYihs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494079; c=relaxed/simple;
	bh=ORIvckZt2jSkddDsux0hSRr+GV/AnGOc9Qvj7yYAm/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOdHX3qewKdWFWo+Dpa6hW5R2R+0j5pQB9HhK1Sks4iXjYbg/9MZVR+tRD4X4YLvZsOoTGImL8Tw2gwk3EoEXoAw254Hoz3e+dmCasnS/aUlUKW10qM4Zs0W4B+ds/CWsZa4isOLVixPBcwZpVcutvcyAREWAkYlIOXK0S6EyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwYDmCuV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777494076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oF+i8JGuoRRVgN4Ucsmr8gvo+be6kQhWhDQaarZPrg0=;
	b=dwYDmCuVttit+8jkIsi5/yQmr4adp/4gtah9IWhKnFYEsWP2V+ZQIWiVwNF0r0hbet9qwI
	KdfTTcpn5H2ZzclKfbpZtaTfsb6HBOoc46af7D4/jf1nlpWJ1FzREa6yUn2nCr7+Wm9CYa
	xmzY5lWfDcGlTUjVbTtJp010+8b7USE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-zsqFRm3gMZC8a5KE28ejaw-1; Wed,
 29 Apr 2026 16:21:13 -0400
X-MC-Unique: zsqFRm3gMZC8a5KE28ejaw-1
X-Mimecast-MFC-AGG-ID: zsqFRm3gMZC8a5KE28ejaw_1777494071
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 856951956056;
	Wed, 29 Apr 2026 20:21:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBDBD1800347;
	Wed, 29 Apr 2026 20:21:10 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TKL9x32823284
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:21:09 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TKL9HP2823283;
	Wed, 29 Apr 2026 16:21:09 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen <chenste@linux.microsoft.com>
Subject: [PATCH v2 01/10] dm-ima: remove dm_ima_reset_data()
Date: Wed, 29 Apr 2026 16:20:59 -0400
Message-ID: <20260429202108.2823261-2-bmarzins@redhat.com>
In-Reply-To: <20260429202108.2823261-1-bmarzins@redhat.com>
References: <20260429202108.2823261-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 5607349A163
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
	TAGGED_FROM(0.00)[bounces-9378-lists,linux-integrity=lfdr.de];
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


