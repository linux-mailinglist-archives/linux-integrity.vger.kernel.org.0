Return-Path: <linux-integrity+bounces-9591-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFVcFjoYC2o5/wQAu9opvQ
	(envelope-from <linux-integrity+bounces-9591-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:46:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF456DEF5
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A57A2302F247
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B7B846A;
	Mon, 18 May 2026 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Nizw3OgR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B184481A82
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111645; cv=none; b=bi4uLiXDeQ9qjcHYBHmuhnLQSYQEw9Fr1hOSykCqYbzPIcISHZ1RTpTI9EAitoOAlK7shcFgku+Caj9sqqRCXiuG8THGqpSch+VUZBTDrs5QbkTAss13/rO/rhOs3bOdaEtJZRCzi7gxBmR4bDXUkZxoVL7jfi/DB8BMYSoCEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111645; c=relaxed/simple;
	bh=ZhXkY/aFii0+a1TkYz4GJmkLr4kAHKio/rEJc4mD+jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kTIqqxNbPm5hNrKaPDCChviyYOKLFp65eQF5OvdBRgy1k38SpddjNq+nCHGLfdJ8+sgq8bRkRm8/M29pwdmenpg43S8jXuwxn1MHwD1B1bsG6xXhTy50JaRDsHZpkBXFhcw8W2s3JMcOQbuLZDS2ULmRA3/jFODA4hBdp6zIZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Nizw3OgR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso13685705e9.1
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779111642; x=1779716442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7e3Kv37qN46FabbuNjAXyfnvvC90X5GgaD4rjhPUgYk=;
        b=Nizw3OgRYO3TyT6GjlgnPltCwgHQTUFVxe3pWHlPE7vc5IZ8MrTxNtl7IF/I4J3HAg
         xRuZaSA7cB+HG0xipcbxEmTHIGC+6apxrHwKttHNF6SagjprR3J1n1Qwq4aNZyrqsmEa
         4Z50tewql2XXTB21Pja6tqS3S112L0mvM6Nvuj4yjWBpQe9frnHeG+IZEb48GpDHbGhS
         SLuJ5IyXT1GH9HEzIXt86D6poJ1mxUSv85cmlWM8Tm908R6jlqDTMdszVmIgVrxuvr0c
         petabHJbMDQwpfNne+VWXwLmtp8+rjwe87cfzy4J30vGxdgQJlgzbGUA8+Tpowq2r4b2
         2QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111642; x=1779716442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e3Kv37qN46FabbuNjAXyfnvvC90X5GgaD4rjhPUgYk=;
        b=qQq+UnV0QSJmy7QS7vboG+SNmALbhFLK3NNKP3NylaYi2utZxG0ChvUUF+CDzPO8Vr
         hAeSDMYuKlhMzyuaDGOdG8DIACg0G9ghkUt0+/czsuKcHgjCkqJtBgrJZn621F0rURHz
         Yo+2U9s1rQfstNVbZnZoViUB8eJ9qAi6EMUCQ6P8NyQl7piemPeExX+SPmgjAe1W3sOw
         QrHa7bKsdqU32N07ADvk33OXxpDHpFmtKPFUF5wtNtxec1RxtaLbouxUSono28tOuYzU
         Q54ptCEVi6bDE/Sn9TWsGEkJN3rNh0IJlcAc/OnlIr2XiJk2EbEgCSiAqb1pog1cq7w4
         a1lA==
X-Forwarded-Encrypted: i=1; AFNElJ+soTMLryL0e4L/7HAS1566D1ZaSUiH7napSb7KYkYfe6e1YGYcyUxYdOgu6Lg3OQh1tcDEG8/j2C3xCNjEcQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6QFrss7V77i1mYZ4Cemn0V0dKNtbt5nlaRCcYaiL9w3A5Hpm
	woKeC2tMFIyhIvTGoHNkizFH76Hof68BG0vVkY3xlU4FZ5RxUn51pBVlJmbqOxyDoNQ=
X-Gm-Gg: Acq92OFrNKsPk4qx2jok77n8rXY6xrgFoeixQCri/yRQdXBkoYIS7XZ6ufUaa2t+gvP
	RX4pajr/jkhRjdpkMwU9A35vbbcc0sKwF299bBFN5Kw8nbudiWIz943wQXvA/ODKbDQCbrbWSQ5
	X02ggS3b9FVGB2J9i6uPBUm/nbBvnX4Q6a+WOHyaMG1cUl1xff0Uwz5h9fk0JZnaruJmNNpl7Ic
	jDFhEer8RiEifxNPlOtlUVl0BsRZSmAER0ongyVNKt/RPnF6stER+HRT5c5uxeSTR6n8tzUe8hI
	a49v5nkjTrtvzOSUwy7AMm74Ess3n84Wy77ZLNqHfOn4zn51CCeqk1tQjnksTP8AvYNhipMDSv1
	FL1a1XirFUGc3RlJhyElk8OoiJWzhMaTfJsJCeO5VKUhjo2iHy/u0/tIeJnA+P3kJEbLkb3xI/f
	zslrRga71J9XVGu2xJ+NKsVdhH0BYd9aY186lJ+x3hM6Cu6UCjT8ukII2IxYm83sHA66VzwZ28a
	hax220QX9+pfQ==
X-Received: by 2002:a05:600c:310f:b0:48f:d346:e646 with SMTP id 5b1f17b1804b1-48fe60d5693mr214937675e9.10.1779111641728;
        Mon, 18 May 2026 06:40:41 -0700 (PDT)
Received: from localhost (p200300f65f47db04e77777300859e43d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e777:7730:859:e43d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe5694fcasm237673935e9.5.2026.05.18.06.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:40:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
Date: Mon, 18 May 2026 15:40:35 +0200
Message-ID: <20260518134035.644762-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ZhXkY/aFii0+a1TkYz4GJmkLr4kAHKio/rEJc4mD+jA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCxbU++qQEdVaxAqo/8l8BQ0m1/2K1bb2i65eo qF6fugk1RSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagsW1AAKCRCPgPtYfRL+ TrOKB/9Qnvwl9/SiA5vvgWwnsbHhSW0UoB2wS3555Lw+bx2OvdqgUUfwPv2Wl83ezwUy5baG9jc sjKYnXluTZipV+XqrNg0AoX6yd/NnTmDKWzofkIrqCLQKDKurQsQvQeE07ON2Z151MNO5D2vAf8 APac63DA6DULCt0j6ZGSR9IqIw6XLfPwa42EyxRZrpkruPzj8H6KiMXEYqzHQeEu1+xkVte4jOF oy8IuE+gKVfLdECDbpsmZ9jb6gDYOIyeAMi8yIRLlv6LqhixPiV2+jkhPv2M3zn/V0A3xymIxJl scgKrn9swWQF9D1C11/36T0aYFNTsyw6N8mB6UEdSQwh5bhk
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-9591-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:mid,baylibre.com:email,baylibre-com.20251104.gappssmtp.com:dkim,cheri-alliance.org:url,lwn.net:url]
X-Rspamd-Queue-Id: BCBF456DEF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {

	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..dfb0b07500a7 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};

	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
	 	{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
	 	struct regulator_config config = { };
	 	struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a tpm driver that benefits, so this
is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/
---
 drivers/char/tpm/st33zp24/i2c.c     | 4 ++--
 drivers/char/tpm/tpm_i2c_atmel.c    | 4 ++--
 drivers/char/tpm/tpm_i2c_infineon.c | 8 ++++----
 drivers/char/tpm/tpm_i2c_nuvoton.c  | 6 +++---
 drivers/char/tpm/tpm_tis_i2c.c      | 4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 81348487c125..74b25af5ce79 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -133,8 +133,8 @@ static void st33zp24_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id st33zp24_i2c_id[] = {
-	{ TPM_ST33_I2C },
-	{}
+	{ .name = TPM_ST33_I2C },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
 
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 9fd73049821f..6891642a7f51 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -199,8 +199,8 @@ static void i2c_atmel_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id i2c_atmel_id[] = {
-	{ I2C_DRIVER_NAME },
-	{}
+	{ .name = I2C_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, i2c_atmel_id);
 
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 8b7d32de0b2e..29cf2f998405 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -664,10 +664,10 @@ static int tpm_tis_i2c_init(struct device *dev)
 }
 
 static const struct i2c_device_id tpm_tis_i2c_table[] = {
-	{"tpm_i2c_infineon"},
-	{"slb9635tt"},
-	{"slb9645tt"},
-	{},
+	{ .name = "tpm_i2c_infineon" },
+	{ .name = "slb9635tt" },
+	{ .name = "slb9645tt" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_table);
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index d44903b29929..71c59eeaccab 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -624,9 +624,9 @@ static void i2c_nuvoton_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id i2c_nuvoton_id[] = {
-	{"tpm_i2c_nuvoton"},
-	{"tpm2_i2c_nuvoton", .driver_data = I2C_IS_TPM2},
-	{}
+	{ .name = "tpm_i2c_nuvoton" },
+	{ .name = "tpm2_i2c_nuvoton", .driver_data = I2C_IS_TPM2},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, i2c_nuvoton_id);
 
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 6cd07dd34507..21d66bfba6a8 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -375,8 +375,8 @@ static void tpm_tis_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tpm_tis_i2c_id[] = {
-	{ "tpm_tis_i2c" },
-	{}
+	{ .name = "tpm_tis_i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 
-- 
2.47.3


