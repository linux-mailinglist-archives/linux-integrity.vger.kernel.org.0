Return-Path: <linux-integrity+bounces-9174-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNLdEUuK3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9174-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:28:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B853F4785
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3E7307CA0B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DA23E334;
	Tue, 14 Apr 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yew05vve"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9F220F3E
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126174; cv=none; b=qtnFcHJrGtzy42Fs/fHzdl9nIcMaPj+wG/TkH2p7KM4TkPEFB9CevFoLzP04QSrFyoIG2Kgj1yDyo1u0V4pRaOh8aLCc/bzsz7ziXlxMeInfLfi2RgW7hi52+0rX9rLkaqodSU5TcgXYg0BwAil0U8TKwztlT/hs6BkhvSDOrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126174; c=relaxed/simple;
	bh=KqsoTlKk+zRcPFrDY/twfH8Fpo4KDq8RpfNV0TcC/NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwrJ5f2nxLNszUWBoh+iRdnDioAVyfyNba6oQqaa9fZ4ewdxN1c/nYFVrQ/TPQBfHHyW0G4UEYcoy9uLmLmhSw0hQq7eq954ij3JcMc89u4EZsmIPB2Hn8Lma9+i9Nn1AJi7QBG6ZpfNjcOS3OUWS9landEsxk28ZUS8s/k9WfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yew05vve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSRZJ55VcThoicOU7apFfS/oyfTRUB0uYu0W+Qd0vmU=;
	b=Yew05vveZG4AL3jGvJYpePsJWKjiQXM35WtuQPTivUobkdaV73/6RdLOsaN03jtehndR0R
	LKl6BRV9H38gdrr6+JlM3sTwSe478ryJ4hQQab20Zo2DtC1fiyMEXarBkCYeaoglY+ybV9
	KROe5Sb7ZkNAr8UTbSdSgA2InTU7WsE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686--4vN-0BbPNmHlbrs30Ofog-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: -4vN-0BbPNmHlbrs30Ofog-1
X-Mimecast-MFC-AGG-ID: -4vN-0BbPNmHlbrs30Ofog_1776126167
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38AC5180057A;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02F9C180049F;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mjlf1917490
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:45 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0MjP31917489;
	Mon, 13 Apr 2026 20:22:45 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 06/10] dm-ima: remove new_map from dm_ima_measure_on_device_clear
Date: Mon, 13 Apr 2026 20:22:40 -0400
Message-ID: <20260414002244.1917447-7-bmarzins@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9174-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.962];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D3B853F4785
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index e8fa049c6317..317f6d7e0e5e 100644
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
@@ -612,11 +612,9 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
 
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
index 9e1b654867d9..2f2ac69042f2 100644
--- a/drivers/md/dm-ima.h
+++ b/drivers/md/dm-ima.h
@@ -82,7 +82,7 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all,
 				     struct dm_ima_context *context,
 				     unsigned int idx);
-void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map,
+void dm_ima_measure_on_table_clear(struct mapped_device *md,
 				   struct dm_ima_context *context);
 void dm_ima_measure_on_device_rename(struct mapped_device *md,
 				     struct dm_ima_context *context);
@@ -107,7 +107,6 @@ static inline void dm_ima_measure_on_device_remove(struct mapped_device *md,
 						   struct dm_ima_context *context,
 						   unsigned int idx) {}
 static inline void dm_ima_measure_on_table_clear(struct mapped_device *md,
-						 bool new_map,
 						 struct dm_ima_context *context) {}
 static inline void dm_ima_measure_on_device_rename(struct mapped_device *md,
 						   struct dm_ima_context *context) {}
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 16609882aa92..2288f3d58ce9 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1737,7 +1737,6 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 	struct hash_cell *hc;
 	struct mapped_device *md;
 	struct dm_table *old_map = NULL;
-	bool has_new_map = false;
 	struct dm_ima_context *ima_context = NULL;
 
 	dm_ima_alloc_context(&ima_context, true);
@@ -1754,13 +1753,12 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
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


