Return-Path: <linux-integrity+bounces-9454-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNKZHCRT+mkJMgMAu9opvQ
	(envelope-from <linux-integrity+bounces-9454-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 22:29:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD914D3AB0
	for <lists+linux-integrity@lfdr.de>; Tue, 05 May 2026 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4FE8306B3B4
	for <lists+linux-integrity@lfdr.de>; Tue,  5 May 2026 20:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7113639D6FC;
	Tue,  5 May 2026 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFEsZglD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2410E365A11
	for <linux-integrity@vger.kernel.org>; Tue,  5 May 2026 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012861; cv=none; b=Qy0hRX9XTY1tuU5schUh++44DZ6kNBrBH7HK8lgtjyohIqWdjfquGcNH8IQXRvFHq65I3u+dMX+fWl434qvrO0ciQKvnr6zE/EaV8A1sRyEgauGMeZjo8oSlQU0LVAV7EoI84aSfE12LBAo0FKDwNY/X3BfmQ7mlEsD6vvudUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012861; c=relaxed/simple;
	bh=QCG1nboTvYCdLQm/WNl/ku5KblOJMLKZxNN8MesVFhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EV76CdZ4DrmbuVu5vb4sBuckNBwJmu1ZINQgVyB2o997jjG6o8NZp3WVv62zqOIqdVCvZ8YTLVJ2OWMdbzxkU4LiuWUmv9WHEbEkcQQ//lzRyLLmqohyFgFyd61Ve3EK+MoCpK9iOYIrb2hGAxxxhVlnjIZ2d4wMpigU+9dnaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFEsZglD; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5c5033f6so44809361cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 05 May 2026 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778012859; x=1778617659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1P7LiFiiS/jbih3ofgc0LfI30QvDKlAuIjRR17pE2rw=;
        b=jFEsZglDtTRdw6x3cS7dSYyC9NoIyO4ZJN9b9eZjOHEX4A6pnqoCpYa+A5YJ/LNseZ
         scp/Fyp1UghfXqlRAQvQK8oSzf5+1LybDiJyCyi9THksImyjfheusjSkpWUDydi5atAN
         OGLK9KP4moznOFcAQwVyz9Sf2Tvd4Lexwn2Lo8l8G5NEs4VS74dtMlpP44r0fxvrwXv0
         XVBt+ZoECUCO9NGE2nRc3WdLbiYkZuNAwKH742Dta/Cmg+z55y/z+n7uOmNpdEGI1/Yr
         m2Y5XQ4Gw4/ARe8qeyrZCgQOIGkas6Qkasu9THsmdS20GOtm2EgDLeT+4zdrTrmUAqIw
         QRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778012859; x=1778617659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P7LiFiiS/jbih3ofgc0LfI30QvDKlAuIjRR17pE2rw=;
        b=coPhvp+EGcizpP8CaPOxmxIooNIEStPSqvjbtl5vxM/0SfcBtjLeg84VdcntQlBSEf
         AQslBdJYaP6KfdJLYnyhV10B5m/5fKy3Fpo8tlzKy9Ft3N6MmELf8AOxDOkgYDl4SDGA
         U0FP5yzx1d8ISU4tIU9Mo0MVECq4gwdlEKsEuvzP7fWPY4mMuLIdmR9CjxKzwx3vSuy1
         NGGq/U3FlUEw+S5zHaGBQty1J9t7GIZP8JwyJWl5E6m8CoFd6QVeMxsb3UVDHgLVWCkk
         /e/zt8OopnNGKUyqyrd7frQLzDJpTokXhHAtL5bPgxKsexxd4hU/QvJtS44sXcXVe4PD
         G52Q==
X-Forwarded-Encrypted: i=1; AFNElJ9PSTm0Plw/mFPbSrq6f3BUX00Md3L9H9Ue7u2Emby2CVvRCOh7O7DVU/ZLKXerDO8ckHQt55o6izysQz9ICGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBaTwCioKTHrUiDF0CLycg3EOZTjnvS4hndGpJ7iC/zhqYk0X
	T5pn9hHGEER0n0izCyxHjorm/5LwGxNNXcAw09ButDXub0xhGsCkSap4
X-Gm-Gg: AeBDieukSshBcmw2AWyuyX8K4kUzntiVbOGkm5sZbHGNjgwkmaRnMqrHybZHK4m2dgY
	oz+EdoqYwiy1uhL7zGAbF/8Kj4tXSwV6DpadEKMvk6S2F7gQjeo5VRsgiMe7zQ7vYTYMZ1UDc/x
	EAEhDSeERI3Yh53iirbvyyy1geNR8cODj6wvNuLHi/Ju5ERrK950qUhaKWEPNOpp14o1wVmINJr
	swy7/vXNOssJoyL+FQZU9nwZoNqFyCf2UNLWZoZyD7o32/uvuOoleh8f0aR8YizuEqyFxgDHvM8
	TWSyLK7H24UUKe7JzauJalFoOR6VYpIGihDmy8ghRCwTUgwliPBo3NsIKLpOolUR4yUSFiaim/p
	BAUW+QTNp0ryZEvozEvx8BKm0ArHzd7hZ2c/iwOi237jzBA4LzdLElwVkfS7e985H3vsZkcGB3Y
	z/PYeuj6OiVWrAk16J8lxJ3Zu/EpqW98V8/wKf/gSTjOYoyuy6ssMG6MzZ33Zdz/90F13gL6KvE
	pCcS3oRG43NGWxjW9sRQvJ+7QgEeFAfovZYqiDz3p/Ro8k=
X-Received: by 2002:a05:622a:1390:b0:50e:5a87:6c0c with SMTP id d75a77b69052e-51461e54766mr9789701cf.24.1778012859098;
        Tue, 05 May 2026 13:27:39 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b8174csm151082571cf.25.2026.05.05.13.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:27:38 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: svsm: constify tpm_chip_ops
Date: Tue,  5 May 2026 16:27:38 -0400
Message-ID: <20260505202738.145800-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CDD914D3AB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9454-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,209.85.160.175:server fail,172.234.253.10:server fail,138.88.31.60:server fail];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Constify the SVSM vTPM ops. It is statically initialized and never
written to, so let's store it in .rodata.

Every other tpm_class_ops instance in drivers/char/tpm/ is already
const.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 drivers/char/tpm/tpm_svsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
index f5ba0f64850b..b74d60f687d5 100644
--- a/drivers/char/tpm/tpm_svsm.c
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -49,7 +49,7 @@ static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, bufsiz);
 }
 
-static struct tpm_class_ops tpm_chip_ops = {
+static const struct tpm_class_ops tpm_chip_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.send = tpm_svsm_send,
 };

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0


