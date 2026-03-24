Return-Path: <linux-integrity+bounces-9065-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF9hEeTUwmllmgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9065-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:16:04 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738031A967
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 642F230ED28D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A23988E6;
	Tue, 24 Mar 2026 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7J6J2GD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChRQdfky"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E67394476
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375987; cv=none; b=Uh40euTICOPpJ2/oHtVpcKzqVh67AqJoieqWvucfX07YTQQ/Id6+htplSFaKF+vSqf7kQSET2ZXjtw6tMhl5sFkLwgHZBlo8tPx+eEzGfawuhU69YTFRjZThTZo4WxGt9DpOPMSJhEqwp6MKYJ96rN2fI5juwH2GluaNVum1WWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375987; c=relaxed/simple;
	bh=NVqoURi6GkLCUA6hulCm/FUPyOAGzXe36crCDX+t3B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7iJSXdDHTptbs9FcxwVC5Ieix2OrBIIDnb+x7Sg75wi92vTEQsvzyjD5lr9Rv/1TMuie+F1y02RqJYzLkrn5RfYm+xy/plJ40R0duby8WVLi1xaagu+Xp/wlecZaP52aoCril9CCHKXEdq99PmfOx7L/onZHBTESJqKkA+5PiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7J6J2GD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChRQdfky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774375985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjOFiAc+loOVh0FFRv70s4LnEAsNKmBF0aaLgN5vhcY=;
	b=I7J6J2GDRc7PnxfiqV5SdG5/z+fKoLAC72Bi+qeZKfT+ig0Zsix11+Wcehy4kfcXxH330P
	VWKRP+6t/B/46bkTCXBvfuPe8Dm3+SMcJX4Jq5B4HZH5jtmy6W9Fyipr4VWwCn/1XFrLjp
	DUtBytA063syAc4jihCsAFHQcL8pVhc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-RFiuzPryPkuwi8TNwaXBag-1; Tue, 24 Mar 2026 14:13:04 -0400
X-MC-Unique: RFiuzPryPkuwi8TNwaXBag-1
X-Mimecast-MFC-AGG-ID: RFiuzPryPkuwi8TNwaXBag_1774375983
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c73c065dd15so3883239a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774375983; x=1774980783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjOFiAc+loOVh0FFRv70s4LnEAsNKmBF0aaLgN5vhcY=;
        b=ChRQdfkybmRvpdr0WrG4YksrkfpVxC1tSrRxecVzOzSL/zqjaHpqUm684ORDdeDGak
         OCGYSbMA8jTYH7Ud831Y1zADs7BulHlX/d031r5oKtDMBz/AGNwgxj3yHN/diqxFN3hX
         1DX2fak124+MSpdvJTsZKy2H7za+qD/mZNY0WOltmtLqNfC1KntqSWJlzp7YGIM75yBr
         ZlDNYWybhAyIVoK2crDDE0Zz7Rid2l1Se/wT5/va8Nw0P6O6rnnqof5k9at33qseMuwR
         31/BydTN6ythUwjGFSGCul6aIRGaVbqS1PWJZjBTjFgNHltQV455pZrS4h/YpyJikAuP
         hSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375983; x=1774980783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjOFiAc+loOVh0FFRv70s4LnEAsNKmBF0aaLgN5vhcY=;
        b=m1nAifID1gULEVHAl4zoUVjy3REgft2cZ8rUpmc1jt+/FnuMXDWEcqG9uyjxfETFH7
         Gj3fRJA3TcDzKuXsdV4+zdQDwkLe5iR/rzFmtD0BX6k/9Cj0hjaBYvkDYzybleKXG9CE
         MB2PAB5qhIia2cnmh8zEbKEYviqSLK+IJx+wnsS/JCugKBiL8y59zBo68YxYjcvVVmco
         oA9cwm36HoQtumVlRJbaOnPW0De4SyLcN1QAmaQnIBwd63rY4qybF5I+XiJo59aW52mC
         UUgsWYzhbZNxjv6w5vnP885LIBG3cArp/EUeGy7eM99UTx2DX4K1RD6tFY57WSNpPEu0
         59IA==
