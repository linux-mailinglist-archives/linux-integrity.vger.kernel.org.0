Return-Path: <linux-integrity+bounces-4108-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CE9C7B72
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 19:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D818C1F22020
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 18:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F3F2038B8;
	Wed, 13 Nov 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMzIN0Ai"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB120125C;
	Wed, 13 Nov 2024 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523495; cv=none; b=XsEl2K0QrzHMb9v7vqGp7K5FQSfe7WougIrJnS53bcy0tbBpTtvclkbXNY2Lfl1u4Wqes+RSzN46uEy61p6UtJAFOJBPJ0eaE4ZdeRSVRHpythKBgr8pNm2vnBLKwxlVa7EIQ6mzlLybtCxaF5Bw/OohaN3DzpxdnZ9YX3Q8+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523495; c=relaxed/simple;
	bh=9b+TTCpVQFtzpW7fgoyoQDsAoWwHFZNEITgQxl3ZD38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wjd+ALIBZ56L8q5yRRt6XMFH3HaMQfmqVAUq2wwt2XD+OC3d5aX3cQQscbk6lOMdaLrQxF+Y18fPKuakKDP5+7tXxnLcvq5oXWFdTUJEv+IJyIEIWYM4T6nHB54hJ6eE08UkchWnYMoNxrl72oMX7pEUbElwQdwjGiGzdr6M4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMzIN0Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D097C4CEC3;
	Wed, 13 Nov 2024 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731523495;
	bh=9b+TTCpVQFtzpW7fgoyoQDsAoWwHFZNEITgQxl3ZD38=;
	h=From:To:Cc:Subject:Date:From;
	b=YMzIN0AiFnKMPxtr73YZGmnkfyafC0lzJsSeoamnxWf0XyCiZCO+nKgXJYKwzAcOq
	 2EG8evfPHOmBBZB1pmbTiM7uLweJ2hkFuU9uCSaTRbR28SmAmntI1Vy/E43rE5TEvJ
	 0Pw5NgwmkqfuxkoH3n2lel3sErtiCUAclFC8OImxsV7PKF5pWpzXznf9vM5hbaFIUB
	 3FFxfKgV2YjxAb0xX7eg2k8pM8HQ5IjE1aBPlIs9S8SEWWNaVycWyTQuqSwrPfOdMy
	 nLBSUIxeIOS1OaxQhTA4eKp/NUAOhmz2cFQNgU7pSYP8+FTRGjtShtRsgCGoUkmiWP
	 3KI3yfG+F+/jw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefan Berger <stefanb@linux.ibm.com>
Cc: stable@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] tpm: Disable TPM on tpm2_create_primary() failure
Date: Wed, 13 Nov 2024 20:44:49 +0200
Message-ID: <20241113184449.477731-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The earlier bug fix misplaced the error-label when dealing with the
tpm2_create_primary() return value, which the original completely ignored.

Cc: stable@vger.kernel.org
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1087331
Fixes: cc7d8594342a ("tpm: Rollback tpm2_load_null()")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-sessions.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index a7c1b162251b..b70165b588ec 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -953,10 +953,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 	/* Deduce from the name change TPM interference: */
 	dev_err(&chip->dev, "null key integrity check failed\n");
 	tpm2_flush_context(chip, tmp_null_key);
-	chip->flags |= TPM_CHIP_FLAG_DISABLE;
 
 err:
-	return rc ? -ENODEV : 0;
+	if (rc) {
+		chip->flags |= TPM_CHIP_FLAG_DISABLE;
+		rc = -ENODEV;
+	}
+	return rc;
 }
 
 /**
-- 
2.47.0


