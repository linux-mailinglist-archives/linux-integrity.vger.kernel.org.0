Return-Path: <linux-integrity+bounces-9198-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDlYBdS232lVYQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9198-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 18:03:32 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF3406314
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8FF6301A141
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B12F1FFC;
	Wed, 15 Apr 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rh0exJPk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CF2E11BC
	for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268825; cv=none; b=c/8sqxxOQkxApcsN3gfMcCSQUlhrGPebngbnQwy5Wz4reXwH7o6BXCCUNUEvOg4wOTOARVyUbNEtDr/D7nNBXkXhOcm4eau6kxQZdQxTE6XGWErcE2SLBzt9IXMwUrydjtEr3FlmoMKw5eSvRBPe4iiPdGzvyDRKzM22M7nttVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268825; c=relaxed/simple;
	bh=2MchBYRo5Hvmgx4SSvk41u0fGcM/ZBQ1U9c7bFPnj3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSYxuZOMeTtyvrvgVVloKMhS+cWb3Ckg7VXy9QMS69T9m6eSfnwQDZ8/CaZyvzjw/SDNInNFoXwCOeUzWWFz3W3T3fDt7VLSuNGH/AzS/UMmWzux3wJVLVyCm61qlLgJb+v45Tj4C/XzphNvpUkT+EYCx4yrdH70MpOlhlk38Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rh0exJPk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358f058973fso7179390a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776268824; x=1776873624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ba704IBSnS175Sq9QaONDvM1ykopZLjTBKoCq/xkw2A=;
        b=rh0exJPkcLKcViTS9g4ufeXlUwhbjTaz49tVNpVuLZsVMKmy1RwFy0X/nfpH0e3uTz
         ybyHGaHE7O1cvK+YaY5m7XehSEG5n545FAMJlHw+LwFS65x6Q7Eo8MECmmJd4dMYzg9n
         dWSdJ8Xhacu6skJIicAPknfRBTSztMcg+kdGc5/iVcBLPQH7UbXm4bTvD3ZXs4RDwxqU
         aOPEm3qo4SSMRKI3cJk5TACVLvHZrRso+gZMk+WyTRoGfjWsrxo9wGF6blKwEKSSt4I2
         E5R6MwWri1aQeXT6wqYugnFoyDKN2+4UjH7lFhVP0xBLHdw6JCV+VyECqIUAqkXqEFrY
         loNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268824; x=1776873624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ba704IBSnS175Sq9QaONDvM1ykopZLjTBKoCq/xkw2A=;
        b=lqJk7ZaG0Fq6bLY+5X3rjxPJ2Creu06XLOy4iuHVJW80mhrvmYifPkjEX7SqrBTiFH
         23u6xCYvH1drG/rXqrWD41shBZhNShbKDBeBuioX1C5YYlM+kD8vIIQ/eERjTZ914m2q
         2Usc73CQ6FI+nrp33tGqbei8q9eLi+4R82p7l9mKtjAWs+yz91BcD5xECm3daH4VLk3+
         9oPT6/JDwsf6k1Y4zpClwplmmnVfSPJaGu1hki078NQUoGJJG4xzOfoIrkOe84eZV80f
         KaHI9HUKBLlCI/e4sy68lnwXuZqwe4q3tGkxTa/egfIm3exwcMnPTp1zcZdh9TZmt2sJ
         gDdQ==
X-Gm-Message-State: AOJu0Yx+BGBvOPOnzIOMD7872fGOvlKbQIDP6+gzyJX/uUmA7CdKA/LY
	ZlmHITSkyHMecuIxQOTGNzCgvYy+A43dngbVYDfbHqo9vs7qwN0JtDPQUKJi06DymLS7NgsZAaY
	IywVPhWa9GwlpDb97J4zpCroypSLknUndY9Pr/UXvDbQO4uqKgXNBTzaCbXStZ7Ys1SHDKqD67S
	6ahBGtSUJkA7InBUYO6ol1x3TkavCvHx8mIyVde9vwxfdiND0NKAGq5PioYzM=
X-Received: from pjbst8.prod.google.com ([2002:a17:90b:1fc8:b0:35d:bd0d:a729])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:33c6:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-35e42847a4dmr22749878a91.25.1776268823182;
 Wed, 15 Apr 2026 09:00:23 -0700 (PDT)
Date: Wed, 15 Apr 2026 16:00:06 +0000
In-Reply-To: <20260415160006.2275325-1-jacqwong@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415160006.2275325-1-jacqwong@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415160006.2275325-3-jacqwong@google.com>
Subject: [PATCH v3 2/2] tpm: tpm_tis: stop transmit if retries are exhausted
From: Jacqueline Wong <jacqwong@google.com>
To: linux-integrity@vger.kernel.org
Cc: jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	axelrasmussen@google.com, jhand@google.com, 
	Jacqueline Wong <jacqwong@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9198-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacqwong@google.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53DF3406314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tpm_tis_send_main() will attempt to retry sending data TPM_RETRY times.
Currently, if those retries are exhausted, the driver will attempt to
call execute. The TPM will be in the wrong state, leading to the
operation simply timing out.

Instead, if there is still an error after retries are exhausted, return
that error immediately.

Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
Signed-off-by: Jacqueline Wong <jacqwong@google.com>
Signed-off-by: Jordan Hand <jhand@google.com>
---
 drivers/char/tpm/tpm_tis_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index acb91bf1e5f5..21d79ad3b164 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -556,11 +556,16 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 			break;
 		else if (rc != -EAGAIN && rc != -EIO)
 			/* Data transfer failed, not recoverable */
-			return rc;
+			goto out_err;
 
 		usleep_range(priv->timeout_min, priv->timeout_max);
 	}
 
+	if (rc == -EAGAIN || rc == -EIO) {
+		dev_err(&chip->dev, "Exhausted %d tpm_tis_send_data retries\n", TPM_RETRY);
+		goto out_err;
+	}
+
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
-- 
2.54.0.rc0.605.g598a273b03-goog


