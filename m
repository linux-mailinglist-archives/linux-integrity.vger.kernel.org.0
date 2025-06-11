Return-Path: <linux-integrity+bounces-6414-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A822AD5C0B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BCE3A5699
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DD1E835B;
	Wed, 11 Jun 2025 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="hOzaqiUH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26431E521A;
	Wed, 11 Jun 2025 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659134; cv=none; b=mjTuU7ShnNih57+31Iau61/5is0V5MqkALoqSrTgsbU3KRzVAvT7LyeOyH1HMszZ/m+aQJlNuV3bEJd79OPWYYbQZFskyrn2MchvWahDuHsFFxE6tD5EHVVc0g2KDdYJlhGJVOTqkkSqt+pvlTpksR3u2Go96L1lPXv9J+WpY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659134; c=relaxed/simple;
	bh=aBTVw3PuvJo5z3eN/AQeqvV+M+Pj0uGtLXlCNtG97ow=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hfQ6zy4F/BWnz392RYHaLlT3mR+KrJZ3ePB6dCejelaUal6bZIS2bETFRdzgyZAB2ytjIeMfTQnI3CJLOI8dEPfwEi98br6yua77XQVeHYk+WhK9WaZjJgFvQ9DHcNiice8NPFGp75BRTGeAmlIp6n84IppFXeVDc61Up/LgkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=hOzaqiUH; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1749659132; x=1781195132;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zxipZaSvMF3rLRe+Je24orldwQjdEfGflisvDibgi1E=;
  b=hOzaqiUHrA8TUdCI0V7kW+/9pz7oe9g8ujLEnkGLhswstlMd8ssiYREy
   vmt/nm2ra1/1YjYYLzmJ7jHnB9A6jfTuj7Vxk2Lgum+blm3+KhuB+V0r0
   U12WA/7G4RxR+5G3lkJdi2WSKuHIxsw0yg8bu9a0sf6VWB1hHn+lO+FcT
   leiYm3uUYf3bwCi8T/SPlJPAPjALKRCeP4S4teT92y/u/qA1RIcg8kpPM
   MWnJco3kJg/Sz9iIL+4KtQFu65W3biLgLaPTQ9ImQ+EidofapR0+/+tAk
   MUNIxFiK4onZ1aMfVomuqpLDaEJXHSrvm3GuOy8+2A9YGIXefWihYzth+
   g==;
X-IronPort-AV: E=Sophos;i="6.16,228,1744070400"; 
   d="scan'208";a="754326538"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 16:25:29 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:28764]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.229:2525] with esmtp (Farcaster)
 id 1a0bb186-a9d1-4c9f-9181-3be1f035e32f; Wed, 11 Jun 2025 16:25:27 +0000 (UTC)
