Return-Path: <linux-integrity+bounces-9044-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLZXDFg+wmmZawQAu9opvQ
	(envelope-from <linux-integrity+bounces-9044-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:44 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4609304066
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68CB331726D1
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C413CF68B;
	Tue, 24 Mar 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp4Uoll8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t1UvfYt7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAB3CCFD3
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336709; cv=none; b=ZTGO2nml1IbEyG7mfXQkVkSVQAuRW8aQM31jnetqfARe3GU7tk4k3B/XPinemLFZW4Y1Dk7Cn3D1MCQcwK7nhITvbWYXreBI+aSA4vB+96tNZV2s903COX6LUU/2PSXRlHxAdvt1yvbIACmPsmccaJou74PbQHcY1MNyLYABMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336709; c=relaxed/simple;
	bh=SilugzOMu2AyY0n7FNza7D3+fn1Dwqn99jbo8QgsmZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCDZKiDVC8/o3G05WxpIiTYOzS5uxrDvP8KTrAaeLrwKoer7uR6VhAMzNYG70mEHDkkQcNrFlr5luF5/ReQev9im5oVSajZuvCKNR7bX09AjwXdrRLahhwR9b1S4EC10FrfMsVmRjFCCjJz/1gUxpyt8TWYVIqe8ZlhT2StiirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp4Uoll8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t1UvfYt7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQoVz9hmYf6qqip3bEa+gA/UnhF/MBgQeN1TTtkBG3s=;
	b=Zp4Uoll8mVXi0Ux5jzPTBxmQi2Fhr2ST43YJeSojkDPAwKLy3IEt9m5vtn2rrLxcT2RBe1
	nQ6aWAkPQx3m978Hn0CaRsLl8m6pi17ry4Tj4zYgtwceDIBQmDPn4DEvJoD9DByRQdGb8k
	rQbltRiOUe85kVyY1ro7znUNgrfGXGU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-HokckXubNNWBf0xBy4WadQ-1; Tue, 24 Mar 2026 03:18:18 -0400
X-MC-Unique: HokckXubNNWBf0xBy4WadQ-1
X-Mimecast-MFC-AGG-ID: HokckXubNNWBf0xBy4WadQ_1774336694
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82a11aeee8cso1978569b3a.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774336694; x=1774941494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQoVz9hmYf6qqip3bEa+gA/UnhF/MBgQeN1TTtkBG3s=;
        b=t1UvfYt77/Spz8U/Y8P93z5BQKpZ4nrSQ9H5wEP4D+j5mn57B1eUJ/WLmiG3IoPKKt
         52mJhr/4SgBGe/3JtNabW6guSk0EDDOJAIQk3ULZ295mSrpQ2a6+GuG1N2Ex0b7e7LwY
         Mz03k2ansjge8kf3q5gcKmLSyDIViy8Cfs6X1t+s6t3oJgyN3w/XMJOVqz554sJTiBcE
         A9pTkzrmCvGAJTN/AkFW7JRZTP68MhU3qreBNbTBL04ZblUmYLEG9mgpILMu3YecQu4m
         P8KauZTcMIjmwgH/YDbfUg8uAoGPG9Td9Us9eN/v4N0p2Z6M5SjekWmD5ESvlhYURR2/
         YTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336694; x=1774941494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQoVz9hmYf6qqip3bEa+gA/UnhF/MBgQeN1TTtkBG3s=;
        b=YvKtct+FUqnQ6zq/IkcgIqZZ6sNP6gFIm5iIsf4Ii/sFbuFjRnBlg/+M2lL+xErFte
         vbzIIy7oFZ+Gx4x80dPy8SowP0EkmA7Zsvo5uvU5MhkSKOkBxK9i04sp3sYb3YL15nSS
         KGeE0i/jWjj2QEJRourUKwgDq7WN5EyouFIbBk9ZAfgHv+m/9RX0G6/x2hIu3dwIzJGg
         RvHWYjtwYXYmlHYMoS60U6DEHmm4hkPU03f+sLVc/EkgginPUHrq/7VkSV07m4u5OIy1
         AqeKl/9hovuIqhsmF3ZF48Zsn0zn33RSJxjaBB9H8FBVUioXPU9uscclNiOlq95ClVUH
         JyZQ==
X-Gm-Message-State: AOJu0Yzgwo1pwAoapKerM19HbU+jOI/CyddUXTEDgLddi+5FJQT2/9zU
	NByTP8wAFpaJZitq/DrWRftCeuB53HMUAiWVOlgjGNc7gVVSCJcNLRDtZ9CJ4Vd3rTKcAAbp7Jz
	+AgAL9/KIbhq0qWIxIWaqLOoYRy0CcMSf8Iq5k1i9z9UcChMfB0KjNxYhvlzAfGkmtp2Tew==
X-Gm-Gg: ATEYQzxkSNWz8ajVDTZO1UpVD9Q7Edq/NwEk1SsoQXH82FRBZ1tll55pA43ZoQeu4fX
	+FB3i+Uvz+yTuiEqdviNiiLY3XCKuu/2rj1TVMEhi7dDzX1oDQ7Buh5ixp8q0Ywq7yu9a9MM3DF
	UtBcAYufuhglKFjVsABI4FnJY8CqfDUFxnXoWl66p6BBmMw6IVqZtQ14zl/6yKRnB1lQgbKnQl6
	N2uEBiRgk8noxEo/GQCPGrf8xdiHzsajDdrDEbkZlPje3mNIDPQHb6xd2E4Kroo1Hk3fkVjrmpx
	/thyPYya3DIm0XrV9fg3VYgf5cRO/WNXt7M2wqmbEmBGNtHwuDgLmQQD3fE42aQjuuGGPJPuqer
	m4Y52KiKOFE+b+hAKCBqUTmvmZkqro/gzZDKFwC4GxYXezc8PLfDcsqSJCBGYtA==
X-Received: by 2002:a05:6a00:22cc:b0:82a:6dc5:4e0c with SMTP id d2e1a72fcca58-82a8c280ccemr13121135b3a.27.1774336694061;
        Tue, 24 Mar 2026 00:18:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:22cc:b0:82a:6dc5:4e0c with SMTP id d2e1a72fcca58-82a8c280ccemr13121104b3a.27.1774336693644;
        Tue, 24 Mar 2026 00:18:13 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm13597766b3a.37.2026.03.24.00.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:18:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC 2/4] tpm_crb: Add new wrapper function to invoke start method