X-Forwarded-Encrypted: i=1; AJvYcCXEzeCZcFEGm1nhEyHH/12tZSI7aWq19OA14+okbSABJ6uwqVyX0tHOC0/8gOfPk0pZQNr5ETx1ePR21wymWLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfFgUKn2Qhf8pywNpCSYb28E1m8ZNKZq18Q1hZ40U71XMZeCMx
	+tfh/TUlFKVWnp/KNLcwA47Dyl4CMj0zLLknMAmbeZQzLFBLOQK9K6wmGx1KhzuigTRjim3KJKC
	eg/52XK8mH33C4H94pgWHQNrUpDeCol92Fzd7oWj3YBt4zGTGzGsAP1xULcY5TzjGzxY4Dg==
X-Gm-Gg: ATEYQzzUvoWQSD+AS0aR4GTUmj6Cp5CGEkjOS2tCVwUN3WX2QQMPCYn13TwBEPDARlZ
	9hSN79f8zchUHCnJB7cokuQusw2RLeqCstbuTgnF9WCcyrhauLoxVhhbx2lUk/imEILB318WaVo
	g4TvjHFjVhqwc5BZiqjXugnc7VjURXhEQ0itEO+ph4Hla+I1fguIVyx7QowEkyNuRU5Halty4Ei
	JF1H5ctWVpKI63OXs/Rmb6YhZL4Thg0OdhU+KuzWOea8uawXojsTBmutmSFMgV2KDm3744/ZrrJ
	Xh49K13aeT6qGJwuDljkcyNCepphKDLrbQPcoJL6SGcyezQxAHuRERnSkYUdJlU1RPW1CSrWYEN
	p/r7UNcJLjwhj5+G4dwBwIt3Yi+icrnaXcmNSXZz6+nd6MnVxKmN7VBdO3UFvyQ==
X-Received: by 2002:a05:6a00:27a7:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-82c6de7adbfmr532181b3a.11.1774375982923;
        Tue, 24 Mar 2026 11:13:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a7:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-82c6de7adbfmr532160b3a.11.1774375982417;
        Tue, 24 Mar 2026 11:13:02 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm16654229b3a.57.2026.03.24.11.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:13:01 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC v2 5/5] tpm: tis_i2c: Use local 4KB buffer to limit memory usage
Date: Tue, 24 Mar 2026 23:42:44 +0530
Message-ID: <20260324181244.17741-6-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324181244.17741-1-armenon@redhat.com>
References: <20260324181244.17741-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.de,ziepe.ca,redhat.com];
	TAGGED_FROM(0.00)[bounces-9065-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 9738031A967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The global increase of TPM_BUFSIZE to 8KB is necessary to support
Post-Quantum Cryptography (PQC) payloads. However, applying this increase
to the tpm_tis_i2c driver is unnecessary and wasteful due to physical
transport limitations as pointed out in [1]

This commit introduces a local buffer limit that is used in the i2c
driver.

[1] https://sashiko.dev/#/patchset/20260324071803.324774-1-armenon%40redhat.com?patch=8319

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 6cd07dd34507e..db19d459ea1e1 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -54,6 +54,8 @@
 #define TPM_INTF_CAPABILITY_ZERO 0x0FFFF000
 #define TPM_I2C_INTERFACE_CAPABILITY_ZERO 0x80000000
 
+#define TPM_I2C_BUFSIZE 4096
+
 struct tpm_tis_i2c_phy {
 	struct tpm_tis_data priv;
 	struct i2c_client *i2c_client;
@@ -232,7 +234,7 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	int ret;
 	u16 wrote = 0;
 
-	if (len > TPM_BUFSIZE - 1)
+	if (len > TPM_I2C_BUFSIZE - 1)
 		return -EIO;
 
 	phy->io_buf[0] = reg;
@@ -339,7 +341,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev)
 	if (!phy)
 		return -ENOMEM;
 
-	phy->io_buf = devm_kzalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
+	phy->io_buf = devm_kzalloc(&dev->dev, TPM_I2C_BUFSIZE, GFP_KERNEL);
 	if (!phy->io_buf)
 		return -ENOMEM;
 
-- 
2.53.0


