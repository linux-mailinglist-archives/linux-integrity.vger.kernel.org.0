Return-Path: <linux-integrity+bounces-9687-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON8NEoIrFmqdigcAu9opvQ
	(envelope-from <linux-integrity+bounces-9687-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 01:23:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1BA5DD83E
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 01:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52A83022933
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2693C1F50;
	Tue, 26 May 2026 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9dqABwI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135063CE0A4
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837823; cv=none; b=ch33sPqvkCYpf045TTIhRkWfZmLiJFCWVzSKhxT+ECuGToNPPJaCxZbZOoY4utGxldxHuDDfvazkGT1retCKUXVyBeUlejzQCXmds+MEzqaSsL2Te3wpV2bv+bA4KAqLZhkpp00t9o5YGkGJiJsDSlGBqglIHCYhqrqG2kM3w9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837823; c=relaxed/simple;
	bh=Af7beS4YzYIWd0gIkVoWgdrwpXtZJX1iGVChKQqJjds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6btP5r1bUmBsGWEi/QptZ54nyvExf8hrXJ/Z7KjDwnNk7jFP00l1WhiHCO7KFt85Vng9XqRnTBjKwFJJz83m5q3jv04UdS0NGGB9p0TYeAvdlEhXpPFzZnnqCQTN9kOHSK8fMM09u6t9NpIZwFa/XsxrzpPxO1Hg3o655u6xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9dqABwI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bd80b3aa13so74463195ad.0
        for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837821; x=1780442621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44MaYKgmOZTUoXwiuNfPKV3Ce/ndgF6NAT9m48G8ZAc=;
        b=N9dqABwIZW0Fd53/OFhlb7DhdfbOavRYxRe9dI60/k2DAhxMsar0Gx3uU0eiKgKK82
         eDv9Kh0bNxQWkseZruMp/TvljzvPnbFDBv8n+K7YuJmr2mw7pq5mfaNKHTrEis2OBPdX
         FBcx/e2HildqMmZoHRfdubxedvGJDtxyOw99VJA9/sZrl+YSfAKQwwBpn4wF3SmgG6gj
         tu/noFKr3W5erENv8MZmEFLGp1EMO3/OrZCLuuJc1CeeN1zqIr3cRKoLRr+9/7auKLOZ
         +ka3MEUG3B+7+DcYaxxjYpuMEVslPkoA2RqO6LQx3Ra05RVL2/G3wWGB+jZj+T8NvJLE
         V2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837821; x=1780442621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=44MaYKgmOZTUoXwiuNfPKV3Ce/ndgF6NAT9m48G8ZAc=;
        b=ZIeHi9dHcNZn572VKlhxTw2EYXTOLY4SNphzy0Asa8y678gs6NcXtiIrBbj9itRwng
         y5vJMw5P01nC9p1EJ1Ud7vNp6eLFx/10EA0lP1UYGJ5sVS4/ZfWloOH6zOFle+xNMuh7
         ZSu/NQvbDzuv0f7EzgJwQrxvoe7a64HH6aD4cC0uaIp83DYSay14p0409dETWxDuySVC
         8z/hLYuLkjTZAErlw2Tgh8EYoxyQIa5nn0LE/U0EYFozuhJ65d+m1swZDYJKsi723MT5
         94P57g57kwalJWmv24usCuimMHY+Fdk0NqTTRkT759J4glHZnL8iIOE8+DowfbQ3cEGs
         tIWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IpVMVlcsxXH1/BPcBwx/KuV4BdLGraGllf6nfI++4CkdKB0WfJxAipzgLMPPzw/2bsiVRJumxU9nc4pEGTUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxB3QmckgdKw78urgPe5idggSaSGtqv3rbhxzTDgq4+6wp/8lm
	PkIo9m2RR+rKabPpSZrDCJRrzTCdiW1hsOMLea3g4kolX3HsNhAYDvm5+lXh8FofNWE=
X-Gm-Gg: Acq92OFvEvicQERUafd6/2Oij10AgWzOSCg31BUKoEiJtJIeJjeLHjo8fxt5zujM2eD
	GzhSb8FzYpRRpou64PkNwuGWNUHpw6+I1J6OK0PK7/ukG6IRjiAHh+7yNuFh1upqcbf+Xleqwk5
	lZ4z7vRMlle/+TsCXNsuifMNxX0fSLWv/9dIKRKXCyxi1puSd7QbV4OnEmohEmvGXV4Xn1b4jGM
	wfbbHW4M3Kf0Qc023aLAoF2ioYsNBxJxKN/QHDyGCa9jHCtQ7WrD9VoDkr5h9TJFxG9eNWvEE72
	hIt5D9Tl9nneo70Nmj0dcCVdokRI4b4L5va5Wmy9h9PBbWBzdJomsuRFtTA0k5BjyFWMiPT89Tr
	Y2u7L4XsZ9sGZ57Y/huExLSHFRv2UbisldE93W25jgQOPPhC1saPrYZNhKHpDYA6cNWp9DEwS2h
	PitY182skbqff7Z5aFMWnVMZuE6+j9cofZaquBkk/fRC7umJ0lVahTHjW32EAMcnhmUg==
X-Received: by 2002:a17:902:e5cf:b0:2ba:de0:1eea with SMTP id d9443c01a7336-2beb075a829mr238008075ad.18.1779837821348;
        Tue, 26 May 2026 16:23:41 -0700 (PDT)
Received: from harvey.lan (c-73-83-32-130.hsd1.wa.comcast.net. [73.83.32.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5903bcasm142501045ad.77.2026.05.26.16.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 16:23:40 -0700 (PDT)
From: Jim Broadus <jbroadus@gmail.com>
To: jarkko@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jgg@ziepe.ca,
	Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH v3 2/2] tpm: tpm_tis: Add settle time for some TPMs
Date: Tue, 26 May 2026 16:22:44 -0700
Message-ID: <20260526232245.5409-3-jbroadus@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526232245.5409-1-jbroadus@gmail.com>
References: <20260519154530.6386-1-jbroadus@gmail.com>
 <20260526232245.5409-1-jbroadus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9687-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA1BA5DD83E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some TPMs fail to grant locality when requested immediately after being
relinquished. In this case, the TPM_ACCESS_REQUEST_USE bit of the
TPM_ACCESS register is cleared immediately without setting
TPM_ACCESS_ACTIVE_LOCALITY.

This issue can be seen at boot since tpm_chip_start, called right
after locality is relinquished, will fail. This causes the probe to
fail:

tpm_tis MSFT0101:00: probe with driver tpm_tis failed with error -1

This occurs on some older Dell Latitudes. For the Nuvoton TPM used in
these machines, add a delay after locality is relinquished.

Signed-off-by: Jim Broadus <jbroadus@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 6 ++++++
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index d0b87f5daa3e..e0ee98e93ede 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -171,6 +171,9 @@ static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
 {
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
 
+	if (test_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &priv->flags))
+		tpm_msleep(TPM_TIMEOUT);
+
 	return 0;
 }
 
@@ -1166,6 +1169,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (vendor_id == TPM_VID_IFX)
 		set_bit(TPM_TIS_STATUS_VALID_RETRY, &priv->flags);
 
+	if (vendor_id == TPM_VID_WINBOND && device_id == 0x00FE)
+		set_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &priv->flags);
+
 	if (is_bsw()) {
 		priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
 					ILB_REMAP_SIZE);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index f2c77844062a..aa6d78898ef3 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -90,6 +90,7 @@ enum tpm_tis_flags {
 	TPM_TIS_DEFAULT_CANCELLATION	= 2,
 	TPM_TIS_IRQ_TESTED		= 3,
 	TPM_TIS_STATUS_VALID_RETRY	= 4,
+	TPM_TIS_SETTLE_AFTER_RELINQUISH	= 5,
 };
 
 struct tpm_tis_data {
-- 
2.54.0


