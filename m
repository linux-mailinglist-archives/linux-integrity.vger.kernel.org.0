Return-Path: <linux-integrity+bounces-7918-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DBACB6AC9
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A15300E158
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BD31A57C;
	Thu, 11 Dec 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kV367gP4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CF31A04E
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473375; cv=none; b=PnvyjoEXhguy68fK1wWfOzRYM+6o495C6C7KHprzo34EOAjtJsUltOQ1nGcpsmHdub+Q2IXhjZGXrHm/rNDA+Np4AUUNrVsnbi6cf7kmsg8D4iqVcF7GhZZlXAW4z9O0VKd2lXeZu039IAXKexiLmh6mfTK8AXB2Qni4wKlpt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473375; c=relaxed/simple;
	bh=5qNJMJD9NKYLkVk7kOpcgd1zMxW4iDtExg+oTk6DzX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4jG+1Lx9UcWBDNA4hxOKCLi3D6QxY3HVyCTkL8ozrh2wEwhH1qTTTDtnK6zzkrPS6CRURSQ/5N6n+K/ACgl7CRc5HzPtmvQPFV9X8USKvtmocCZ04x6bDM68879uyh7kwcEhHquc2e42zUzgTa8f/HZif8V+3rj6m3PYmIhrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kV367gP4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so3493955e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473371; x=1766078171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBhu1Uqa8RVHn7QCjomFckovl/MFhjzqjW3Qy6nBbgQ=;
        b=kV367gP49DVkUnjW/zWuUTaSsJWrDNoHGOwZiqikhZmOAqBT8WJQzw3kGCMpfW4XQI
         pJiuwlHeoCI//y2GRN058R7rt0R2Gjnnb3FIsAXHMe67qnLDB8bB4oyhrR1KIO9ljHVo
         Rck3eix67N7xoZG1RpH4xEKrrnuvKWVbpOtSIYAgH7XgIx9Eiryq2q8RIIUCD0ADcDXY
         yKbBsAjlTEuenxdxzCkatiNMCC8dBra31PYwhjrxLVczWMgAR6gVglKcSJVsZatOG5eu
         4qjEK6qIBqjzssRK9rtPI5kKNTA35pk13UBloaGDEjN9pVZd2cVi1ifToghOYzBC5+T1
         JrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473371; x=1766078171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBhu1Uqa8RVHn7QCjomFckovl/MFhjzqjW3Qy6nBbgQ=;
        b=Y3PmgjxjX/dPhQAG90/H2NiOXUAvavbZGQNEtPz8rTXNmz7bjvLYjKdw5IXMxcoSKp
         Ou0BrGuo17MCqz4vNoBc8uxMqQNXYl9HDv3V+1V/DWuZ1lW7IFSuDrriwj6O9Pnvjk7/
         7FHOxKZFIKOi6nP89r4PJWdQpRySBniryEksx0oM1xC5OQas4M7W0Yr6QK1McZzkHyGz
         dLu77Ik/xTsyF8/ipxSHR3/O4ppZRmM2cg4GWGT07Hy+zlqUpPGRkSaIwrzcmK3KtwZo
         78FGzxvsoPD+StC1Sj+p5/vLEBzZtMn8vxy9GHMMXhxmwWxhh7dOgkEx72dMh7/t8Vp2
         DTwg==
X-Forwarded-Encrypted: i=1; AJvYcCXFV6Do9CQ5qExl+ISs1rT8cb5LfqLQsGMmL/IGKd+HrYPmpVLgacRw1TbU20s7iKxYifCSehmvMihytMzijrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1D6h+PX0deTwbfvsEjJJF6lU/V3if2NKutpyxtAMKz6z8ADe
	vd+osWKtQsx5XFNQW+qHlr2OqBQ5SKRXwYNmJWD2Y8P2kHXaB97BINOxfyYmU9jrqci+vkK3+QA
	u1cpT
