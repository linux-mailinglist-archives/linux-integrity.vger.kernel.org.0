Return-Path: <linux-integrity+bounces-9598-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HhmC44xC2oZEgUAu9opvQ
	(envelope-from <linux-integrity+bounces-9598-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:34:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB465700FA
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F86B300EC7E
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6980265623;
	Mon, 18 May 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+U2ncEl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RH4e6OlV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41462378821
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117943; cv=none; b=KIm+UtN0TL/+KPI/xL9+i+k3aOeWwYREvdzcEo5Sd0pK9H5DVwKBDsFU3gLGBaYBLEF/lYZ87i4PfAt9NGCjZ0a7p2kmcczCe2u2/EFKDte2jpmW02pHKzegVrSYfr+oo2Os4qvotjS8OfmqXFtm0NSNzzsOGc6V70oo/tULuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117943; c=relaxed/simple;
	bh=VxX+WokTYMcXgCaqGRDIyCcANcY+2xvqODyU/qFVdVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZIiN3D6Cbu+EUUWinyTxXIT9qa1AJYpYZWRzzP2Tfo2a3jBRwJTQEAnRTFeMMDmUJX2bRabfzc06rFlMXz7b8DphCgJQ4VVW7TG7r+Of9VBQbehKQfwAvVE2Z7QBhi0Vc0gm4WWJyel8r+/fouEdIDjdR3GbBQXidFHfO1Gd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+U2ncEl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RH4e6OlV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnPbGV+ZY+zNpAkrnk2fLEpoynLtxIvL3bKUiWP9NRA=;
	b=a+U2ncEla2J3lVanQq8oZwrVgbeiYo3YwITeNhGrgucAabCP11ZsaFBDhwkdPJOxvqjNeS
	JPys8yQdufDOplssE5gJZpM2ptWUa+wXEGBToWeEjOuR1Jl+EUv1S9I7t2vSrQig4fUHPz
	KAvVZC5A7kHhU9Z/6arK7fcpu4QitDA=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-PmjBfgyjPJWh8Muhu4VQtw-1; Mon, 18 May 2026 11:25:39 -0400
X-MC-Unique: PmjBfgyjPJWh8Muhu4VQtw-1
X-Mimecast-MFC-AGG-ID: PmjBfgyjPJWh8Muhu4VQtw_1779117939
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1353bfdbf99so15829933c88.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117938; x=1779722738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnPbGV+ZY+zNpAkrnk2fLEpoynLtxIvL3bKUiWP9NRA=;
        b=RH4e6OlVYhraC8zDuQgTvgP/OepZuHmR1pfpSqDNorviqsR6ABPjVYiaCvrKOH1uvq
         VsYOeUe7p85ZBmUSUNDMNRw5WMUIiP4IGjAjv+zD9rRacGwYgWHTaua8kZyLPO7FKmAu
         LTB4r5VkispiLLIY9mbSbapKXrV7XrYUyRDgl0EIE/mjkRYzWSwm3m145kWl/a3vm/Jd
         cnh1PNFWxrB63Q0F1NNq1+J0FktlbdQCL7X/qeJu23KCN/CENxyQK2ugQIpeMsJI3Uh7
         CT58p/mADc/8c/aKdaLig0sRHBOlUv9px+KdBKvMVp2+WZuaVsw0Cwspcgi8lASbvt5l
         yu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117938; x=1779722738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BnPbGV+ZY+zNpAkrnk2fLEpoynLtxIvL3bKUiWP9NRA=;
        b=N5cyeORgmV6QPomRKci7iZ1SDPWQcXExQiSsPPWz+uRXo3cn3qLV+f7nMIlZeyFYtJ
         ua6k2Wb+xmJFCSpT8Zve3IWyi8swmDCh7DKjYOLvsnYJ+lOlQXWbi2AFcgEmHEGOGXIm
         TwEpwSZu5JtKrTBd9CeBsplGzzoRCXW+Tbe4E+tPjpNyreR++u0snNybZrb52QX0IeLz
         Bphozzkg1at0ACLEBGng/w71BhglfXj0+F7mNX9QE2hjx3BN0ggvtA6qiOzok9uvPAMS
         qCZK4NGEPD9Ck+9HcqlmhkpQkbi7TAvm4iNwAxDETShSMd95OTvIIOsde+iAHvPu1pTo
         PzCQ==
X-Forwarded-Encrypted: i=1; AFNElJ82Yp2WZ441RoHgRVkGW1V2P5eKn3svMiT5AmwJoMLJ2wGn3FVTN7TuzLI5A9ewW17XoNNZmKnNoDASNoIwUdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bX8n5rdFzw0CmZ+0mvX5w7Ocrdqga9cK74hNj8CfseWHoDcu
	HsdKaAO5nDVI06Azm3cruDLseGfOWWiYqojATjI1Trt9oZzQgx4JVVyBGYANzHkojdcz5iz8wNE
	gH1QLfvQq8DsVzoKfP3eos7QR9URWx2vG7FXCRjbHl9RKqHjX98+siE/TjPmxzvwbc2dPJuAb/i
	xIzw==
X-Gm-Gg: Acq92OHEuo4w7lHrG0QyLmnMVJVxVzNXrQ9u2taTLhgXh8W87VoVNBQXsejp3jTRl5l
	Q6C+F2rOU2TfsbSjSBlpF5FFnEWdTm9RPUH1gTcodGJohSAiO0YsDtwCcsmnTk9AwLbb+eiQ1pL
	Ue68peyMf07TosmdVfafHFw0D2FRtssOb7sGNhWJZCnATbzLGIVIn3FMK9zCQwKNoF4KAduOli8
	PO04GHxEmOWSpYANsYcJ1NJp0aXJlAoOjxikDgUB04Ztq0dGs7tZcPq4MNAaXJ06sGG6/var4Px
	o68iYB2Q0V4iytwZKiphDEXrr0Tj2Ra88/2+xlfk2cxGnUmSvQrGle4+QHkVwyCgJRdBj1lmOkR
	qZmYyfKK+/YGthwRusfh2dsLKUTNUPbpw8PkwofDEGAIZ8IsaaaEj6y4/HR5XFe4=
X-Received: by 2002:a05:7300:a984:b0:2c5:b23e:48a9 with SMTP id 5a478bee46e88-303986a160emr5998467eec.25.1779117938257;
        Mon, 18 May 2026 08:25:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:950f:b0:838:c01a:7a50 with SMTP id d2e1a72fcca58-83f33d8c1ddmr14067498b3a.30.1779117459638;
        Mon, 18 May 2026 08:17:39 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:39 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 2/6] tpm_crb: Split start method into a separate header
