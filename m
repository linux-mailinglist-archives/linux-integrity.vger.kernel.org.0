Return-Path: <linux-integrity+bounces-7991-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF4CBE8F1
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FCD33002BAC
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0C340A62;
	Mon, 15 Dec 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yizn8qVm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C733F8BB
	for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808286; cv=none; b=nRw2xz68FoLbbHlM0MNfdiJ/beXvNu82vXb1BXPiBHma+JN9HUFZYb+AR1FeILv2zhhOEyyGoabGuJJAwuI9qNkgJrFAfaMYRAeCROl7Z3KeY7tF6/M9EvDooeuZGQ2lfhQjFqf61Q5e2+/wjvTk2IJuvOTtjOEUX/7XW6Ge9Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808286; c=relaxed/simple;
	bh=GGyKb0nPpNUP9YxvKC/UL/zntZq4nlTFqMxQrMaeHc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVsDXZGKyEjPSgnKV8i8wQ0/dg1rL3kr7JUy/WwBOSrtQ894Ly44K2pV/VdxZedHaslVD9zDpB4CgyEd9yi0GG7TrrtOP6+XJiEuVXPJnW3TAoCRyCTWm6ATh9xpWlXwRn4fy/b/Rw9QNFb6VlkRy6dXdvB7IBqP+ePgwiTMnZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yizn8qVm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so748077966b.2
        for <linux-integrity@vger.kernel.org>; Mon, 15 Dec 2025 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765808281; x=1766413081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhxFEbi3upUhHH0lvs3ziMzH7rdhLkVDsyriiRkxcyM=;
        b=yizn8qVmlHUteyWzETfUZFGprgK080TTkYDl9FAfO3X/CC/uQgH8LL72/tO3nY0nmK
         eH2uRnxFmtnfjqadvHeZDddxpYZh5PkJpd/vvXaHf46joHBI1O867ml6vXu/7K+daZqh
         Sg10xVlzUVvZJ6EUjwtqa0XRNWaA2Ua7F0+RXUVPxTVXC5WgXANt+rL5cudyyvjZ4DX1
         J5Sh97MF0baeHJRSFM5cyCx7NBfUrM0jrDaORHUi8tbSDX/2vcJocI9h16poIzWyPDw/
         ctraDBoLCiZ5bW1PAIkYXSGZqljS1OtIISaRXXnKjrYX1EE+FSbZbuvylLSQp+gFUywT
         km4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808281; x=1766413081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhxFEbi3upUhHH0lvs3ziMzH7rdhLkVDsyriiRkxcyM=;
        b=eCdHxDPM4WhLuSbajtI/XjJF4yGMFPIY8BP/oKyVFQ+Yy0vkMYzrenbYRTjLeNTkRg
         5qxCrgP2OGS5Kc9CPC6KzhXU5KI/HB4z75c6KCDrvDkJOsTP1/40Q1XMYLkuBTsKETas
         Cem5kP6d3/fedKZFq/a5NXRPYmSr/VfjhzpUUQqeQYR8iTC1krYgQimN9SbTVH17T7TN
         /kSUkNmGMAWypcbVbe+JXGhXwuTMlzndYdWW3x0RLCvbfkZCiSDwrfwjx36mhNnJGK/i
         Eg70T+9KlUHumCGwSdPdlsyoyAVq92aBoWRwqdp9UTXqw5L/vY3Frd0A4jvGX6zvVsDa
         UY0A==
X-Gm-Message-State: AOJu0YzEOj8LlN0/iiMsV4eRBwNM6BebD5dxtgY20P+RB8QnCgOBlKv4
	OLcGqph4znzZY+gR1pr4QM9FU9o6ofev+Eji7KKOXD3lMdI6PsqxWgQXa4Rjb7fGQbk=
