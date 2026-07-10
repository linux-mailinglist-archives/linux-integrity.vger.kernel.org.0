Return-Path: <linux-integrity+bounces-9905-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 55e9E7i5UGo84AIAu9opvQ
	(envelope-from <linux-integrity+bounces-9905-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 11:22:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49CF738FBB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 11:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R2dW+uTP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9905-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9905-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C52B30459E8
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4B3BE165;
	Fri, 10 Jul 2026 09:02:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA852E7369
	for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2026 09:02:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674160; cv=none; b=R4LDazqOcgnkjwp9ImoFN2j5i87/MvYKgkj2bC0Zx9Ud5OnW5pN15lI7s0JuNx+/LkdfGC3JMc93gTmNEW1SbZkjknv0pNnStMJ/eg1RjR3z6UHmx0AsQzdAg2mn5MJle3mM/b8aZXJBjvBWEto+Qb3BH/JdyMjInwHETWSD430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674160; c=relaxed/simple;
	bh=/wpKpY45DSI4HgdAk0vcydnpSfjw078lWvatlK/8ypM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQ7eNu0vNz6tTNwCTzH6/SekegL1IuD/3xQ2avbcMGXjG231JCXOZS4AyWAfmFtiV61lQMmGrFhk0VByh5lUhCj2xeFXSQN7J5cRZfA8TSZ+PcvXVmFILuC7iZeXyrqqIKRbinFhs1ojPM7bYLVHwLu/uTBeS73MAs8ZAqZcmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2dW+uTP; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so11541525ad.2
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2026 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674158; x=1784278958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4L33oMpRIj1SI06g0mcWO4Stxr8HrpjctK5+3kxoMio=;
        b=R2dW+uTPpofsK5q+f+0DAC8zVk7+XTqEfGXgQLhpn75zqGGhx+2pXlCDxMyxqxwOc2
         Vbf+6NoYCJmREsu27ttMiPTQDIo3zJKPVAwSi9203qVgcWea89PdTQ8RN+2crfIT2HXe
         wK1XdjNT3WfcaA1NhIsJvxeIMBpQ7Cg4m6texJnA82/ORrGrLQskgipoXk+U2Sfu/6NG
         v/7vj7pv0xXJf/fRy1dCuJPPRJ+kFhqD5zcy3gFbW0idjPqGXvrG9BocZoLMnhVprp5b
         XvzBiNsXlmoxV4Lcq4FOVTRbQBu3Rn8yJ3pl1BHFaMGGQnnjZaYq+7HVU5mGH4ANciQn
         3PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674158; x=1784278958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4L33oMpRIj1SI06g0mcWO4Stxr8HrpjctK5+3kxoMio=;
        b=reC5G/3exFkP8zMHmB0vb5981oL6C4XAhd1reDAaTof9sLq6xvHtIby8tmH2ABSYND
         vS1hLWZ1NRxGSFfT7M3NchD6ie05m1uDJlC4drNiGutDxF0Dh8ydMCU1g6oPyNXC0a7s
         sD609Uj8truxjIlsH4Y+z9KXmu19C6itaq8uNZ2+XRBGuhZRiOUG75La8nL9Ok7CO5e5
         yUDYCqVypfcdyb6Btap+JAFtAqSvnl8asLvHg0tAF78eNG2msxaOSGeCLsgm5sT8MaFX
         IoANZewN9W+KMsro/+y26HlsJAjPvVTVvuIznPHSlEoc1BEcVgZli/wtZpcVpbdNt1y7
         ezZg==
X-Forwarded-Encrypted: i=1; AHgh+RoKdnjcDpyqRcfT32IbuoVW7jfFWP3K1+wcs3bhZTxjUpNKIT/f6oFmvDSfIBA8XwE2hbUbhyPTte22HF2i+aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQkNSZ7gx9z/4c3jl+fy2US1tp1bpxbgPtI3CXixKItbuiyBh
	QXDuvqJOa6UmWgzISBMwms3mKSIV6Hvm0IEFGtwuTDLTw6H3gbUOPrhb
X-Gm-Gg: AfdE7cnG1U3Xxh3c63VwqlySC/JflNfIdOe1xkxhwBHb/AYDMrDCMCkROogI+IOQ48P
	gOHGaJOpnKgxYi61HVSxH31qdV6lZtpSfn5RjbspjmZSNCJV96kkupyYmPHVs+uSF/NuddKVJg4
	8adVgEr8bsNJOWJS+iAiKlsFvBkTEw9obzi2BcYXVVUClLRbtKBAW8qWwEPyN8ct+1j7+AuzPVe
	OL/Dwq3vuZIsCQNf6Di4wRInllww6Ek2gh6GuajRiyWIikdE+AUlKxlHYtxXkp7Xp4/fDBZJsJM
	3ILAAIolK2QT26Gcv0Rfl8+Srvq8zfv059ob50KLtY9nCYWWjiKfM8ULSd1HRtwb9z3WX80RLXi
	F8fmkC8vZh5n7c0WIzUj+TPiMNJ0yfzB7J4s45ohCm8eycYRWYedUfe9NKVQFG/VXYSjPkr08vb
	F4Ur3XESx8zQEJw2dBWDXBWfDhxFWmCGtBZJU41UR0CTsEwPOeWELUGGB5KsHq1fKIbXuMyPTot
	MZKFxAi06vZb800qSAPtw==
X-Received: by 2002:a17:903:3c67:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccea37d246mr106509045ad.5.1783674158389;
        Fri, 10 Jul 2026 02:02:38 -0700 (PDT)
Received: from DESKTOP-UIAUP5R.localdomain ([116.37.10.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce7b3755a3sm13832775ad.80.2026.07.10.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:02:37 -0700 (PDT)
From: Jaewon Yang <yong010301@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH] tpm: Reject reads outside the response buffer
Date: Fri, 10 Jul 2026 18:02:17 +0900
Message-ID: <20260710090217.191289-1-yong010301@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9905-lists,linux-integrity=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:security@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yong010301@gmail.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yong010301@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A49CF738FBB

tpm_common_read() clamps the transfer length to priv->response_length but
does not validate the file offset (*off) before using it to index the
fixed TPM_BUFSIZE-byte priv->data_buffer:

	ret_size = min_t(ssize_t, size, priv->response_length);
	copy_to_user(buf, priv->data_buffer + *off, ret_size);
	memset(priv->data_buffer + *off, 0, ret_size);

Sequential read() keeps *off in range, but the fops use the legacy .read
callback and neither tpm_open() nor tpmrm_open() calls nonseekable_open(),
so FMODE_PREAD stays set and pread(2) passes an arbitrary offset straight
into *off. An out-of-range offset then accesses memory beyond data_buffer,
causing an out-of-bounds read through copy_to_user() and, when the copy
succeeds, an out-of-bounds zero-write through memset().

Reject any read whose offset and length leave the response buffer.

Fixes: 9488585b21be ("tpm: add support for partial reads")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Yang <yong010301@gmail.com>
---
Notes for reviewers (not part of the commit):

Reproduced on a KASAN 6.12 build with a swtpm TPM2 device. After a command
leaves a response pending, pread(fd, buf, 16, 0x1400) triggers two
slab-out-of-bounds reports, one for the copy_to_user() read and one for the
memset() write; on that x86-64 build the faulting access was 962 bytes past
a 4344-byte struct tpmrm_priv served from kmalloc-8k. With this patch,
out-of-range preads (offset past the buffer, at the end, or an in-range
offset whose length crosses the end) return -EINVAL with no KASAN report,
while sequential partial reads still return the full response and a normal
read after a rejected pread still works.

Reaching it needs a process that can open the TPM device and send a command.
Access depends on the device-node permissions; the upstream tpm2-tss udev
rules set tpmrm devices to mode 0660 with group tss. My reproduction ran as
root, so I have not shown non-root reach on a specific distribution or built
a privilege-escalation chain.

I searched public archives on 2026-07-10 and found no matching report, which
does not rule out a private, very recent, or unindexed one. Found through
AI-assisted source review; the code path and reproduction were verified by
hand. A reproducer and full logs are available on request.

 drivers/char/tpm/tpm-dev-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f942c0c8e..dbf049028 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -145,6 +145,16 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 			goto out;
 		}
 
+		/*
+		 * Reject reads whose offset and length fall outside the fixed
+		 * response buffer.
+		 */
+		if (*off < 0 || *off >= TPM_BUFSIZE ||
+		    ret_size > TPM_BUFSIZE - *off) {
+			ret_size = -EINVAL;
+			goto out;
+		}
+
 		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
 		if (rc) {
 			memset(priv->data_buffer, 0, TPM_BUFSIZE);
-- 
2.43.0


