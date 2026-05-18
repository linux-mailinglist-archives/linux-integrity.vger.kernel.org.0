Return-Path: <linux-integrity+bounces-9597-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPvUM3IuC2plEQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9597-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:21:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5156FD0A
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E273073542
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9323783C1;
	Mon, 18 May 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHiaVY8j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mwsMKjOy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98B378D71
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117482; cv=none; b=XcGyr0Zf/8QxTY/wJYhMedCcD+25P+AQIPUMEIXpLB/wHzQpLm1LQPy18vZNmazS/yW8Q+E1h9ffhhJQajWkQl23X2R97mZLOgRZKSKweFa+ftKTjTvJVURsBQZgaVRiI9VNr5gVfOel3UxSWdRrMxQk4GD3LGMvEUxpfLPfIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117482; c=relaxed/simple;
	bh=GUOwjHTHp7F+veAyU1RHSAr7O3jNZOc2wq937tHgqSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjXFvMDybNmNEVsAhzSvyo1RsH1MiSYc49dVwSftVOt//VGrF8K/925SJDESeBdPDV8QB0cDmwxHydcEUT2vcab5U22iU7ORrdVEjcSs6Ei7E7unrQrtFjdVqDheFGyyWm/a1JkNUOazT9MRxC31iov/44ftbjx5K39EKY2akUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHiaVY8j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mwsMKjOy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
	b=hHiaVY8jWAyES52eM4i1ZDzDlgmipQtrOkF55vo5w5/eoGvcPc/4G45xXukMpV7Vz9fWoz
	Iy1wy3Bal8Lc967ELWG6CZyiv2I9IRxSV3OLHfa+SxUlULv4y1o6LrCuqbFEPBi8jOjnmA
	zIrdYwU76OtpElMttKXyGMxqv389TyA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-dvfRXWQeOy2OE8eaK2OgTA-1; Mon, 18 May 2026 11:17:55 -0400
X-MC-Unique: dvfRXWQeOy2OE8eaK2OgTA-1
X-Mimecast-MFC-AGG-ID: dvfRXWQeOy2OE8eaK2OgTA_1779117475
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c829366cf25so3527125a12.0
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117474; x=1779722274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
        b=mwsMKjOy4Mo7r6U/tMDLh5QGPymTLeLWP5GE/750WfOgyHqKcUR27IPGCRzNCV6Wdm
         3ZahPXY5ERNoo0+QjsSBgxnTL53+njpCGHuiKFVMvPcODVZP9SW8AiJeEd76u2h26P4l
         KzmftXsq460SEVk9J9stjl9YbV4XHEsyITAPTQFj0sPI9E1MkWSnrzRaE9t8Ug4R1Yx+
         T/lAxGKBkEIX3Hsw0/wMmKFtpW+Koh0R+jFjrlg4efqvVWjZvkFMCXIgvDnTRkiofzxq
         7pxo6RqR/wb1t1qAXtWfUM68hS/8CrZXjhjWidoVOZkLhj33enFdiLJrZF99kA1U/GL0
         Nfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117474; x=1779722274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pe/iolypET0Kouxm0CjpcIMCpG/CgODFZgpYFH+mQ+E=;
        b=Auv8K2ih48FPSjHK2vWouFafNAFc6o2+JeDCzObv04Ib6rdLrPkK1HitCbzDE6oaoA
         gnbYYqXJAa8gAWvqj+SelCCTYs0ATOlbggHlvtMrOMU11MLe5JSAoX+2DYbTnrS2882e
         kFLh5L5dVbI3ps3fB3JD/HqBbxqdyO2mlervO7lwaPhSTgQVRKolzxbyLVfcn4SJLZpQ
         Lkwxo6HDrLadiOrOs7n0N+pEV6TGRNZ69DZumGrHMK2qLJJNu+ZJsWMqW5VmNeWHPArt
         ogBfEmw+VesXxjut6ycP6whPZTT5P0Q4E8275yytvIcwwq5jT3LCzhISRPH/5IfIxLu+
         TYcA==
