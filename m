Return-Path: <linux-integrity+bounces-7993-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A513CCBE45A
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 15:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 731273012DC9
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238333FE08;
	Mon, 15 Dec 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="euLqReZi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9533F391
	for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808287; cv=none; b=QRbTUmqG1JGbfEIv/987u+Wy8X16u8AZXKsshLkoa0hWkSL0olgzUq4YCGQO3ngNO0tikR5WJ44teEi32l7AbxJoHgnTFSa0u9i3Bbidop7NuJfGyk7NwdpHMh9A3V/R38IqKM2YfyVDaoynrKs00TIvmW65Mj3Kfg7IqYKglF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808287; c=relaxed/simple;
	bh=Zg7mCOEZ4Z6I10BCWu77BY4uJ1KchHXm6/KivSfImCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVIf/Fs6ffobyg+XBqn+9Yx+W8CWRnnHVIf9bnmW/3Vj2tTGRf+a/cOI//bh8GBjvdUG1Lyyj3Hip5jHrwDfySKmloPDe0DnWBPUTEaSxfxdxcbo3O2oO/puBoS6ZkL08GtXm7swtB8aj7Du7KmOYtbSL/MdPwDCflUVMcgEtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=euLqReZi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b736ffc531fso716513866b.1
        for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 06:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808279; x=1766413079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+EJpP28ACswVH+s22Escdl3RH0kKfptytDh+TM4ml8=;
        b=euLqReZi1buW9Pt6pFNFg1JGQi6ms8IluV+HAjs7TSAJoOBB3hfCWEXlVAPXCTmRKJ
         /nd80Q3krOT0rb7g37WOv3lO1POnMZOPISgXRuRy92dm+jK+ZFw+xWsuR04N6KZZlf8R
         t3QmgdWnFRqRZluw3OBNlODMZoiNXRsnSj/pSsl++MIOObUQ/qozfHEVNnCP0VvwYAnJ
         ixY78zV/uOD5HPgZhrqg/bXdMLkIC9IsvCRAuQc6yHnP4UMaLuiq2DKwqwmU3kR/BzZ6
         X2nTEvzrlMIOe37VNRZ/ALJ8IR3ZA3H3EEVzQ7PtFoBUOvul2UMZIVJpWZ1mq4xtMNHr
         GgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808279; x=1766413079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+EJpP28ACswVH+s22Escdl3RH0kKfptytDh+TM4ml8=;
        b=JoZa8OHnfwJvJcNG9f16Zj5rmQrIhTzP+mUp6OShV+Mj+12zwU2Zb7jAlasotZtTxO
         MYR+Qi1Fe2Ue0maC1zIvIMmz23qYc0A016g/YrneRqr9rnZlQYoF0/A77+0tEKd/b6mP
         6G/Q4+M5EVE5cuX19Eh9iWp+mOP4SlHszsoEve/5bKGKF5y7RcEStfI2VaSG6Zq87sNF
         Gzc0gufzyZjJACMUo3vJUBCK9EoJIf7cnlMtCDEbQH40DHjHIXylkNAlCM9GoG32nRIH
         kANeBHdwx4AxK4noixbOJFElrx5Trbr+xHU3orlt9Mh1yJt/iSalkU3Dt1uTVM10kDon
         +kNA==
X-Gm-Message-State: AOJu0YyUilhifyvDYFIp4xcPBzU2qJh8b+JfebaJ2LRfAIxne+nkQwDp
	/WE/g6KpC0J4EGsSI7qzNoMU7jLZjwmDwhTMOdCS3YbBccbLk4i4Kom4QYz+PNfeR6I=
