Return-Path: <linux-integrity+bounces-7917-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C668ECB6AB7
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 18:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2195F30334ED
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B28319843;
	Thu, 11 Dec 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IgjWqMd9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33721315D49
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473375; cv=none; b=jUa/0vhsHouoAjmSOx/8qZDYMDaBudYL/e5fw1qrIIgoTnVGs/ydMu6XIhzT4sOr+90XOP+bt4cldhKixpRXl64lIjlJPlkgE0gmy2VpQjcWLdJ64A4+F3RUxXTSvUeywqpAoM9ZKsmmhgLxNGQ1wXWXWc9hKswczoS/2JWsVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473375; c=relaxed/simple;
	bh=CzasmjigxMDc3RbPNhKzZOfqJrGSXpxinQ87lLaAs6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0wK5Yth28+Zp0FWp9uHL3qNd8JV5Iqrx203R/vhMSWFNKopuYZxiPT+tXssNkfiL//PtWALDCdYscC1Fe54eB6DCKEhv9a0hY2sNMhaDXKlDjSs1oFjYB98O2xxFCizwUVmlTwfufInY87OeuxKHGruemRxJQjNZeoopMxggAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IgjWqMd9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso146361f8f.3
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473370; x=1766078170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+SHfa6vAHr55xEpYtx8saNp/3XbgtX4zTiJHIYfZ1k=;
        b=IgjWqMd9j04SJLnMtl+zQippp7RKIYHp0avf98okpcRZctk9dwkIOVIm/h4F6e9gNG
         R16rEHDttSX2nlOUb3axfIPs4SuLcNY4LqlwuLMAfkpjnkgJKDR24Lna63MRVnVgDSSC
         jf7dnvXuHKEVjgw9LKWcfMglWf4gAWzWNNPKaDPXx+Y5/0Mr9F4At1yrO9Bbd1Y2nWTg
         jarUF9Kxpy/Tys7m/Ep46iyTD2tiErOlkA+vhf1Z1vlU/EtGTY8GHzudzxKNpqxIo6wC
         /v/R6T0N866RML9olQDqs+ehSlADhbM2VBcSDbTYQmkpmi9a7I1MlpwP6bSwLLS5N/CO
         RNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473370; x=1766078170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n+SHfa6vAHr55xEpYtx8saNp/3XbgtX4zTiJHIYfZ1k=;
        b=Oh56bTfLY6vWowqimP/dOze1OCQaQiCFzFXgkqrj87WX+Xit5hsyf+urO0yYYBc2Mx
         SP5IiVr67EII98Ko6RbGHY78hjRpRSyCU6P+InzTnddQvWuddM/hpVhFd8y4ExjJeTUC
         O7s39/8m6oLyAHTH2xya1fSdei8m7DvtDXm9JTN4ZuV0odgXegOjFRgsVO/UZF4rE7eu
         Sr7D9qhAHqFpbNES2mMFLTUZuQSeToTtlC5/nzAxHU66xf4baHtSP8s9p+9ZPzuRUgs9
         9yWC75llCre258p7XTS2pQ4ABEvSWASXkMtMDmGq/DGIAKKZKRyFjpTKnqSzzT9tq5Kk
         sO3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoXNMFLZk7u57s/K0donQROK0rP0yPgoaUIwAPj8SEX+anae1EczICTEGyMvm6o8HuaHR4MenQ4yYvILc8UOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5DgBOb3l+aa6mKvDfAXaxu/d6746oIymNsZh6qAp6jKFKTBi
	v/Q0mwOAGREVLJbUi739E8OvPO9PK66Fjk2UlfgxY9ComBmYb64h+9Nl3NiN6vJanRE=
X-Gm-Gg: AY/fxX6Sh5R7uJWrvfZst3OZ41nxOTB71oSXp16xTORLJwiEV5qs0sgAeJQimOo+4vW
	g8qKRi1miEXJpoMQIIWTvuD0sCf0LgD9i4T0vdhL4AVPcpxTGfdFCc+KxFISS9q3IaGUQt6hAKK
	4uSFNeFJuhCFd0lbq6oK7i5V/jOO1v8unBt+c0X3J6Z43aYkcx2zUJ145HQCnlJyttT7f4gAMfq
	/Pkm86kN8nc88DeE9LfH3CuKU2EgIM/bQ5rGJymxIPMcIpcmR6miojXdYPMmh9zuDk1XUoixbto
	vB2Xm9DNsrmrEPjFrgfcU/M/xlRu/hcJXMudIi27DRg7Gn8I7Y/MhHDgKJ0i6QB1B6dS7+OfL//
	WiI4edtNVspDvb8AMnoDKTbqNMNIn7YUCcz/yhuewS6qFZJ+G1oJW/IqnXhnRYj3f1of+KDPesL
	lH/o5o0YP6j0wyfR0/qtz9le55Uth097PWAMow+77rj7PyMNOcVti0JBYyizmj+UbfOlj3LCb2X
	BA=
X-Google-Smtp-Source: AGHT+IEVlfLgsF/P2fkju8/EGLrakjagEMlQtCpgWX8RHB5vEnT2Q9O+No1JYvdMM/sRnem0fYfvQQ==
X-Received: by 2002:a05:6000:2012:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42fa3af895fmr6416347f8f.30.1765473370344;
        Thu, 11 Dec 2025 09:16:10 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8b8a973sm7064875f8f.36.2025.12.11.09.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:16:09 -0800 (PST)
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
Cc: op-tee@lists.trustedfirmware.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 15/17] KEYS: trusted: Make use of tee bus methods
Date: Thu, 11 Dec 2025 18:15:09 +0100
Message-ID:  <aab4c00b7e89abce7bcd8241c47f3398fb7227f8.1765472125.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=CzasmjigxMDc3RbPNhKzZOfqJrGSXpxinQ87lLaAs6M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvw6brlrzvg29fcU3xprVy3jDUvD6QI895K+A 4P0ITtETEGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8OgAKCRCPgPtYfRL+ ToAKCACHrdHSasYStywLZJGRNAkC64NWvFb/BwKzZCoF8C+nTT45O0JbfN5t/ZZlz3WQUTo5Kj7 m5QHbprAIkb7KlG6c9wMZpIvnIBvKwpE7j+PUzZ2X2+UD2nnn20123zaagJYaJHriTJetqmRK/g fl4EgbD/AzpOofrYMbezG60UvGRmRCPd4NvhNQ6GXkzjyAH5oICnrjI/ufaG65GzQSejD8nT5qK UIdLIccaehc7imlrk0QNv17cD5+/y0ZIwdI2uAIuelzdvUdNHWDYI1/zMNQ3t+FkqM+vgaElDdx 8Ft+pQXoK9ErCp8MIxolmLzr+4840mvUoLiV3YhnVRyUrSkT
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The tee bus got dedicated callbacks for probe and remove.
Make use of these. This fixes a runtime warning about the driver needing
to be converted to the bus methods.

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


