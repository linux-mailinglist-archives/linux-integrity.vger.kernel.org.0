Return-Path: <linux-integrity+bounces-9702-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uuGPLkMtHGoZLQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9702-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2026 14:44:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABC6161FA
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2026 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF4D3019060
	for <lists+linux-integrity@lfdr.de>; Sun, 31 May 2026 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1837BE7F;
	Sun, 31 May 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGhmxeOz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5030C34A
	for <linux-integrity@vger.kernel.org>; Sun, 31 May 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231488; cv=none; b=SQKPWaRnasSDrMcIeNT4uypQBuhMTLGLdTuGDRotjJzJ5iFocE1txVVnWChddt3FZVW0e8U86ZUIaUvb9iZRLWplxQTFssO6cbYVlAeUe37enhn6PGlSUYuPIuWiLrFq0/EaRPvfv31QgXIZ1oY4qBjgJjgkdW8csp7geBKhXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231488; c=relaxed/simple;
	bh=dJ4GRFwuWSHnPw/cVXnvzNeCJ5o9rhmasOCW7qlG0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N313uJm9Q67mhWMouUsbOGnbHjxXAnARPJfhyN3RZiXQcH/V/p0tTp6XE5QnucrD+v/1R7iyEQY8h4yS7LyQ4oUJWpyStN3KtmtHwT8k25Wm2ZTJV88aCUBycIanIv6i/44jumZfBeGzCb7zeZhaZSHz71McoWpprhU732J6msM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGhmxeOz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so13085276d6.3
        for <linux-integrity@vger.kernel.org>; Sun, 31 May 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780231486; x=1780836286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA3GlBTHlZs+71CgTMpALkS8BwxWXgNQSpyqZfnP7CE=;
        b=WGhmxeOzmMYFkQ7UqLH4AIoi3GEwo+OW39OE3y2e7LeLlP+LZskQYNBJ6imHzRLqKL
         4VeEj3K4p81z82T18WjoQH2nB1e+PHIH5Z7n01SNxNjpcmN3emOpETuAfHxJ+/KN76IQ
         4IGopmUSL6zdSlETNCBLExJob7Azc9fZMCljIlf/5kHDqU15jP98RbD+o6N0T6ms8+yY
         oVmabbT6jpcRJYfEcRpgtm50q2bONW9m+mUjeoz6YV+bfOpPNy4pu3ylCcuQEBT9lOrY
         /24MIhcI9//4Hr6u70Zj+62M8xvb0wRe8ChC2xSN8giFDu0c9qIT9KMhYMROu/01ta1/
         D1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780231486; x=1780836286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA3GlBTHlZs+71CgTMpALkS8BwxWXgNQSpyqZfnP7CE=;
        b=ITOi0f7XyvAJQH+WRZ/vzrY8mAjXiluOqT25vyO7TGkSTOq/sOMRCbDEaOHBgSqLX6
         Y0nbk4X5jadxhZ6iEStZWoat/IiUz7zX97aeXifE1GK2EPWO911rqWw0jPIByG79d2j5
         dKjBApqNd9s2wLNSR2T7kwMOtGK2A8Ql+VGW6HRfFJLN4hwN2uQzA3oEvlserCQykfrt
         2asqKf1XowBrdxJJxp+8Ck5E6NSCo5hjtwh0Pm0i6C/o6s6rHQ2ndX2Yt0XiSl9kEoKt
         s8TCemi3cXiQ33vLISYBYPYLv9DS+H7JvHmo6WZrA3llHWSkL9BXKa+VLM4lVe/5XSqn
         wuSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nbPRC8ygsvu2S5mtu+wFlKANJ5giDHihurt4e79jydn+h1dOWmK0uFNRihthH7cxF85kWjyU+zUVqCs+nUVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSMhHjRL1ay/FhgEP39i9WoINh0l0+1fwS82/V5QfLEI+9PN3
	Fu20jgm/AwlC9TeMZaqybojDYJtKxWSjh6lRU9JGAkNkGLmDd4vgp6zXvkoL7To4
X-Gm-Gg: Acq92OFMbeQpSIRk3rkV4+6KGnreT3JaPfsXbvzu9C3LeM2msTK2AdRxow1pqHRs2vP
	Crhr0+pj6Oevo65JwIG2l6PqhU8pf6I7rO11BpLAJ7nYv+LMJ34TeJpmNpEzIMmUtl+HwGnxaIT
	e+yi2qVwO3939DO7bCE1WlUxXlqvFXrK6IzYSEI2rVwV/tXCn/lJYZt92xnVPtr4mPcIuQR6jXy
	E3vZJ6hqx8S6TubHLFw4Yoc2qRumkwRtnQTqfl1Np6784BGc0PFUbBxzdFh0etLKVszRUT5gGgb
	bCjWViO29ItKmDz4i9Gq6k2byjGRaHM1uUA9qDn+dAGRKEn6cedOQU8cmmKtj9NDF81X0GElVj3
	xDzQrDmR/ZJ13gCfktNqGJuTges7iB0rPSvIPHD765S3jKvuJA7vze8zCjuYl4bg99P3TK0RxQ9
	YzktjceHEXZvrELe1vgqN4mUEa95vexcM8gUwFODkqvLkfWk6yWgEHYg5DwKGXonuY17xv9yrpk
	Fk1kW6s4JnGskBGhzC6v35/MU0yN0A=