X-Forwarded-Encrypted: i=1; AFNElJ/AvwpZ7wA25UX2a7NGwcGDEV8ftXH1+hZE5MmkZRZNwq1dWNa/VGzF0VLCNWn3uzpd0/drbAeWGQ00EAad/Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydn4PICsjcINeL6Gisu2X2HG13OrSvoBslla+rfvR/HAznGjFR
	4Rr8brawx4bUNuDO3q4koydJOzPi7fzeDFuvlwBkJes2/XDI6jLkIwxAuYjS1HR2SO8UByWIUzN
	07kW++N+OdgemjJTkvy/g6XvWjPBzvscHbgcsKa5sQDOvVckazQSszYmYs+NlKv0+/oO4Mw==
X-Gm-Gg: Acq92OGkawMxDPC4EhlGk0gQonjga55Bz34ydFRN+2mc6DSw1nsSATwPWkc9eDKHm+f
	Z1IVuu7N8RziiSPo3E/jmrL4FeCitZ+DCyoqTiYlpn44fcvs/dZHbc7FTaQMXwafX0UhuLEfECD
	7GauL5L7FIkpkWJjcCLxrLfeFNDoqAPVyW9Vklue2HD4ad4XHh4OiUEC6Y7hWWXkh3I1EA+YTn5
	rk3VPcX5febkowNJy687U3I3VbqGxwDFs46OJIit1Utyc8rY5yF0H4pyVnhw0uFVqPn/ELoP1mm
	pApEG2HEETP78P2rEjeMG64IjG5RTF27LUoium8RdZU1UP1SGwm5BOJ3UCuRKKOUIwJRrsHtFj9
	/3HNTNAzX3jeOilwLeL0myO9/OJhN7LeaKhYaJMGL5bF0jZPCUGe31KrlsSMFXUc=
X-Received: by 2002:a05:6a00:a10:b0:83e:c8f8:cec7 with SMTP id d2e1a72fcca58-83f33dddb8cmr16057926b3a.35.1779117474378;
        Mon, 18 May 2026 08:17:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:a10:b0:83e:c8f8:cec7 with SMTP id d2e1a72fcca58-83f33dddb8cmr16057884b3a.35.1779117473762;
        Mon, 18 May 2026 08:17:53 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 6/6] tpm_crb: Implement command and response chunking logic
Date: Mon, 18 May 2026 20:47:24 +0530
Message-ID: <20260518151724.730443-7-armenon@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9597-lists,linux-integrity=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 3EF5156FD0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arun Menon <armenon@redhat.com>

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

[1] https://lore.kernel.org/qemu-devel/20260506075813.120781-1-armenon@redhat.com/

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 215 +++++++++++++++++++++++++++++--------
 1 file changed, 173 insertions(+), 42 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 31f530744e90..8b2aaa109fc4 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -105,11 +105,13 @@ struct crb_priv {
 	u8 __iomem *cmd;
 	u8 __iomem *rsp;
 	u32 cmd_size;
+	u32 rsp_size;
 	u32 smc_func_id;
 	u32 __iomem *pluton_start_addr;
 	u32 __iomem *pluton_reply_addr;
 	u8 ffa_flags;
 	u8 ffa_attributes;
+	u32 intf_id;
 };
 
 struct tpm2_crb_smc {
@@ -369,38 +371,6 @@ static u8 crb_status(struct tpm_chip *chip)
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
@@ -472,17 +442,71 @@ static int tpm_crb_start(struct tpm_chip *chip, u32 start_cmd)
 	return rc;
 }
 
