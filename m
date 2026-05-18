Return-Path: <linux-integrity+bounces-9594-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJWmMjYuC2plEQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9594-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:20:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011D56FCDD
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C9B305774E
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16924377ED7;
	Mon, 18 May 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmLNdiUQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n3sslKY8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12131B80D
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117468; cv=none; b=K7K0v7RGgWYb8cUycYnl9Q+SskgB07zcx6BICLHeJVth4f0WMcL+Jvx1jv/N/aeVj77PSqNCzU1JqrCg7WWOK/5mAGqsdPG0fOFMitAFv1KCT5vDbbyfCPTXUzBRSICdGpRNw7Ix6w0GUIEYakCXYB391SHbBUQD8wckw0caTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117468; c=relaxed/simple;
	bh=ExFMwvKcte30iE/5xeAT+yE2G/l/cIlYbv6MzIObXps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD5Q3hV8OwZVg6cDDg1ppx1h3J1r6OB9w86mdc7HzzfLIqnpbgXmm8phNXni3E56ZRiFL/GQK10V/gF2nugXKepQcBJ61TQiERy4WiF+mC50yMVH6MX90WGUpv7oFRMVW6zvJzfqUi1HO5IEzzIoH/6kqn1zifUxPafI6m9YGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmLNdiUQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n3sslKY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChwJFmg7CxWjli9jGFgnSfwP9Dprp7rtfDPtVsAymzA=;
	b=WmLNdiUQiuPl8AxfJC3CiaN9xfzWvb27lPs1/b5x0GXrN+/6REd7Vd1Pqq+cnnhIkzlA5F
	HU0/gqdhbb1Bl+8uY2J4JSeo8z21kndalv/eEJI2CZz0xFc2otODWmAadzk/4YskY+vUpJ
	oMpwKVfK0ptkEHsL6/nF4h4dFpHQSIE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-2Bo_PTUdMVekTkjz76O0Cw-1; Mon, 18 May 2026 11:17:45 -0400
X-MC-Unique: 2Bo_PTUdMVekTkjz76O0Cw-1
X-Mimecast-MFC-AGG-ID: 2Bo_PTUdMVekTkjz76O0Cw_1779117464
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-83f7e7f7457so762350b3a.1
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117464; x=1779722264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChwJFmg7CxWjli9jGFgnSfwP9Dprp7rtfDPtVsAymzA=;
        b=n3sslKY82wj2LoCyfoL90aSj4VDRZrV2yEPsD0/26pYR/K6+5FtJ9RhikAJHOUl6G6
         xpup1+gssNLo7MnD0PzRcbf5YTYZpJPMWtw45MnUy49Q1mRa2m9jaBDo+ECNcowIqbFF
         KPRHg5xGnzN+GeNUec7/+/IR1PCMOUSXbZ3x69TmGQu4lrTSknPOAjmq+VF+YWKBOkI4
         4tnFy8HH5a4ELJPxcUYeT50snDSViRZYyxVAopGzRbfdrNrszbscoIEKFALJH8jdImZl
         vyDefJMQ5xgPrE33ncqUYxB00l0LnFqszZ3rJFtglQAJk0iXE+YiKBGlLD2pnhv9/Pz7
         YebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117464; x=1779722264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ChwJFmg7CxWjli9jGFgnSfwP9Dprp7rtfDPtVsAymzA=;
        b=Dl6iBKbWrpGn/m7JrWZCk23QwO3F1sk/H9rGVALvOm37zahZm1e8w6TiIOaYtbqTm6
         4UCIaIN9P7qqxmDWhUgbiXqMFlEqSkdAxF0n7JGdN32CRQaoVsX79FDDrPCzJm1sGXtC
         CBUt2jc7EBgaZ3VaJdgdWNO2TWpBJbqkuONMul2JPFKEsB7pC9ouhVAYjlnGVdDcJcXa
         erHj0zmeOMkJEdBCOOyieoM4s5LDN8o/xXdWDrflBeVZTLqtWEQdoz7mUX8mgXv3BfeP
         fSvdAfq2OrY6UksPMLSgOcOVb2XsLwaGWSAC9JtWUMSgVpRzI3kTFH5iPzt2pIMVtYnO
         3S5A==