Date: Mon, 18 May 2026 20:47:20 +0530
Message-ID: <20260518151724.730443-3-armenon@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9598-lists,linux-integrity=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6AB465700FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arun Menon <armenon@redhat.com>

The current implementation handles different platform start methods
(ACPI, ARM SMC, and ARM FFA) directly within crb_send().
Move this logic into a new helper function, tpm_crb_start(). This is a
pure refactor with no functional changes intended.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index d76f9e30f036..9a2f512b4ae3 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -446,6 +446,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
+static int tpm_crb_start(struct tpm_chip *chip)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int rc = 0;
+	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
+	 * report only ACPI start but in practice seems to require both
+	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
+	 */
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
+	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
+	    !strcmp(priv->hid, "MSFT0101"))
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+	if (priv->sm == ACPI_TPM2_START_METHOD ||
+	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
+		rc = crb_do_acpi_start(chip);
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
+	}
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
+	}
+	return rc;
+}
+
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -471,29 +497,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	/* Make sure that cmd is populated before issuing start. */
 	wmb();
 
-	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
-	 * report only ACPI start but in practice seems to require both
-	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
-	 */
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
-	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
-	    !strcmp(priv->hid, "MSFT0101"))
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-
-	if (priv->sm == ACPI_TPM2_START_METHOD ||
-	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
-		rc = crb_do_acpi_start(chip);
-
-	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
-	}
-
-	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
-		iowrite32(CRB_START_INVOKE, &priv->regs_t->ctrl_start);
-		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
-	}
-
+	rc = tpm_crb_start(chip);
 	if (rc)
 		return rc;
 
-- 
2.54.0


