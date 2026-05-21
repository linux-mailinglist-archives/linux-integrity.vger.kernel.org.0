Return-Path: <linux-integrity+bounces-9620-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLxHCCzWDmr2CQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9620-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 11:53:48 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 281865A2BB6
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3A91302AE36
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B903783AC;
	Thu, 21 May 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AmGn4Vjx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B97376A03
	for <linux-integrity@vger.kernel.org>; Thu, 21 May 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356285; cv=none; b=cUPNLShstoNngKUv2Bk+Dzkgs9s53aFnHM33ttfgOyWv6bilxibFNyB0XUTztxI07y/RpHjRmV7T7f7I7aaT4tEtQpEg2L9RhEvyfg6aZ1RiD0dAjnmEnInmiYf8+jGjdbagTDmLCrq4BUUvm7qbdX0sdtzte8AmdoJOIHMlflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356285; c=relaxed/simple;
	bh=YqAQytJbYhQ39t3pkKct2Su+5H1G5e6obzCJjhI+d9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPcese8AXuhyIh3Wpli/5oivW7ssr1LjqdfDBXhXM95P7i/phFBUNWeve9fJCgIF68df1bVifJwkqTDAeshgVGiXm+P9VuAGmqGG8tCEXxLM1aMCewZy505KkZj+t/3WwzMQnHcHVn5ArwgCg5nHWRcCOf4wwW/HtaPOAchcKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AmGn4Vjx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779356271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q3HkDah9G3ZXvEMnDoovHGjAyQRejsoiaP7BkJegKqo=;
	b=AmGn4Vjx+ulywScrk174lQ9+slQRI44UuUrK6HoHiI7FCvmgM4IwlrI7kqPz9osUiBHyUw
	+vAbVgu1S+fgSxgjVQPsO2TqZI6YN39OY0dLoUgkxBYUEJz9bPKHyPPj95zMahsNY2+QdP
	C1nO9gLpynXyZk1MDuKTzisQB087umM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Harald Hoyer <harald@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: fix event_size output in tpm1_binary_bios_measurements_show
Date: Thu, 21 May 2026 11:36:39 +0200
Message-ID: <20260521093639.162095-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2280; i=thorsten.blum@linux.dev; h=from:subject; bh=YqAQytJbYhQ39t3pkKct2Su+5H1G5e6obzCJjhI+d9o=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl8lzQqb4pMZlNfHqsd2PR358Oiuxtke1uvKP7/+2jlC ebcRcvrOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiHEaMDN+E4n9JzL96yibx 8OnVwSWyWmKXt/AZ28y3f/XRuuFT5idGht5v6S+VL+z1mNUiH5LzZVOyZhj3NeO8yzNrFrmvK16 mwwsA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9620-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 281865A2BB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
split the output to write the endian-converted event header first and
then the variable-length event data.

However, the split was at sizeof(struct tcpa_event) - 1, even though
event_data was a zero-length array, and later a flexible array member,
both of which already excluded the event data.

Therefore, the current code writes the first three bytes of event_size
from the endian-converted header and then the last byte from the raw
header, which can emit a corrupted event_size on PPC64, where
do_endian_conversion() maps to be32_to_cpu().

Use seq_write() to write the full endian-converted header, followed by
the variable-length event->event_data.

Drop the obvious comment while at it.

Fixes: 186d124f07da ("tpm_eventlog.c: fix binary_bios_measurements")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/tpm/eventlog/tpm1.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index e7913b2853d5..291720e89d91 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -224,29 +224,17 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
 {
 	struct tcpa_event *event = v;
 	struct tcpa_event temp_event;
-	char *temp_ptr;
-	int i;
 
 	memcpy(&temp_event, event, sizeof(struct tcpa_event));
 
-	/* convert raw integers for endianness */
 	temp_event.pcr_index = do_endian_conversion(event->pcr_index);
 	temp_event.event_type = do_endian_conversion(event->event_type);
 	temp_event.event_size = do_endian_conversion(event->event_size);
 
-	temp_ptr = (char *) &temp_event;
-
-	for (i = 0; i < (sizeof(struct tcpa_event) - 1) ; i++)
-		seq_putc(m, temp_ptr[i]);
-
-	temp_ptr = (char *) v;
-
-	for (i = (sizeof(struct tcpa_event) - 1);
-	     i < (sizeof(struct tcpa_event) + temp_event.event_size); i++)
-		seq_putc(m, temp_ptr[i]);
+	seq_write(m, &temp_event, sizeof(temp_event));
+	seq_write(m, event->event_data, temp_event.event_size);
 
 	return 0;
-
 }
 
 static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)

