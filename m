Return-Path: <linux-integrity+bounces-9046-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLYQH2Y+wmmZawQAu9opvQ
	(envelope-from <linux-integrity+bounces-9046-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:58 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A76130407C
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC0CA31E8EB2
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3989A3D349F;
	Tue, 24 Mar 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHX8k5m2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVPivqhP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD12D94BA
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336712; cv=none; b=kwHo/ttaVkzu6F8ZGSZ0iPRwjivfOrBC5pZ1iIoSVs30uZkCCVc/owGdvjGbVb2T584pFfDWRUh9gUwUDseKtG3LuOBb7nQkLSdm6jTmuukoGCzh1df2jYWPs3eb0SxoPZGZOsvFhdT8aUBoYeCOc8M48eyK6riPWoCs1CnN/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336712; c=relaxed/simple;
	bh=+sKk+LR9zR9ZKqE6bhd3PLSWqidIdSpmgScoe+3cKZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9UJ72ReEjYwUOv9r/EDXd36jz4NzXladYnZy90eFXRaDKcMPpgk1zmi5BNIBb8VSZwGhw1cx/7gm5E5efMsRTUE6eJAMDGwIIMIJ8S0F89TqiJ34sIU5K5yRa9YVKMtROwiK1yaFM3dx/u/q6zSDnI4rgkqXO6qSWJ6I66Rz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHX8k5m2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVPivqhP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNnPw5foALWPQjwieo1e/lEK9v8tBtgy/PYi8XddQNs=;
	b=dHX8k5m2wVlsCGqXh7YSF3OZ/X8amtQYa6htCy9dn1cWVYJrYvU5ELA0coZZTKdnRBTyS4
	LXtLYAHsvwOUboQcfzCZCAEfoGtcN+uquaozkS34rFSt183x4raklMVHz3q+gGYpo9X4ls
	x8pJwDoM3rVt6O4IKfYTtYpblToPQsI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-s2L-63r7OxOd8kqAVyGGYA-1; Tue, 24 Mar 2026 03:18:17 -0400
X-MC-Unique: s2L-63r7OxOd8kqAVyGGYA-1
X-Mimecast-MFC-AGG-ID: s2L-63r7OxOd8kqAVyGGYA_1774336697
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2511779a12.3
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774336697; x=1774941497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNnPw5foALWPQjwieo1e/lEK9v8tBtgy/PYi8XddQNs=;
        b=KVPivqhP2VstkUeZ41TZ0odHldRhv/mbRqjFbqC0MfjO7f5PKWKz6YHuZ3J79uPymB
         rJQht4FXa+rmDU9evu1TM1JQT7CQ6uG5+cwA3jIeDlh9yiXuXw+AeFUYEgcUWsvjzTYd
         dpTv/Cj93QIGjhqSadSvIgBxUHGu33xXr6YfcEYYv0SdxT6c8BQ/xsHCQxkWP/Pmt1c0
         K2dmZYZoz/zub5PaetGtLAXCa+MdiodTbUy704aTNFVcRXNJFm594qBLsApRoT3h515J
         bwSz7QrMxw8rGUV6NyavkEKdLFa3a1DcUZzs9FMF54hMQjVjrdgoiGdbpIHZsHREBCmk
         jS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336697; x=1774941497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNnPw5foALWPQjwieo1e/lEK9v8tBtgy/PYi8XddQNs=;
        b=ZXDL/Dvwcfhy5wz+ss+NVhGw/WBsP5E0FI3MYx8ch1dPrcvviCXB4WMFU/NIqRXEMS
         scJSPMcotlsYHe0SpcTHc5bEe8HfHRhfA6rlDnnPsv0yAotj/r4fVhX031jDuCKKM+eW
         xz3T4NwITdRtXHchwOQvdAam2hjdTfDKxCQal07OqLvmjs7yL2AQfDoWC7Riwm6/H7kP
         TnAhFi+X/lVxGsLDQ7CxUPFc/jNnyEfzZBmphFbzcDJJ1mZG3tTCCDzbX9wty7Tp1P5n
         Ylc4LlCGnzH1mGrl/XY+4mVIXIxiEjZyw5rkEiPJSdU2DnBfcGqQ8cSs6HRGEwl2kYpY
         ppPQ==
X-Gm-Message-State: AOJu0Yyxgl8RVKVtSXFSKrkRhpFhdK2Q/qIIVOYp51g3SGE83YRleDpA
	S40KE20aI9lx7JdGrt/mmzgUrrhtH1xFYsKnUVLJCSg1aU4YGIp7QLKhm/2qhucjWCklkKjP+8m
	ZZP6anFAcsuu5LCkyebMu9PK9nf1IXQdTbtaqAZ+Rryk+di2y8i6PKVUe1vRyEqh72VL6oA==
X-Gm-Gg: ATEYQzz16phhEdbPuo+RDH3HgowUW1cAWbJfDUZb9KFQO6/SnR7+o+/jyvpljZ5BAF/
	pdy4ZbW0WJZpTjGT6cJxIxC1V4/2a3pQbVyVG3TdrcOod1XAVkSNEINsIicYRUATcGVo/px7klt
	OGFFnUcVADNAaZF6NoM0lFFMQIxORwWTqQIssqF4FMI8zKRICesNYUTl2EEqynLTQDH6qayQ3P2
	E+TfcaRV/wCBY/Yh71zn6qQeg9ccTUTQcQlWA8NJAOb4BCAsqOsMNG6m88fRQCyPKdqVWCkWKra
	Y4bLQzMuP29pzr+tnQxim8+beHi29QGdyEd1hjslhdTWzy90vy+ICm5co0kJa7SqJMQt3f0HS+V
	iNkLv66bivHn9uYZ7xJfvxFqwygZUypuN2XPfh2xcJNSA7OYYfBu1gAOv31TciA==
X-Received: by 2002:a05:6a00:13a1:b0:82a:6852:559e with SMTP id d2e1a72fcca58-82a8c21270amr12493378b3a.12.1774336696569;
        Tue, 24 Mar 2026 00:18:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a1:b0:82a:6852:559e with SMTP id d2e1a72fcca58-82a8c21270amr12493361b3a.12.1774336696100;
        Tue, 24 Mar 2026 00:18:16 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm13597766b3a.37.2026.03.24.00.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:18:15 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC 3/4] tpm_crb: Implement command and response chunking logic