X-Gm-Gg: AY/fxX7r+84YbsET2EvNM2kZS1PV1NQ80i9JIIAlzW5YGLdjqm0fKJLDEGABBUMj1jO
	+o/3Qn20RB8GZU6niZJkEcD+S8E33Grn3RV+/HBTpTolTQ6fEtwRRscVpU1qH0XeJpdqwB4ivLG
	0jkNMs0/lWEiXxQQ8qpFxPzCLVBygEzMfwwnTiA+A5+puxA74ERquw0ORhJjRupsZJHp0ktEw0H
	r8+ouBhDaLKfcNYrNG07iPRtLj9nsKFCTUoZgerw7BYGTULKuN12LhhSujmlC3meYdnWR7NwLP3
	kCMOfTH95OPZbII11745LenE9Q0vgU6ylo/MqaiF6GybkUQpIPF/NOotGYOXzDI4QgjuQQiQlx8
	oJt6L6qkTHf/mf/arQJHREp0oL/xuCsmEIXUA3/2TkDkR1bM7Eq+dyd4BnO+428cTmfVGAApD+0
	D2BHxSkP8SRBg6Yr7NoJ9YTwJtOg3qV7BQPICJhfkFwuI/627JpSxwpu1YJA==
X-Google-Smtp-Source: AGHT+IEK116a+hzlpDVrTZCFE6XuiyE4/HJN0uW0RxfmRWXh+Z7K4wAXn5iM/HwRNMkehyWwuERbtA==
X-Received: by 2002:a17:907:944a:b0:b7c:f5b6:bb52 with SMTP id a640c23a62f3a-b7d23a22c68mr1176743866b.43.1765808279239;
        Mon, 15 Dec 2025 06:17:59 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa29e060sm1447274266b.2.2025.12.15.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:17:58 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 14/17] KEYS: trusted: Migrate to use tee specific driver registration function
Date: Mon, 15 Dec 2025 15:16:44 +0100
Message-ID:  <687c004c32718ba7044ffa9165f33842267a745d.1765791463.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Zg7mCOEZ4Z6I10BCWu77BY4uJ1KchHXm6/KivSfImCk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhuRfKfm9AOVl8Q/VvcEeDtJDpwUt6Lmf7cq XA9w6mZtvWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYbgAKCRCPgPtYfRL+ TsZpCACirKqeCOo4fBLSL2yhYE15pWpKfHROUGgAZZeKbVTJC+rvy2kfsHLSn29V5iUFd6n/aBB RLMpQStbyHgc70HfHAyCuTdZObAa7h3bTSPGnjOjmLZigHIKG8/6g3+CqxBL8pTOH97z5DxZWNX VvkFx7JbUtReVr6BFh73Afq+MQ+f5TAL8pAFAgaE/nIFZCpM/LtSoIbp2blmkVrNpNEeNa0PYfd RA5nfTVhDCElUIctzgjpURVdvtEdKi8neQAbH6MIaiIU0cei0mA1FAKf6PQmApjRoegk+gVMHbu EBwmm55AFygfkyiAxcXwwxwcne/wKbaG9kvdFW74ByDZmhIM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee subsystem recently got a set of dedicated functions to register
(and unregister) a tee driver. Make use of them. These care for setting the
driver's bus (so the explicit assignment can be dropped) and the driver
owner (which is an improvement this driver benefits from).

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 security/keys/trusted-keys/trusted_tee.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index aa3d477de6db..3cea9a377955 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -264,7 +264,6 @@ static struct tee_client_driver trusted_key_driver = {
 	.id_table	= trusted_key_id_table,
 	.driver		= {
 		.name		= DRIVER_NAME,
-		.bus		= &tee_bus_type,
 		.probe		= trusted_key_probe,
 		.remove		= trusted_key_remove,
 	},
@@ -272,12 +271,12 @@ static struct tee_client_driver trusted_key_driver = {
 
 static int trusted_tee_init(void)
 {
-	return driver_register(&trusted_key_driver.driver);
+	return tee_client_driver_register(&trusted_key_driver);
 }
 
 static void trusted_tee_exit(void)
 {
-	driver_unregister(&trusted_key_driver.driver);
+	tee_client_driver_unregister(&trusted_key_driver);
 }
 
 struct trusted_key_ops trusted_key_tee_ops = {
-- 
2.47.3