X-Farcaster-Flow-ID: 1a0bb186-a9d1-4c9f-9181-3be1f035e32f
Received: from EX19D031EUB001.ant.amazon.com (10.252.61.29) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 16:25:24 +0000
Received: from EX19D031EUB002.ant.amazon.com (10.252.61.105) by
 EX19D031EUB001.ant.amazon.com (10.252.61.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 16:25:24 +0000
Received: from EX19D031EUB002.ant.amazon.com ([fe80::33ef:803f:4724:b020]) by
 EX19D031EUB002.ant.amazon.com ([fe80::33ef:803f:4724:b020%3]) with mapi id
 15.02.1544.014; Wed, 11 Jun 2025 16:25:24 +0000
From: "Orlov, Ivan" <iorlov@amazon.co.uk>
To: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jarkko@kernel.org"
	<jarkko@kernel.org>
CC: "Orlov, Ivan" <iorlov@amazon.co.uk>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Subject: [PATCH] tpm: Fix the timeout & use ktime
Thread-Topic: [PATCH] tpm: Fix the timeout & use ktime
Thread-Index: AQHb2u1uqkNjG78d+ECf34VMuAYsKA==
Date: Wed, 11 Jun 2025 16:25:24 +0000
Message-ID: <20250611162508.85149-1-iorlov@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The current implementation of timeout detection works in the following=0A=
way:=0A=
=0A=
1. Read completion status. If completed, return the data=0A=
2. Sleep for some time (usleep_range)=0A=
3. Check for timeout using current jiffies value. Return an error if=0A=
   timed out=0A=
4. Goto 1=0A=
=0A=
usleep_range doesn't guarantee it's always going to wake up strictly in=0A=
(min, max) range, so such a situation is possible:=0A=
=0A=
1. Driver reads completion status. No completion yet=0A=
2. Process sleeps indefinitely. In the meantime, TPM responds=0A=
3. We check for timeout without checking for the completion again.=0A=
   Result is lost.=0A=
=0A=
Such a situation also happens for the guest VMs: if vCPU goes to sleep=0A=
and doesn't get scheduled for some time, the guest TPM driver will=0A=
timeout instantly after waking up without checking for the completion=0A=
(which may already be in place).=0A=
=0A=
Instead, perform the check in the following way:=0A=
=0A=
1. Read the current timestamp=0A=
2. Read the completion status. If completed, return the result=0A=
3. Sleep=0A=
4. Check if the timestamp read at step 1 exceeds the timeout. Return=0A=
   an error if it does=0A=
5. Goto 1=0A=
=0A=
Also, use ktime instead of jiffes as a more reliable and precise timing=0A=
source.=0A=
=0A=
Signed-off-by: Ivan Orlov <iorlov@amazon.com>=0A=
---=0A=
 drivers/char/tpm/tpm-interface.c | 15 ++++++++++++---=0A=
 1 file changed, 12 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interf=
ace.c=0A=
index 8d7e4da6ed53..959330212a16 100644=0A=
--- a/drivers/char/tpm/tpm-interface.c=0A=
+++ b/drivers/char/tpm/tpm-interface.c=0A=
@@ -88,7 +88,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, vo=
id *buf, size_t bufsiz)=0A=
 	int rc;=0A=
 	ssize_t len =3D 0;=0A=
 	u32 count, ordinal;=0A=
-	unsigned long stop;=0A=
+	ktime_t timeout, curr_time;=0A=
+	unsigned int ord_dur_us;=0A=
 =0A=
 	if (bufsiz < TPM_HEADER_SIZE)=0A=
 		return -EINVAL;=0A=
@@ -126,8 +127,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,=
 void *buf, size_t bufsiz)=0A=
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)=0A=
 		goto out_recv;=0A=
 =0A=
-	stop =3D jiffies + tpm_calc_ordinal_duration(chip, ordinal);=0A=
+	ord_dur_us =3D jiffies_to_usecs(tpm_calc_ordinal_duration(chip, ordinal))=
;=0A=
+	timeout =3D ktime_add_us(ktime_get(), ord_dur_us);=0A=
 	do {=0A=
+		/*=0A=
+		 * Save the time of the completion check. This way even if CPU=0A=
+		 * goes to sleep indefinitely on tpm_sleep, the driver will=0A=
+		 * check for completion one more time instead of timing out=0A=
+		 * instantly after waking up.=0A=
+		 */=0A=
+		curr_time =3D ktime_get();=0A=
 		u8 status =3D tpm_chip_status(chip);=0A=
 		if ((status & chip->ops->req_complete_mask) =3D=3D=0A=
 		    chip->ops->req_complete_val)=0A=
@@ -140,7 +149,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, =
void *buf, size_t bufsiz)=0A=
 =0A=
 		tpm_msleep(TPM_TIMEOUT_POLL);=0A=
 		rmb();=0A=
-	} while (time_before(jiffies, stop));=0A=
+	} while (ktime_before(curr_time, timeout));=0A=
 =0A=
 	tpm_chip_cancel(chip);=0A=
 	dev_err(&chip->dev, "Operation Timed out\n");=0A=
-- =0A=
2.43.0=0A=
=0A=