Date: Tue, 24 Mar 2026 12:48:01 +0530
Message-ID: <20260324071803.324774-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324071803.324774-1-armenon@redhat.com>
References: <20260324071803.324774-1-armenon@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,gmx.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-9044-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4609304066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- Extract start invocation code into a separate function called
  crb_trigger_tpm. This will be helpful in repeatedly calling the
  start method with different bits set to toggle between start,
  nextChunk or crbRspRetry behaviours.
- Based on the bit set, we signal the TPM to consume
  contents of the command/response buffer.
- No functional change intended.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 67c0061d4cab7..10128d078245c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -445,6 +445,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
+static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int rc;
+	/* The reason for the extra quirk is that the PTT in 4th Gen Core CPUs
+	 * report only ACPI start but in practice seems to require both
+	 * CRB start, hence invoking CRB start method if hid == MSFT0101.
+	 */
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER ||
+	    priv->sm == ACPI_TPM2_MEMORY_MAPPED ||
+	    !strcmp(priv->hid, "MSFT0101"))
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
+	if (priv->sm == ACPI_TPM2_START_METHOD ||
+	    priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD)
+		rc = crb_do_acpi_start(chip);
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
+	}
+	if (priv->sm == ACPI_TPM2_CRB_WITH_ARM_FFA) {
+		iowrite32(start_cmd, &priv->regs_t->ctrl_start);
+		rc = tpm_crb_ffa_start(CRB_FFA_START_TYPE_COMMAND, chip->locality);
+	}
+	return rc;
+}
+
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -470,29 +496,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
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
+	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
 	if (rc)
 		return rc;
 
-- 
2.53.0


