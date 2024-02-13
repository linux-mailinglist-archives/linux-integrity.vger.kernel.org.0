Return-Path: <linux-integrity+bounces-1164-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962A8536F1
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AB01C22514
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690B5FDBA;
	Tue, 13 Feb 2024 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cyUPRw7x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99C5FB94;
	Tue, 13 Feb 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844452; cv=none; b=GtaT3MBoPRlwTd7OqZ5qrvnDcsXDOS7Wmug7t34T9Xd4RarFOyOV7sN6BHcXyhohg0kEHMWDAGQbqW9fqloDlM11OltU826Ly68d9zD+oeJ3JQdK0/9pujJyIu4rtILhw2ekPvVAP24g1zh/N/9QMyiWnm6KbuvU4V2e38BsINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844452; c=relaxed/simple;
	bh=4qxQrwlnc+5YPOt4IlE0P++QkRidh610wXXOVgj1Ql8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Icjsf/YPdZMylR0LmFqz3HqB/t70iVH4z8nNSWLBpKRxOB3bFBeeuqWnslJAIRxrgv7Zd+Qs08BtGD5NIDI/552J73YpBY5amMZhgKIppCVEDfiUcIBr1RIm+f73YxwoLF6fG8WnvIDyeqCVJqlf4aF5JT3vcQN5Qcp5vxnpJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=cyUPRw7x; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844449;
	bh=4qxQrwlnc+5YPOt4IlE0P++QkRidh610wXXOVgj1Ql8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=cyUPRw7xLe55pOKlQFGWsY6qhWKnTDPkq7UCGa2PJbGOB08ZsE5+Mx/M3KeyA+Ttk
	 0TYKtf5ZXcEeFL3BaxjMV8K3SQEXneH7nkM9JzpUk7f0CKmyEZtj+VJVX/9jwkJXJK
	 Ee0VlaOT3RoVLXJuIXsyhOwzfY5PFDSp2bTaqLtY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0DC591280BAC;
	Tue, 13 Feb 2024 12:14:09 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id aKD9u3mJaakk; Tue, 13 Feb 2024 12:14:08 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 401721280BEA;
	Tue, 13 Feb 2024 12:14:08 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 01/21] tpm: Remove unused tpm_buf_tag()
Date: Tue, 13 Feb 2024 12:13:14 -0500
Message-Id: <20240213171334.30479-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
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


