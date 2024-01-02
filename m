Return-Path: <linux-integrity+bounces-592-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A590821FF5
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8231F22F67
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jan 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F0615496;
	Tue,  2 Jan 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hqBQRlXu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A015481;
	Tue,  2 Jan 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704215217;
	bh=I6Gvq5Hf1pNtrzsESMyjfVDjeg4UkqOIhC0QdXTOBag=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=hqBQRlXuAv23y/2D9kP1c4iWt9RvtAcHhcNputeA/Hfn4E5NvhVhtLveBCgko4r0y
	 wOh5lfu/EGfIZ9Pgd3e8qYrb7Il1X+AFy4sgmqcXttOrFtzO7nDq54VFdT1nZ70gYU
	 PDcoW2JVU4DbzFpPx1wLNogElNhJcTJj5Fj/LEOM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E4BF5128680E;
	Tue,  2 Jan 2024 12:06:57 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id TLzj-YvbkZ4C; Tue,  2 Jan 2024 12:06:57 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 56FC912809EB;
	Tue,  2 Jan 2024 12:06:57 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v6 04/20] tpm: Update struct tpm_buf documentation comments
Date: Tue,  2 Jan 2024 12:03:52 -0500
Message-Id: <20240102170408.21969-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

Remove deprecated portions and document enum values.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
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
2.35.3


