Return-Path: <linux-integrity+bounces-2605-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C59B8CE5A0
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB8E1C20A41
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8585C79;
	Fri, 24 May 2024 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tIyI5/vL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652EE84FAC;
	Fri, 24 May 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555699; cv=none; b=KSvq/fNCZ4WP1DRe4roilx0qU3EybT+QK92fCFHGNDc6WdIRSE/VQRbzBxOpxH9jFvfEzV4uwxwgyAI+RBxxjxTxznfkG/M3YSXH/XkkwLkr/qtHu4Thp4/ITjy1bduX1l8G7pkr8FO03GxE9S0dgxGSVjIIlvlNfFGxQfN5V7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555699; c=relaxed/simple;
	bh=DiayMIgQMfFI7pbgJrFjn+K43IClPfvZHrsfCCfRYtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4kcYczXSUbRLlAT/N1yOXpjFpiAbU9COljL1H1oTxE7TLwdXUpTOY/nKX37P5fzRl8ujdVGpDx8uTALvL4cAdDspNaSkhxeuYv9zNSXo/TrjnTkftnYJI00681OQAMAkss6KBiL2yqv1DSE/sWIbi+vaPzO8q913zXtgoLHHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tIyI5/vL; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555697;
	bh=DiayMIgQMfFI7pbgJrFjn+K43IClPfvZHrsfCCfRYtg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=tIyI5/vLzHd++nlmv5+JVv2WzWUFQ1lBDQReVYghjAdja7vJ/Cs5Su73vlZVhTH31
	 V00SOORiADZeM3AqlH6PEl/3kcNWn1a/M7k8Gi2DfGnAqF79l2/M7WOAZQwyC6SbiW
	 cJN6gBzWnHlmEgjOKvhcSwXUZzdzOTLmzmbbd2lY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 981C31287771;
	Fri, 24 May 2024 09:01:37 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id F5uFo3TOUYLV; Fri, 24 May 2024 09:01:37 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E1B8C12817CC;
	Fri, 24 May 2024 09:01:36 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 3/3] lib: asn1_encode: remove obsolete asn1_encode_oid
Date: Fri, 24 May 2024 08:59:55 -0400
Message-Id: <20240524125955.20739-4-James.Bottomley@HansenPartnership.com>
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

This has been replaced by encode_OID from the OID_registry.  To use,
consumers must make sure the OID is present in enum OID in
oid_registry.h and then use encode_OID with the enum.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/asn1_encoder.h |  3 --
 lib/asn1_encoder.c           | 91 ------------------------------------
 2 files changed, 94 deletions(-)

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
index 08cd0c2ad34f..5f8cf47ede59 100644
--- a/include/linux/asn1_encoder.h
+++ b/include/linux/asn1_encoder.h
@@ -13,9 +13,6 @@ unsigned char *
 asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 		    s64 integer);
 unsigned char *
-asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
-		u32 oid[], int oid_len);
-unsigned char *
 asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
 		u32 tag, const unsigned char *string, int len);
 unsigned char *
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 0fd3c454a468..c0db3cbebe89 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -85,97 +85,6 @@ asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
 }
 EXPORT_SYMBOL_GPL(asn1_encode_integer);
 
-/* calculate the base 128 digit values setting the top bit of the first octet */
-static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
-{
-	unsigned char *data = *_data;
-	int start = 7 + 7 + 7 + 7;
-	int ret = 0;
-
-	if (*data_len < 1)
-		return -EINVAL;
-
-	/* quick case */
-	if (oid == 0) {
-		*data++ = 0x80;
-		(*data_len)--;
-		goto out;
-	}
-
-	while (oid >> start == 0)
-		start -= 7;
-
-	while (start > 0 && *data_len > 0) {
-		u8 byte;
-
-		byte = oid >> start;
-		oid = oid - (byte << start);
-		start -= 7;
-		byte |= 0x80;
-		*data++ = byte;
-		(*data_len)--;
-	}
-
-	if (*data_len > 0) {
-		*data++ = oid;
-		(*data_len)--;
-	} else {
-		ret = -EINVAL;
-	}
-
- out:
-	*_data = data;
-	return ret;
-}
-
-/**
- * asn1_encode_oid() - encode an oid to ASN.1
- * @data:	position to begin encoding at
- * @end_data:	end of data pointer, points one beyond last usable byte in @data
- * @oid:	array of oids
- * @oid_len:	length of oid array
- *
- * this encodes an OID up to ASN.1 when presented as an array of OID values
- */
-unsigned char *
-asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
-		u32 oid[], int oid_len)
-{
-	int data_len = end_data - data;
-	unsigned char *d = data + 2;
-	int i, ret;
-
-	if (WARN(oid_len < 2, "OID must have at least two elements"))
-		return ERR_PTR(-EINVAL);
-
-	if (WARN(oid_len > 32, "OID is too large"))
-		return ERR_PTR(-EINVAL);
-
-	if (IS_ERR(data))
-		return data;
-
-
-	/* need at least 3 bytes for tag, length and OID encoding */
-	if (data_len < 3)
-		return ERR_PTR(-EINVAL);
-
-	data[0] = _tag(UNIV, PRIM, OID);
-	*d++ = oid[0] * 40 + oid[1];
-
-	data_len -= 3;
-
-	for (i = 2; i < oid_len; i++) {
-		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
-		if (ret < 0)
-			return ERR_PTR(ret);
-	}
-
-	data[1] = d - data - 2;
-
-	return d;
-}
-EXPORT_SYMBOL_GPL(asn1_encode_oid);
-
 /**
  * asn1_encode_length() - encode a length to follow an ASN.1 tag
  * @data: pointer to encode at
-- 
2.35.3


