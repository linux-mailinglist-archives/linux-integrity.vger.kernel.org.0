Return-Path: <linux-integrity+bounces-163-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD47F3924
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F78E28283F
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B256754;
	Tue, 21 Nov 2023 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idbuuFfM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179156468
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 22:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D8EC433C7;
	Tue, 21 Nov 2023 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700605790;
	bh=Y56AO+jdgKKv2wjrPycIECDNz6SB1qKX+7if35pK/Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idbuuFfMwKFL0iyCutYWXuJIooDhF73x8euFxOhC7EKEvw+6Yc5EpK2TimQbXQRIQ
	 Oe6iI4hy2XxIC6XhyP7KGmymfOxjKKC34gO54coa70JEZGaiwtx30W2VRgFJ9qKJlc
	 1K1UTH8hWw3ZrhEanBhOM//WW+/fDfbLWoHIGP/Zw1oM/1mRTsZ1tpfCK60yl6ZuCi
	 baZO+JrFOaoPwtgw1+YYQZIirO2dncGOAvQb26W5UEDMC8yu7RSRQBLup5s5PymbX0
	 PXvwjCVP6jFoO94kzBQ3NXZg7CEdmdlym04xaDy8xn652NoEXU9roOMp11BRuaOliB
	 0LiL2tdGocyuw==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
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
Subject: [PATCH v5 1/8] tpm: Remove unused tpm_buf_tag()
Date: Wed, 22 Nov 2023 00:29:34 +0200
Message-ID: <20231121222941.30222-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121222941.30222-1-jarkko@kernel.org>
References: <20231121222941.30222-1-jarkko@kernel.org>
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


