Return-Path: <linux-integrity+bounces-9925-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TagvBunKU2pFfAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9925-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2026 19:12:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145574578E
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2026 19:12:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=klnivRbQ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9925-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9925-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0CA330137BD
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2026 17:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A319342146;
	Sun, 12 Jul 2026 17:12:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E933F5B4
	for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 17:12:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783876325; cv=none; b=VexaTckQQbdi2x9bPrtESb9zCPcFzeTAK9ZFhye6yIvObZCw5CKvohhRh+qancis/5YQL/i032bSwCN2++JuyRTksOl80XC3meaA3fk0JWXeFFhAfJVpgjpHOMZaMYPlooR3XuQme4OrHrqPu+/Eo9NjD9Jxl+P1bFKe6dcn1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783876325; c=relaxed/simple;
	bh=BYuOZs3FhdP+WpUpATCq3M1/Cd7DWKOjgexkt1eckq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ76gZQXpGf0EYH4sHmJykkh9bADFKxCjr3bCGJdBqMQWUDlOzjOD1v4Ys53jVLn4OmB2mLxYKzPo0nhUNbU7AF3+KFSJ8c1yn5BieVWuttBUAjeqnEVjCCxik1MYkapXMOtiIEQQJgpYsSNGbwmnf3mkSDkvbL6SeKMW0nu8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klnivRbQ; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc891373e0so23966795ad.2
        for <linux-integrity@vger.kernel.org>; Sun, 12 Jul 2026 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783876323; x=1784481123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5lXEqICBIqkji+uxAJTXRS2K+JcXjR+GmTpqueIXq4s=;
        b=klnivRbQX1y31CLPJ/kTCQLcOJm90m4ueyZA3MRzgopflHq102ozGt4uutwWYWEil2
         wh5wPuJ6rkQPlbPxpSstfTJkJDnWWTIj0GXNg/Zd/TX3r/o+fMmFgt9zUFoV1q82dxA/
         WgqQYkFdQ8/isuG8Zr4tKcttp77XEU174qpK7bSSQTT/nNU6KP7DPScrtxB17k+SE+qr
         Y4S3B8TC7B1QZHwJYeSXFzlc43PyQ/WrWaRiLovdklxhz5+W615GMYM3jHPjY87ZDV4v
         Eo9kgPZmBKMpvjc/0qsN0/3jeVjLUYaC7qKmobgHrguolhf64w+Sg7jnSjt22GCgdxbI
         CBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783876323; x=1784481123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5lXEqICBIqkji+uxAJTXRS2K+JcXjR+GmTpqueIXq4s=;
        b=Bj6Ie2DyAvDTRmHfUrh3kIKFza4Xkh0c9TWIQmIOrgGGzbpX21BfI69tsd86t0jRJS
         F+etmk15UEX2zutzNB+oUgTNCD7QlhZ9hxo4oiVSHJpSDgCi6Ee+xUyKcQKyyvQeN1qN
         IWXOhDWTW1jAmuWpeRk6/MT7MmoVUuGGthUQC9cl2GLnTt3SRid4TePBKhi1uygOSsgu
         4Bow0aBgjPXgYFdEmKkKpIzUj66I4es/08oYXVBqLxBuoepjEn5LzmoLsvNzijMxyjGO
         VD/UOgFxwEOGsq8JHw+qRK6MmUYHLBV2RShHRwKx8YOefefiEnn/5lHMFmna/xGfD0iu
         isJw==
X-Forwarded-Encrypted: i=1; AHgh+RrefulFhI0e5LY4tvxnFhvLzPWea8AsV7D8sJoU9tUP78lsbP0rRSRESExypkmx916B2YozkglRWQFJQyZxkaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6KkKvg9ivcrFvSEZVrAE5l806e1ZpEX7uxr+r0K+3dtmnp9m
	3B3SxnMrp+rooDz6gDf2d0WnAQf/EhHrLVX8idsBBe8s8oyoyXCEaKLF