X-Gm-Gg: AY/fxX5BZNCodBeFS/4P/dr03rMcdc6KjZ6I+59+m+TCNhIoOU7njtHX/H8l/beQws/
	EW4DOwHfDHjOrm/wvMSwDHug32oaCRlX5C277v7e69ExV3QT3tpetIUxZUyWlaVnXXJiJn0B13r
	XRCK8T2VZvhJ5hUcoK1gnxAJos6/6P6FzzLsjkueS2nUA6rsaQIBusILIdkbBpDKEN+CMUaL5+Z
	FF2aPfDU0LT4NW1hnIooPwWMm37EOtM8uQix48s0wbwNOF1IVb7H4RmXxDILPh9IrhChovgLiD4
	swBmlXJ3Wof6iTgDUxW1HQnYGWJeZUaCZ/MGBx2H+5LOX9Wq09pW10f/t7ZcAi+NAacSBe/OjnQ
	OQ/MhiKsxF6+eR3FW1FZixBnD4iNlNShFYMo6inwc3RDqHfzcsiQh93XzSpQ4/XYV4W6v/X7djo
	rSVb4km9q94DEEdbWFP61GyCCWls5tjCbhwMnjkkkvu+s51C74kq+TUK4M4M9XMhKgyZL/p+RON
	W8=
X-Google-Smtp-Source: AGHT+IGk45+DhZ6tL02Xp6VckzN+X1jTYMhezBcXnBBMkdftVDcvtciBmncNg6/XCy6IPmPPgrbLng==
X-Received: by 2002:a05:600c:b8a:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-47a83847b05mr75101475e9.30.1765473371412;
        Thu, 11 Dec 2025 09:16:11 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a89f8b31bsm48120115e9.13.2025.12.11.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 16/17] tpm/tpm_ftpm_tee: Make use of tee specific driver registration
Date: Thu, 11 Dec 2025 18:15:10 +0100
Message-ID:  <812e5c580599b27d4f752ba8cfc35ad5371ab545.1765472125.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=5qNJMJD9NKYLkVk7kOpcgd1zMxW4iDtExg+oTk6DzX8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhkyrP7ZRP1fMjFA/WaKg5FDBu+/h0r09x78+ZffZdZXTX K8x3rywk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ/K5n/x8w65hR5gxFs+/u GzYLL+XpyOWJ+hfn4z9vftb2s2XL1hfeEixpKTt0buWjXDHxXelbk46nXLwyr6poXvT2xtqS9hl T1NyyC3deOH33eYneLyW9bPcF81Yo20hdYTD3mbLAI2qG4Xfn/yvcyzl26umo8Nk1r91sMq2Xsd piJS+/VXiansHLype26+RzmPXOi03Wz6/tW1i+2PjcOlmePwKFhbPYP9isfeKc5agau/VyuUlL/ emWkHg9Ad34ZQZXLqafXHT08r8IrWn8sW0Vmu+mJmmEs096+fBOW7qN5S7GphJeHcPI9zeLGR5s tdyd/pNpd+W7gEgO14dTjq/1jVD3LJzv5hjy+pTq2YcnAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

tee_client_driver_register() is typed more strongly and cares about
assigning the driver's bus. Similar for tee_client_driver_unregister().

Make use of these functions.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 4e63c30aeaf1..e5fbc70b0eca 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -338,7 +338,6 @@ static struct tee_client_driver ftpm_tee_driver = {
 	.id_table	= optee_ftpm_id_table,
 	.driver		= {
 		.name		= "optee-ftpm",
-		.bus		= &tee_bus_type,
 		.probe		= ftpm_tee_probe,
 		.remove		= ftpm_tee_remove,
 	},
@@ -352,7 +351,7 @@ static int __init ftpm_mod_init(void)
 	if (rc)
 		return rc;
 
-	rc = driver_register(&ftpm_tee_driver.driver);
+	rc = tee_client_driver_register(&ftpm_tee_driver);
 	if (rc) {
 		platform_driver_unregister(&ftpm_tee_plat_driver);
 		return rc;
@@ -364,7 +363,7 @@ static int __init ftpm_mod_init(void)
 static void __exit ftpm_mod_exit(void)
 {
 	platform_driver_unregister(&ftpm_tee_plat_driver);
-	driver_unregister(&ftpm_tee_driver.driver);
+	tee_client_driver_unregister(&ftpm_tee_driver);
 }
 
 module_init(ftpm_mod_init);
-- 
2.47.3


