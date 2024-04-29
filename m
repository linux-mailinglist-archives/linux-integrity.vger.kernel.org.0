Return-Path: <linux-integrity+bounces-2258-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F6E8B637F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADDF1F22D97
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF521411F0;
	Mon, 29 Apr 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iP4idAs5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD213AA5D;
	Mon, 29 Apr 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422507; cv=none; b=kV5aoDYhTMxmIl6Hor5U5MXOLcZdkzlpNJOvotadjw3wLHH+jlm9cp1pcfo2NRjq++RP4aK0YsGxmvCmYPlWDmqBEjbzjocfuOeCQOPKVj3d7ZSo0hGicwqOKrzEzPisoQFe21P7TM9urJe7YDMUqIMSjoyxRZxyfNEdNdFnBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422507; c=relaxed/simple;
	bh=4qxQrwlnc+5YPOt4IlE0P++QkRidh610wXXOVgj1Ql8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itLtHiANGwpvP77PLOhyt/mech6bgcCCZKrBsyf5xD8D5s3PfS6JrRHjSdsc1z6wvRT4Aj67kQBSOkwZd0DP3MVXkvAKRLFmrSGdCSKOllbbwHm6Dz6egg1tLH6eN5dGVJf0F29vU9Z2IU1n8CBQL7q/pSJEHkMg4JnlFfcKutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iP4idAs5; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422505;
	bh=4qxQrwlnc+5YPOt4IlE0P++QkRidh610wXXOVgj1Ql8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=iP4idAs5UflWNZSmLFSVnzASL2r247Ql+2g57DF24mWsmp0J7TeseDkk96gTDRXiZ
	 Xr+csCLR24+6n49FfFnc032SAVBVdq78UCtnVzQwlgVJtgEOvrcVJf07PRDwFWcaQM
	 EMra2FmU+hkfIaf2AswSlmK2sNTXZT0vw5CrgtUw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CA54D1285D65;
	Mon, 29 Apr 2024 16:28:25 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id T32Q_sndhkbk; Mon, 29 Apr 2024 16:28:25 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2684D12819F3;
	Mon, 29 Apr 2024 16:28:25 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 01/22] tpm: Remove unused tpm_buf_tag()
Date: Mon, 29 Apr 2024 16:27:50 -0400
Message-Id: <20240429202811.13643-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

The helper function has no call sites. Thus, remove it.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
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
2.35.3


