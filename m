Return-Path: <linux-integrity+bounces-9063-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KFXLozUwmllmgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9063-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:14:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98B31A947
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B72130A6908
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D3D38946B;
	Tue, 24 Mar 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiesThDs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf7s45Cz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99729BDB1
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375983; cv=none; b=Zm5VbkW6g1UAcRRP5eKxBPagSE7h2lDFpY0j6entPMqFEvZqDqC8jSEB+ADtGxeYdVHprs6ZFz5+ukhZDlfkUZq3TlrVqaFajWrgtMdNnZeraj2sdwidiQFBehDXIZlL82MuAJbS1kWNQ3q4euGPiTzfFJQiBsIFM76BspsVPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375983; c=relaxed/simple;
	bh=orXh+Es5W797mVKPf+s7K9KOo+YnHs2Q86rzO0qqpVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu2sVxx8FyviJHJx4V6xKQSEnmj6cyJP5ZE+YzZbAaCKLbSMo325w3DLte6YS9kXAB1PH/ti2NFDp9pieM1rxvMZcpyoJO7UyxjpqAl2tlfSKta0pL8kGDNVRswj2atuiMz4GwOXQXlTHw0OK4+rgd2Nil5Y/qNDTvb4eH1iAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiesThDs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf7s45Cz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774375980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxd0G1I4kWf+JoknGoSmowxDRTwU4glRvJ0760l4ojQ=;
	b=WiesThDs+ekKUp0x5xuwjXIw9CCkOmqsjynfeO1bvx/gNG6j3qJ+2lCW0nZVUXWPsC0A1b
	AHTr860KCQk/EAxSwcIL1q5k5ZjOmwUNGOZa+XF1F0hOnqPwi56a9Y37yV4cZaZdPt9yaw
	PpsbBFiNfDNx1eOTYjZc7t32VveJlis=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-rVZTb0EvNeeXkkCyKSsjPg-1; Tue, 24 Mar 2026 14:12:58 -0400
X-MC-Unique: rVZTb0EvNeeXkkCyKSsjPg-1
X-Mimecast-MFC-AGG-ID: rVZTb0EvNeeXkkCyKSsjPg_1774375978
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7423ba5342so5315284a12.0
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774375978; x=1774980778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxd0G1I4kWf+JoknGoSmowxDRTwU4glRvJ0760l4ojQ=;
        b=Nf7s45Cz/dxOgZ5TRLMzdayaJU2mwpgvN7Qb3kauNEHW6A3szDvKRyxLONY85ZqOAh
         87FzJ2TUYZ53l9z76KpvHCCFPULHC28KOCWhDE5m/Lg/4VAfNa29gTOocxWBvjDZ+4m+
         b9o17SPMSCiCXzaY/lJl0yl1LTeNi0Tbcb5fTlZ/NV0EDSfwKy+0LLt/F8btjqe414sT
         o/hLK9op76TMPXROmMRWW3BTY008ByqtblmlnxV10bfvBem5bkpA0rCky3eCGX931XeM
         H1u8PCf4Kx337L8jp4gMU255Ry74XA8KNzHOo5RyRCnHE8y6mglWCQeFjwFs81uLpCTD
         XkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375978; x=1774980778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxd0G1I4kWf+JoknGoSmowxDRTwU4glRvJ0760l4ojQ=;
        b=P64GkfwwbsiZmGJKfEqtYfPrfaOC3/cgF2SMTTxHucETowKS13HAmwqg9BiRMmHXHL
         Pqn11sIcAW0eQ0xAF6KV35u9xNCBgSHgU/pfTIMSktavL1n7kNAvEqOQQmNgSOWUSqZO
         js80VQrROxQJ+Yp/42x3Uyrl0/IVIghaJ5dnL/RjG14W3hFfoUmuZRn+6nipJsW1KPe0
         +UDY3Dn9HGqkxslMx/3/wNBdAvCbpDlM+3ZEeFr5RMhD+zHLtM3fMAA6lEEiG/qUA1d9
         9XXj0O8iqPM38WdoMkLAZF5DoCTsSU3pjlkMqo3zj11dbVKiqGPpZkfkmxkPwUw92Mjm
         WEEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQB07SYjA+tUbDmnl63yrkyrvVK9cY7Cqy0D7VZv/osHxXCAHPgHrBiMEM/7Guxl3xHK78hBXiBaB/ZQOjm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EMOAb2cwXYRZQOTQIDL9oCc7hh4bUssZUSBL19rPOzPkwI2H
	s9DbTOjcGdk7jt6Gxb9mpdeetkPIIf/qDpzbKH0QwSIkEWyJ+U02IjnP9nCljh16C18C1//mK3F
	9m3+KGBdZhEpLZ88/vh62yZ52FnScvZ3keJzB+XzvsEw1ukDzyRdBQS+en8ddP4WLzNEFAQ==
