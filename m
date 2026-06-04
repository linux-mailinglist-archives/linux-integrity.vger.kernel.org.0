Return-Path: <linux-integrity+bounces-9744-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AeFdI7DpIGqo9QAAu9opvQ
	(envelope-from <linux-integrity+bounces-9744-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Jun 2026 04:57:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD663C9DA
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Jun 2026 04:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="YvapC/JJ";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9744-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9744-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94CE730238ED
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2026 02:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1283AC0C2;
	Thu,  4 Jun 2026 02:54:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663823D7F0;
	Thu,  4 Jun 2026 02:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541645; cv=none; b=rmpcOn4pbY7hx3sk6Ys5XfUD0gxa8mUjwxB/0huEetpPaJ7ku9NSereY5zehTGw+FVoOD5YJHxecBXShqYTSXkHHcPw49Mn679SlhYt+2vhqYrFu1r1Tu644IfyihlqefwqEACZHQjdlJbgJQlyBa2GsB3CdSttFJcRRqD9nI78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541645; c=relaxed/simple;
	bh=7+C6Nw6iMQL+90/+XKxfgRLwMLCaC5fM1Y3EGM8tlMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGNPqadGU2BrwGYPir4W8CHsC2FCsODd4NVd64fmGl8ihMFslt/ZTFJgzNUqKZL7/+FhXNLgdR92zolwt8br2DprFYN+2H5t/sALZB3De9gb5HTFjKZW/I7aZZjOuikTHF06LKiTdCDoh/GZKTNwfk64vDRdIwxYT9f44GTgVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YvapC/JJ; arc=none smtp.client-ip=115.124.30.110
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780541640; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aQaB2ZmZl+E8FocwraYwhjlJEmmAKUy+YTGT5D/wOTI=;
	b=YvapC/JJHqcyAul/EE4tPh/Tu0KPT+t+sb4Ab9qMemSO7jr2hd1D6rS3ctCTz77xxSmmxmIunvfTO8pJgomiOu0o/vq2hr6PUqluDVyciKTBxHaTYulwDM43guwd3/5CckOjAjFcIAoAmEpF1eeUSXkDcXmTJeTH/cofPsqcfXw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X48rcwu_1780541638;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X48rcwu_1780541638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 10:53:59 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Nayna Jain <nayna@linux.vnet.ibm.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: eventlog: tpm2: allow event log entries ending at the log boundary
Date: Thu,  4 Jun 2026 10:53:47 +0800
Message-ID: <20260604025356.3436943-1-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9744-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ZongYao.Chen@linux.alibaba.com,linux-integrity@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:nayna@linux.vnet.ibm.com,m:tianjia.zhang@linux.alibaba.com,m:ZongYao.Chen@linux.alibaba.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ZongYao.Chen@linux.alibaba.com,linux-integrity@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEDD663C9DA

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

The TPM2 firmware event log buffer is a half-open range:
[bios_event_log, bios_event_log_end). An entry ending exactly at
bios_event_log_end is still inside the buffer; only an entry extending
past that address is malformed.

The TPM2 seq_file iterator did not handle this boundary consistently.
The TCG_EfiSpecIdEvent header had to satisfy "addr + size < limit".
Later events were rejected when "addr + size >= limit". Firmware that
packs the final measurement tightly at the end of the log can therefore
lose that measurement. If it is the first measurement after the spec ID
header, binary_bios_measurements shows only the header.

This has been observed on bare-metal systems whose UEFI enables the SM3
PCR bank, but the bug is not SM3-specific. Any tightly packed TPM2 log
whose final event ends at bios_event_log_end can hit it.

Accept entries that end exactly at the log boundary by rejecting only
"addr + size > limit". An accepted boundary entry has its last byte at
limit - 1, so this does not allow reading past the buffer. Keep
zero-length entries rejected.

Also treat addr >= limit as EOF in tpm2_bios_measurements_start().
After seq_file restarts from a later position, start() can scan past a
valid final entry and leave addr equal to bios_event_log_end. That
address is the end marker, not another event header.

Leave the "marker >= limit" check in tpm2_bios_measurements_next()
unchanged. There, marker is already the start of the next event, so
"marker == limit" means EOF.

Fixes: 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
---
 drivers/char/tpm/eventlog/tpm2.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
index 37a05800980c..6b65d872e43a 100644
--- a/drivers/char/tpm/eventlog/tpm2.c
+++ b/drivers/char/tpm/eventlog/tpm2.c
@@ -54,31 +54,38 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
 	size = struct_size(event_header, event, event_header->event_size);
 
 	if (*pos == 0) {
-		if (addr + size < limit) {
-			if ((event_header->event_type == 0) &&
-			    (event_header->event_size == 0))
-				return NULL;
-			return SEQ_START_TOKEN;
-		}
+		if (addr + size > limit)
+			return NULL;
+		if (event_header->event_type == 0 &&
+		    event_header->event_size == 0)
+			return NULL;
+		return SEQ_START_TOKEN;
 	}
 
 	if (*pos > 0) {
 		addr += size;
+		if (addr >= limit)
+			return NULL;
 		event = addr;
 		size = calc_tpm2_event_size(event, event_header);
-		if ((addr + size >=  limit) || (size == 0))
+		if ((addr + size > limit) || size == 0)
 			return NULL;
 	}
 
 	for (i = 0; i < (*pos - 1); i++) {
+		if (addr >= limit)
+			return NULL;
 		event = addr;
 		size = calc_tpm2_event_size(event, event_header);
 
-		if ((addr + size >= limit) || (size == 0))
+		if ((addr + size > limit) || size == 0)
 			return NULL;
 		addr += size;
 	}
 
+	if (addr >= limit)
+		return NULL;
+
 	return addr;
 }
 
@@ -115,7 +122,7 @@ static void *tpm2_bios_measurements_next(struct seq_file *m, void *v,
 	event = v;
 
 	event_size = calc_tpm2_event_size(event, event_header);
-	if (((v + event_size) >= limit) || (event_size == 0))
+	if (((v + event_size) > limit) || event_size == 0)
 		return NULL;
 
 	return v;
-- 
2.47.3


