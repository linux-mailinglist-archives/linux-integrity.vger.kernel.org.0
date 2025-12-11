Return-Path: <linux-integrity+bounces-7919-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63AACB6B03
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 18:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A553043F6E
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348E3168E5;
	Thu, 11 Dec 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xpr28zqx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96C3195F6
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473376; cv=none; b=EBQsBT2pwCjoOOME5OeCMB40jqtCtG/MEADpt7aC1W9uk2pT6LTVou80f5V4BfQGEHZOqDvZnNfga+CITF1Iau3UUlbUsqx/HFYNzA388V4bWRidgrY5taVyG19vMYmmFKnYSOyF+ekpmgjxj6pAXxp6OHbwyrhW6XPYlYY0oAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473376; c=relaxed/simple;
	bh=Svc6/wu5PiStY9NpUW3zypfWEAb+rgVj8zt7WVDcjFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9s/xhXiSmRBcRC4bzbgI1qswrH1lPRJ3tNMqwdTWyEeqm+1M9NXvhJ03lJaTi/EghOKptGJzwFa5D0tL4aYGG7XJ4GsHL96QO4q5/VoUJiw6pJBICV2/kFlRlWeFTZTw8mkLgKYwB9D0Hjs0Ne8qcmV8Xa6PWdaqvxy7ajcK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xpr28zqx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae77516so4197165e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 09:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473373; x=1766078173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7slVLIofatSoTo54gYSEEiPQgSIuIVsTlq2fZY6I/RA=;
        b=Xpr28zqxve6mIpnQwcoi4KvFAhs+G4+ezlZEpsKNxI5upYsQZOmtim/tss6U/kflvf
         8kWYCJo/KFO4rOcYHNt2HWD+m+yVk97F5NWofXH9BdgurW6cbo7bQtdwZyLKNa8hpnol
         Ges/0jgoiCmt9f4Z4roI/ZZTAK4scZxB/cnE1MWQ66mBqlUV8Hq3m7A02cgQ1vkNZRtY
         lcA2Hjbg2aYjh1A+mVNdkYCngcYytMqkF1uOMLbZ/RNrY4SU3BPjd9LOuh8OvEcAqHUa
         enHQIPmLOSXv5CGqWfHEfmohouDt1zueqPP71hLsrb4eXeWjzElW2hVkKnLYVf7yRFwQ
         cX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473373; x=1766078173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7slVLIofatSoTo54gYSEEiPQgSIuIVsTlq2fZY6I/RA=;
        b=Z2sWX4JB4BGCyQuw4v8p47tQmwgjOruWmmBOi3Uw9Fz+1EpJHhui+zSEhFO/TeL2Ib
         N3PQW87TLuLRRreg4dlcCPrXssa9MvtB3oHt/ZC3UQrN99zZ1XoOqXahWZQthfjRPwCd
         WR4NikMzCV5g8ekIC8gdP3uP2s6UiAGoaD5b6E9YwYq8nV0szaPmyEkTJJFpSNmTbdse
         wFI+QkXQUtQDJmJ86UegKF2Ck57ZdfkwaU2xAH9gY1mo7z1GMVlxLVbV6F+du9UEORup
         gvJDqLbhYfQ718SHlCAY6PrTxo90sYy+qBmY8hKs0fqvwOfgFgRm5jLKam20bZmardZd
         Wqdw==
X-Forwarded-Encrypted: i=1; AJvYcCXVM60je1Y/V3QeTZxy4N/oBCDQv95atiG6B5suhU/NfY4FubQC8aawVdr8pzsYmqOeRXvwxj0XofgdO6V0xsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTYj0qPM+K9P9i5OXlMV+Qd1UgvcG1wLPJEIHChOC8NkO+hXQ
	0xO77MT/U6DyLjnuqyaI1DgG0Xz+gQ7GL6PIHXUsqmjFeTUOCh4ThdPqyeQ/+lk1jcg=