X-Gm-Gg: ATEYQzxwNe4dQOF6mglmrLdULT15iqwnrHZ2Pyz16nT3/YbkyGATJIsV/CnCQtPSYq4
	Z5Ih2V8iFjbpJncqa8WB34Eqh3Fj2pWytuejufcx7nAZqReWN2n0MIzIhK/LpG98bsteFAEcmei
	q6NeGNXaaceFsTL/qLYjBrOS40xVM8/tLeSZcZf8XaaSuX9H8ekrkSP1DSTcWFj3h3tJMzikLs9
	sI7oZij4+pGStAz72wwq6kev29M+yRkvPdMuq3uw0iaK7nXcvKvTzJ6tKmN1uF/3yXIXjZaxW4W
	J1FvylZxGKCAXXskBwlpVeJf23yN6T47PIkUraWvYeRUoPafGSy2Ph3gC5NYApmeqSBOx9wmYAp
	PsgC6kLFfXAsWoy58SRhxj2Rk5rK5Tlh2r163GG+Ax8B9fc/W/Iis7EvvhvzknQ==
X-Received: by 2002:a05:6a20:158a:b0:38b:eadd:449a with SMTP id adf61e73a8af0-39c4ad52483mr738114637.38.1774375977801;
        Tue, 24 Mar 2026 11:12:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:158a:b0:38b:eadd:449a with SMTP id adf61e73a8af0-39c4ad52483mr738086637.38.1774375977199;
        Tue, 24 Mar 2026 11:12:57 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm16654229b3a.57.2026.03.24.11.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:12:56 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC v2 3/5] tpm_crb: Implement command and response chunking logic
