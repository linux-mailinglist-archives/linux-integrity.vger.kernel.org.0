Return-Path: <linux-integrity+bounces-9157-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEPdHeZo2Wn5pQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9157-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 23:17:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27BF3DCCDA
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D669F302D977
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Apr 2026 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2F38F938;
	Fri, 10 Apr 2026 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUrEUSmq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A363A8FF6
	for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855653; cv=none; b=oGzE+Zh5dmRIcy+J9xnnD41PajkNGoGllrQJncn3bvHFuSk3OCCjfrGwntt9DogXPUkVG8B5pvvqwaHTSZw8cVnXaj3rRWtxOwq8vjTV9zv2JebYAHMon2nKLfibPcJc7ycdxXN8DdLBqgfgwN0bplASmWyODyMJrFpZmHF3klE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855653; c=relaxed/simple;
	bh=FYQDOltfrc3opjJ2E0nvh2wcU3TveNn38McFy/IMHa0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EIdxbCyFmOzvuHMdLZMlXX+cmS6CJbnZA15eJHThW1ogXwwXI28fZiRYBMzXPb8aUUcYl7ij/7CiYRGYFzInuEsHPYoJuS3WLssQ1A4syeQK3Wr3x2INmPJCz4aEOPvUEs7nJi5bc/nm4z9qtxU33mx5ag0BAnaeAmynGOGOxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUrEUSmq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24611696eso19956445ad.3
        for <linux-integrity@vger.kernel.org>; Fri, 10 Apr 2026 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855651; x=1776460451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/bR4j11/2b2AFnB0wDJRBiDOFrgnvZtW0CRGmn1RLZY=;
        b=WUrEUSmqNWsMPbQ1ke9wVYZlkpm+NaYO1GTlXpRNK1lqT/9qvBWvKjwLkN1TGYFyiy
         W2d/lUlj6YEgfFLoz5xOhTPTijYB4d/KlLk1vrSeWH4GeFDgJGDRJMMBBumiG9VZk8lK
         kc9WFhpRRmxIe5l7WP4SISbKnaLtwPkrYRO6uGHBUAf3s10zc21I4Tb5XbUnU+g1bAjs
         7VKNKGTvsKu1r7dWngQTSy1a+wotGMBBq2BnlxnGnMIVT7PA3Kl9g6AATDhoiRDCJgOT
         3fKunQtogZRcqXmESns1w8bYe39NE1hY1F2d3tExggq9IT6wzTubEJq8x8WqTbYG6Ls0
         Sq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855651; x=1776460451;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bR4j11/2b2AFnB0wDJRBiDOFrgnvZtW0CRGmn1RLZY=;
        b=KmjypLYDAB22oUn4UEd8c2g+6/hg/RYjCUKhUCK3G6A8bED8I0UNkdWKnj250tX2Xn
         tJcFQhg618BjI1qZnhHna/HZbZr5NMCuRZeq7qjxh/mre5pA72BYR2gRtBR9Cu4i5N4/
         czmHA1bon+Gg9HH1jB+nLimZomEu0osZ83LMUJSRXiedeDX2hpWhYz/dY683GNaKc4JF
         yH80GgrZTr8c6T/g+qESWaW2hJoCI+GceOb/qzcUvFfFKMkc3/rG2cG2QaA2+LOCcde+
         E0hsMRgRtCNBMCRHhpDc/vl83d5bzkVW2HC3BTCiuBUWAUp59ZUOliO8ArOlWkQmYvOU
         uqQw==
X-Forwarded-Encrypted: i=1; AJvYcCURFN0ObFeYO5iQv/43mzvZaEr9LrHHL/4CsKe3CbwSyIhb+zu48LC5fWw195WimY5KaJtNyX11nSiZO9ajeAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlM4RyZdIaQDAmjEGzF/yQQKRc1cfeszCivx2YU/M+yKPZLM4t
	fmK40uVkXUKeqsHzu/BcrwS7WKlnFzmmqW/ew2ZPWUKSrTqS405OA2TWlCXJZTktFJMS/wPshVm
	WK4NaCF0QLzNBAA==
X-Received: from plbbj8.prod.google.com ([2002:a17:902:8508:b0:2b2:4d5c:3eec])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf05:b0:2b0:afbe:4e14 with SMTP id d9443c01a7336-2b2d5a8eee1mr48142395ad.40.1775855650467;
 Fri, 10 Apr 2026 14:14:10 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:13:50 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211350.1132611-1-jacqwong@google.com>
Subject: [PATCH] tpm_tis: Check for an error after exhausting send retires
From: Jacqueline Wong <jacqwong@google.com>
To: peterhuewe@gmx.de, jarkko@kernel.org
Cc: jgg@ziepe.ca, Alexander.Steffen@infineon.com, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	axelrasmussen@google.com, Jordan Hand <jhand@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9157-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacqwong@google.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D27BF3DCCDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jordan Hand <jhand@google.com>

tpm_tis_send_main() will attempt to retry sending data TPM_RETRY times.
Currently, if those retries are exhausted, the driver will attempt to
call execute. The TPM will be in the wrong state, leading to the
operation simply timing out.

Instead, if there is still an error after retries are exhausted, return
that error immediately.

Additionally, add logging to more easily determine reason for transmit
failure.

Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
Signed-off-by: Jordan Hand <jhand@google.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e2a1769081b1..b78937841879 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -471,6 +471,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		status = tpm_tis_status(chip);
 		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
 			rc = -EIO;
+			dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
+					status);
 			goto out_err;
 		}
 	}
@@ -491,6 +493,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	status = tpm_tis_status(chip);
 	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
 		rc = -EIO;
+		dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
+				status);
 		goto out_err;
 	}
 
@@ -552,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 			break;
 		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
-			return rc;
+			goto out_err;
 
 		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
+	if (rc == -EAGAIN || rc == -EIO) {
+		dev_err(&chip->dev, "Exhausted tpm_tis_send_data retries\n");
+		goto out_err;
+	}
+
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
-- 
2.53.0.1213.gd9a14994de-goog


