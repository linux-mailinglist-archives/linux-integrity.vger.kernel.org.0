Return-Path: <linux-integrity+bounces-9173-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNZQK+yI3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9173-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:08 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3113F46C5
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AAA43019078
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3AF23C8A0;
	Tue, 14 Apr 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkE2kYdV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538A3D561
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126173; cv=none; b=tRwN/Me9d5y6gfHKJGybWDJlGjRmGOvqMMjgtNn0Z/H4DWrghHaayWecKhNBe0Kjiq8jDA3gfzWOe+vG87WI7p1iBbq3UUpePbZzDu347y1ABTzmdckKjhYixBVgkycK534gMQrMLuhr6BBijWQ1mlo5v4/Z8yNjae6IPnhagzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126173; c=relaxed/simple;
	bh=ZPf6+GyTYTtLJpb2olr89OG+58T8BFpkfO45JkufXOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbDbYsi7bdsgeGJTuHcOJyPwUQhfWljVGcyYQMVCt0Y3dWKsED2VlThptaKLW2p7mPM7XIT7Xggwgp6sxLz2sXObqX2T+Zshwx6BdAhZMdym3A4nDM33HuMv4HkMly8aFjIolkzYmaFkXdYgd0Ta6k3ZFtlTdhOevJFEE/glidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkE2kYdV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuX7YZ9gmtzkSJwSnc3wdTpZ7pYRQ0Q/XfXE0uaqq+0=;
	b=gkE2kYdV2gVf8TvmXJ9jK2SchtLcc3q9lkwlWvbWgn7e/KIgTRPF/GQqm5A0rscOUf1j0i
	5xYSomsDuooqFJG//4ns4EgM64eyNDk1XW6kPxsjcvu7YjdXUuJcEBs0MLOsHRGyybxhKi
	JeGXPnujv73i7uq2MRfrb+uB7gk4jmQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-3XoPpnAjPD-81Ld1JJN6gQ-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: 3XoPpnAjPD-81Ld1JJN6gQ-1
X-Mimecast-MFC-AGG-ID: 3XoPpnAjPD-81Ld1JJN6gQ_1776126166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B24ED195608E;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62EE23000C1F;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mj4x1917478
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:45 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0Mja51917477;
	Mon, 13 Apr 2026 20:22:45 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 03/10] dm-ima: Remove status_flags from dm_ima_measure_on_table_load()
Date: Mon, 13 Apr 2026 20:22:37 -0400
Message-ID: <20260414002244.1917447-4-bmarzins@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9173-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.961];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8F3113F46C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no status flag that is is used for STATUSTYPE_IMA type
status() calls, and STATUSTYPE_IMA itself is not a valid
status flag.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c   | 4 ++--
 drivers/md/dm-ima.h   | 4 ++--
 drivers/md/dm-ioctl.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 209221fa8bc5..8b84b676cad4 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -162,7 +162,7 @@ static int dm_ima_alloc_and_copy_capacity_str(struct mapped_device *md, char **c
 /*
  * Build up the IMA data for each target, and finally measure.
  */
-void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags)
+void dm_ima_measure_on_table_load(struct dm_table *table)
 {
 	size_t device_data_buf_len, target_metadata_buf_len, target_data_buf_len, l = 0;
 	char *target_metadata_buf = NULL, *target_data_buf = NULL, *digest_buf = NULL;
@@ -217,7 +217,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 		 * Then retrieve the actual target data.
 		 */
 		if (ti->type->status)
-			ti->type->status(ti, type, status_flags, target_data_buf,
+			ti->type->status(ti, type, 0, target_data_buf,
 					 DM_IMA_TARGET_DATA_BUF_LEN);
 		else
 			target_data_buf[0] = '\0';
diff --git a/drivers/md/dm-ima.h b/drivers/md/dm-ima.h
index b0b166aa2283..c0548492bef0 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -54,7 +54,7 @@ struct dm_ima_measurements {
 	struct dm_ima_device_table_metadata inactive_table;
 };
 
-void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags);
+void dm_ima_measure_on_table_load(struct dm_table *table);
 void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap);
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all);
 void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map);
@@ -62,7 +62,7 @@ void dm_ima_measure_on_device_rename(struct mapped_device *md);
 
 #else
 
-static inline void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_flags) {}
+static inline void dm_ima_measure_on_table_load(struct dm_table *table) {}
 static inline void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap) {}
 static inline void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all) {}
 static inline void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map) {}
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 405acc14d718..1a0dd4981d03 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1548,7 +1548,7 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (r)
 		goto err_unlock_md_type;
 
-	dm_ima_measure_on_table_load(t, STATUSTYPE_IMA);
+	dm_ima_measure_on_table_load(t);
 
 	immutable_target_type = dm_get_immutable_target_type(md);
 	if (immutable_target_type &&
-- 
2.53.0


