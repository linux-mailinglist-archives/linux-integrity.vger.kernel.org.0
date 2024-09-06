Return-Path: <linux-integrity+bounces-3492-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714696F966
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB42D1F23AC3
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C631D318A;
	Fri,  6 Sep 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mF+7Bl9/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD747322A
	for <linux-integrity@vger.kernel.org>; Fri,  6 Sep 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640418; cv=none; b=mxjTt/oI4TEgQl4NhLGtaY53NTzFZGF/ORnXavl2frEKuAnq5A4KZOLw2Jl8wMqoviOiuWcs2rdUEbdjIV9MsQ3dovbPuSpJCvRvFR1nhcHNLQyeJCk9NZZXcpuT3/YDankLYcJGAO5Ul2JgXDTFY5eTOayNFk5yP7SEIFuW/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640418; c=relaxed/simple;
	bh=I9FitKu32sQS6CHvjwK/wGygEoj/DAIBEjDdIB8l+C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTv8JIr5y13Ho6mJ5Wgj1/VDA3TAFK2vGm3/QsaCH1QHOnBuUfzSX8z7dZSMwGA1C9tOEqfgM8jkUWTqweH6KfJtJ0ByUSr0By2ueDlNXZf2RqkGqUjARPLWZRXSPu+ophhn8Ske/GhtuATNqru8szVl6oQ2aDsSL4N2+QI977U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mF+7Bl9/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so41709866b.2
        for <linux-integrity@vger.kernel.org>; Fri, 06 Sep 2024 09:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725640414; x=1726245214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LfmJOb/jUm+7E9CUcvrFmOvdVMUS+Zu+g542F26uVC0=;
        b=mF+7Bl9/gWOp4KPpyKBWgI4x4czum4KaZduVSK5WvB7Qm/9PGIWXmu1kFaKaCSJlUf
         NPWp1A98R01/xxjPnOi7uucaQbiWX9nS7Y+1RAMeb2CT92QDFOdaho4MMYil+d7Ajmy3
         496kGW+ca8dbWhDQFeveqtVHhy9D9WUtoorpug5kMmCkjweW1uJA57XO1xXH380HAoS8
         nPYp8XAdXA0G9NcXH1+O39tWfs98swPku0scWG/OkuALOOmXQ9/uxtPbG/ye/f9qs/l9
         TH60444X9nZtq5pcq/K/eKd8mDZjWZta1su89iNOyQ6M+9pzeYgRkA/7kifTUgcUVw+s
         YNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640414; x=1726245214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfmJOb/jUm+7E9CUcvrFmOvdVMUS+Zu+g542F26uVC0=;
        b=g/h8czpnWcJtWJyONWPNAhMw9otfQ+hY3v+eHRj/Eb6nIsPXY+6Mm6LCZk/0NBUKxS
         K196sccH0gQys+uTdp5QKVKQDK0YJ33UPgPkwq5bQeoOpBvWRnYtT0rt4eWFaPvV14P3
         B5PdyEFy/GM/j1/EuXI2nN46zDpPpmFCILO3MrWyYJChHEtzxfGRgumKzQJNLdqbuviF
         EFJZkzRudV9B2vRo9k0kmG1jLDJVP1jaRLm7cm3VM5murQAt3BzBkP7AP5SRqXvL70US
         1QvaQPrbk0fM/aPkU4oI4oFP5irXETowci1GU0smz3KHj9LguG/82SdqrG1IBj1jLvGe
         BgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUW0nrTGWWXhJM1Xcx0vG+fQ4BprBFY5ZpXpEao7j+8rsg8RBgmJrEC0Fv+at1AjQ2N1swBfEPgZTRVeb5MyzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXhGbGjtaiKgJ3CYq8xjGNIRJkHfq8DVlqJ4PVdzQrCpWD+wT
	YOC4B7o0hL8BIpgZtcpOJFtseG0FRwQbhSr4vY1ShMFlbIuEl4lCdOgVWpCXCcs=
X-Google-Smtp-Source: AGHT+IFWSyBL0JGYi5gI1X5ENn5sLmxFPNM801IhUvElezaEQPT8qc9UzQS1LyqxKb6OmdTn5QYizw==
X-Received: by 2002:a17:907:31cc:b0:a8a:7549:2a25 with SMTP id a640c23a62f3a-a8a88667a59mr272522666b.36.1725640413963;
        Fri, 06 Sep 2024 09:33:33 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fbb039sm298591366b.18.2024.09.06.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:33:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tpm: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Fri,  6 Sep 2024 18:33:24 +0200
Message-ID: <20240906163325.321610-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=I9FitKu32sQS6CHvjwK/wGygEoj/DAIBEjDdIB8l+C0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2y7V5AcqoyWa4VJFQjAwbJEE1qbNFlEeYbWwT gmNcKMDW6iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtsu1QAKCRCPgPtYfRL+ Tow1B/96v1OtyI0evFeGDr47TBuE+9OV4qiOz6lar458tuI7pRp1VwY0uXc1hqYoML4Nl3AhQYz px9YKkHpK2Y4WGR1Gp2GqD5tiiJFPoJwjhL8N10fc++DFaxqauamORBnm4vLVT0VFR324LQqRi4 vLfFVR4y6riib2KX9w/7mrWJLfVuXXfeFcvgWDeiPuvKsG42/R1JXUYyVcgiHjwZI6P7mA6vmcJ DNjjhFDZdBCFz1Zzz7rtJqzm1zOEufthJInBDGkgTgam6l45OcSaVjj82SO7HtvHmvg14zd6Hjj D0rEl7r/nkkgSoTSl+MuPPaaOP6X4S4OIl5milsuB+esvEqS
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/char/tpm/st33zp24/i2c.c  | 2 +-
 drivers/char/tpm/tpm_i2c_atmel.c | 2 +-
 drivers/char/tpm/tpm_tis_i2c.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 45ca33b3dcb2..81348487c125 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -133,7 +133,7 @@ static void st33zp24_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id st33zp24_i2c_id[] = {
-	{TPM_ST33_I2C, 0},
+	{ TPM_ST33_I2C },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 301a95b3734f..d1d27fdfe523 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -186,7 +186,7 @@ static void i2c_atmel_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id i2c_atmel_id[] = {
-	{I2C_DRIVER_NAME, 0},
+	{ I2C_DRIVER_NAME },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, i2c_atmel_id);
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 9511c0d50185..6cd07dd34507 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -375,7 +375,7 @@ static void tpm_tis_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tpm_tis_i2c_id[] = {
-	{ "tpm_tis_i2c", 0 },
+	{ "tpm_tis_i2c" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);

base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.45.2


