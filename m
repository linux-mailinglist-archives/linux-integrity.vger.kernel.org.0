Return-Path: <linux-integrity+bounces-157-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257527F37F7
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856AFB21056
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A454668;
	Tue, 21 Nov 2023 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgdOdZt+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DF54666
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 21:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3980BC433C8;
	Tue, 21 Nov 2023 21:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700601456;
	bh=uRT/e1IV/Y1HzSN6eQYcs9k1Bz81L9apwgEI2XgWaq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgdOdZt+Y9rMfJnlEv9QFxcC0DKqIUvHQWdzlNLVbvSmkSp3EkooBPT6i/A06uCZ2
	 joc8x38odsjBA8JbBWrjpz8lUPetXbG2/yOJUn4D586vSWLkNKYi3dG1upp8dVJwBs
	 E9Je8uhn5Vhe3Y7ZhZhRwBUHhdE0SrTtUs3JelW+KV/pqyJJij3Lul2CvXEKqScoJO
	 8i3OMfxtjMQVAOVfFhrpttvxgOwvvyviEQwQTRxidETv763qv8zJjCwIT4EXQUGh2U
	 ZRUpw6MEW+NdqAdiCBC869WgdByzsFm6H0Ca/I4Ku9aY087vylYd2qACnZR8obuB1Y
	 CWnCvfozAmf7w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	William Roberts <bill.c.roberts@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <jejb@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Julien Gomes <julien@arista.com>
Subject: [PATCH v4 4/8] tpm: Update &tpm_buf documentation
Date: Tue, 21 Nov 2023 23:17:13 +0200
Message-ID: <20231121211717.31681-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121211717.31681-1-jarkko@kernel.org>
References: <20231121211717.31681-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove deprecated portions and document the enum value.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 [2023-11-21]: A new patch.
---
 include/linux/tpm.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index bb0e8718a432..0a8c1351adc2 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -297,15 +297,14 @@ struct tpm_header {
 	};
 } __packed;
 
-/* A string buffer type for constructing TPM commands. This is based on the
- * ideas of string buffer code in security/keys/trusted.h but is heap based
- * in order to keep the stack usage minimal.
- */
-
 enum tpm_buf_flags {
+	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
 };
 
+/*
+ * A string buffer type for constructing TPM commands.
+ */
 struct tpm_buf {
 	unsigned int flags;
 	u8 *data;
-- 
2.42.1