X-Gm-Gg: AfdE7ckeBo3RotJNNC+J0bEwOb0QzQ7EmJi3yyL0ok3ZIkIIH/z4CncMrXKjA+ntOkD
	N1FLDjdAxTxmwOW3e8qoRcj0BJxJsGIarwgomEPo6ujgJqo1GpnEKfWXnZxWrNbbPX621j7SIGC
	DditJ3v/WRgFDiM575lJp3AqlBX1j3QNV8qeqjhejupBYHkBoQjkusSIfTxFRcQlOsdkOtrVuUm
	sXETYhBRMsSZJEVCbRC1LILukkxV2ImU3lzk+Jv2D1kCmHBLHfdE3ec4zQcD1z1zAHArUUjHMI4
	5BKpKcWMJJmLHVkXrD2ZBYlD60T6uDNQM8v0QzSxezXJn6jNBVoVst7WHLPC18OjwYBncnhU+P/
	3k45AqaEHqF66bmHlwc7/h07VgXOYPLdedYqRq0v5RJdg0u+C3revULA2lPgo4Bk3Mfn8IKJe34
	s3pZ+1/TxgxFQTSFpQB2rlQb4rQFkv2GPrnw54F0fX1AVK+L92lYwuF2Kg+eNK1cimkkBZruSBW
	xldRIRW5HoeXfgd2/GIZw==
X-Received: by 2002:a17:902:d546:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2ce9eac212bmr66417335ad.17.1783876323131;
        Sun, 12 Jul 2026 10:12:03 -0700 (PDT)
Received: from DESKTOP-UIAUP5R.localdomain ([116.37.10.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm86810655ad.31.2026.07.12.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 10:12:02 -0700 (PDT)
From: Jaewon Yang <yong010301@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH v2] tpm: Make the TPM character devices non-seekable
Date: Mon, 13 Jul 2026 02:11:47 +0900
Message-ID: <20260712171147.323213-1-yong010301@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
References: <CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9925-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:security@kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER(0.00)[yong010301@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yong010301@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5145574578E

The TPM character devices expose a sequential command/response
interface, but their open handlers leave FMODE_PREAD and FMODE_PWRITE
enabled.

After a command leaves a response pending, pread(fd, buf, 16, 0x1400)
passes 0x1400 as *off to tpm_common_read(). The transfer length is
bounded by response_length, but the offset is used unchecked when
forming data_buffer + *off. A sufficiently large offset therefore
causes an out-of-bounds heap read through copy_to_user() and, if the
copy succeeds, an out-of-bounds zero-write through the following
memset().

Positional I/O does not provide coherent semantics for this interface.
An arbitrary pread offset cannot represent how much of a response has
been consumed sequentially. The write callback always stores a command
at the start of data_buffer, while pwrite() does not update file->f_pos
and can leave the sequential read cursor stale.

Call nonseekable_open() from both open handlers. This removes
FMODE_PREAD and FMODE_PWRITE, causing positional reads and writes to
fail with -ESPIPE before reaching the TPM callbacks, and explicitly
marks the files non-seekable. Normal read() and write() continue to use
the existing sequential f_pos cursor, leaving the response state
machine unchanged.

Tested on Linux 6.12 with KASAN and a swtpm TPM2 device:

- sequential partial reads returned the complete response;
- pread() and preadv() with offset 0x1400 returned -ESPIPE;
- pwrite() and pwritev() with offset zero returned -ESPIPE;
- the pending response remained intact after the rejected operations;
- a subsequent normal command/response cycle completed normally; and
- no KASAN report was produced.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Link: https://lore.kernel.org/all/20260710090217.191289-1-yong010301@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Yang <yong010301@gmail.com>
---
Changes in v2:
- replace the response-buffer bounds check with nonseekable_open();
- reject positional read and write at open time;
- preserve the existing sequential read/write state machine.

The alternative response_length rework proposed during review was tested
and not taken: a read-until-EOF loop hangs because cleanup resets *off
without clearing response_length. It also treats an arbitrary positional
offset as the consumption cursor; for example,

    pread(fd, &c, 1, 99)

on a 100-byte response can discard bytes 0 through 98 without returning
them.

 drivers/char/tpm/tpm-dev.c   | 2 +-
 drivers/char/tpm/tpmrm-dev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index 2779a8738..74488f0a7 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -36,7 +36,7 @@ static int tpm_open(struct inode *inode, struct file *file)
 
 	tpm_common_open(file, chip, priv, NULL);
 
-	return 0;
+	return nonseekable_open(inode, file);
 
  out:
 	clear_bit(0, &chip->is_open);
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index f48d4d9e1..19e8f2779 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -29,7 +29,7 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 
 	tpm_common_open(file, chip, &priv->priv, &priv->space);
 
-	return 0;
+	return nonseekable_open(inode, file);
 }
 
 static int tpmrm_release(struct inode *inode, struct file *file)
-- 
2.43.0