Date: Tue, 24 Mar 2026 12:48:02 +0530
Message-ID: <20260324071803.324774-4-armenon@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,gmx.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-9046-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 3A76130407C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for sending and receiving TPM command data in chunks when
the payload exceeds the physical size of the hardware MMIO window.

This introduces the following changes:

- crb_map_io(): Checks the device interface capability to determine if
  chunking is supported, setting the chunking_supported flag. It also
  stores the hardware's maximum response buffer size in priv->rsp_size.
- crb_send(): Iteratively writes command chunks to the fixed priv->cmd
  MMIO window. It signals the TPM backend to process intermediate chunks
  using CRB_START_NEXT_CHUNK, and signals the final chunk to begin
  execution using CRB_START_INVOKE.
- crb_recv(): Parses the expected response size from the initial TPM
  header. It then iteratively reads chunks from the fixed priv->rsp
  MMIO window into the destination buffer, advancing the buffer offset
  until the complete response is retrieved.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 150 +++++++++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 41 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 10128d078245c..fb63cc3737253 100644
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
@@ -491,16 +463,101 @@ static int crb_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t len)
 	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
 		__crb_cmd_ready(&chip->dev, priv, chip->locality);
 
-	memcpy_toio(priv->cmd, buf, len);
+	while (offset < len) {
+		chunk_size = min_t(size_t, len - offset, priv->cmd_size);
+
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
+	return crb_try_pluton_doorbell(priv, false);
+}
 
-	/* Make sure that cmd is populated before issuing start. */
-	wmb();
+static int crb_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct crb_priv *priv = dev_get_drvdata(&chip->dev);
+	unsigned int expected;
+	size_t offset = 0;
+	size_t chunk_size;
+	size_t first_read;
+	int rc;
 
-	rc = crb_trigger_tpm(chip, CRB_START_INVOKE);
-	if (rc)
-		return rc;
+	/* A sanity check that the upper layer wants to get at least the header
+	 * as that is the minimum size for any TPM response.
+	 */
+	if (count < TPM_HEADER_SIZE)
+		return -EIO;
 
-	return crb_try_pluton_doorbell(priv, false);
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
 }
 
 static void crb_cancel(struct tpm_chip *chip)
@@ -727,6 +784,15 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
@@ -764,8 +830,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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


