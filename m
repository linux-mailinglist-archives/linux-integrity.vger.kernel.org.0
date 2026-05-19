Return-Path: <linux-integrity+bounces-9600-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INkJDN7+C2pcTQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9600-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 08:10:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB238577C3D
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4D53018756
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 06:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC437D128;
	Tue, 19 May 2026 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efLuJxH1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621D37C904
	for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171000; cv=none; b=HfB6kpzBbTtL42zpFF8E1pNzafCLV7BF/KXkxO5+uijj+goDGgv6giWWq2Kz8fJkur92fy3QCBLUD/XmWLxMWiST6jK00rUuDYOmvC0gcHBXwPcj2RJ9w0Y3SFmN+df0/YVUuhrt/4sCRLGb1zilHqRwVSDKvvL4R1qPsaD/3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171000; c=relaxed/simple;
	bh=m4Wkj+rk/VrvijEitrfIMERd/zmOQp580t2sTN8465o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBhE2TZWyNCsrqbsl02RW+zNQT5+g4VyI3zw//m3uBswOnoDSDsaD2K7eTp1o1WdrPXVlPvu1mPME3SCLwihgLDVYmC1ElPAKtqhJ6JAaFOLQU9AUd1Q+06aWdrfmyoJkmwBc5CM/YKIVoAalO5N6wMNLUJ9Yr3zGltlJvJw4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efLuJxH1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3680540a6efso1598519a91.2
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779170989; x=1779775789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35UEgwPy5bOt7bPAiRN5I3s053dsTnr88mncjkP29bU=;
        b=efLuJxH10cUg1gukP013S367aaVA1L9r0LkGaWAVp/yFbTxJ2TP1CpIdBJRtmKc7Zz
         fGr7acFJmVz5GxgIuhls2Ti5nrnLFnmdbNxu+U8MiTjG2340f+N8rtD0C+ORScuGf5fK
         hCZb9/EcPOD5K+ZtqOdRkHvV587n4Br791Cdgdu3UitFLqS65nBs1VdeweVNFnSThA2d
         zMClp/ExjcF0ttlXzJu3T7zrjsNhRUH/xOr9AStU8oREjyuclsfyqX6fpgRU5wjPp0KQ
         lkJRVbYXOll1EqyHKTNG5HrGAvTPDZDFMfmXqk0omxWngJpQQi/lWN0Wm8wRackSO2rm
         XSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779170989; x=1779775789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35UEgwPy5bOt7bPAiRN5I3s053dsTnr88mncjkP29bU=;
        b=Et6gOvP/4B5NSoO7YPhfP64EfLdH7bSQreQclhjzZ2He5jvNzbzRCDGA/DGTpW1u67
         UkU3ZRqNt9o9r30a3zMXP8YEmWDJnLapHDez6YhDl0APer6r334p1VLIKB8/KZzdvrgd
         z9Rb/hv0EsROw2OdvLRPE+8+HpMedtOEYzYkf1LQO/ketr8JUKOpDuQK/ZO8EpseXNaG
         ZTrLI+5p8TcNN2ustbdCa5XZ3jMlVRQ9WvJOeNPzXdsRXBVjVdBIcAZcMJ64DyvQyUx6
         HiI4LpZfs5CogHIWmB9w4kwH2ViCazrxCzHjO0JeV4tFMFstqmq6VBGuTSgRSwb4rkFo
         z6Pg==
X-Gm-Message-State: AOJu0YxWfBtCgKHIhwz8igaz243cOEN+ZvVTkYqICIph16oKI5vKruLj
	7JOvijOM7CLWX2cStoU2VbKmsO9dzI8IoA4ppVFsFcMfTiU5YbbrrkQm7wO2sER23vA=
X-Gm-Gg: Acq92OFwCmP5evD0ZjToJUAHH6oZTiEW2cS6fxmnnQX61hEfgVKnfCuk5Tb+Rtff0CB
	ChTm8chJvhMI/xDDuTQBTFHZg1kYH+qFzP17EAx7TEypyc6MEucFocJOBzAxSpwrXp/luTaK263
	Mdim7KhpHBPl+bhTpZRUxxQofD1Icb6uycusbRvpbHP0J5tQYYOQ4J0hhJDz1nRLYfVOasTOobR
	ZHvSFbjU9d6II63OszvxwS8QQH5+Ll6qAzbQPQZ4QYbbZvbpqPHzsBkozfpKsM5QUm4uetgxH7S
	wO/VH7qAmBZezUDxcpo4F78OBuDWemBOin+9bq2+OtlGaQX36WuzWeA2POyg199Ri7NPetnzp7+
	QnIb3bLc8Ky8In29xZJtCuXudfWEHaSAdCTvwCNEuRRHs5edXJzhIBZsJPE8AYUKDpdV7Sc0kGI
	SvnVHMpouLq4mdfXe6/bQlbb7mrXv9Xy4lsiOpeQoSrz6egmupi5AXgTux2q41FZ3CcA==
X-Received: by 2002:a17:903:284:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2bd7e977b8fmr200540165ad.28.1779170989314;
        Mon, 18 May 2026 23:09:49 -0700 (PDT)
Received: from harvey.lan (c-73-83-32-130.hsd1.wa.comcast.net. [73.83.32.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe64a9sm172805975ad.53.2026.05.18.23.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:09:48 -0700 (PDT)
From: Jim Broadus <jbroadus@gmail.com>
To: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
Date: Mon, 18 May 2026 23:09:26 -0700
Message-ID: <20260519060926.103727-1-jbroadus@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca,gmail.com];
	TAGGED_FROM(0.00)[bounces-9600-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: CB238577C3D
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
index 21d79ad3b164..68be26fa5817 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -184,6 +184,9 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 		__tpm_tis_relinquish_locality(priv, l);
 	mutex_unlock(&priv->locality_count_mutex);
 
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


