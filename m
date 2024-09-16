Return-Path: <linux-integrity+bounces-3614-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7AE979FF1
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E3C28335D
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2024 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E757149C57;
	Mon, 16 Sep 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb+W3zzG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA714F9FB;
	Mon, 16 Sep 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484851; cv=none; b=oIFx1tX4fxHjJx7r7YG561eYUuZALPfVqSCErlhcWwAn/a9RTIVDMXun1DoPCgo8NsrIkXBAhC3xKeC04IeTMXxIl0bRE2ntgWqS/SoFxDKKgWVzcccQKDXXs/iuY5+hB2nmasU/6urc2oVhnsKb4SWgXgUeH75W2xFdE/V0iX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484851; c=relaxed/simple;
	bh=WKndujFOl4HJUdZxPiD2QOGHxLXb87Q7q/U3qAy0Wpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue63OpltDMk8MGkkWYJGg8xnYP1+GdEk17uCtq0aQlVcWSiz8rpuQWr18DO7jzlDmGoKhJWR8KQfu5dfNUlAeIB1YO4CYkGutov+Q/vJAKrMq7I+LmglkSnkSTb8t2Bu71JRwGzSjnZtk+AoN4dTTMuZaP7Xac+sV1GH24EKl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb+W3zzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0FBC4CECF;
	Mon, 16 Sep 2024 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726484850;
	bh=WKndujFOl4HJUdZxPiD2QOGHxLXb87Q7q/U3qAy0Wpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb+W3zzGl63tk4zLCIBX91MR2i7HIYHfO/b+VmSAM1/EFS7UY9RfhUueMNELM0EaU
	 Hbirwy/QSDw2OkLsZigJA1MJNruSpJfhEHEYkj+1O8owi/NdWGwKuUYOy7+AEW81hA
	 BVTfmqAHogvGlNGV7i/vfkiF0LEj+GuLD4iczuP+0QboZVicPVK2VNsqVaQm+RZOnb
	 5jKyZMst4CWkz17truMx7U3NThJ20mXDYNUHPhCsKA7jAY/ZPLWOGxfuf3RSfT3I/q
	 JTa3OCCnquJ7CAIAqPFRLMGY83GSEcoGRNw+XutJZqqE81QOnw6OKzHrmp0XE+JiRR
	 HBlzqxzUlS6Rw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	roberto.sassu@huawei.com,
	mapengyu@gmail.com,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2 2/6] tpm: Return on tpm2_create_null_primary() failure
Date: Mon, 16 Sep 2024 14:07:07 +0300
Message-ID: <20240916110714.1396407-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916110714.1396407-1-jarkko@kernel.org>
References: <20240916110714.1396407-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_sessions_init() ignores the return value of
tpm2_create_null_primary().

Address this by returning on failure.

Cc: stable@vger.kernel.org # v6.11+
Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Refined the commit message.
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