X-Received: by 2002:a05:6214:2b0c:b0:8c7:2be0:6c91 with SMTP id 6a1803df08f44-8ccefd9ea17mr119791426d6.28.1780231486169;
        Sun, 31 May 2026 05:44:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea061e87sm68138276d6.12.2026.05.31.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:44:45 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt
Date: Sun, 31 May 2026 08:44:28 -0400
Message-ID: <20260531124428.2304629-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-9702-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 12ABC6161FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tpm_buf_append_salt() in drivers/char/tpm/tpm2-sessions.c calls
crypto_kpp_generate_public_key() and crypto_kpp_compute_shared_secret()
without installing a completion callback, discards both return values,
and immediately frees the kpp_request via kpp_request_free(). When the
resolved ecdh-nist-p256 KPP backend is asynchronous (atmel-ecc, HPRE,
keembay-ocs), either operation returns -EINPROGRESS and the deferred
completion worker dereferences the freed request.

The path fires automatically from the hwrng_fillfn kernel thread via
tpm_get_random -> tpm2_get_random -> tpm2_start_auth_session ->
tpm_buf_append_salt on every entropy poll, without any userland action.

Install crypto_req_done as the completion callback, wrap both KPP
operations in crypto_wait_req(), and propagate errors to the caller.
The wait is a no-op for synchronous backends.

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
v2: restructure the error cleanup into an explicit success return plus
    err_free_req/err_free_kpp labels, per review. No functional change.

Validation (QEMU x86_64, swtpm, async ecdh-nist-p256 stub backend):
  Unpatched, the deferred completion worker dereferences the freed
  kpp_request: KASAN slab-use-after-free with the allocation and free
  stacks both in tpm_buf_append_salt(), reached from
  tpm2_start_auth_session -> tpm2_get_random -> hwrng_fillfn with no
  userland action, then a NULL completion-pointer oops. Patched, the
  same setup is KASAN-clean across repeated entropy polls: the worker
  observes a live request and the free runs only after both KPP
  operations complete. With no accelerator present, the synchronous
  generic backend establishes sessions unchanged.

 drivers/char/tpm/tpm2-sessions.c | 45 ++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c4da6fde748f4..f44646b26b192 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -489,15 +489,17 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
 	sha256_final(&sctx, out);
 }
 
-static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
-				struct tpm2_auth *auth)
+static int tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+			       struct tpm2_auth *auth)
 {
 	struct crypto_kpp *kpp;
 	struct kpp_request *req;
+	DECLARE_CRYPTO_WAIT(wait);
 	struct scatterlist s[2], d[1];
 	struct ecdh p = {0};
 	u8 encoded_key[EC_PT_SZ], *x, *y;
 	unsigned int buf_len;
+	int rc;
 
 	/* secret is two sized points */
 	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
@@ -520,14 +522,15 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	kpp = crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
 	if (IS_ERR(kpp)) {
 		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
-		return;
+		return PTR_ERR(kpp);
 	}
 
 	buf_len = crypto_ecdh_key_len(&p);
 	if (sizeof(encoded_key) < buf_len) {
 		dev_err(&chip->dev, "salt buffer too small needs %d\n",
 			buf_len);
-		goto out;
+		rc = -EINVAL;
+		goto err_free_kpp;
 	}
 	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
 	/* this generates a random private key */
@@ -535,11 +538,17 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 
 	/* salt is now the public point of this private key */
 	req = kpp_request_alloc(kpp, GFP_KERNEL);
-	if (!req)
-		goto out;
+	if (!req) {
+		rc = -ENOMEM;
+		goto err_free_kpp;
+	}
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
 	kpp_request_set_input(req, NULL, 0);
 	kpp_request_set_output(req, s, EC_PT_SZ*2);
-	crypto_kpp_generate_public_key(req);
+	rc = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
+	if (rc)
+		goto err_free_req;
 	/*
 	 * we're not done: now we have to compute the shared secret
 	 * which is our private key multiplied by the tpm_key public
@@ -551,8 +560,9 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	kpp_request_set_input(req, s, EC_PT_SZ*2);
 	sg_init_one(d, auth->salt, EC_PT_SZ);
 	kpp_request_set_output(req, d, EC_PT_SZ);
-	crypto_kpp_compute_shared_secret(req);
-	kpp_request_free(req);
+	rc = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
+	if (rc)
+		goto err_free_req;
 
 	/*
 	 * pass the shared secret through KDFe for salt. Note salt
@@ -562,8 +572,16 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	 */
 	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
- out:
+	kpp_request_free(req);
 	crypto_free_kpp(kpp);
+	return 0;
+
+err_free_req:
+	kpp_request_free(req);
+
+err_free_kpp:
+	crypto_free_kpp(kpp);
+	return rc;
 }
 
 /**
@@ -1018,7 +1036,12 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
 
 	/* append encrypted salt and squirrel away unencrypted in auth */
-	tpm_buf_append_salt(&buf, chip, auth);
+	rc = tpm_buf_append_salt(&buf, chip, auth);
+	if (rc) {
+		tpm2_flush_context(chip, null_key);
+		tpm_buf_destroy(&buf);
+		goto out;
+	}
 	/* session type (HMAC, audit or policy) */
 	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
 
-- 
2.53.0