X-Forwarded-Encrypted: i=1; AFNElJ82TRCBkBEUGdSj2PIJyuFi5gLHgWdDLoSS+7xUazWqi/RdwXiUaPBAARexEjo85JocSa45dQrlHVcm3ggLETo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezA8V49/ZD31FaJV3+5tTQVgCP1E7SDiDuSob1HlACLtWsJ1Z
	yfCOTAoHjCTG8OYht5z38fXK+R8nyas+F3M92pcf66aLLLvTAP3N6BMq6Qp93uWS6m7hZ33uOQq
	D5T9/0tkCRfJVckUt1FRnlEBMOZIq9nkSoRv0igREtEWdw/2PrPhrsur3enb28qPl+hCPUA==
X-Gm-Gg: Acq92OEJ64g6Cv12+Ui82GxcG3elHouShI9+anZ5lO9a2kPmPE2uCqDaeqJZLElDl5f
	qjZYUS+H73eltHqYhh3OuiXSVjjQBM6SwMxc3v6pxB+FRE4sZpNouAoo/uKv7ejxA1wW7K1MdPf
	ltKGNP7bIZJ7IIKvje0GOhhsFIaNBitm/yfb6iV5ZIkVNg0vtfN5EboSPfaJyV2asvKXaYcvd1Z
	JZYZx9AShshX65bf8fvXIBnVwCjJ4In6L0mhfcKrsS2qYpD8z7m/lxuMSM5p0/mejfGi1fVQrHC
	hQUw9qY/O+QONWsmrEtmjFGjycak2UYntZ1Jrf2UxrWggIbkW4BOdSSDsG9oB4Ppplm7aUhkF+v
	ty4+1ucHqQ0n4KxlWhSQ/Bmau8sPyYf/8Pz7Gc+UPDe0d0o0jMSo75/UJfSD1KsM=
X-Received: by 2002:a05:6a00:2d81:b0:82f:49b5:cfc3 with SMTP id d2e1a72fcca58-83f33c9080fmr12002532b3a.18.1779117464053;
        Mon, 18 May 2026 08:17:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d81:b0:82f:49b5:cfc3 with SMTP id d2e1a72fcca58-83f33c9080fmr12002498b3a.18.1779117463426;
        Mon, 18 May 2026 08:17:43 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 3/6] tpm_crb: Add start_cmd parameter to tpm_crb_start wrapper
Date: Mon, 18 May 2026 20:47:21 +0530
Message-ID: <20260518151724.730443-4-armenon@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9594-lists,linux-integrity=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3011D56FCDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arun Menon <armenon@redhat.com>

The current implementation of tpm_crb_start() is limited to triggering
the CRB_START_INVOKE bit. To support command and response chunking, the
driver must be able to send other control bits, like
CRB_START_NEXT_CHUNK, using the same platform-specific paths.

This commit adds the start_cmd parameter to tpm_crb_start() so the
caller can specify which command to send.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 9a2f512b4ae3..31f530744e90 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -446,7 +446,7 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
-static int tpm_crb_start(struct tpm_chip *chip)
+static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
 	int rc = 0;
@@ -457,16 +457,16 @@ static int tpm_crb_start(struct tpm_chip *chip)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
 	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
 	    !strcmp(priv->hid, "MSFT0101"))
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 	if (priv->sm == ACPI_TPM2_START_METHOD ||
 	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
 		rc = crb_do_acpi_start(chip);
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
 	}
 	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
 		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
 	}
 	return rc;
@@ -497,7 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	/* Make sure that cmd is populated before issuing start. */
 	wmb();
 
-	rc = tpm_crb_start(chip);
+	rc = tpm_crb_start(chip, CRB_START_INVOKE);
 	if (rc)
 		return rc;
 
-- 
2.54.0


