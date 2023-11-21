Return-Path: <linux-integrity+bounces-166-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE77F392F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C492AB2104D
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1E5B1E0;
	Tue, 21 Nov 2023 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPyXwNgn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D95A10D
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 22:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4429CC433C7;
	Tue, 21 Nov 2023 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605901;
	bh=Y56AO+jdgKKv2wjrPycIECDNz6SB1qKX+7if35pK/Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPyXwNgnS7zCF6NPrE/wIwQ55UVOJ0qF6KkWl1qTqcOf9PV1bPFpjhn5GQmTvNPwK
	 ID2TjXgxEhkiSYmImRMOZ42tB3tsPxRCL2qix7iI9ihdMiHtqpQWvYq/dwceU2Fk6H
	 n9ddxB+8B+ARG93ER8ByfbcDImsZaYu7mSLANI9xrZTGzUSqt9KFQObprNhqSE1r0P
	 eUxmzPUJrzYIB2f5w+tC1tszr79TRdJo6tX7LlvKXFL48lB3Ez4wU1hTx5mKmRp3Tm
	 LmpPoquslb2qkTj7ZQZZwZyoDH7oNzepnMYf8As3boK1L+QeexKJ3MIakFmy1/hQyr
	 zRdE6BK7O9vsA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Julien Gomes <julien@arista.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v5 1/8] tpm: Remove unused tpm_buf_tag()
Date: Wed, 22 Nov 2023 00:31:13 +0200
Message-ID: <20231121223130.30824-2-jarkko@kernel.org>
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

The helper function has no call sites. Thus, remove it.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v1 [2023-11-21]: A new patch.
---
 include/linux/tpm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..6588ca87cf93 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -358,13 +358,6 @@ static inline u32 tpm_buf_length(struct tpm_buf *buf)
 	return be32_to_cpu(head->length);
 }
 
-static inline u16 tpm_buf_tag(struct tpm_buf *buf)
-{
-	struct tpm_header *head = (struct tpm_header *)buf->data;
-
-	return be16_to_cpu(head->tag);
-}
-
 static inline void tpm_buf_append(struct tpm_buf *buf,
 				  const unsigned char *new_data,
 				  unsigned int new_len)
-- 
2.42.1