X-Gm-Gg: AY/fxX6ss5A3pTbdevx9xivNwVUFE/tYT3nCPCMIp2hC77gJuBaAs9AGc8C9CRazEa7
	vBkJR/oFeKJY4gr3XJmcW/oKEhAQu1dWWHTJ3G700240suBlFuG3TIxhFLBL/YcC7cKArQ5Vy5t
	nAtWp90lbIpQg/ZmBiI/oCHLJ5kuIAlHzv+iGPB6V9qwiz+/Y7LfqPFGVbp8fIiz/n/bHwFGROr
	h5urpTmU6Zd7RWtX3Rl1Aj3vsfl10/qhZD0Fv0NyDA34ArcH19PUzj1sDBPV2disWPKECg2tder
	o6fX9xmOO/U8o8fW+SOt22Ku4c87d8HIvKvC9DQ2MoeoI2PzUDq1Jvsm6gR2GpamqDDvI+OjmOM
	sioIbNdBwRiRRv03g5DRngAB/baAOG6FfGjzwp+dXLPHWfSwMtzu85uhZJCgV0V5sW8smK0ZQ0F
	e6xBKzTdYBd5xFjFbJVayJBGN+k9gGvyuutVU/WRZlxgL33wAkLlA5Q8tglEFVoy0teZy8UC3GQ
	Ag=
X-Google-Smtp-Source: AGHT+IGJvbFZQsknQaRH6NGcKkb8LTeqvHIo6DvlNxlXfRNU3KD3pAM+iHJV5Xd8AsZ/8DUR/5v8wQ==
X-Received: by 2002:a05:6000:2489:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42fa39cf06dmr7635910f8f.4.1765473372543;
        Thu, 11 Dec 2025 09:16:12 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b8a941sm6802514f8f.34.2025.12.11.09.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:12 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 17/17] tpm/tpm_ftpm_tee: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:11 +0100
Message-ID:  <eaf8216e8a6c3dabce5a82be5765d67c66318791.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Svc6/wu5PiStY9NpUW3zypfWEAb+rgVj8zt7WVDcjFU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvxANVuZTA+Vs41/jfUCca0wp0pub3aHXza8N 0dKzZ+eSCOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8QAAKCRCPgPtYfRL+ Tj+NB/9VP2U8NFQ0NoJVMJc3zyFqZ1tv3cfVRRg/zerpzGxs0TU0wiMUcNVrwY/foFivXYxySWi sBBzEr3Nbh81+LLjnzbnBZWMmMlR/LDg1eZEKjt9oRRqblTq9vKa0v2Jw+zGSBVjfHWCWEroVcL Ah0WQompRwLVbSfLGUP50lh/teI82ay9QXe9Jr6R843myqJnsCWcPFMxUOQycE0aHwvXkmyVv5M +Uk45OlbqDsep5AzX+PLGbJu8QgBpdkwDf3qwzB881AWz3UvzneB0Aj7IqtjA3LqayVrwPiatzs uythHyB0xKp+f2PNjUzkiaZYKpKSSugZ3rVhqqVXLMZFQwez
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index e5fbc70b0eca..20294d1953a3 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -169,7 +169,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
  * Return:
  *	On success, 0. On failure, -errno.
  */
-static int ftpm_tee_probe(struct device *dev)
+static int ftpm_tee_probe_generic(struct device *dev)
 {
 	int rc;
 	struct tpm_chip *chip;
@@ -251,11 +251,18 @@ static int ftpm_tee_probe(struct device *dev)
 	return rc;
 }
 
+static int ftpm_tee_probe(struct tee_client_device *tcdev)
+{
+	struct device *dev = &tcdev->dev;
+
+	return ftpm_tee_probe_generic(dev);
+}
+
 static int ftpm_plat_tee_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return ftpm_tee_probe(dev);
+	return ftpm_tee_probe_generic(dev);
 }
 
 /**
@@ -265,7 +272,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
  * Return:
  *	0 always.
  */
-static int ftpm_tee_remove(struct device *dev)
+static void ftpm_tee_remove_generic(struct device *dev)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
 
@@ -285,15 +292,20 @@ static int ftpm_tee_remove(struct device *dev)
 	tee_client_close_context(pvt_data->ctx);
 
 	/* memory allocated with devm_kzalloc() is freed automatically */
+}
 
-	return 0;
+static void ftpm_tee_remove(struct tee_client_device *tcdev)
+{
+	struct device *dev = &tcdev->dev;
+
+	ftpm_tee_remove_generic(dev);
 }
 
 static void ftpm_plat_tee_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	ftpm_tee_remove(dev);
+	ftpm_tee_remove_generic(dev);
 }
 
 /**
@@ -335,11 +347,11 @@ static const struct tee_client_device_id optee_ftpm_id_table[] = {
 MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
 
 static struct tee_client_driver ftpm_tee_driver = {
+	.probe		= ftpm_tee_probe,
+	.remove		= ftpm_tee_remove,
 	.id_table	= optee_ftpm_id_table,
 	.driver		= {
 		.name		= "optee-ftpm",
-		.probe		= ftpm_tee_probe,
-		.remove		= ftpm_tee_remove,
 	},
 };
 
-- 
2.47.3


