Return-Path: <linux-integrity+bounces-9197-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EpjFv2232lVYQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9197-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 18:04:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECE406341
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77E0330E32C1
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E7331A41;
	Wed, 15 Apr 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGW74ukM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472152F1FFC
	for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268822; cv=none; b=umgoR5BQnxIAfB2U4pwLPEqx9+KYnd9WutZufdoffCk6zeuaP7gfDeOrACINzvv7Mi68WJa62aOyo0GJnzPwdHnHCB0xuD+wiBCeQALzUDKY/ue+HjuXdcGeEr+pr/Cq97KAVi23ZC8NWiG+gTEQNbATqmY4sDDF6ZSyP1AmorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268822; c=relaxed/simple;
	bh=KAjYR0dCKl/Kn7Rr39vzxCm8S3IpfdR2yr9r8ru/wi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FnvjNDLTFkI4y/+BmbZCFnLC9vl+S+m51TJCcr1gC4RNR9I4bEHA3Q1FFCb1nQwBwDJ/qX9QbPnIY86m+UQFstywlA6uaJwgeR6DgRKt5G72K7dj4pO2a0HJiIxKYIKMjcSeVTy0TlGbRUEQxQGDm4bzv+gkDxVCgMAewZND+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGW74ukM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacqwong.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so8666678a91.1
        for <linux-integrity@vger.kernel.org>; Wed, 15 Apr 2026 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776268821; x=1776873621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvUkmyHrF4RN47+3Dw34ntCqk7+kYPgu+lQVJWZSZNM=;
        b=FGW74ukMjq50UzzdwXSVNAuy/JxSNfKOS1gB1uIqiqlcZrpyyIt2GZAwdTAtEz9dtf
         weSKZTG0926Xaj8eAYeaX81shd/ahf08TKCQmR/P+PVEiJP2Cdlwo5lZCJIv9N3aBSF2
         ET3ULB73hqI4pxOkQCCufulk2jXYkrxOFBr+61765PSSqe/PV9ESeIIQGBOPTUML9n9r
         /46Rhf5a8QnL7dBYYKAO53j1riQRt7f6o6Hi/tlea4QvrB/1TNXqth042yMQ68I1ixq0
         11JfK+GoWCNlS1CsOv4qFVVxQ/bNKHZ/HAfyEGbxGekpvdMWI2N4paugijbSXAbh/0BN
         amqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268821; x=1776873621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvUkmyHrF4RN47+3Dw34ntCqk7+kYPgu+lQVJWZSZNM=;
        b=FVDqv2zPionzBskiBd5TEoH0NyDXFrf8YyZfMVpc1X38oDq2wIhNaFF9gP4y1JaYsu
         sx5HYyXrUstTGh4IRoLBcpIP+xEWI5PM7grjBYFk/+hsrZjNML+q4+AxVQ2MvgrxtjtK
         4H5k3y0n/1WNhfMKJiVcz/tOY2AoVWi2Odv8aD1zxVAmFzAonwbkvmgKiWV1CbfoVtKT
         Ohx7HLo9rB9qa0f4D6/rTJTvAEMvsKaazspjoefP7HhEpuaXkBjZ4Eg/f2x5bG/S4ONj
         pk63M9WeOVYX7iv+Hy7HLMbc2Ob6KXvbugWYTJS1Xqh4z6l6uSlkERuC/BexKpwy7UUD
         piwQ==
X-Gm-Message-State: AOJu0YxYg9E3vFPWf9QY0HhOwQPMqTuMclgeKE7ji2/yOiIsknmzLJGJ
	aLtI7gFtyD0hTOx+BDySY77ybjvuDumAiXLO8YQXBMsfZ04RoSGNoN3leuRbEKY8PQhtd4+RA7a
	Lvf/mPCHY4vXOwb0hZZLVawpuQIyJKuLmRW4qWdszKrKuYgsRtWyPiKxmqg44v3B08AujzDfO+k
	P4jEdeMVtuj0b9LB453/2HGLQkpg6C/iMx6t0p5A3DW7Gsr7MUn5f/MtQ7BWw=
X-Received: from pgar3.prod.google.com ([2002:a05:6a02:2e83:b0:c76:6641:8ea0])
 (user=jacqwong job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a0:b0:398:7796:ddb8 with SMTP id adf61e73a8af0-39fe40dbb56mr24504336637.60.1776268820184;
 Wed, 15 Apr 2026 09:00:20 -0700 (PDT)
Date: Wed, 15 Apr 2026 16:00:05 +0000
In-Reply-To: <20260415160006.2275325-1-jacqwong@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260415160006.2275325-1-jacqwong@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260415160006.2275325-2-jacqwong@google.com>
Subject: [PATCH v3 1/2] tpm: tpm_tis: add error logging for data transfer
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
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9197-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacqwong@google.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18ECE406341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add logging to more easily determine reason for transmit failure

Fixes: 280db21e153d8 ("tpm_tis: Resend command to recover from data transfer errors")
Signed-off-by: Jacqueline Wong <jacqwong@google.com>
Signed-off-by: Jordan Hand <jhand@google.com>
---
 drivers/char/tpm/tpm_tis_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e2a1769081b1..acb91bf1e5f5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -471,6 +471,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 		status = tpm_tis_status(chip);
 		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
 			rc = -EIO;
+			dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be set. sts = 0x%08x\n",
+				status);
 			goto out_err;
 		}
 	}
@@ -491,6 +493,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 	status = tpm_tis_status(chip);
 	if (!itpm && (status & TPM_STS_DATA_EXPECT) != 0) {
 		rc = -EIO;
+		dev_err(&chip->dev, "TPM_STS_DATA_EXPECT should be unset. sts = 0x%08x\n",
+			status);
 		goto out_err;
 	}
 
-- 
2.54.0.rc0.605.g598a273b03-goog


