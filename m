Return-Path: <linux-integrity+bounces-2603-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327ED8CE58F
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 15:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640B11C217DF
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2024 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9F86628;
	Fri, 24 May 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wkW1Sb17"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812686621;
	Fri, 24 May 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555646; cv=none; b=q1+4+pognnwgcQyVc+FZXcdm15/E3REGmrdoWVc4VybepCEFC/r+kJbO0I4FbE6A7ijbceQt52yVncL4/DnAT8ky1SXsGxO21FxTy76N7tb4dFIr/wnl8bkXsh2GsoZ+oRhAFofvh4BvLrN0UCefQtATltVD6BTd4Huhqjq8pGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555646; c=relaxed/simple;
	bh=E7Q93VXO0tSghAmHNRWgbqBPL3ipbE0loQYJl45tbRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EcnULpkYjj/RZD6emZlVJ19lg7C5z9mZJEa7MIF3jLHHds1qiWB9s0hAr4ODuLr8g2/11vEdtTfwiTc0CYs72/kQkecF4aB7OFh0JoqkIbSPh1rkU5h3Ukjyt3/AKiGMd1IlnNw6lk3BQSWWvY+E4A3ZYGr4rDTl/VNwwTjEKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=wkW1Sb17; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716555644;
	bh=E7Q93VXO0tSghAmHNRWgbqBPL3ipbE0loQYJl45tbRA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=wkW1Sb17AWqGguyW3MvkSqFHv+ZSLT1tHe8RTZ1xSBbKSLIC94cAjSauP+sBQ70FU
	 hIjWa+7q8C/VonqP23VFW8lCPsaR9fd62fmIAgpD8nMb71BXkHnNdXZWU4L3kKl5Pv
	 1Ic92CIAlmcHSs9KRs37ifkppuyM7lf5QVpuxJ0I=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D60F71287771;
	Fri, 24 May 2024 09:00:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fwqf7ULsNs6z; Fri, 24 May 2024 09:00:44 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2F57A12817CC;
	Fri, 24 May 2024 09:00:44 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 1/3] lib/oid_registry: add ability to ASN.1 encode OIDs
Date: Fri, 24 May 2024 08:59:53 -0400
Message-Id: <20240524125955.20739-2-James.Bottomley@HansenPartnership.com>
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

Consumers of the ASN.1 encoder occasionally need to insert OIDs into
the ASN.1 stream.  The existing interface in lib/asn1_encoder.c is
clunky in that it directly encodes the u32 array form of the OID.
Instead introduce a function, encode_OID() which takes the OID enum
and returns the ASN.1 encoding.  This is easy because the OID registry
table already has the binary encoded form for comparison.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/oid_registry.h |  1 +
 lib/oid_registry.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 51421fdbb0ba..87a6bcb2f5c0 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -151,5 +151,6 @@ extern enum OID look_up_OID(const void *data, size_t datasize);
 extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
 extern int sprint_oid(const void *, size_t, char *, size_t);
 extern int sprint_OID(enum OID, char *, size_t);
+extern ssize_t encode_OID(enum OID, u8 *, size_t);
 
 #endif /* _LINUX_OID_REGISTRY_H */
diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index fe6705cfd780..adbc287875c1 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/bug.h>
 #include <linux/asn1.h>
+#include <linux/asn1_ber_bytecode.h>
 #include "oid_registry_data.c"
 
 MODULE_DESCRIPTION("OID Registry");
@@ -196,3 +197,31 @@ int sprint_OID(enum OID oid, char *buffer, size_t bufsize)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sprint_OID);
+
+/**
+ * encode_OID - embed an ASN.1 encoded OID in the provide buffer
+ * @oid: The OID to encode
+ * @buffer: The buffer to encode to
+ * @bufsize: the maximum size of the buffer
+ *
+ * Returns: negative error or encoded size in the buffer.
+ */
+ssize_t encode_OID(enum OID oid, u8 *buffer, size_t bufsize)
+{
+	int oid_size;
+
+	BUG_ON(oid >= OID__NR);
+
+	oid_size = oid_index[oid + 1] - oid_index[oid];
+
+	if (bufsize < oid_size + 2)
+		return -EINVAL;
+
+	buffer[0] = _tag(UNIV, PRIM, OID);
+	buffer[1] = oid_size;
+
+	memcpy(&buffer[2], &oid_data[oid_index[oid]], oid_size);
+
+	return oid_size + 2;
+}
+EXPORT_SYMBOL_GPL(encode_OID);
-- 
2.35.3


