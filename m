Return-Path: <linux-integrity+bounces-2604-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C288CE59F
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47958B2215A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCF127B72;
	Fri, 24 May 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="A9jTMPDz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BC126F14;
	Fri, 24 May 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555692; cv=none; b=q/BrU7Do1wEeVEioyi0UflD2h26sY5dFMePHpqP+Ts++NJ1OlRoV7C6vxQigwGKXHpko3eT1WhBy7Ap80ZUh81N1yY+6AWL5iT7b2gZeN1MunI+LkdGj3eFNeyEcgq4QUomFGgagBRW7E+PV+fFucqaJJEHAdgNBAn5NqPjwO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555692; c=relaxed/simple;
	bh=fwkVUqyuoGV+nactJePBL7JXxmQ07OROf/rnJYMz7OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNMiYCsIWQD7kfbBY77fg8ScPo/too4V0vfW9vRboGoA2JGeLH1DaXORV0a8FI/4jOucfV/ICGy3MvOKcY+oo+iOjDn6Axg9DlZzqkzDPPdyeN86DbzHfJ/O1DNI43byYlOM/PcUHEXLsOPi0zDyLh/OPM7FvdlgDhdhqKUiP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=A9jTMPDz; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555690;
	bh=fwkVUqyuoGV+nactJePBL7JXxmQ07OROf/rnJYMz7OI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=A9jTMPDzqzvMzFyQy1+MqkPeQTPfSxBSfzdMKHOhRXMKmiqz9HOvnzt4Qc23oGraN
	 7AMnUDS/3njSrw6Z9VKbAjy2y5wwzTxq+jvg/ED0iknMOquBrmnj4iCv5EfWKx+KlP
	 WFSdgokzipGvoVlYu8wWe91i0rNPf2aP/aftEYrg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 284851287771;
	Fri, 24 May 2024 09:01:30 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id D3ksWtT7ACPw; Fri, 24 May 2024 09:01:30 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9835812817CC;
	Fri, 24 May 2024 09:01:29 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] KEYS: trusted: use encode_OID for OID encoding
Date: Fri, 24 May 2024 08:59:54 -0400
Message-Id: <20240524125955.20739-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
References: <20240524125955.20739-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new routine takes the OID enum instead of needing the u32 OID
array explicitly which reduces duplication and the potential for
mistakes.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 9c7ac2e423d3..b6f34ff0ca5c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -19,8 +19,6 @@
 #include "tpm2key.asn1.h"
 #include "tpm2-policy.h"
 
-static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
-
 static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 *src, u32 len)
@@ -31,6 +29,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
 	u16 priv_len, pub_len;
+	int ret;
 
 	priv_len = get_unaligned_be16(src) + 2;
 	priv = src;
@@ -43,8 +42,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (!scratch)
 		return -ENOMEM;
 
-	work = asn1_encode_oid(work, end_work, tpm2key_oid,
-			       asn1_oid_len(tpm2key_oid));
+	ret = encode_OID(OID_TPMSealedData, work, end_work - work);
+	if (ret < 0)
+		return ret;
+	work += ret;
 
 	if (options->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;
-- 
2.35.3


