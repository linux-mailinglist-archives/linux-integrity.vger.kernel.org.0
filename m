Return-Path: <linux-integrity+bounces-169-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965087F3932
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2C282799
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9A05647D;
	Tue, 21 Nov 2023 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF8HDR+Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6DE56468
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 22:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477AFC433C7;
	Tue, 21 Nov 2023 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605915;
	bh=uRT/e1IV/Y1HzSN6eQYcs9k1Bz81L9apwgEI2XgWaq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tF8HDR+YNfB7jLRvyWfuJ20K4Lbb64cSxpg9dy3F2KF8bzJKYW2OmmUYUsjF4PkOW
	 NKcXar9akm9NzkdRWIN6GOjCAkBxJ8JzSCx/l90ayZ+oMwcTUcGZ8uqMXmtVA2c8ZN
	 MOmj7QRJsNbHIXlApR5dJ73tyrhuwdCCd3JA6d4VDC8niSu//6EoMV7lSYjf2J1LEU
	 0J5xi2AC0wq37fEwM+wnIOe4N+ASPuqTxcsLs1ol5DbogAqN0Us2TyjcosXVhZicUh
	 +PGWjHwnSz/XwzPXOvGtndfGh52Ms3Lj8Fk0yOQ4Gfb1YJ9Xq2BKT9aLRhX30wZSDL
	 tPQYA/lUhWjbA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Julien Gomes <julien@arista.com>
Subject: [PATCH v5 4/8] tpm: Update &tpm_buf documentation
Date: Wed, 22 Nov 2023 00:31:16 +0200
Message-ID: <20231121223130.30824-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121223130.30824-1-jarkko@kernel.org>
References: <20231121223130.30824-1-jarkko@kernel.org>
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


