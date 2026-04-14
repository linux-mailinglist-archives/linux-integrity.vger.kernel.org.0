Return-Path: <linux-integrity+bounces-9169-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B/6G+eI3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9169-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:03 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7403F46BE
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7639D30164C9
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B4239085;
	Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjovigCl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5251E5207
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126172; cv=none; b=YIeZPIrpAxTPzXbyuaDtoR1u54lWzjQiA3A2MGMDwzzADEmFAKfKGA/BNiEBHvzsxm3iG3CZvjLKe0MpHqBBLr/rEa4WLsmvnoD1L8Deb/p2LognPQ40Gs4HC1KFbV4yclY7ROiAZChT7VJAWEX/jQAr1cSM3FEt3O0szTn0t+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126172; c=relaxed/simple;
	bh=S2t/1ZIPTPz36gInG8LpTnv9ZVB7pK1s7Wd3Rc/7Xz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJQpY/jr7iY4tlUsNZdD3svygxsPrXIjvo8bwsGNdfW1GM/LmQTU6ssoWUFgashe1Zq54e0P70OQ11172xX1iUirHMF5XLkJ9A5ujoYEtzyeI0wbP1ODhWa6nm1Inyq+b+5Zgs9O/RtJ4tk3Hju5OWDGapgRtIsHAIof/Auyw8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjovigCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIGjSRzHjgHK3cVWJrouI3TfS1aOqL3ldvWQApm8Ax0=;
	b=gjovigClRk78ZssNcisUNetASM3zICjlHcc5+3t/mhKgFpxCRtJYdUfNskTYskGnFMGaQl
	Vadt+KYWOCUvWVt6Fzmg4vPjMpuYmkBw+XEeCfQFXF2RLNPE6BMmfyFeeAhRkilcSQ/tDJ
	UAmrvxt1JKFnxcRWltJvhF9CkKdmNmY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-m7oIsHyAMDeas_JGBiIC2Q-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: m7oIsHyAMDeas_JGBiIC2Q-1
X-Mimecast-MFC-AGG-ID: m7oIsHyAMDeas_JGBiIC2Q_1776126167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8F41956048;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AA3B18002A6;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0Mkt91917498
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:46 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0MkSL1917497;
	Mon, 13 Apr 2026 20:22:46 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 08/10] dm-ima: Handle race between rename and table swap
Date: Mon, 13 Apr 2026 20:22:42 -0400
Message-ID: <20260414002244.1917447-9-bmarzins@redhat.com>
In-Reply-To: <20260414002244.1917447-1-bmarzins@redhat.com>
References: <20260414002244.1917447-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-9169-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5B7403F46BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

a device rename could happen after do_resume() removed the inactive
table that it was swapping to out of the hash cell, but before it was
made the active table. In this case, the table metadata would still
have the old name. Update the swapped table's metadata to avoid this.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 5c6f3f8761a8..4631dc2a6d4d 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -367,6 +367,19 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap,
 		kfree(md->ima.active_table.device_metadata);
 		md->ima.active_table = context->table;
 		memset(&context->table, 0, sizeof(context->table));
+		if (md->ima.active_table.device_metadata) {
+			/*
+			 * A rename could have happened while the swap was
+			 * going on. In that case, the saved table info would
+			 * still have the old name. Update the metadata to be
+			 * sure that it has the current name
+			 */
+			struct dm_ima_device_table_metadata *table = &md->ima.active_table;
+			fix_context_strings(context);
+			dm_ima_copy_device_data(md, table->device_metadata,
+						context, table->num_targets);
+			table->device_metadata_len = strlen(table->device_metadata);
+		}
 	}
 
 	if (md->ima.active_table.device_metadata) {
-- 
2.53.0