Date: Tue, 24 Mar 2026 23:42:42 +0530
Message-ID: <20260324181244.17741-4-armenon@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmx.de,ziepe.ca,redhat.com];
	TAGGED_FROM(0.00)[bounces-9063-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A98B31A947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the introduction of support for Post Quantum Cryptography
algorithms in TPM, the commands and responses will grow in size.
Some TPMs have a physical hardware memory window (MMIO) that is
smaller than the commands we need to send. Therefore this commit
implements the core logic of sending/receiving data in chunks.

Instead of sending the whole command at once, the driver now sends it in
small chunks. After each chunk, it signals the TPM using a nextChunk
signal, and waits for the TPM to consume the data. Once the final piece
is delivered, the driver signals the TPM to begin execution by toggling
the start invoke bit. We use the same logic in reverse to read large
responses from the TPM.

This allows the driver to handle large payloads even when the hardware
interface has limited memory. This kernel-side support corresponds to
the backend implementation in QEMU [1]. QEMU reassembles the chunks
before passing them to the TPM emulator.

[1] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 155 +++++++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 41 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 922bcf7a69ad5..a97fc5e9927e3 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -104,11 +104,13 @@ struct crb_priv {
 	u8 __iomem *cmd;
 	u8 __iomem *rsp;
 	u32 cmd_size;
+	u32 rsp_size;
 	u32 smc_func_id;
 	u32 __iomem *pluton_start_addr;
 	u32 __iomem *pluton_reply_addr;
 	u8 ffa_flags;
 	u8 ffa_attributes;
+	bool chunking_supported;
 };
 
 struct tpm2_crb_smc {
@@ -368,38 +370,6 @@ static u8 crb_status(struct tpm_chip *chip)
 	return sts;
 }
 
-static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-{
-	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
-	unsigned int expected;
-
-	/* A sanity check that the upper layer wants to get at least the header
-	 * as that is the minimum size for any TPM response.
-	 */
-	if (count < TPM_HEADER_SIZE)
-		return -EIO;
-
-	/* If this bit is set, according to the spec, the TPM is in
-	 * unrecoverable condition.
-	 */
-	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
-		return -EIO;
-
-	/* Read the first 8 bytes in order to get the length of the response.
-	 * We read exactly a quad word in order to make sure that the remaining
-	 * reads will be aligned.
-	 */
-	memcpy_fromio(buf, priv->rsp, 8);
-
-	expected = be32_to_cpup((__be32 *)&buf[2]);
-	if (expected > count || expected < TPM_HEADER_SIZE)
-		return -EIO;
-
-	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
-
-	return expected;
-}
-
 static int crb_do_acpi_start(struct tpm_chip *chip)
 {
 	union acpi_object *obj;
@@ -474,6 +444,8 @@ static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t offset = 0;
+	size_t chunk_size;
 	int rc = 0;
 
 	/* Zero the cancel register so that the next command will not get
@@ -481,7 +453,7 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	 */
 	iowrite32(0, &priv->regs_t->ctrl_cancel);
 
-	if (len > priv->cmd_size) {
+	if (len > priv->cmd_size && !priv->chunking_supported) {
 		dev_err(&chip->dev, "invalid command count value %zd %d\n",
 			len, priv->cmd_size);
 		return -E2BIG;
@@ -491,18 +463,108 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	memcpy_toio(priv->cmd, buf, len);
+	while (offset < len) {
+		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
 
-	/* Make sure that cmd is populated before issuing start. */
-	wmb();
-
-	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
-	if (rc)
-		return rc;
+		if (chunk_size == 0)
+			break;
 
+		memcpy_toio(priv->cmd, buf + offset, chunk_size);
+		offset += chunk_size;
+
+		/* Make sure that cmd is populated before issuing start. */
+		wmb();
+		if (offset < len) {
+			rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
+			if (rc)
+				return rc;
+			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+			    CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
+				dev_err(&chip->dev,
+					"Timeout waiting for backend to consume chunk\n");
+				return -ETIME;
+			}
+		} else {
+			rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
+			if (rc)
+				return rc;
+		}
+	}
 	return crb_try_pluton_doorbell(priv, false);
 }
 
+static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
+	size_t offset = 0;
+	size_t chunk_size;
+	size_t first_read;
+	int rc;
+
+	/* A sanity check that the upper layer wants to get at least the header
+	 * as that is the minimum size for any TPM response.
+	 */
+	if (count < TPM_HEADER_SIZE)
+		return -EIO;
+
+	/* If this bit is set, according to the spec, the TPM is in
+	 * unrecoverable condition.
+	 */
+	if (ioread32(&priv->regs_t->ctrl_sts) & CRB_CTRL_STS_ERROR)
+		return -EIO;
+
+	/* Read the first 8 bytes in order to get the length of the response.
+	 * We read exactly a quad word in order to make sure that the remaining
+	 * reads will be aligned.
+	 */
+	memcpy_fromio(buf, priv->rsp, 8);
+
+	expected = be32_to_cpup((__be32 *)&buf[2]);
+	if (expected > count || expected < TPM_HEADER_SIZE)
+		return -EIO;
+
+	/*
+	 * Set chunk_size by comparing the size of the buffer that the upper layer has
+	 * allocated (count) to the hardware tpm limit (priv->rsp_size).
+	 * This is to prevent buffer overflow while writing to buf.
+	 */
+	chunk_size = min_t(size_t, count, priv->rsp_size);
+	if (chunk_size < 8)
+		return -EIO;
+
+	/*
+	 * Compare the actual size of the response we found in the header to the chunk_size.
+	 */
+	first_read = min_t(size_t, expected, chunk_size);
+
+	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
+	offset = first_read;
+
+	while (offset < expected) {
+		if (!priv->chunking_supported) {
+			dev_err(&chip->dev, "Response larger than MMIO and chunking not supported\n");
+			return -EIO;
+		}
+
+		rc = crb_trigger_tpm(chip, CRB_START_NEXT_CHUNK);
+		if (rc)
+			return rc;
+
+		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+					 CRB_START_NEXT_CHUNK, 0, TPM2_TIMEOUT_C)) {
+			dev_err(&chip->dev, "Timeout waiting for backend response\n");
+			return -ETIME;
+		}
+
+		chunk_size = min_t(size_t, expected - offset, priv->rsp_size);
+		memcpy_fromio(buf + offset, priv->rsp, chunk_size);
+		offset += chunk_size;
+	}
+
+	return expected;
+}
+
 static void crb_cancel(struct tpm_chip *chip)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
@@ -727,6 +789,15 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		goto out;
 	}
 
+	if (priv->regs_h) {
+		u32 intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
+
+		if (intf_id & CRB_INTF_CAP_CRB_CHUNK) {
+			priv->chunking_supported = true;
+			dev_info(dev, "CRB Chunking is supported by backend\n");
+		}
+	}
+
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
 	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
@@ -764,8 +835,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	priv->rsp = priv->cmd;
 
 out:
-	if (!ret)
+	if (!ret) {
 		priv->cmd_size = cmd_size;
+		priv->rsp_size = rsp_size;
+	}
 
 	__crb_go_idle(dev, priv, 0);
 
-- 
2.53.0


