Return-Path: <linux-integrity+bounces-3108-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03198930EB3
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967BB1F21115
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C901836FF;
	Mon, 15 Jul 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sfhzg7CD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2A18309D
	for <linux-integrity@vger.kernel.org>; Mon, 15 Jul 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028304; cv=none; b=ESBIot7VrDCXnL9W5XXy8m26EjTsO2Go8z9rBcXzZGV1LmHPFftBw+HTklddMGUwNUP+HEZY6ieYEzqutgSxSZTXa3xAVvc0zflUurzb/Jchi9FXvO279N/1BC/jYD7d/YwzyDtDS0sEqdJAHydPn3u/Bj+TFgYf96yGZkdJR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028304; c=relaxed/simple;
	bh=sbyLlhjofZdAJtPNPgnb7LPHkkkU7QhNTT79vwUcv54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=puu+TwOL4aEPDJGV5YDkAzpnfIuXHJ9wlh6XO3PI/hE66Bj5Yjv17+ImFPgu/ChFFeD2BLPRDXHsUTwNvW8t3H42nCcjgoWt7KSwP7uyn54WPfaE9a7izUsmL69yXnyGrXFqQXFANvP41cVB4Wxhjf5eWtNsi4fVPNSTL7tqBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sfhzg7CD; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jarkko@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721028300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwcjV/bevO35hmapj8qjcNG5QxUfmtf63GLtye+Mzas=;
	b=Sfhzg7CDnh2hGMQjojYRzdOIWBGfHdH9UTldSKMuH4eMy5ZcDWpFHIRP0+PMevBgTRZP0B
	S8/Yxu6vie+z+GXxnRfQIoTCnIiy400wuFpWq3rJH98MECMhkkdrq0Ny4823xSWgDTLu/K
	ohfxxzCYJy5r474Fd6a08WfGDUyZse8=
X-Envelope-To: gehao@kylinos.cn
X-Envelope-To: hao.ge@linux.dev
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: linux-integrity@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: peterhuewe@gmx.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: jarkko@kernel.org
Cc: gehao@kylinos.cn,
	hao.ge@linux.dev,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de
Subject: [PATCH v2] tpm: Move dereference after NULL check in tpm_buf_check_hmac_response
Date: Mon, 15 Jul 2024 15:24:28 +0800
Message-Id: <20240715072428.474760-1-hao.ge@linux.dev>
In-Reply-To: <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
References: <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Smatch static checker reported below warning:

    drivers/char/tpm/tpm2-sessions.c:755 tpm_buf_check_hmac_response()
    warn: variable dereferenced before check 'auth' (see line 752)

Move dereference "auth" after we have checked that it is
non-NULL.

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2:
- adjust title and Fixes commit
---
 drivers/char/tpm/tpm2-sessions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 2281d55df545..d3521aadd43e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -746,15 +746,16 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	struct tpm2_auth *auth = chip->auth;
 	off_t offset_s, offset_p;
 	u8 rphash[SHA256_DIGEST_SIZE];
-	u32 attrs;
+	u32 attrs, cc;
 	struct sha256_state sctx;
 	u16 tag = be16_to_cpu(head->tag);
-	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
 	if (!auth)
 		return rc;
 
+	cc = be32_to_cpu(auth->ordinal);
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
-- 
2.25.1


