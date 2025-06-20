Return-Path: <linux-integrity+bounces-6489-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E37AE21C4
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 20:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18A61C24037
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Jun 2025 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59228CF41;
	Fri, 20 Jun 2025 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="FYzt9bfB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E430E830;
	Fri, 20 Jun 2025 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442920; cv=none; b=UGAfh+8+VDhsomC7qdvVZ30SNNaZULUOcqb8ZI9ntRYnlUSXvi1JFf56cUlZAvfjUqJdc+edgqK9u+feU1YgfCEGPjBS6SUXPnoLqdEWM7yJ8VriOJqgr/4me+KUXuTZSIhPXevifLGnFGPUqhBJC/DbOVgRrlVuK1zAQlHFOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442920; c=relaxed/simple;
	bh=t1h/NKkK8cEwtLBeyp2T/WCU+1jO2QeiqWnC4nACPJ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jEKQGebbBhMciy3o9YbIhbP3DtV8wvQT46g29nsWpDl42zSNggXAN7qvBVuAkhJOmuUh791N8L5GeGI1lIqhloR0m8TlDh0+cG2U/TNkYA5O35UOZjAt22KTqpAR8PnqPpQKYq16CuoDNXfHoJmThXskl5QhBeLagNoOvvDrd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=FYzt9bfB; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1750442919; x=1781978919;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GhG7Mn5TeXYPwLyALqxnBg3OgPet0/LmcqQZUQN16cI=;
  b=FYzt9bfBDOELraQ7hPe2jRSz5l5IW4oUwn62KyDgkTAvalC0kXSgjUk2
   qJ9GB6Ms343gjd71GqTCcsO+YJbjySXZqlZu/C8nGufHBEpU/31Y9yhSQ
   ygP9VI1lW4bSh5hTu60ptom90RxGmAxZCvxgb+eemn/aEuD76pMBmkTiD
   V2FPVNL+WOQZf2t2HozjTv6AxfVq3npkG4I640mu4OKxvp6iBEplGvYac
   frR577T0j3EPetm92/YJblSKlCQhi1qIDYS7Mt7wk+pRn8ElDqaB7Kgvw
   fRSM6TAdrtdtlK7FyhHaZFk1s8NjFEUCb+Dxi1/qAUhe9eM1SjGgm7KB7
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,252,1744070400"; 
   d="scan'208";a="512323869"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 18:08:33 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:17959]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.171:2525] with esmtp (Farcaster)
 id 620fb4a1-0951-4c54-ae47-01c96faff03a; Fri, 20 Jun 2025 18:08:31 +0000 (UTC)
X-Farcaster-Flow-ID: 620fb4a1-0951-4c54-ae47-01c96faff03a
Received: from EX19D031EUB002.ant.amazon.com (10.252.61.105) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 20 Jun 2025 18:08:31 +0000
Received: from EX19D031EUB002.ant.amazon.com (10.252.61.105) by
 EX19D031EUB002.ant.amazon.com (10.252.61.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 20 Jun 2025 18:08:31 +0000
Received: from EX19D031EUB002.ant.amazon.com ([fe80::33ef:803f:4724:b020]) by
 EX19D031EUB002.ant.amazon.com ([fe80::33ef:803f:4724:b020%3]) with mapi id
 15.02.1544.014; Fri, 20 Jun 2025 18:08:31 +0000
From: "Orlov, Ivan" <iorlov@amazon.co.uk>
To: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jarkko@kernel.org"
	<jarkko@kernel.org>
CC: "Orlov, Ivan" <iorlov@amazon.co.uk>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "noodles@earth.li" <noodles@earth.li>
Subject: [PATCH v2] tpm: Fix the timeout & use ktime
Thread-Topic: [PATCH v2] tpm: Fix the timeout & use ktime
Thread-Index: AQHb4g5UspHmJE4YYk+ZmPc+YkBqTA==
Date: Fri, 20 Jun 2025 18:08:31 +0000
Message-ID: <20250620180828.98413-1-iorlov@amazon.com>
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
Perform the completion check once again after exiting the busy loop in=0A=
order to give the device the last chance to send us some data.=0A=
=0A=
Since now we check for completion in two places, extract this check into=0A=
a separate function.=0A=
=0A=
Signed-off-by: Ivan Orlov <iorlov@amazon.com>=0A=
---=0A=
V1 -> V2:=0A=
- Exclude the jiffies -> ktime change from the patch=0A=
- Instead of recording the time before checking for completion, check=0A=
  for completion once again after leaving the loop=0A=
=0A=
 drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--=0A=
 1 file changed, 15 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interf=
ace.c=0A=
index 8d7e4da6ed53..6960ee2798e1 100644=0A=
--- a/drivers/char/tpm/tpm-interface.c=0A=
+++ b/drivers/char/tpm/tpm-interface.c=0A=
@@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip,=
 u8 status)=0A=
 	return chip->ops->req_canceled(chip, status);=0A=
 }=0A=
 =0A=
+static bool tpm_transmit_completed(struct tpm_chip *chip)=0A=
+{=0A=
+	u8 status_masked =3D tpm_chip_status(chip) & chip->ops->req_complete_mask=
;=0A=
+=0A=
+	return status_masked =3D=3D chip->ops->req_complete_val;=0A=
+}=0A=
+=0A=
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t b=
ufsiz)=0A=
 {=0A=
 	struct tpm_header *header =3D buf;=0A=
@@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, =
void *buf, size_t bufsiz)=0A=
 	stop =3D jiffies + tpm_calc_ordinal_duration(chip, ordinal);=0A=
 	do {=0A=
 		u8 status =3D tpm_chip_status(chip);=0A=
-		if ((status & chip->ops->req_complete_mask) =3D=3D=0A=
-		    chip->ops->req_complete_val)=0A=
+		if (tpm_transmit_completed(chip))=0A=
 			goto out_recv;=0A=
 =0A=
 		if (tpm_chip_req_canceled(chip, status)) {=0A=
@@ -142,6 +148,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,=
 void *buf, size_t bufsiz)=0A=
 		rmb();=0A=
 	} while (time_before(jiffies, stop));=0A=
 =0A=
+	/*=0A=
+	 * Check for completion one more time, just in case the device reported=
=0A=
+	 * it while the driver was sleeping in the busy loop above.=0A=
+	 */=0A=
+	if (tpm_transmit_completed(chip))=0A=
+		goto out_recv;=0A=
+=0A=
 	tpm_chip_cancel(chip);=0A=
 	dev_err(&chip->dev, "Operation Timed out\n");=0A=
 	return -ETIME;=0A=
-- =0A=
2.43.0=0A=
=0A=

