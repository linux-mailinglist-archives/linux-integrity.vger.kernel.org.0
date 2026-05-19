Return-Path: <linux-integrity+bounces-9604-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HnhGNuFDGoniwUAu9opvQ
	(envelope-from <linux-integrity+bounces-9604-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 17:46:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE5581B32
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0B50303FD49
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 15:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5B33CE80;
	Tue, 19 May 2026 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFcgK1O6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5E33BBA7
	for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205546; cv=none; b=t3huUClCwar3VeQ+EGBtYoXfAVtSx5xQxcqlvNiZ5MrAOnIK7uSBu3iszOiSkA1niF71wYo0FKFcBUdB1SopKIIYr10dsJYUQSCLj7MDL65XplumaZHg/AMWMJY7agZVRJ8iWebIs7mW3SuTvxK/jEnttU7vVjjPTdTFIGiz3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205546; c=relaxed/simple;
	bh=8xTLkP5HHGOSsPXahYYct4AINZU4Xnh41shnZzK8sM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hspar/rYl0FamoPkOMsAu3B7RFMcj/bKUZpGHX7HrJE0vMPYm2C87VzQP9QukMZNEiZKYmOS5yxSedDm3abbyNmxxLCfkJ+328reBuKzpTXTsXjeGbVPoiYESfkEKiL2vwPgSfZ4t4pCs07WShr3/oKW3Ap20aSN6AJueJc21bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFcgK1O6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba6485d219so26733735ad.3
        for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205544; x=1779810344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNUJfukVCrNvL6eNTnpH1HFwWnM+ieYubC7RiDQelIA=;
        b=hFcgK1O63VVLGtntdCe7y0qOnrxWh1SNvScVIhAhGxbC9kqdaokWe0GnywafFktK2d
         /B3m+D/0TfkX6XBt54V5Ae8MdvBwJUDwxXMshpWcxYfrE1qxqhqZw1h95VjWlPCoP088
         lhT2Q04//c1naK0fSTank/uW2WZAH+dxaQetsbfcPR8DTiKSJtkQcoZUQ5OTWc8cSS1y
         2DhXoTPwGEIToQsaSstNpxR7Kfmw2DcfIictUy5CyHLGjQEjlNbgWtSMr/RA6BQ7X6GX
         xFMRY/gyBH/cHzkuPCDww//LrIrOp32IATE2dk+xT3lvdB1QJBjuOYiuakdRk+AN0QpM
         cIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205544; x=1779810344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNUJfukVCrNvL6eNTnpH1HFwWnM+ieYubC7RiDQelIA=;
        b=cE8h5srS/lpVeYgAimCWspDtCcqh09+yzGFOIiau1rrK6P7niM8LUEXyinogjTzvXb
         KgfdS3/o/UKJWQRKRgGatO+aAgeux7wIwsmViV3zjl3pBDbWxE6Y0iZ4QXy5taJbo+5x
         hiBCWfh7IpthAvriXhta2KfQ0AMBzlI7YsmAt7LtxybEvvsVcBzdHMTu2hleP/COfULR
         40mFHftucCpHtvr3ggw2oW1i72WUiTw5xG8BPolJMe5FTy8AYa8pvuIIVGdlUbl9sxAv
         GKa+q24KdZ+pppwWSertkM7Wx9WSDgrHPMrNdobujeZLt8EhMq2rdEbQvHb5UNPZfcZs
         asUQ==
X-Gm-Message-State: AOJu0YxjjnxhfgSmCrS4fyllyvQLdx928UGTkM58rT/hwaU5Bxa3uTdx
	HVMV4kz9ozFbf591lcCDxH9p1c5RaKzr1r/yMb5rN+pWKUxuYQIZeMkSczUToSYiXIQ=
X-Gm-Gg: Acq92OEzEsId5qMbbx2OvLk++/kqOHzyh75VlE+jBINHl2gn41imZh8ruQU/FHXHKuC
	44hRzqBy/gtnXwTB6z0CJ4YpbNx/YZuwfaMqZiYKPitrzx7WPPAN46/zjucSljNhIqa3Q1HbP0p
	baEGpIaOGGs8luq5edQSGXAP6a4U3AzvlQlAz+I3YeVj0hrVrh9PU9UqRG187FJUJcEB3y/hGKa
	IhC5WqKgvojMb3sCPbmlvcxk2IYy8XVxVzMgnaPyccKuVDwCWFqHGo6Zf72YC1Ad7DgDFJkF9dU
	HKA1vuPjOFunRD1CRv9x9Xa5ANpGDbbAT7N6ukSDdGARDz5pd3SZ6n804n7YZxIFzrmYj+SPX0H
	A5Ap2pcBctzptxGPtWSJcLkxv/V35XYslbw9baGZI5bSmjurZjFy88VYESuBtVfj6XxJ2j9tFdf
	2sD/v8KkHGkMC5hQ4le16l2BBTHHsycXJvpPYOu6LzHTWrdyVKIm7IN39DekdD0+CDoA==
X-Received: by 2002:a17:903:f8d:b0:2b0:b016:773f with SMTP id d9443c01a7336-2bd7e8a0b31mr223662135ad.11.1779205544013;
        Tue, 19 May 2026 08:45:44 -0700 (PDT)
Received: from harvey.lan (c-73-83-32-130.hsd1.wa.comcast.net. [73.83.32.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe7270sm187058105ad.50.2026.05.19.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:45:43 -0700 (PDT)
From: Jim Broadus <jbroadus@gmail.com>
To: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH v2] tpm: tpm_tis: Add optional delay after relinquish
Date: Tue, 19 May 2026 08:45:30 -0700
Message-ID: <20260519154530.6386-1-jbroadus@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,gmail.com];
	TAGGED_FROM(0.00)[bounces-9604-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4BBE5581B32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some TPMs fail to grant locality when requested immediately after being
relinquished. In this case, the TPM_ACCESS_REQUEST_USE bit of the
TPM_ACCESS register is cleared immediately without setting
TPM_ACCESS_ACTIVE_LOCALITY.

This issue can be seen at boot since tpm_chip_start, called right
after locality is relinquished, fails. This causes the probe to fail:

tpm_tis MSFT0101:00: probe with driver tpm_tis failed with error -1

This occurs on some older Dell Latitudes and maybe others. To work
around this, add a "settle" boolean param to tpm_tis. When this is
enabled, a delay is added after locality is relinquished.

Signed-off-by: Jim Broadus <jbroadus@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 drivers/char/tpm/tpm_tis.c                      | 7 +++++++
 drivers/char/tpm/tpm_tis_core.c                 | 3 +++
 drivers/char/tpm/tpm_tis_core.h                 | 1 +
 4 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..5b7111033fbb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7651,6 +7651,13 @@ Kernel parameters
 			defined by Trusted Computing Group (TCG) see
 			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
 
+	tpm_tis.settle= [HW,TPM]
+			Format: <bool>
+			When enabled, this adds a delay after locality is
+			relinquished. Some TPMs will fail to grant locality if
+			requested immediately after being relinquished. This
+			causes the probe to fail.
+
 	tp_printk	[FTRACE]
 			Have the tracepoints sent to printk as well as the
 			tracing ring buffer. This is useful for early boot up
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 9aa230a63616..8ac0ea78570e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -101,6 +101,10 @@ module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
 #endif
 
+static bool settle;
+module_param(settle, bool, 0444);
+MODULE_PARM_DESC(settle, "Add settle time after relinquish");
+
 #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
 static int has_hid(struct acpi_device *dev, const char *hid)
 {
@@ -242,6 +246,9 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 	if (itpm || is_itpm(ACPI_COMPANION(dev)))
 		set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
 
+	if (settle)
+		set_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &phy->priv.flags);
+
 	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
 				 ACPI_HANDLE(dev));
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..fbeee085098e 100644
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
 
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6c3aa480396b..413cac5e0f31 100644
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


