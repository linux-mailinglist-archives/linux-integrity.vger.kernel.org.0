Return-Path: <linux-integrity+bounces-3473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B396E9BF
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 08:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8737285E8C
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3313B584;
	Fri,  6 Sep 2024 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NZDnBLEv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A62224D7;
	Fri,  6 Sep 2024 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603007; cv=none; b=QdFcee/b/8lbhXH67e4aVErXGl/Kq80Y/oDI10f6xDpbH13W/G2DCp7fBOanuGI51sl4ib3pF0Rstj/2Zc+pT3fJxA0dZYEpBO4dReYULjkglUruJ+zy24ymJINPrRdbsk0P+TEg5R4S+8c8KrkUTEr/iiW1razJAkVAm+T2rvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603007; c=relaxed/simple;
	bh=lecfhukrHUWAp+GZ93B56Tr7Zso06MRPZjsNqjMukKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tiC4TZ6eRX14cgbbRgmUgrXeZ21tZUXn6BzzsD6vnCp4w1bdQTK+lDUNTvqJmv9BnvgYItncUWUZCYpHDVQfkOgrHpovh9jrwC2ahXTCrVd3TBpqxZrl6ZJBkzkC6j4Q2xDciTMN40eprVy1vq9P6WZ88n72pvGZV16rysT0qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NZDnBLEv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725602996; x=1726207796; i=wahrenst@gmx.net;
	bh=+XbPJ8LsOXG/b/TRXHeXh1z/5ZeRbhx7UZWUzuL3bms=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NZDnBLEvxVV/T581ERw2VtvRhlvOzYERU7uqQqPpfp+fsTM/ikrbdIyX+hfgjC8W
	 FoPa2C7V6xd/s/Z6AiL2dgz5ozdRCsAudEo7j4c5g4hnsi1gL6qzOH8hs9S1kwWfO
	 UhIScjBLzDb07kcFSY8du5bdapd5bt3VA9u50Se/piForNc0G8stEaU/ERNPQ3/ko
	 KQSpUtp9VsMgMO6CUtydjHvPMFWY9E74X3tV/AfrZbHhLqOHIpzRxuiII9JPCMAG6
	 9rabHqxUq9nQlp5SECF7qHKXt5XZvfE78HcS57InYFVzziZpyLWzNyEfMjFRDg36X
	 t0oYfvb2nDb4SeXR0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1s3aJC3Gur-00veS3; Fri, 06
 Sep 2024 08:09:55 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC 2/2] tpm: tpm_tis: Provide error messages in tpm_tis_core_init
Date: Fri,  6 Sep 2024 08:09:47 +0200
Message-Id: <20240906060947.4844-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906060947.4844-1-wahrenst@gmx.net>
References: <20240906060947.4844-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Prv4qvya/RrWQwDEQS03tjIOD8eqxAwtqxHmk5hipQFeIJya5yW
 mD9xMvaE/OBqrIsIeYKtusiYH3KTx/RF5WP7oS2Vip/NO/BN57z4RJP6X9BWFm6lVzJwLWt
 oFg2wgDUmoC6yGD4IDN9fEd7GFRtrXW14SW1GfRZw58B8ufoHx9TNnGD1K6aSU4MF95PMW2
 +nBKJuCJA2PgybF5FK5iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zIh6P9ax0Qw=;6M2nEot+SGZxbhBbYXQ8VJe0TD0
 k4/nn3dImJq8+NO1PG5Fxd49e5tHys3SNMC8ayulR2rU9yZLJc45HM+B/8fF6C8BZPgSDGxL+
 OyQugzyhaLpwckbHNx7MzDSWv2lEeeoNaTeD35id8XyZXDWZJ5bX26b7HzeBCnOPbWTY4mgzl
 /1tjjLjFCHRCfnB6IuQalK5zXv1YIMQ1o9y8dfyczAChDFhGWsIWcMQOq16PjD4jci4FDuTMy
 AX2l5QhiFEeI0Inkeec56Rawph/bLtlkpMlfU1y+ABUJsVIhI0v/0ZSjZft1wuLU8L/cAvKv6
 LLsj0uNzD/ENtfJiNn37gWr0zZUBWfN/k7JsDjsd6J/eIcMZv0mTmfW8XD1ooPE2uO0XUWqpa
 yW4aIt/v0bKcbK5NLri2n+U5q42D3TTSAMF3E+4CbF92VDYIbIWRsAfjSZ/ElUoxQ7vlasuUC
 hdExU1FxSYcWfP9fbv+pL/QSU4vlX7iuLVqVO/YX6TPe4WGvaiumWN2H+cFqMMdkXYBy4XcHT
 91bI6uvbnplC8yLBJTRQ1wEHwPj4vBa4PxTJHfQSCPyWXcZhP0aL3yzjj8QpCKD8WqejLMXaV
 I+ka0wZUXrJ6aRexI+7HZ797LceBOBXkhiWCO7SAtOE5EHmpPnwgjq/rgDiuoOEL0o3CJeTuq
 LiwFTmM7HBiB8ykF18jfY7097NKN6dGSP5bOCTVyKZ/59yj6fArzEVT3O+ETz0X2wJRL8YYNc
 p7kb1hqx3dEMpBErjiMTm0Q4JsaVbStuGUFA4ata6+C7D4zXjMkdywsX0AQxoqhFXUfGHWKtA
 JWAZox0l/Ljdt01yn9QZhaOQ==

In case of SPI wiring issues (e.g. MISO pin permanent high) the
core init won't provide any error message on failure. Add some
helpful error messages to tpm_tis_core_init(), which helps
to better understand why the driver won't probe.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/char/tpm/tpm_tis_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_co=
re.c
index fdef214b9f6b..830e331fcebe 100644
=2D-- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1133,8 +1133,10 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
 	dev_set_drvdata(&chip->dev, priv);

 	rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
-	if (rc < 0)
+	if (rc < 0) {
+		dev_err(dev, "Failed to read TPM_DID_VID register: %d\n", rc);
 		return rc;
+	}

 	priv->manufacturer_id =3D vendor;

@@ -1162,19 +1164,25 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
 		chip->ops->clk_enable(chip, true);

 	if (wait_startup(chip, 0) !=3D 0) {
+		dev_err(dev, "TPM device not accessible (0x%0x)\n",
+			vendor);
 		rc =3D -ENODEV;
 		goto out_err;
 	}

 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
-	if (rc < 0)
+	if (rc < 0) {
+		dev_err(dev, "Failed to read TPM_INT_ENABLE register: %d\n", rc);
 		goto out_err;
+	}

 	/* Figure out the capabilities */
 	rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
-	if (rc < 0)
+	if (rc < 0) {
+		dev_err(dev, "Failed to read TPM_INTF_CAPS register: %d\n", rc);
 		goto out_err;
+	}

 	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
 		intfcaps);
@@ -1209,6 +1217,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm=
_tis_data *priv, int irq,

 	rc =3D tpm_tis_request_locality(chip, 0);
 	if (rc < 0) {
+		dev_err(dev, "Failed to request locality (0x%0x)\n", vendor);
 		rc =3D -ENODEV;
 		goto out_err;
 	}
=2D-
2.34.1