X-Gm-Gg: AY/fxX6HLoLG54lioYrtahHr+6ZQfWwplEOsYTOtG+rLtQ6hljkM/0TwoGHwL7toNa9
	USa8KHCNymYANHSf6lC7jBaq/EyVTPV4iFkj6SpyUjFQelVtbWgET1Fv6ixHfzsl50L/WWezA59
	PGJU8hyi80tehYOhZgqVDRcF1E8BQIzYmR32tQ9PnwiSQApdJAdvQGGhQuuoI9u37OGumuJ32Kd
	kEcCIOPUBfpXH6WV8JGP6PPQl0RSGSwozIn+4ntRJLbm/J2+B/YE5i1c1r9w79G+rVHcYVuK7vT
	Fgr2gdFNo1vVNoCI5ihKN/DjLQtHhPSP0bozPycPW9I5u6uWWWVs3dNcqqmGBtdEX0Gr16e0Aqz
	VrJMkAnZYLcU5K4MalSZckjbIU9kDjPl4cRdg+u1hn4EfdGE0PFvHp8F3m8/KUWhIaDSuGOW7p3
	zzC2HxZrrRVZOWgZsz+SlywWvDErlQwoRxtVKiH0j2QQhd/ZtaDeewcNfFv8OHvg+kr1Wi
X-Google-Smtp-Source: AGHT+IHC8ujpn/jRAp3uyUfhPlLVYnf8gdfe5eEvlFd2Ct3yaq9KShqsTrao9oJk1KAsuZl7TA5Hxw==
X-Received: by 2002:a17:907:7b82:b0:b70:68d7:ac0c with SMTP id a640c23a62f3a-b7d238ddd7emr957125366b.42.1765808281128;
        Mon, 15 Dec 2025 06:18:01 -0800 (PST)
Received: from localhost (ip-046-005-122-062.um12.pools.vodafone-ip.de. [46.5.122.62])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa57190dsm1442761666b.49.2025.12.15.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:18:00 -0800 (PST)
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
Subject: [PATCH v2 15/17] KEYS: trusted: Make use of tee bus methods
Date: Mon, 15 Dec 2025 15:16:45 +0100
Message-ID:  <ad8aaa343c1e8523659259290f63aea8be906977.1765791463.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=GGyKb0nPpNUP9YxvKC/UL/zntZq4nlTFqMxQrMaeHc8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpQBhwtaw6vWGcyIGKsWICqFr37WWt86tvJxrvx 1eTqfVDJZqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaUAYcAAKCRCPgPtYfRL+ Th3cB/9e3Pv5r3zMgBKsAgjAsHEhpC0EgCY2oqRVfxKl8HHNjl+lB20MGJ2Q8pSnEUNYokQO3QL mOTOzUqSZn9hAaGG/5LKUE70SRu5xo1OgksDBfRcBInzXTVG7RDE0gQMoPbW3O/QimI6W2kQfJx KesCYRfngtF0s9Jq1wiZvB24whWT0ZvkV2bFXypQVF3Ta77WO8PtMmx3Bk+0u+EkLt3e/pfof0U NylFPVRHjBIX4DRRlA9oRL2MT4Npc9hTQBUo9iUHIoOxuI3uaEzDXB/69vwGC5Y1KsCDA+XS5Ma emNcInkIoXdw9B5y8cwnaf8ckyn6/3KiWopHnE+ahW+5sT3k
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 security/keys/trusted-keys/trusted_tee.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index 3cea9a377955..6e465c8bef5e 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -202,9 +202,9 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 		return 0;
 }
 
-static int trusted_key_probe(struct device *dev)
+static int trusted_key_probe(struct tee_client_device *rng_device)
 {
-	struct tee_client_device *rng_device = to_tee_client_device(dev);
+	struct device *dev = &rng_device->dev;
 	int ret;
 	struct tee_ioctl_open_session_arg sess_arg;
 
@@ -244,13 +244,11 @@ static int trusted_key_probe(struct device *dev)
 	return ret;
 }
 
-static int trusted_key_remove(struct device *dev)
+static void trusted_key_remove(struct tee_client_device *dev)
 {
 	unregister_key_type(&key_type_trusted);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
-
-	return 0;
 }
 
 static const struct tee_client_device_id trusted_key_id_table[] = {
@@ -261,11 +259,11 @@ static const struct tee_client_device_id trusted_key_id_table[] = {
 MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
 
 static struct tee_client_driver trusted_key_driver = {
+	.probe		= trusted_key_probe,
+	.remove		= trusted_key_remove,
 	.id_table	= trusted_key_id_table,
 	.driver		= {
 		.name		= DRIVER_NAME,
-		.probe		= trusted_key_probe,
-		.remove		= trusted_key_remove,
 	},
 };
 
-- 
2.47.3


