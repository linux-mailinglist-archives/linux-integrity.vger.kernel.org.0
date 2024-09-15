Return-Path: <linux-integrity+bounces-3604-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E6979806
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660E281FE5
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7D1CA690;
	Sun, 15 Sep 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA3v3jEU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC617C91;
	Sun, 15 Sep 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423502; cv=none; b=pBt5rEB3nL9OofHSkTMiERi/g3xBOqXnqiPV5kIY3OqzQMGOvkrtnkg8j9fa6MyAa5nZRwp7CURBLy5roVCDBEevx+8pZ0q2RmjgX1LEbiy39BmlmeSCzmDK9H/aiBxdsN4en0+DXwMxvUkgY1lu2z4azZ47r7hX242RVgt88Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423502; c=relaxed/simple;
	bh=OMNS3XiyQZk7/mSoZqBVQ3dWvXlMWzK4cHdqClsviZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0lqKaq/xPlv7wXiYSdkA0M0wlcQJcocwxkOnDgBqAj+vIxz42tUuyzD3UwJobH7LhutYdcmCnrTM8RXT6uhpMkAvpFR+RFSeRkWOEPdSijLkyAorhsw6HTev2yw4CQhi7gPRij1CFfqVt2slr8R6w08w64C4qicbImRPThS27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA3v3jEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CBCC4CEC3;
	Sun, 15 Sep 2024 18:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423502;
	bh=OMNS3XiyQZk7/mSoZqBVQ3dWvXlMWzK4cHdqClsviZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA3v3jEUXWjxg5ccmhka127pM+QjBbuYRcywZFOrneuYZnQi9dqs6HbjaK+kRZ/fK
	 pYiAi08AP2jXOyE12opn7f2izKqMSVWry99KvBNGCc3sd9YRLrp2CQJ+X7H64/tTWZ
	 7I+25VrcAEEGdm8qc8IRr3ZoQWaZiOW1KCoMGAVUoQ0CfJnKGiUWvq4klpZDx50k0e
	 AmUMcmlN5SecWrrQh9u7whbG/aUuT6IvWqajpVkj9aRcFQ1ekIAoSwg3JfNhGeKQGF
	 N88M2MpMVcczI86QUa/kaO9Uy20EuRnq34VWJPSssc2LlLATaBiQebdgdmy4Hp1t8v
	 PiBaqWfOBoBUw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] tpm: address tpm2_create_null_primary() return value
Date: Sun, 15 Sep 2024 21:04:44 +0300
Message-ID: <20240915180448.2030115-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240915180448.2030115-1-jarkko@kernel.org>
References: <20240915180448.2030115-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() does not check the return value of
tpm2_create_null_primary(). Return on failure.

Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 6cc1ea81c57c..d63510ad44ab 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1288,8 +1288,10 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 	int rc;
 
 	rc = tpm2_create_null_primary(chip);
-	if (rc)
+	if (rc) {
 		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+		return rc;
+	}
 
 	chip->auth = kmalloc(sizeof(*chip->auth), GFP_KERNEL);
 	if (!chip->auth)
-- 
2.46.0


