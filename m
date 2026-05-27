Return-Path: <linux-integrity+bounces-9693-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOLVDYE8F2qg9wcAu9opvQ
	(envelope-from <linux-integrity+bounces-9693-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 20:48:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7E5E933D
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051AE304C7F5
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2026 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864212472AA;
	Wed, 27 May 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzCsJ/07"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE330E83F
	for <linux-integrity@vger.kernel.org>; Wed, 27 May 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907624; cv=none; b=qHdjKtx9RbAIj43RPrJpXsWh/2voRwF14FfsxwLf+FS1aLN1QK+yVMwD/zjDmUsXzCNm67GRT+b5w9i8LXuVKHKgD6hj3xTDBpjv8NtjJrn7k/p3DPumn/PFdKqiU2wId89lRDZMX54Hc+KYRiWHGlFvA+LaAqDt8joQnHD6te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907624; c=relaxed/simple;
	bh=E3gc4ZRJKcVussyClDrp+FgO+UjnTznkNqO4Lm7JwrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbEDibm3sltXvtGS8R4y/8JstUrMW6+HME2Mj7wQkg5lRNv03MbEfWZHwPZ7rxAV2nWa+GpMsQAtLZ4HKFmuxBPjc5p8jUQL3POG7CBSVTfQ5MQthQd69qtAReT4JhUaV4258shMPASKkuuxoAgvCa+RWp+zThtgAGtHmZxHP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzCsJ/07; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-914b03e42b2so719348085a.0
        for <linux-integrity@vger.kernel.org>; Wed, 27 May 2026 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779907622; x=1780512422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnnO6Up2KIBP1TWTFBhRQUg/zlMghDxRrcKQAM6nb0U=;
        b=jzCsJ/07XK8rrTte69szxmOcm2btT+/L2W5+oyXFyB0EIdUFzRvNMV59eHcomsjjKJ
         ZFbGJeOxPSGtsFk5lTf2KIvLNT54Gx4giGGfV94CWIvwbHZQ02NYHHitE9fV2IRyShv8
         crLAl4hz11CrBH9itcYK/Vk/UtvnO4wiS+5o47Q5Cl2gQNv5qAFpGbNHk4Bwr1Q406Lv
         4CHKBW7eee7/8iWkerq8lGwXgBQk1FUZgBrSfXb2UiI+y8oK7HcxagapufivtJHvvAGW
         TEwf0WEFNWoKsv/c5jYmpzWwCU4C3JZGd5zJSaGXNeAEOYlvrGe+cCoiGqvK27wo8XEK
         s9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779907622; x=1780512422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnnO6Up2KIBP1TWTFBhRQUg/zlMghDxRrcKQAM6nb0U=;
        b=cxlcjyY0VjTeCr2oq0yzzTn6a7DHRx+CkPMoVOdlugMAxO0ezeZjBH3q58uugxgdvo
         I0qjj/+ZXf6ZQ2bnMbBuQs4XI+BAqG2S9tmFS90YsTdAzjVT1oZ/y71UvpwvTw8z5dtp
         m4XsKh0PUOmqD77W0rl4+kGGarW7nn6MMcQry/kzslc6NoMCS7fTsSMPrL7rZmBfJwhi
         GBB2k8fGdy9SbKtzB5racqZRyJHJYnXhalpWO6qKEzZtL96G7vUOFtxy4RWyRCHnS5yR
         93sna/9bfed3HV1ffD2RBXrARPeTT90Hhe5Hy7zaYdTy0rKTiXwcSK3m7n8LFRVr9enT
         99QA==
X-Forwarded-Encrypted: i=1; AFNElJ+v1BB9gice+LcieY5s+/rcJw+qTutaAkT4rQ10ubu3ymsGG31uFaBAlTeI9qgpAfFC/mSlqj+DKaZlM8NemZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznyuHjjgbs/veZBtZ31IWOXQ89z3HLTJ28ygAhGdCUhi2FVlx3
	wUQy0ykydRaU9D9VwCCdUnk7uOBbNOAWsmCakBMgB9OPsTiHXo5fXRFp
X-Gm-Gg: Acq92OFoCo4c8WxtKmFFUZrUvyA3lcTPhOWnlQD2g1HWEZeylG/5xtAAGxGOFFmCW6H
	3U20B+kZp2NcbRZgRwt2dhxBOn9gfPys970QEtSbLUPWHZtX0TlCCiq6jKhOy+HHEIeCN8uW7+T
	ly2w3nVOF5HSDuuAE8tgBVNlsV/3yExDq7WA7Z5LtIAQZwSJpi5asM67x02RpW14cYcmTptG4d6
	GVu9oV3B0R641anExuysEbs0lNJEYyTtrF4Gb+xRNOGbTAbcPdFi6ZmJbhZi847otzep1v5U3xN
	1nFPppl/Qe/JOwCs2co6ow85luvmJkr5Af60n6cgbwT+Qfr5qWYlNaiNCg5k31MreQSTNuNMlys
	urGpDDreKl4/XODcWycXCFmLM1sV3/s7YMV+cryc/IXQ83RX/fy+fi08al5VR2Dnhwv0uY/6/xV
	RcLedhKatR0WqXOHUBqkKjYXGNHbaeJM4ByE4KdV934j92TDr9pJkFd2k4bsDhRkEJT36LzwDgg
	Ya48fKqzt79kBzrlI0em0ArdWxYuC8uZtqJz6S84a25XgY9/Ufi3A==
X-Received: by 2002:a05:620a:1b83:b0:914:b104:91e with SMTP id af79cd13be357-914b48ea7e8mr3726390385a.18.1779907621780;
        Wed, 27 May 2026 11:47:01 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d1a9bsm548554485a.30.2026.05.27.11.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:47:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt
Date: Wed, 27 May 2026 14:46:55 -0400
Message-ID: <20260527184655.1919993-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9693-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99D7E5E933D
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
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

Impact: on a kernel with an async ECDH KPP provider, any local user
can reclaim the freed kpp_request slab slot and control the indirect
call through req->base.complete. A reproducer is available on request.
Filing publicly per security-bugs.rst guidance.

Notes:

    Validation (QEMU x86_64, swtpm, async ecdh-nist-p256 stub backend):
    
    Stock kernel: the freed kpp_request is reclaimed by an unprivileged
    heap spray; the deferred completion worker jumps to a controlled
    address (RIP=0x41414141) via the overwritten req->base.complete
    callback pointer. Reproduces on production-hardened allocator
    configs (MEMCG, RANDOM_KMALLOC_CACHES, SLAB_FREELIST_HARDENED,
    SLAB_FREELIST_RANDOM, INIT_ON_FREE).
    
    Patched kernel: crypto_wait_req() blocks until the async backend
    completes; the worker observes a live request with the correct
    crypto_req_done callback installed; kpp_request_free() runs only
    after both operations finish. KASAN-clean across 50 entropy polls.

 drivers/char/tpm/tpm2-sessions.c | 36 ++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index c4da6fde748f4..a23cc3a540c55 100644
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
@@ -520,13 +522,14 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
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
+		rc = -EINVAL;
 		goto out;
 	}
 	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
@@ -535,11 +538,17 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 
 	/* salt is now the public point of this private key */
 	req = kpp_request_alloc(kpp, GFP_KERNEL);
-	if (!req)
+	if (!req) {
+		rc = -ENOMEM;
 		goto out;
+	}
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
 	kpp_request_set_input(req, NULL, 0);
 	kpp_request_set_output(req, s, EC_PT_SZ*2);
-	crypto_kpp_generate_public_key(req);
+	rc = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
+	if (rc)
+		goto out_free_req;
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
+		goto out_free_req;
 
 	/*
 	 * pass the shared secret through KDFe for salt. Note salt
@@ -562,8 +572,11 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	 */
 	tpm2_KDFe(auth->salt, "SECRET", x, chip->null_ec_key_x, auth->salt);
 
- out:
+out_free_req:
+	kpp_request_free(req);
+out:
 	crypto_free_kpp(kpp);
+	return rc;
 }
 
 /**
@@ -1018,7 +1031,12 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
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



