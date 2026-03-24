Return-Path: <linux-integrity+bounces-9062-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBEYA3nUwmllmgQAu9opvQ
	(envelope-from <linux-integrity+bounces-9062-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:14:17 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802831A937
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8332308B632
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9F38911A;
	Tue, 24 Mar 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRpXLmIc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7FAE+0m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464ED389116
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375980; cv=none; b=oME+ZeIABlzpm6xglzjgHrxjZxjswSdNmPigh4bWuHp3w6fy3M1DrO+6D/QvrUMayL7JAhvBFWjgZXE2YKzs9O/LCgQSP+HTgh5QILiPcVylX8JdNiF16YLAapQ0rC2RPuw6bn7ElVN0eRCOhC3ce2gMNcGM8UQwELHU4pmuLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375980; c=relaxed/simple;
	bh=CbKw7uCHTcASIbjhrtIAbyn29K0D1wi28B2cF/M0q3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqqRUO1glyhy0fwtt4vpFm3Ojdo/PWTPy6sPSZComRkR8MfhQGRWtOCAujkSloaf0P7aYUo1mRqoRR+26e+DFbiCt5vtY5MdKAFHvgVJg8qeV3HcfbZ1IoJIDq4mqR8QqkQFaY6qdO6uqu84yFG9EyLoMzjSnHIBSpG4bijfTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRpXLmIc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7FAE+0m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774375978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LlOqs7sUxhA26BwtIb2xj4ODpYuCm+x9OqSh9XodAHs=;
	b=XRpXLmIc/0GN43XK/p8b32AKFSFsylfOx33aOVjLzEHs+B4n5G4Qpd1JSTzOiOmgKSm5RI
	olIy5NvWD3HXsmwy8p4kuEGBWrjNicAqqB9jO5HQ82tkrdo/TYynq0K5jtXDEcz+4pT8XP
	Icihxy7vgUcBoNzQltL8TvpjnLAMZKY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-WfGnTGr3Ow2gaRuF4ZegLQ-1; Tue, 24 Mar 2026 14:12:55 -0400
X-MC-Unique: WfGnTGr3Ow2gaRuF4ZegLQ-1
X-Mimecast-MFC-AGG-ID: WfGnTGr3Ow2gaRuF4ZegLQ_1774375975
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b62da7602a0so3123361a12.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774375975; x=1774980775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlOqs7sUxhA26BwtIb2xj4ODpYuCm+x9OqSh9XodAHs=;
        b=M7FAE+0mjYNgCoKn7pY92s3VqoMSL2XyzYy3qalGByZu1/REhTVdOasphR2CO0OBUw
         Lehzrd9ovv/bUzdgbE1lbi6KHKdNDDDF+UtjxYoNwsk42L/YWcX3OQutgAQVbbKnligq
         BPoTl+J1xnyvNjZs3kRAGysvtJaig9G31IUojIYFejVmJ2/2OxCGkXSG6jiXJZoeybbL
         E43EoJviikfNTSDu4lctDM0l5AEmkIIwKnOEjq27p0k+2OafIV0QA3y20Ul8iMJh4x0P
         cHRUfnVG5ZOn/VHBIKUiGgUt33aq2kHFoHmhXY74gdll5NyyqmMiPzAC7+/5QCIG6ALo
         XWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375975; x=1774980775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlOqs7sUxhA26BwtIb2xj4ODpYuCm+x9OqSh9XodAHs=;
        b=Kz9U1e7mDO45aqWEpf8qxic8dux3kh+WJPZOrTawve5n8c1r6pH4iYW2tRArtVupYK
         Mwtzf3mKRZVyELDPdUKTVKRM1brUe7HaPn7uxTUeorM1Ckaq9QReKgmSmGVcjMBRzeCM
         AG2ww0PTnw1CxG3a0Jnk6N2vbOAv3WiHJOUKfFGBUODrcMoTOhdhGc73OCFpieOG0GP4
         wswNqU5qhYbs7VWLAjrgMd58hmVylvotPfeeZkoz1PL6IZcQwcAbLny2ledQuoTh7Kbj
         6cnbHRPqN8RZZWZZkjhx17xL+m8nd3g45GKuOXi4jzBkKfC6MdUOybnv/v8e7WXCYptu
         0e/A==
X-Forwarded-Encrypted: i=1; AJvYcCXjfYDvXLBVYUjwZeWYncJ1K5avU9pXj3BEocky8p5EBgvBLMl/BhilWJQZalZ4Jter3uFlNSD0LaXuBoJpqek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbp12AJDsuVQPox86mSW6iQUpMPr4EmxhHR4SWGCUIF8wmQlj
	8ajY5TbhKtsWmts6q0VF/e44YRP3EBxhYh/q9whbhWGU2GZMvUjZNuoEnWveRvoU78fNklVfH+a
	GV+HnYelFJ9xb29f/V9WphMA9z4xq0iEomeAiOLhoLuxcrJJsNN3v/lAwBUDw6x9/Cwbusw==
X-Gm-Gg: ATEYQzy5sgU19I5MqYWvOE5QauOtCwClqxwRzEwjye07g1T48DaFiNvb4BjP1pDTjZP
	5SNBsRx/0rsQVbZ1gZM+uaYuTlNlEfl13Q8a3yqHZLi4j0Ro8+bdTbbHgvVm0xdZohbLB6BosZ+
	2WMjBYF9hN6B7aYCNOuoLYEZAiHDg8bwGt9b7UamRUV66a+N7a4H7COTjl+Db2TEpgbX+m7Rqyw
	NxFB4cXLuiG9gD3FiZR8fyJysu6o9fDhVUyt8STFQuDZAByqgdFPRM9/K9U33f/3fkmxFXLuT1A
	wmywba56OG4eJ2rCsez4LcHDw8VqU0x4fCy3KMLaoYXDk+r3DK6rIEhgxlu1thuMzsDQY7dPPSi
	gEZBDIRBllHIqkYN5tRiYLiym1J4fsThbo4c+X81SUfweikpDq+mRngwz9KY+Mg==
X-Received: by 2002:a05:6a00:3924:b0:829:7d31:dd99 with SMTP id d2e1a72fcca58-82c6e0eb05bmr509171b3a.38.1774375974809;
        Tue, 24 Mar 2026 11:12:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:3924:b0:829:7d31:dd99 with SMTP id d2e1a72fcca58-82c6e0eb05bmr509150b3a.38.1774375974343;
        Tue, 24 Mar 2026 11:12:54 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm16654229b3a.57.2026.03.24.11.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:12:54 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC v2 2/5] tpm_crb: Add new wrapper function to invoke start method
Date: Tue, 24 Mar 2026 23:42:41 +0530
Message-ID: <20260324181244.17741-3-armenon@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-9062-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6802831A937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current implementation handles different platform start methods
(ACPI, ARM SMC, and ARM FFA) directly within crb_send(), but it is
limited to triggering the CRB_START_INVOKE bit.

To support cmd/rsp chunking, the driver must be able to send other
control bits, like CRB_START_NEXT_CHUNK, using these same
platform-specific paths.

By moving this logic into a new helper function, crb_trigger_tpm(),
the driver can now send any required control bit across all supported
platforms. This prepares the driver for the upcoming chunking support.

No functional change is intended.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 67c0061d4cab7..922bcf7a69ad5 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -445,6 +445,32 @@ static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
 }
 #endif
 
+static int crb_trigger_tpm(struct tpm_chip *chip, u32 start_cmd)
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


