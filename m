Return-Path: <linux-integrity+bounces-9380-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPXUDIJo8mkBqwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9380-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:22:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C06ED49A179
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 22:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE693051AAE
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD306393DCB;
	Wed, 29 Apr 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fi9VIdEm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F8392838
	for <linux-integrity@vger.kernel.org>; Wed, 29 Apr 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494079; cv=none; b=TKUMR0ilpOb48qJKOd2g085qOqCwf4yTFEkqXfc27fKc9xCpQtDZd6IkEJIngCR7el1K34+sC3+NAb/eQpLnBU+aNIQpDwrJWbAv5njZut252LyIK42arIcKriu1hq3Ycgh46T0SxDNC5rDN7aBpxA/06XXC63HPefpgP7yRcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494079; c=relaxed/simple;
	bh=FBCE/e2DQLmdrxFbwUi0kjU61yqBjzCdrEG1t5mdOJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp2nnr/1x0NQejLJVhNV49vQ5xO6eJtgCzB8EvslJrK37UtcNhV6jvwHnVaE9F6I5e+k3dELxlCZfqVXO2KdMeLwlhpyG35dCEHD+Rb/ejBGmx4Iayqt7fN/Ai/1VaB/JmnF3D7jHql6fl/TQ9eQ2x2O7E7B5tcWam7Hwua+KDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fi9VIdEm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777494077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5xUZTJsd44w9WQxYgKTqXwyB/Nh4ILj4CNYugrwQLo=;
	b=fi9VIdEmEJGp+5kcH34jhRoSdV/lVsQk1h0ym8Zp7yYBsoId7tKhQeYSxSgTm0U7ZDjhmU
	a+qdKAWrI0Hv2+K0V/Lb3Bonc6UXqMvQmFfa98uhKu0KD+v2wbbS9yP0XGw1ftEh53ygQY
	TcE8UuG1EczZcFZYrvgOrqoOjLCU3J8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-HVenBpKpM6ifFqKLhAOXFQ-1; Wed,
 29 Apr 2026 16:21:13 -0400
X-MC-Unique: HVenBpKpM6ifFqKLhAOXFQ-1
X-Mimecast-MFC-AGG-ID: HVenBpKpM6ifFqKLhAOXFQ_1777494072
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0032A19560B5;
	Wed, 29 Apr 2026 20:21:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A93C1800347;
	Wed, 29 Apr 2026 20:21:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63TKLA3H2823304
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 16:21:10 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63TKLA352823303;
	Wed, 29 Apr 2026 16:21:10 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        steven chen <chenste@linux.microsoft.com>
Subject: [PATCH v2 06/10] dm-ima: remove new_map from dm_ima_measure_on_device_clear
Date: Wed, 29 Apr 2026 16:21:04 -0400
Message-ID: <20260429202108.2823261-7-bmarzins@redhat.com>
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
X-Rspamd-Queue-Id: C06ED49A179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,linux.microsoft.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9380-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Now that two processes can't modify md->ima in
dm_ima_measure_on_device_clear() at the same time, there's no need to
track if an inactive table was actually removed. We might as well
clean it up unconditionally, on the off chance that a previous
ima measurement failed and left md->ima.inactive_table behind.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c   | 10 ++++------
 drivers/md/dm-ima.h   |  3 +--
 drivers/md/dm-ioctl.c |  4 +---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 096c664d855c..75c46b5af3f7 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -549,7 +549,7 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
 /*
  * Measure ima data on table clear.
  */
-void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
+void dm_ima_measure_on_table_clear(struct mapped_device *md,
 				   struct dm_ima_context *context)
 {
 	unsigned int l = 0;
@@ -609,11 +609,9 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
 
 	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
-	if (new_map) {
-		kfree(md->ima.inactive_table.hash);
-		kfree(md->ima.inactive_table.device_metadata);
-		memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
-	}
+	kfree(md->ima.inactive_table.hash);
+	kfree(md->ima.inactive_table.device_metadata);
+	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 
 error:
 	kfree(capacity_str);
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index 01fa0b89a385..b240e0e4b6a1 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -83,7 +83,7 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
 				     struct dm_ima_context *context,
 				     unsigned int idx);
-void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
+void dm_ima_measure_on_table_clear(struct mapped_device *md,
 				   struct dm_ima_context *context);
 void dm_ima_measure_on_device_rename(struct mapped_device *md,
 				     struct dm_ima_context *context);
@@ -108,7 +108,6 @@ static inline void dm_ima_measure_on_device_remove(struct mapped_device *md,
 						   struct dm_ima_context *context,
 						   unsigned int idx) {}
 static inline void dm_ima_measure_on_table_clear(struct mapped_device *md,
-						 bool new_map,
 						 struct dm_ima_context *context) {}
 static inline void dm_ima_measure_on_device_rename(struct mapped_device *md,
 						   struct dm_ima_context *context) {}
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 3da8b33cdc54..b92ec3efff01 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1741,7 +1741,6 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 	struct hash_cell *hc;
 	struct mapped_device *md;
 	struct dm_table *old_map = NULL;
-	bool has_new_map = false;
 	struct dm_ima_context *ima_context = NULL;
 
 	dm_ima_alloc_context(&ima_context, true);
@@ -1758,13 +1757,12 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 	if (hc->new_map) {
 		old_map = hc->new_map;
 		hc->new_map = NULL;
-		has_new_map = true;
 	}
 
 	dm_ima_init_context(hc, ima_context, false);
 	md = hc->md;
 	up_write(&_hash_lock);
-	dm_ima_measure_on_table_clear(md, has_new_map, ima_context);
+	dm_ima_measure_on_table_clear(md, ima_context);
 	dm_ima_free_context(ima_context);
 
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-- 
2.53.0


