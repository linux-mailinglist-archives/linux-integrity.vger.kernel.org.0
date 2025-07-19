Return-Path: <linux-integrity+bounces-6654-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0CFB0B1B9
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 22:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7280E7A1D3D
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1221FF27;
	Sat, 19 Jul 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIZCNDL8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651331422DD;
	Sat, 19 Jul 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752956029; cv=none; b=Hv704P4sDIkV1VpOD0nGwQWe/cj6sJdMrBeO3bMwybjcRjV4ziM6UfyXry+MY4ckRNWKTw7ezVIMyJ5TY11dwIvENivf12hsfHE667+OFb4pwmYwVk8OclE0LicXHdD4jvKZ0tn1DH7NjeVbMH2+PUDHxqHgf7MjN5yBamNhlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752956029; c=relaxed/simple;
	bh=BJuiJFxFWen1mX2O9kqsVBAVZ9G5deeY8gE9u2WXPQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8620LmjFPn61rZ1a216lL7II1+iclzaSrCVmhNrItaa02O2Nuq4uuhUoymYvGdY3unbY0NlVrBJnRfZ/uYaOCwoTQgJt8A8xf5WUXGezh07YmMf+yOdZPP6jOb98I/hTgN5/TBqvN+SjOpgmyDOJmE5xxfOQCx9aflVjrTaMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIZCNDL8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b611665b96so1735873f8f.2;
        Sat, 19 Jul 2025 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752956026; x=1753560826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=in+3wMalymhyd0mcNEzfURo1USS+50XS18ZabbbVbQ0=;
        b=TIZCNDL8nu+KPtrtz2CjYT+TJEl0FckFq6h3pW6vnEpTD9/owZTnBArepm1xJmg3IB
         xkiwMipHrhED34CXAQRtzrf0QPM14pvD5qWSxwRaUUzzn4BhcAtaOUB2tLl32f0cP6ZL
         VXniN6GmEgxKoF5LvizFE9enk+alWOKX8peyVjGVrqhE9gIVRPNIYT+8LSTX/+opiOs5
         KHGzKeowkJhXEx6cPNEwox1zXDZfP8UeMPUVAxjjUd4v1rV2DPZa4pPm4GoWicQI2Khm
         UlOpXWMyeo2W3YnHqFeVv7TUKK0MP+iMYW3w5ZsthWDwFaRmrfgciu64autLtq6r4R2Z
         WJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752956026; x=1753560826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=in+3wMalymhyd0mcNEzfURo1USS+50XS18ZabbbVbQ0=;
        b=drmwUr7lVnVS4W0CLAx0/y/Eq98wsT8BvZcgWgiJ12PXAz9Xe4sWV47+6wvBCLeXwG
         tlD1o+r3w4AsyNOkSK/S0C+z9mEhpe4PZjKf87Owc59LAlmtDy0ocfi5vNA1TtPmmf86
         Ia730Dpc9NzcZrhq0pc8kh+oIw2lDh0nTS+xslq6P5l5/qyCXysIk3ISkH1qKv/xRkYt
         XRllO6TZNpZ0zpy5z7s5sBBoZvC2sT3eFGu/3u5mcE3Jgc8pll9lCaz84JVvqivA9WZk
         KBhsqmPudzUv262SAieVGON4nCv9c1Vd+4Pjt8SvY1TozRhvgv+oNZQhm2Xd0/42cY49
         eVxA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8yA/LRs2ttGy7PiAZXRIpsCG6YdlSXb2+Vc9el76iR4Qg6s9llYOlHSwPgTauNW8HYVQ/+zLOe+77Fa3@vger.kernel.org, AJvYcCXzR4xdolqaK+D2ANApcEP9Ct4Y+UhI6d6jl/fBwYbubWk9MBCAEdjPowdXJS6wbDuim9ZdpMKfsQRInxnBtXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTbpu+laDBm/uzH0HfMz0FI9egKR9lkiwHBol3/Gb0ecZ8BKz
	BITYcoNCZU7x5gK3MZJ1c37B26XiEJuvCE+1Sdt2K7sWLp5w9TdVEeLAurB2U8PJhkU=
