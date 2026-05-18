Return-Path: <linux-integrity+bounces-9595-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGhuHagtC2opEQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9595-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:18:00 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 178BC56FC32
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2690B30117D7
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB7374E5C;
	Mon, 18 May 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMaX0Mbi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1wTpCzR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16737757A
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117473; cv=none; b=aBxdjw4ieDpNk0cHratRyA1rbzNZLztDBVkS+PxohAmjvihH3PKlFaQ9fPJbcA1ZaAfFPyCSoREKzWJnBaxQXWdlEwmrAEXFRlUREjvoLvKHFrBM5bxz87xUPpz2/Qs39JO8amTvf/zzwa68RIree3LOInh6Q3EoggSmeLC8JVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117473; c=relaxed/simple;
	bh=PRKgbwrbL5iMNslBxl3scRrf7sNesK+Vs+rfRBhB4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX17wJNp7UjDIKmGfkLfAE+vtxl38F/9EPrAks98DJccC63M40UngE6qJsFWRZOHWlTSpiiYCUJ9otCoXy7HgZYzGANcplZhfSOYGtKWZAO1q4eaWKR0MGTV4ChkpEAh7UaQ8YVK/HzoV1BItvG/KeSmovH2Qd3u6Mb3RmmQJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMaX0Mbi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1wTpCzR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1xmf5x73w7x9YqKPrcPljDvbvvQKElp2j9AELMu+d4=;
	b=ZMaX0Mbivziy8JDEPkDNug84ioe8Vwds+J2ErsUQQ1dYohYcRt8akJOjiXnpk8v6FTwR8J
	1fpVY+y8nm8llo/09EHovJoGlz7M5Ey9HlglEwskv1dViO8aYSoac/tpKI3iU3DxdhXEC0
	fK18KniEgnG8rkQxsVXLBo4pRRr0/Is=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-GzwBwBUePnqyo3hs2sb2sw-1; Mon, 18 May 2026 11:17:48 -0400
X-MC-Unique: GzwBwBUePnqyo3hs2sb2sw-1
X-Mimecast-MFC-AGG-ID: GzwBwBUePnqyo3hs2sb2sw_1779117467
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c827bda3052so3715509a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117467; x=1779722267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1xmf5x73w7x9YqKPrcPljDvbvvQKElp2j9AELMu+d4=;
        b=d1wTpCzRtfNOBj7XfRANCzMr78RNQDzBHreLV7JCoORJCUf2GUral2hvQtgxC/ZoOE
         2QJMpf9I6DzVRrUPHF1t66KULBCnsndgre7+/mpl9J0ijYuRO1vOABK6GQldAxEizMJR
         xIeCTTPJhpcW3wltbrBnMfu8VPKzluCWeB3iHnz3se1yd6yXxTuXwaKPKjX4OfoU+/jd
         P0vrRZhGranGQJA2sCbmqMxqfVIdEKK2Vqb84bp56qbDgvaaY4o/4soij6oMzDYQM2h6
         CPKkJpL/HLuDc9UFgOrzrA2ZMIBlyWeNb8FlDBd6QrYUVlwRIPu+9pz5Po+C61sisASe
         PBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117467; x=1779722267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1xmf5x73w7x9YqKPrcPljDvbvvQKElp2j9AELMu+d4=;
        b=g8LsG9TKwAcKzz8P5Lcw6kqzH90/Ay3zfQgT/V3IbJoKVuUqwPYXnuXOY1naUtt01i
         AwgT/6DJq7klXjQlc+YdOYdTJ2pR3v+UMhtwqwEsC59j8UhRVgB545JbXyYjp3WANALs
         QFfBL0bWuyTyzQfYLezhTFkCGWZxSr6yZoeYNE9CnMXIY2V5mud4DFxSp8T69XF82SOr
         gZQ+QkaclvwVG9vJ/D2lYodXmee7bN43LrKgk3FXbs00TiIKHTwBrJuEPmsyPjJEfCv4
         VsyjsBwDEIIlukwrL3peKznh/YJoVXsszLVByPnNqXiiyCFkEydRbieyFRoQ3HJfjktz
         H6Xw==
X-Forwarded-Encrypted: i=1; AFNElJ9f42Z3XtBzcFg5F48AkHrATJdFs2HA2vpgVCfqq6YP3Ak8TBv3iThTuJsmeWVnacCDe0WOgdF62X29uXBhiUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiYhRVeNHe7L0OLu78qTsL/7kjaqa1qsbeSvTO7J4SjmddErf
	LWHojNXG04DfEUO24HFP+23rGAGwYOoE2BWon658Cm0FlRKI89dxU2ZR/fh0L74K9HajYidWDP5
	sDVcWhf5Wd+xUEWfULIee1Ce+u9LonMDcXcOgNgbbuLUHu9g0fxg8PDCfxvhg22YMx+fC6A==
X-Gm-Gg: Acq92OFutm1BpdEgCjBwmrR3lVDIOeAjmBVkhiwmu7Vtm8I9/o/zj/iTp31FwtF2JQB
	937v0/3tpYoM1/SG6vOfDnykD92KtWWDhTNUTjoMZbiRR7cYk25H/Tx5866HhbxVj98x7Hl+0G7
	aqCeze4U7hu06Q7kKIlv6D8CiMUL+nnfWT/x4Evi3bH8v1N7S3WKfzlzWMYYiA0p/0V9dw6UKuF
	M6XSt5d+SKiT6jmey6Uo4c/c+HHENsB1oHKYMEucGtIadlGxCggiNUBRRygTGueoLOB8Vy/ASLx
	hgHfV4gyWr6G2O3U6VmpF7Z0a/rxtZVlYMa2jsyBDu15PVbV/Eh9WD4sCxSZxhzKDmmbLAJAj2j
	AHI8oFHgZnLxUZUWix4FDs8/B1wm1uQ1Owodo9+cXjcNaNcZ2l+y7tbxxZ2jZeDQ=
X-Received: by 2002:a05:6a00:1743:b0:82f:3828:a009 with SMTP id d2e1a72fcca58-83f33aebda2mr16553738b3a.3.1779117467300;
        Mon, 18 May 2026 08:17:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:1743:b0:82f:3828:a009 with SMTP id d2e1a72fcca58-83f33aebda2mr16553698b3a.3.1779117466798;
        Mon, 18 May 2026 08:17:46 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:46 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 4/6] tpm: tis_i2c: Use local 4KB buffer to limit memory usage
Date: Mon, 18 May 2026 20:47:22 +0530
Message-ID: <20260518151724.730443-5-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518151724.730443-1-armenon@redhat.com>
References: <20260518151724.730443-1-armenon@redhat.com>
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
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9595-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 178BC56FC32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arun Menon <armenon@redhat.com>

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
index 6cd07dd34507..db19d459ea1e 100644
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
2.54.0


