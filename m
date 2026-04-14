Return-Path: <linux-integrity+bounces-9171-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MhbMhmJ3Wk8fQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9171-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0104E3F46FB
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 02:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23757301CEC3
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2026 00:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2B23909F;
	Tue, 14 Apr 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPlg0nBB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1F1E9906
	for <linux-integrity@vger.kernel.org>; Tue, 14 Apr 2026 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126173; cv=none; b=Ivgv6J9hWQuXIChXYtkBWiRjlCy7ja1rxl3KwdLxw/zyoxneA9WRK84lKTFCVKT2FtXBanddzq3V1aiRpKOc+jOgW/o4kJKKzu23XPNEi4BuEXEyRGlXedJp6XFn6xcAUqpKOpw6xZIp+W161m5/tW+9VwMnA4Rjff1VAm9Fh0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126173; c=relaxed/simple;
	bh=LGXCPK0WIeb96A3NC8ZkfX/nGxwdjBOpBz9Knpay8YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CykR3C54jRmptwVyCx+N0p0DshqZqQwFuAe5rS1Z9OmYpJ+M5lyCPdo8Eckexdh5V7+DUnp19emtBZ4SxWFhaAe4H+C6+isiCk3Hy6p10ie4gS7S/AM2edakomGOOLQan3VQm9x8eKuVUom+bNNk2Gopjoy8lXYXv8qFI3m3Eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPlg0nBB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776126170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFqV/KOxxVZt5oI9jDOVr4WGcOcSzlwNUFUrpU5i+XY=;
	b=ZPlg0nBBKEJspNoFS8aCtFhg10xN5zUrwSB/ek7rdc7OxHYIr4gYZXUouwwv8Vx9JxMOV+
	3GqaV1EUFBYcNdq+hrO/BVXBcN8nZtcMr9uMeeJpoioWPLtzmY7cAgJ+13vReP1fTFkxlw
	7ypFR5s1XuxeuKEaEIElc9ba42IDOEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-gmWdqrukM1ma3swKIIxhLA-1; Mon,
 13 Apr 2026 20:22:48 -0400
X-MC-Unique: gmWdqrukM1ma3swKIIxhLA-1
X-Mimecast-MFC-AGG-ID: gmWdqrukM1ma3swKIIxhLA_1776126167
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2ED9195609D;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E2F519560AB;
	Tue, 14 Apr 2026 00:22:46 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63E0MjWs1917474
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:22:45 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63E0MjTa1917473;
	Mon, 13 Apr 2026 20:22:45 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH 02/10] dm-ima: remove broken last_target_measured logic
Date: Mon, 13 Apr 2026 20:22:36 -0400
Message-ID: <20260414002244.1917447-3-bmarzins@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-9171-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.967];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0104E3F46FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When it ran out of space for adding more targets to the ima_buf,
dm_ima_measure_on_table_load() would measure the dm device early, and
then add the rest of the targets and measure it again.
last_target_measured was intended to flag the last target measured so
that the device wouldn't get remeasured, if no new targets were added
after the early measurement. But the way to code works, the dm device
will never be measured early unless there is another target to add to
the ima_buf.  Instead, if there is only one more target to add, that
target was getting added to the ima_buf, but it wasn't getting
remeasured, because last_target_measured was set. Since
dm_ima_measure_on_table_load() only measures a device early when there
are more targets to add, the final measurement must always happen, and
last_target_measured is unneeded.

Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-ima.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index a639bb0fe6c3..209221fa8bc5 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -167,7 +167,6 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	size_t device_data_buf_len, target_metadata_buf_len, target_data_buf_len, l = 0;
 	char *target_metadata_buf = NULL, *target_data_buf = NULL, *digest_buf = NULL;
 	char *ima_buf = NULL, *device_data_buf = NULL;
-	int last_target_measured = -1;
 	status_type_t type = STATUSTYPE_IMA;
 	size_t cur_total_buf_len = 0;
 	unsigned int num_targets, i;
@@ -205,8 +204,6 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 	for (i = 0; i < num_targets; i++) {
 		struct dm_target *ti = dm_table_get_target(table, i);
 
-		last_target_measured = 0;
-
 		/*
 		 * First retrieve the target metadata.
 		 */
@@ -256,14 +253,6 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 
 			memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
 			l += device_data_buf_len;
-
-			/*
-			 * If this iteration of the for loop turns out to be the last target
-			 * in the table, dm_ima_measure_data("dm_table_load", ...) doesn't need
-			 * to be called again, just the hash needs to be finalized.
-			 * "last_target_measured" tracks this state.
-			 */
-			last_target_measured = 1;
 		}
 
 		/*
@@ -277,11 +266,8 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 		l += target_data_buf_len;
 	}
 
-	if (!last_target_measured) {
-		dm_ima_measure_data(table_load_event_name, ima_buf, l, noio);
-
-		sha256_update(&hash_ctx, (const u8 *)ima_buf, l);
-	}
+	dm_ima_measure_data(table_load_event_name, ima_buf, l, noio);
+	sha256_update(&hash_ctx, (const u8 *)ima_buf, l);
 
 	/*
 	 * Finalize the table hash, and store it in table->md->ima.inactive_table.hash,
-- 
2.53.0


