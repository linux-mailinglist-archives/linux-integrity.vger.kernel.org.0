Return-Path: <linux-integrity+bounces-9870-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ne8jDR4wRWql8QoAu9opvQ
	(envelope-from <linux-integrity+bounces-9870-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 17:19:58 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F16EF311
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 17:19:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=dDxEB+PM;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9870-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9870-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BDD31A3114
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6F40B372;
	Wed,  1 Jul 2026 15:10:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041B3B960B;
	Wed,  1 Jul 2026 15:10:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918610; cv=none; b=tGzuOZnFbTDkH58uAFOanEmcseghT2WvzZcthWiXYPZBDO0oltJ4qK1HAHQHo4aR+6RdTEVLV43WFMCueh8QsGe1h21tyl+tyYSJojPhA5ejBhbX//vGhJjOj+9mTvC9rMNE1QuThUuc7HSQB9U39QMsfoFZLCVYF3Fof+yO+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918610; c=relaxed/simple;
	bh=1YsAFSLztBNTbJTOaOF3NEdOyV5z4rSistGaGl9Yf+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n5BTWVpjeCFDHZrkyxPARohaTmsjkNBOSkRWVOoYUM8lqlQ+cfyDqM7TdLey7Fs+kZ+XUpVP3th+wJiSQQReIHf0Gh/lkunhL6oA5PRHAKQTxz/DyDpAbKZNPhrm5lUhES2org4H6YJOebv0/4OPaX4JPnaE9pjAGHKZP3fLoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=dDxEB+PM; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4484c23b8;
	Wed, 1 Jul 2026 23:04:46 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] tpm: st33zp24: use unaligned accessors for TPM header fields
Date: Wed,  1 Jul 2026 23:04:33 +0800
Message-Id: <20260701150433.1220774-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f1e360c5403a1kunm60b814a21a2092
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTRlCVkodQ09JSE1LGUgZTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dDxEB+PM+X3BsN0J1Q2+dPG0sq1PKK2YXugCEdYvwwaxoikIAE9uxLT4jQBR6hRn5vVd81Vqu68DiSc0sVTO+tZUojtrg+17ycfx4QR15gEeEpdUSrkBq4L/4we+ZpjfBGL7ePRrnUVroHWvTHI+fo7h7Zxe3iTe0FaIU+xrFNQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=OLXQGO6r/9j6+BXT0ROONL8TinGEenBbrQkhFP0G7J0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9870-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 825F16EF311

The ST33ZP24 driver parses TPM command and response headers from byte
transport buffers. st33zp24_recv() reads the response size from bytes
2..5 of the TPM header, and st33zp24_send() reads the command ordinal
from bytes 6..9 when IRQ mode waits for command completion.

Those fields are 32-bit big-endian protocol fields, but their TPM
header offsets are not 32-bit aligned: the header starts with a 2-byte
tag, so both offsets 2 and 6 are 2 modulo 4. Even if the caller buffer
is 4-byte aligned, casting buf + 2 or buf + 6 to __be32 * still creates
a misaligned typed access.

Use get_unaligned_be32() for both TPM header fields.

This issue was detected by our static analysis tool and confirmed by
manual audit. A focused UBSAN alignment validation of the same typed
load shape reported a misaligned __be32 access in st33zp24_recv().

Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index e2b7451ea7cc..2d74f30c2fc0 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
 
 #include "../tpm.h"
 #include "st33zp24.h"
@@ -364,7 +365,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 		goto out_err;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
-		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
+		ordinal = get_unaligned_be32(buf + 6);
 
 		ret = wait_for_stat(chip, TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 				tpm_calc_ordinal_duration(chip, ordinal),
@@ -400,7 +401,7 @@ static int st33zp24_recv(struct tpm_chip *chip, unsigned char *buf,
 		goto out;
 	}
 
-	expected = be32_to_cpu(*(__be32 *)(buf + 2));
+	expected = get_unaligned_be32(buf + 2);
 	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
-- 
2.34.1


