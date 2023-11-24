Return-Path: <linux-integrity+bounces-204-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 996197F6A63
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 03:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE091F20D67
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Nov 2023 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FA64C;
	Fri, 24 Nov 2023 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFpJGdWU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40306646
	for <linux-integrity@vger.kernel.org>; Fri, 24 Nov 2023 02:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670D7C433C8;
	Fri, 24 Nov 2023 02:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700791364;
	bh=drr8cXKrF5OD9PCoerAcJq+7HVp0o9GWJzjGqXuSa0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFpJGdWUmKdA9n3xca5vSrGJX8BPR0hs+/8k/qGWeW2sK41n/GORNaCGPg8ZaOUhJ
	 OMUYoBeouIM0XEp/J7GnOqjdB9kSa1eJieBxbdlHxEYbc731SYb0b6TpmiQzDqV6sv
	 hA11DrVekKz8Ct9Wu+/AM4yRWzooFheBgmWeOu8CLTJNgjN9zWPeeBZZjv+qYkUHVT
	 +DT1Wr1qYurobhyFC2TzClkmDPYs/Ay3Roqqf37P7HoGVx1DF59pNfOBWbQbE1ct5K
	 sFKFjza0oln0Uh4JOw7dVJuWcT+ROmrEnNkY6zTpuVu3bZowwTld8wfPuzE0+MOVE9
	 sflXqRbKCeMnA==
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
Subject: [PATCH v6 1/8] tpm: Remove unused tpm_buf_tag()
Date: Fri, 24 Nov 2023 04:02:30 +0200
Message-ID: <20231124020237.27116-2-jarkko@kernel.org>
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
2.43.0


