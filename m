Return-Path: <linux-integrity+bounces-9177-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kELNBTGJ3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9177-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:24:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E763F4709
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34BC301E796
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F435242925;
	Tue, 14 Apr 2026 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVdQ/SWV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17362264AA
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126174; cv=none; b=tFfguHPfsft3p7ecolIUNgyYKcOMjgGNmognAbEFD3knGG+5oaxg6E1ARWRoaodeZgrNXXCinjyWXqeiyiWWeICR96/3qFICXbsZJxwmS94Zr3sh6N77DYx3M14KccxWS1017JLR+4GWVnb3PYyv5cQmlGtzF1fFBM4UZKWo1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126174; c=relaxed/simple;
	bh=8fXDxeTmMxhwow1M5hchJUf1OMkBFumWlMe6KZ5+umo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRFXt37GjLlfEiF68CwzoOXC84YV/WSeULDgsZK0T9G2GVzpX85j6zewcb0iXRelXLRDC7M/1n0RlxJDgD1u89m7un6WmgBDwsk3Tz3NZghmzvr1K0vWoe+51NytXW11w6ZFDIyFC1kNf+c4Hj/wc/1j0m7/TI2vzUKxO2xyLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVdQ/SWV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dujh8cnhmj46JPJbIpzxfAM/9ZMdECRNyBwQKHXMAlc=;
	b=jVdQ/SWV9GeLJzdkf8UuORmjaRJ9oanPgHgzMMYi/32p/bhnVri2vnByhJpaSuk7uXguX3
	t8i1c1GubO1qVrgwTp7wXd1LF/L4KtngWCt1g6WkZ16Kq2pzt/8O+8nFBrjI55VzeDe+v0
	IxBoa+2aYV85m69iHAHBAwO3hiLOGp0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-CmSllnDbO2CsvyNOp34p9A-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: CmSllnDbO2CsvyNOp34p9A-1
X-Mimecast-MFC-AGG-ID: CmSllnDbO2CsvyNOp34p9A_1776126167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10027180044D;
	Tue, 14 Apr 2026 00:22:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E2BF1955D88;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0MjMf1917482
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:45 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0Mj2w1917481;
	Mon, 13 Apr 2026 20:22:45 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 04/10] dm-ima: don't copy the active table to the inactive table
Date: Mon, 13 Apr 2026 20:22:38 -0400
Message-ID: <20260414002244.1917447-5-bmarzins@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-9177-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.952];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 51E763F4709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If an inactive table was cleared, dm_ima_measure_on_table_clear() was
copying the ima.active_table to ima.inactive_table. This is not what
device-mapper does, and it makes the IMA measurements show an inactive
table when there isn't one. Also, once this is removed, the code no
longer needs to keep checking if the active and the inactive table point
to the same memory.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 64 +++++++--------------------------------------
 1 file changed, 10 insertions(+), 54 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 8b84b676cad4..c141068bc6b4 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -281,17 +281,13 @@ void dm_ima_measure_on_table_load(struct dm_table *table)
 	if (!digest_buf)
 		goto error;
 
-	if (table->md->ima.active_table.hash != table->md->ima.inactive_table.hash)
-		kfree(table->md->ima.inactive_table.hash);
-
+	kfree(table->md->ima.inactive_table.hash);
 	table->md->ima.inactive_table.hash = digest_buf;
 	table->md->ima.inactive_table.hash_len = strlen(digest_buf);
 	table->md->ima.inactive_table.num_targets = num_targets;
 
-	if (table->md->ima.active_table.device_metadata !=
-	    table->md->ima.inactive_table.device_metadata)
-		kfree(table->md->ima.inactive_table.device_metadata);
 
+	kfree(table->md->ima.inactive_table.device_metadata);
 	table->md->ima.inactive_table.device_metadata = device_data_buf;
 	table->md->ima.inactive_table.device_metadata_len = device_data_buf_len;
 
@@ -330,19 +326,9 @@ void dm_ima_measure_on_device_resume(struct mapped_device *md, bool swap)
 	l += strlen(DM_IMA_VERSION_STR);
 
 	if (swap) {
-		if (md->ima.active_table.hash != md->ima.inactive_table.hash)
-			kfree(md->ima.active_table.hash);
-
-		md->ima.active_table.hash = NULL;
-		md->ima.active_table.hash_len = 0;
-
-		if (md->ima.active_table.device_metadata !=
-		    md->ima.inactive_table.device_metadata)
-			kfree(md->ima.active_table.device_metadata);
-
-		md->ima.active_table.device_metadata = NULL;
-		md->ima.active_table.device_metadata_len = 0;
-		md->ima.active_table.num_targets = 0;
+		kfree(md->ima.active_table.hash);
+		kfree(md->ima.active_table.device_metadata);
+		memset(&md->ima.active_table, 0, sizeof(md->ima.active_table));
 
 		if (md->ima.inactive_table.hash) {
 			md->ima.active_table.hash = md->ima.inactive_table.hash;
@@ -518,15 +504,10 @@ void dm_ima_measure_on_device_remove(struct mapped_device *md, bool remove_all)
 	kfree(capacity_str);
 exit:
 	kfree(md->ima.active_table.device_metadata);
-
-	if (md->ima.active_table.device_metadata !=
-	    md->ima.inactive_table.device_metadata)
-		kfree(md->ima.inactive_table.device_metadata);
+	kfree(md->ima.inactive_table.device_metadata);
 
 	kfree(md->ima.active_table.hash);
-
-	if (md->ima.active_table.hash != md->ima.inactive_table.hash)
-		kfree(md->ima.inactive_table.hash);
+	kfree(md->ima.inactive_table.hash);
 
 	memset(&md->ima.active_table, 0, sizeof(md->ima.active_table));
 	memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
@@ -594,34 +575,9 @@ void dm_ima_measure_on_table_clear(struct mapped_device *md, bool new_map)
 	dm_ima_measure_data("dm_table_clear", device_table_data, l, noio);
 
 	if (new_map) {
-		if (md->ima.inactive_table.hash &&
-		    md->ima.inactive_table.hash != md->ima.active_table.hash)
-			kfree(md->ima.inactive_table.hash);
-
-		md->ima.inactive_table.hash = NULL;
-		md->ima.inactive_table.hash_len = 0;
-
-		if (md->ima.inactive_table.device_metadata &&
-		    md->ima.inactive_table.device_metadata != md->ima.active_table.device_metadata)
-			kfree(md->ima.inactive_table.device_metadata);
-
-		md->ima.inactive_table.device_metadata = NULL;
-		md->ima.inactive_table.device_metadata_len = 0;
-		md->ima.inactive_table.num_targets = 0;
-
-		if (md->ima.active_table.hash) {
-			md->ima.inactive_table.hash = md->ima.active_table.hash;
-			md->ima.inactive_table.hash_len = md->ima.active_table.hash_len;
-		}
-
-		if (md->ima.active_table.device_metadata) {
-			md->ima.inactive_table.device_metadata =
-				md->ima.active_table.device_metadata;
-			md->ima.inactive_table.device_metadata_len =
-				md->ima.active_table.device_metadata_len;
-			md->ima.inactive_table.num_targets =
-				md->ima.active_table.num_targets;
-		}
+		kfree(md->ima.inactive_table.hash);
+		kfree(md->ima.inactive_table.device_metadata);
+		memset(&md->ima.inactive_table, 0, sizeof(md->ima.inactive_table));
 	}
 
 	kfree(dev_name);
-- 
2.53.0


