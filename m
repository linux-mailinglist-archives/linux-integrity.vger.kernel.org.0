Return-Path: <linux-integrity+bounces-207-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1F37F6A74
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335A82817FF
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00F64699;
	Fri, 24 Nov 2023 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1rX6Y/q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAE4691
	for <linux-integrity@vger.kernel.org>; Fri, 24 Nov 2023 02:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA6FC433C8;
	Fri, 24 Nov 2023 02:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700791374;
	bh=gORzZnTnBE2H3oHce9S3/9lGlc/hZRFZ0MDxFGFZxTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1rX6Y/qnWHG7DB8DhMf+Oo6R83MLcYs5VO8KN29H1f0Uno04N+VG8nWMYbLrOrM9
	 54L5a/kFUw3OX1GkLd+pYmXX8puiHLJP3k5e1+LA2x35G7Qukcc9SYCnagVaR17CYu
	 pHrfN2Mw+MrG78Iozu7C4tYfBxgmz11+rI3iB7aHPk3lCHVv1AQ0F7XdEH2ObXbhkd
	 /ASdym8QobCwuqXiUaeSQfh/5K2HJBn5ttlE4Puh9X1TtTQG2d3spuGB7OfIOBv3pH
	 U3MJ0AFdGXS0fCNTi+7S34YRf7QxWXD/n2emLIaB0OolgbahX2jOzPBFQhZMkQh09r
	 Y3jC5GHTQH3nw==
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
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v6 4/8] tpm: Update struct tpm_buf documentation comments
Date: Fri, 24 Nov 2023 04:02:33 +0200
Message-ID: <20231124020237.27116-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124020237.27116-1-jarkko@kernel.org>
References: <20231124020237.27116-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove deprecated portions and document enum values.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 [2023-11-21]: A new patch.
v2 [2023-11-24]: Refined the commit message a bit.
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
2.43.0


