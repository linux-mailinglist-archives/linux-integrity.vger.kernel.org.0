Return-Path: <linux-integrity+bounces-7992-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA8CBE8D6
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 16:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A92F4300B8F4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F1340DA3;
	Mon, 15 Dec 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YyEfo06K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAC33FE08
	for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808286; cv=none; b=fpJdc/TzxAdoE71qqfMBn7m0qEpQQp6t89AmRmG8WIG/m8msSeXCX0jdOJIdUp8fn39+y+LBeSpWpdDVaGZF0sNUY2//fpYhfDlZVlLVOSeI6g4ICq82VD13GYvIJrq1fTDv4Gj8HFpoadoQfqxIw3GQJgKUwwKwOrg1hxD4gyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808286; c=relaxed/simple;
	bh=sf0K4iIYSb02rL0mKJ9MRRhFzpLL6kAy33jJ54lqjio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BF0lgEDxMb94xvOxEPT1s0d5Ssq1MGPKLtdIOyROokvrN4IWqjwAhmFo7FLkI5qpwlkrF1mxnhSB6v/HrxOtM6meMI0jxAwLIzVNCPLtZxUD9y/rvQ++8Z+gqRZkeYh9DFzDZI08t1z0cpgbZwjDBVVOou5goXnvgWwrJjdrF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YyEfo06K; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7bd8b170e0so399176366b.3
        for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808283; x=1766413083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrasR7kGrYrWNKAZkndazvg9Pq5KLcOmeoZP0wqwfBQ=;
        b=YyEfo06KQ9FnqKvR995Xxgtcqug/8cLhuCA/F6IUPhEHhacHFCu59Ig2tFHpouI0rq
         ocoVR4Pzf9zbY7RvPRRLMeKdL+GuKX+LsmDA90mptdMW7YL/y/8aT1imd/oAAgxcFGQS
         x6msnudDu66fDx3+GSFTe4FJjdvhHRum61AHFOE6tSA/n9yXe3c9zZQdAHXYlql9m0wF
         8hbIkYZNLUvw+hSrJdGHXwfyjetcU55rglPA4gNyBSJOZq66Uo24nKoIf58pwU3pOyTw
         9PdIcVmZ/00l5wOPj36niTVHmEXgwgnZmpZZzgjtT9Sv1Qrn0d6yefh8+pAr821XwgfD
         7fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808283; x=1766413083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HrasR7kGrYrWNKAZkndazvg9Pq5KLcOmeoZP0wqwfBQ=;
        b=ooE6m8b9vmonbOEh9dYG70qw5PR4tU2lyh0UMtVbtB7vyNXT5sZSJJH/rXhUFDEfSq
         DsBkBlEXEq9wRHzybJN+AKTS8Dy0AUpXjP4pLLWf0nk35s9aJPfwPKhTCUBrAI9N3zCy
         WsQUPjCZP1uzqAHZNn7EV0C2ik8BeS3LhiK/MtTaw0A+Ms4LQIcUDcA1N/VARnPHGkGF
         NnKUz89W0ysuT8KDAt26gK7KOczDKEBbIfb0U02Q+pvUNn/Q6AIrCXtGzSaA2yIU5pV7
         s6BZBoN7aHwFuCbjSSxSm2O4Ai/M6WiEp20G+qR5KY9E4Oypzr7ZzFcHk15vHLOhv2Te
         euig==
X-Forwarded-Encrypted: i=1; AJvYcCUhQzgZjJpYmxuoCFHMS4TyGymkgU1Lj0ThhZHeoTcMt5EEqL1WnOXzZ7xbgNPOIyzpTIn2WQYGnRyfBJMsfUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/De82VP1y/RQET82wxs39PnKtOdPe91hjYVI2eT/5XQS6W2V
	cQ6Z4YMZ+gwWbiDe1aEGvl/fzDSufOfqazOKYR+bRRFNDCEvohm+dAjR65Gwb2itohI=
X-Gm-Gg: AY/fxX7ChNM/ojPL77q3NV4w6vFfeE97wejwDGZBkDe3f6JX5pzryR6B0s8ftvBVo9O
	Ft3jJI5qTDCdDWQceIJEQrqOicspLCzqW8omL9NV96j8RQyLj6do1XlaM8E+E0QxMskanFBO5BH
	5Xku2dbaAhGer2YNfKzLt4c4Tcr7akXlZJz8VLUa9nQNurJIv+0+Gww85Jo24vXw7BfYihalHvx
	EZsQFIVHfgKVkRVq3NFDlK4JBVFeRJ7dBE/sCjAsUpuj9n4qm2FVdIouqDjBDUwya4gvdeIbQUd
	hRjpV3acnO6Ws0i4iHnibwiwiqHc33OmhDz6wXFAyC1Ps9vnqO2eSn0fNLH5BHWTCF7SvXQpqAv
	saDT1CvTRsl4xe7jHlogkz2JnNY89XEF8CUruifp2QjShFpc2yTybWflOfNPBUcjT529jDdQ8Yx
	Kdi6Egid7EVDoioWUcV3Rbln2p3AOucy3o5sK66UW5VqtpSkebaKYD3KRH9w==
X-Google-Smtp-Source: AGHT+IHX0m7kbMZvY8tope7JC2GsN2BbWZe1dZGY3zQ0k7S4MMiH/CtKoy5x3794CwzbShUzQ3pDRg==
X-Received: by 2002:a17:907:3e12:b0:b73:54b6:f892 with SMTP id a640c23a62f3a-b7d2356a6b5mr1114211066b.4.1765808283065;
        Mon, 15 Dec 2025 06:18:03 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa2e70c2sm1388507066b.15.2025.12.15.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:18:02 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-integrity@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 16/17] tpm/tpm_ftpm_tee: Make use of tee specific driver registration
Date: Mon, 15 Dec 2025 15:16:46 +0100
Message-ID:  <5c8d6d420338d0d028f785680520d375e8a49673.1765791463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=sf0K4iIYSb02rL0mKJ9MRRhFzpLL6kAy33jJ54lqjio=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhzv7fuyRMHA7lEtOeYNZ6CC9fofHw/mF7L7 AvGJoDhvh+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYcwAKCRCPgPtYfRL+ TvL9CACVhcY+gEOTNpIRErp2w/DR0HVcSHlsZUncxxNqkggxg/NdYhINtrPC7TX2L8c7demb+/3 hngi+GznovcCzmDBw4iVI2Dg0un0NfTmRnrgDJkyeDiZ6YfwLRTMLRUUNXbjbR/X4wkxAOBN3gm +UhKQPDnGZ/OFX2n0KDIDFSkD6jm2bWwseMZcWgrX9UV6KqrMa5ruNDfjvi1Zk88xofINe35S4y FpC9jQzdzGcU1qIOrSjQ5/6lEhZQMETearZ0GAS96ED1elqYF4XjLZdtfV+Rw2Yec1AjqscWGf0 YKd7cQr/XDBJ27pKG7mgv0+wsPyUalXZWHOBsd5AN1Ja8QAf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

tee_client_driver_register() is typed more strongly and cares about
assigning the driver's bus. Similar for tee_client_driver_unregister().

Make use of these functions.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
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


