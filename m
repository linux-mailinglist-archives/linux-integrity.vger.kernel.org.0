Return-Path: <linux-integrity+bounces-8136-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 122ECCDEA27
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 12:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98430300EA08
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Dec 2025 11:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1AB2951B3;
	Fri, 26 Dec 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9+r8AbX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AA319606
	for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766747561; cv=none; b=S2327ucTZT+T/D6uPuIZm6PGbSGqJVTGPyegxEEUnPX+714rMQBS2G8RjnGdq31Ois4UqEuEYoymSaPkft1Z+INlHT+j16YwC8fdJ7uktqNANqe1Z8EoMa9Gon6Y8iswFac1CKD/2vxG0yxDeIiuRXRM7FjIiT2Yi7x7qT5OfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766747561; c=relaxed/simple;
	bh=hw1bj27kMbXwh1zG/22Eh7NFEQh4926uNc37dty2WoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnhNOrCoo7fNPPtpup91QMu7pvtyG11gSg5fYavZYUCLS2/5DI4+lwzg5MoX6xW7K/xTR/Vd0sgb83n6x9gAP5h+yiEljujbIereL3yiJUXVg5aEuy+oc7Qm27RaZjwzx18AEb0xUiXlDwDXhzNxAEECVfwUTeu76aubBNPRtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9+r8AbX; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-595819064cdso11548228e87.0
        for <linux-integrity@vger.kernel.org>; Fri, 26 Dec 2025 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766747558; x=1767352358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynvuXZS2Mp8RJ8JsAjxV+N8DVr9ucO+9YHRFWnhu0p8=;
        b=b9+r8AbXWCh+aIKnCGkBf3s3iSB4CgpVJmgp6swSP1i5XtY9UOKSIvOLqDQ0rFD91l
         YQbuHt4iXfwxvr8YkTjnzN9fEXS5x5l1Mvm7BlebbgObjIHS4VIFXltwfyyB8dSM2CiP
         O1s9ZTtKPQqj9JuuN06suaBqVsoyLSx9nb+dhQNeTGuMd+eAhsfl2ai18ZvAvKkcGYYE
         SAju4W69EIDTBDlyKaG4/UURP3N8UjMTTqmcOKDlYOgg2ZKPj7A9imR663QN/s/CHRbq
         QaD4ShMGLmciljYCHX57i5pTLvIdwxc1n3KfoGB32GHv+PBG7HwDwpSS6EOJJymn9s2H
         uWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766747558; x=1767352358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynvuXZS2Mp8RJ8JsAjxV+N8DVr9ucO+9YHRFWnhu0p8=;
        b=hFxZJr87msypf1dpbbqVzhdYMBEuunEdZLLAdVsp9TwtfZUXHalZGtdkrL0wmI1hl2
         f39FMy5yBqFTpCHmSQhwFR50Gdtopk+x4Wh3k7SLTOdmC6wQoNdwnuXczQVJP9eVqA8I
         oiFV7HjwstwiIWexSMqN7lujMhSRMLoKoGOE4fCwvy2ZgU302mpsQhAfMEWmUZrzla39
         pfMGeSjtBpXwO+oGFtvInyvHEGMZBCRhlttZBGEZz/jtBGNUia4uCuHg4GS4oAmexZrm
         i8UJfUph5FfuSFT6tqEWicG3Uwl1uVisbvUhDKA/QqMFwXKDR7t23K/ZkrQGboa3OMY/
         todg==
X-Forwarded-Encrypted: i=1; AJvYcCW4TCgSh6u6OHvnWl13Tl4NINj4z9rEkfkU3A94NPFtefPHAv8SY1pRZUUZZt4elx2aewMNFxWyS6XFOI9eEWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15kNg5DDx8O2YCpo5RC+8BflTVnNhr5Byah0H6JyyzY2MKqNL
	YD8PWw5A45DgR/Y9LmJm4NS6H36VKzYj0yOgNLcixikFabeR71oFSnyH
X-Gm-Gg: AY/fxX6vjsvYM/FO8mpMcWnoBb+eIGxlUmVzkvwMmu/ZC+kC61ZEKOhfAlyO970I5zy
	gKKKERBKew+R017ZloOGcHa/RD9xRu/u/iwbcMJm+XzjLVWw8T/jIg+AO2xG+agipoCh5y9Sj5i
	OpF5rU75AzVcjRLWb4QBhqsJfdbLRfS2KG1CajL+XVj0G7F8RecO9fA6bqM8QDZdHdoFPS0htlv
	ft3C90wkOzCH2GXOVjL4Wc/pXRR1Y4AAOIPRQ0HG7XLOu0bXo2OwT3PgCGXR8viYlmOzbFpOTa0
	JemtTazSHqmg8LJ50scGU+PqGOHXIw14cKc3xOKjX1Veq3F+b3MtICCQ63C4ygbzmHdaP9E7DHm
	7+0wVJ37w8DWJfs2jgaksorpQwT7gJ6KhwZC5ieCx0K1qqnZTQ2WIisSBr8R24xLqrrjEmMS/OF
	7PUq0ww///JOgp5d8hB967zeThSPwvj3udMHMG+g==
X-Google-Smtp-Source: AGHT+IHMNSbGH8YQYSxclB2aM2iMCofCPYxSNgbKNci6EY3O+wPuQ3mTKHM/nJpMe004E5r0n0zpsA==
X-Received: by 2002:a05:6512:2310:b0:595:90ce:df8e with SMTP id 2adb3069b0e04-59a17d042f2mr6441963e87.5.1766747557859;
        Fri, 26 Dec 2025 03:12:37 -0800 (PST)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b2958aae1sm2340838e87.41.2025.12.26.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 03:12:37 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: tpm2-space: Skip handle check when context load returns -ENOENT
Date: Fri, 26 Dec 2025 14:12:16 +0300
Message-ID: <20251226111217.50747-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tpm2_load_context() returns -ENOENT, the session is marked as
forgotten by setting session_tbl[i] to 0. Although tpm2_load_context()
also sets handle to 0 in this case, the subsequent comparison
"handle != space->session_tbl[i]" (0 != 0) is always false and serves
no purpose.

Add continue to skip this unnecessary comparison when load fails with
-ENOENT, making the control flow clearer and fix possible
uninitialized 'handle' variable.

Fixes: 4d57856a21ed2 ("tpm2: add session handle context saving and restoring to the space code")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/char/tpm/tpm2-space.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..7dfbe07ecf5b 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -213,6 +213,7 @@ static int tpm2_load_space(struct tpm_chip *chip)
 		if (rc == -ENOENT) {
 			/* load failed, just forget session */
 			space->session_tbl[i] = 0;
+			continue;
 		} else if (rc) {
 			tpm2_flush_space(chip);
 			return rc;
-- 
2.43.0