X-Gm-Gg: ASbGnctExvU7Fqouo9zZPgydOJb3Fzo8Un7LRVe+DAqjHCA6fIVYbwL3kG34Z99Xjgt
	468SBXGHRolVK0Gy6z9tNepksSzSPWulEzIRngU9ACLGIhwksD5Sph5m+K0dZWg/x7d3lsMzPkj
	2mG8Wa6UVVxvdru7kjAmojrRdibT7IMiUy09zuN7wiHjSrxGk3GxkJY2V+oWzAOna+cMad6Ybu3
	T1faTyQLIuYgXQK6btck7es1cFQn66l65jX7bh5B5oxV4sQZTyRfbAVeJK2d7uxAFp3HcQ58BAE
	zMnQZYFjHyGIqPzlkRcnz9NIMLk69iEtOmCd2PavPRcEILQjCvxaeMcykTU+AfgmE6PFY3oWCgD
	OMd2IwX29Z+HjSJsTwH/1lsiu8Vdgi1WJWwan0OyriHNSJLMO7QbakazBlq0w4u/vGD93NBAFiU
	Z7UT1uHos4I6Wb6JbiW3FAQ9LWYXaNdBOp1CyN2GEpbSHoej9X
X-Google-Smtp-Source: AGHT+IEeVEAp37YnmoMBm7w59WNgzIG7isklWQTZZWVzH29omb+dgi0uRxWJL8sxVIM9C8IO8+tt+Q==
X-Received: by 2002:adf:e193:0:b0:3a3:7987:945f with SMTP id ffacd0b85a97d-3b60e5242a1mr13227365f8f.57.1752956025568;
        Sat, 19 Jul 2025 13:13:45 -0700 (PDT)
Received: from ip-172-31-24-186.eu-west-1.compute.internal (ec2-18-202-80-98.eu-west-1.compute.amazonaws.com. [18.202.80.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm5674576f8f.58.2025.07.19.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 13:13:45 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	iorlov@amazon.co.uk,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dwmw@amazon.co.uk,
	noodles@earth.li
Subject: [PATCH v3] tpm: Check for completion after timeout
Date: Sat, 19 Jul 2025 20:13:39 +0000
Message-ID: <20250719201340.24447-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of timeout detection works in the following
way:

1. Read completion status. If completed, return the data
2. Sleep for some time (usleep_range)
3. Check for timeout using current jiffies value. Return an error if
   timed out
4. Goto 1

usleep_range doesn't guarantee it's always going to wake up strictly in
(min, max) range, so such a situation is possible:

1. Driver reads completion status. No completion yet
2. Process sleeps indefinitely. In the meantime, TPM responds
3. We check for timeout without checking for the completion again.
   Result is lost.

Such a situation also happens for the guest VMs: if vCPU goes to sleep
and doesn't get scheduled for some time, the guest TPM driver will
timeout instantly after waking up without checking for the completion
(which may already be in place).

Perform the completion check once again after exiting the busy loop in
order to give the device the last chance to send us some data.

Since now we check for completion in two places, extract this check into
a separate function.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Exclude the jiffies -> ktime change from the patch
- Instead of recording the time before checking for completion, check
  for completion once again after leaving the loop
V2 -> V3:
- Avoid reading the chip status twice in the inner loop by passing
  status into tpm_transmit_completed

 drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 8d7e4da6ed53..8d18b33aa62d 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
 	return chip->ops->req_canceled(chip, status);
 }
 
+static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
+{
+	u8 status_masked = status & chip->ops->req_complete_mask;
+
+	return status_masked == chip->ops->req_complete_val;
+}
+
 static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 {
 	struct tpm_header *header = buf;
@@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
 		u8 status = tpm_chip_status(chip);
-		if ((status & chip->ops->req_complete_mask) ==
-		    chip->ops->req_complete_val)
+		if (tpm_transmit_completed(status, chip))
 			goto out_recv;
 
 		if (tpm_chip_req_canceled(chip, status)) {
@@ -142,6 +148,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		rmb();
 	} while (time_before(jiffies, stop));
 
+	/*
+	 * Check for completion one more time, just in case the device reported
+	 * it while the driver was sleeping in the busy loop above.
+	 */
+	if (tpm_transmit_completed(tpm_chip_status(chip), chip))
+		goto out_recv;
+
 	tpm_chip_cancel(chip);
 	dev_err(&chip->dev, "Operation Timed out\n");
 	return -ETIME;
-- 
2.43.0