+static int tpm_crb_send_no_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	int rc;
+
+	memcpy_toio(priv->cmd, buf, len);
+
+	/* Make sure that cmd is populated before issuing start. */
+	wmb();
+
+	rc = tpm_crb_start(chip, CRB_START_INVOKE);
+	if (rc)
+		return rc;
+
+	return crb_try_pluton_doorbell(priv, false);
+}
+
+static int tpm_crb_send_chunks(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t offset = 0;
+	size_t chunk_size;
+	int rc;
+
+	while (offset < len) {
+		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
+
+		if (chunk_size == 0)
+			break;
+
+		memcpy_toio(priv->cmd, buf + offset, chunk_size);
+		offset += chunk_size;
+
+		/* Make sure that cmd is populated before issuing start. */
+		wmb();
+		if (offset < len) {
+			rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
+			if (rc)
+				return rc;
+			if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+									 CRB_START_NEXT_CHUNK, 0,
+									 TPM2_TIMEOUT_C)) {
+				dev_err(&chip->dev,
+						"Timeout waiting for backend to consume chunk\n");
+				return -ETIME;
+			}
+		} else {
+			rc = tpm_crb_start(chip, CRB_START_INVOKE);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return crb_try_pluton_doorbell(priv, false);
+}
 static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 {
 	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
-	int rc = 0;
 
 	/* Zero the cancel register so that the next command will not get
 	 * canceled.
 	 */
 	iowrite32(0, &priv->regs_t->ctrl_cancel);
 
-	if (len > priv->cmd_size) {
+	if (len > priv->cmd_size && !(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
 		dev_err(&chip->dev, "invalid command count value %zd %d\n",
 			len, priv->cmd_size);
 		return -E2BIG;
@@ -492,16 +516,115 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	memcpy_toio(priv->cmd, buf, len);
+	if (len <= priv->cmd_size)
+		return tpm_crb_send_no_chunks(chip, buf, len);
 
-	/* Make sure that cmd is populated before issuing start. */
-	wmb();
+	return tpm_crb_send_chunks(chip, buf, len);
+}
 
-	rc = tpm_crb_start(chip, CRB_START_INVOKE);
-	if (rc)
-		return rc;
+static int tpm_crb_recv_no_chunks(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
 
-	return crb_try_pluton_doorbell(priv, false);
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
+	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);
+
+	return expected;
+}
+
+static int tpm_crb_recv_chunks(struct tpm_chip *chip, u8 *buf, size_t count,
+							   unsigned int expected)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	size_t offset = 0;
+	size_t chunk_size;
+	size_t first_read;
+	int rc;
+
+	if (expected > count)
+		return -EIO;
+	/*
+	 * Set chunk_size by comparing the size of the buffer that the upper
+	 * layer has allocated (count) to the hardware tpm limit (priv->rsp_size).
+	 * This is to prevent buffer overflow while writing to buf.
+	 */
+	chunk_size = min_t(size_t, count, priv->rsp_size);
+	if (chunk_size < 8)
+		return -EIO;
+
+	memcpy_fromio(buf, priv->rsp, 8);
+
+	/*
+	 * Compare the actual size of the response we found in
+	 * the header to the chunk size
+	 */
+	first_read = min_t(size_t, expected, chunk_size);
+
+	memcpy_fromio(&buf[8], &priv->rsp[8], first_read - 8);
+	offset = first_read;
+
+	while (offset < expected) {
+		rc = tpm_crb_start(chip, CRB_START_NEXT_CHUNK);
+		if (rc)
+			return rc;
+
+		if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_start,
+								 CRB_START_NEXT_CHUNK, 0,
+								 TPM2_TIMEOUT_C)) {
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
+static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
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
+	/*
+	 * Peek at the first 8 bytes to determine the response size
+	 */
+	expected = be32_to_cpup((__be32 *)&priv->rsp[2]);
+
+	if (expected <= priv->rsp_size)
+		return tpm_crb_recv_no_chunks(chip, buf, count);
+
+	if (!(priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)) {
+		dev_err(&chip->dev,
+			    "Response larger than MMIO and chunking not supported\n");
+		return -EIO;
+	}
+
+	return tpm_crb_recv_chunks(chip, buf, count, expected);
 }
 
 static void crb_cancel(struct tpm_chip *chip)
@@ -728,6 +851,12 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 		goto out;
 	}
 
+	if (priv->regs_h)
+		priv->intf_id = ioread32((u32 __iomem *)&priv->regs_h->intf_id);
+
+	if (priv->intf_id & CRB_INTF_CAP_CRB_CHUNK)
+		dev_info(dev, "CRB Chunking is supported by backend\n");
+
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
 	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
@@ -765,8 +894,10 @@ static int crb_map_io(struct device *dev, struct crb_priv *priv,
 	priv->rsp = priv->cmd;
 
 out:
-	if (!ret)
+	if (!ret) {
 		priv->cmd_size = cmd_size;
+		priv->rsp_size = rsp_size;
+	}
 
 	__crb_go_idle(dev, priv, 0);
 
-- 
2.54.0


