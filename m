Return-Path: <linux-integrity+bounces-3931-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18109B4862
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 12:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573DC1F2189E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Oct 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E97204F87;
	Tue, 29 Oct 2024 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="ap/W9MXz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D020492E
	for <linux-integrity@vger.kernel.org>; Tue, 29 Oct 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201665; cv=none; b=vF8qGfO/DgzOcoK2zIdVEOrT8YfzatvlyelYGvnTpS4I6DzjG5hYIgKA0Wd1bXBOIZd7KvOgir05EybBNRbOPzMXIPRc7miP7zR+czDbAKQiQ1W7JuncLKrIcJ8R42Ixxtt58CAZnonHBg/tRm+tobwRmxmq1HMMdNZuEBqsipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201665; c=relaxed/simple;
	bh=cPKEJ4jerXa/h6ueOtoFqHZZD6u7n4AElLCBfDVkuAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXL8ltkXScO8SVRzTWxQXNj4SWq6K04k4s/JUr2JAbyYriyO4fiayYSmebJiIqSzKxSCT+NgwZrbXlRIWS0tG17ZOdbqK5+MAyFaB2CdXvQWDuF7sGIoAsBZX7EbM9rIB7pb9928VX19oelpAsSjnzL1XUsvSxrlHz5NH5uP1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=ap/W9MXz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so4194099f8f.2
        for <linux-integrity@vger.kernel.org>; Tue, 29 Oct 2024 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1730201660; x=1730806460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUO11C/JRTs4GKxfufQ6dUqgB6gKo2LmLUMdUeU8K1k=;
        b=ap/W9MXzkQRzXylxlEwl9vrjtn4+mVxv5Dln5/HFOmSJtI2c1uJDvPw+iTmPDB6+NM
         ogtZzXTUR0mOpR4sKySkHlXlwfGp2SVUCRPOWNM934bn42MyKO/j0AW86OTPImOeKcq7
         ehYDhB6SbvxWHr9PZ28OxYEKvyioWUz4eLZ/5aury1TZa0G8wEIFXfyBVnFG3G3b49Fc
         yvQor9LnoJhhJm1sQuR5nd2A4XENxUIpsZmMuH9+JWbDWzpK+sdTL7FO501zS3pi1YGL
         IyEyu9Xgun/pPgBSnura1G3Q6dHNJA6h6E0XPPz8roSsapXM/Ya/tjj9PPS0qtJsY3y3
         hjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201660; x=1730806460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUO11C/JRTs4GKxfufQ6dUqgB6gKo2LmLUMdUeU8K1k=;
        b=QcmAq04WlipjuIV7RNs6TxcN9geYAI9VdXoDWjuo1BRWRCydfqPhMROAktpzb6Uu88
         jFRnd8gUj8KS/fcas4Dprewsov3AaRUtHomJRYpUPQMcYSgn1D8S6sfR12uPYZNXhsT/
         fWxKeKUr20ehrqbEA3CU80/zZhSEZ5bHRY+83sMpMOxL3Ow7ok5HmQZNC50EvGU9gaH5
         1kyigkUqs0W09ZJ3yzkAg61p8gbKXPiLPE41S0CCoK5xjngocCHIDzBW7gxEytfCo5eJ
         u361bnIIeM/uJiUgWXndxAHD7YGZpSQYZc2MT5nKAeKvfl7uYu5B5oZgHN6oU3evvC0n
         +g+A==
X-Forwarded-Encrypted: i=1; AJvYcCXAcZbn4FhSVE4gBVmBn/UKsDsVaGaYF87B+JE6Cr4VAbsFvWfxnc0xCcY+HOB03GU1IloQUlsyD/Va1LG6aWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5NTDze9LZl9mFlh0NcBU0m5/RHLzLJSBSN/KE16ISolttGNX1
	Q5nwRElwWBtHA32h5hzf+rJUkp5saIAggjl6gFleobn5nsx7Y6P/GdU9G3jSUKc=
X-Google-Smtp-Source: AGHT+IFJoyZ6NxzI4ys9GDFWfJixnTkKlsJEMZbZjWGrqOc2/MIuNQIrRuJSwDRXg2rPjjIDI76/9g==
X-Received: by 2002:adf:fdc9:0:b0:37d:43e5:a013 with SMTP id ffacd0b85a97d-380610f49e4mr7243573f8f.8.1730201660311;
        Tue, 29 Oct 2024 04:34:20 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38058b47952sm12152755f8f.48.2024.10.29.04.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:34:20 -0700 (PDT)
From: David Gstir <david@sigma-star.at>
To: parthiban@linumiz.com,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Gstir <david@sigma-star.at>,
	stable@vger.kernel.org
Subject: [PATCH] KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation
Date: Tue, 29 Oct 2024 12:34:01 +0100
Message-ID: <20241029113401.90539-1-david@sigma-star.at>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
References: <254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sealing or unsealing a key blob we currently do not wait for
the AEAD cipher operation to finish and simply return after submitting
the request. If there is some load on the system we can exit before
the cipher operation is done and the buffer we read from/write to
is already removed from the stack. This will e.g. result in NULL
pointer dereference errors in the DCP driver during blob creation.

Fix this by waiting for the AEAD cipher operation to finish before
resuming the seal and unseal calls.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
Reported-by: Parthiban N <parthiban@linumiz.com>
Closes: https://lore.kernel.org/keyrings/254d3bb1-6dbc-48b4-9c08-77df04baee2f@linumiz.com/
Signed-off-by: David Gstir <david@sigma-star.at>
---
 security/keys/trusted-keys/trusted_dcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 4edc5bbbcda3..e908c53a803c 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -133,6 +133,7 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	struct scatterlist src_sg, dst_sg;
 	struct crypto_aead *aead;
 	int ret;
+	DECLARE_CRYPTO_WAIT(wait);
 
 	aead = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(aead)) {
@@ -163,8 +164,8 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	}
 
 	aead_request_set_crypt(aead_req, &src_sg, &dst_sg, len, nonce);
-	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL,
-				  NULL);
+	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP,
+				  crypto_req_done, &wait);
 	aead_request_set_ad(aead_req, 0);
 
 	if (crypto_aead_setkey(aead, key, AES_KEYSIZE_128)) {
@@ -174,9 +175,9 @@ static int do_aead_crypto(u8 *in, u8 *out, size_t len, u8 *key, u8 *nonce,
 	}
 
 	if (do_encrypt)
-		ret = crypto_aead_encrypt(aead_req);
+		ret = crypto_wait_req(crypto_aead_encrypt(aead_req), &wait);
 	else
-		ret = crypto_aead_decrypt(aead_req);
+		ret = crypto_wait_req(crypto_aead_decrypt(aead_req), &wait);
 
 free_req:
 	aead_request_free(aead_req);
-- 
2.47.0


