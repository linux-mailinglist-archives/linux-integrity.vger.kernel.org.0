Return-Path: <linux-integrity+bounces-2267-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC48B6397
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07F51F22E83
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0851419A2;
	Mon, 29 Apr 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="loNJ4PaO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3A13AD2F;
	Mon, 29 Apr 2024 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422595; cv=none; b=aDRE5vjcNdcisN/EAXKYxR7Ws+Z6r1DTF1xOnDSrwtbQ+zcUHqwtc81iPseI9sRwki1Y382K0OAFGtqpISjpuyqPFR80Yjrcj7IWW4Y7I9Fc6OzHo+clxZ5H+LK/HmAdxMc2d9IJkIxJc4zGLSC9qlNTnGEKBustVonKkICv6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422595; c=relaxed/simple;
	bh=jf2OFp9fwM5S2/gUWTtBTD0TYENRgGwBW8qxb+2VC5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqyZLVlklKOmfcsbtCnUU9BW26ROLUCoHY1WrXDLH8PfLTZuUoPXlX/DNBLvD8+XSjqeyPvYj8gfGniNQKxxnfiqkwj5N+u414thTH962kOi94J3lPMPSoml+lnK9EhutMei4a/USijhKL7L9MWmrx0ADBYNehvf/m3WBAlvnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=loNJ4PaO; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422594;
	bh=jf2OFp9fwM5S2/gUWTtBTD0TYENRgGwBW8qxb+2VC5s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=loNJ4PaOt1PAxDOWPIDXz4HSufXYMUzULR5vNCjlwLb8aZAU1CL4jCbTvk55mlGpH
	 zcjCTUbXi/7Zv2PiDfTSC+rLPXQacjHqxLECM0pc9OVsB1LJpYAXX2dmwmFwj2AhnS
	 MlpL4QptZSyvXw52o/gK9UvVdpZqM9XeDAAhzsw0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6095A12819F3;
	Mon, 29 Apr 2024 16:29:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ohXtigUrJt2x; Mon, 29 Apr 2024 16:29:54 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CAA3B1281D87;
	Mon, 29 Apr 2024 16:29:53 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 10/22] tpm: add buffer function to point to returned parameters
Date: Mon, 29 Apr 2024 16:27:59 -0400
Message-Id: <20240429202811.13643-11-James.Bottomley@HansenPartnership.com>
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

Replace all instances of &buf.data[TPM_HEADER_SIZE] with a new
function tpm_buf_parameters() because encryption sessions change
where the return parameters are located in the buffer since if a
return session is present they're 4 bytes beyond the header with those
4 bytes giving the parameter length.  If there is no return session,
then they're in the usual place immediately after the header.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v4: add kdoc
v5: update kdoc add review
v7: add review
---
 drivers/char/tpm/tpm-buf.c | 28 ++++++++++++++++++++++++++++
 include/linux/tpm.h        |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 32619e9ab4fa..bb81180495d1 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -220,3 +220,31 @@ u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset)
 	return be32_to_cpu(value);
 }
 EXPORT_SYMBOL_GPL(tpm_buf_read_u32);
+
+static u16 tpm_buf_tag(struct tpm_buf *buf)
+{
+	struct tpm_header *head = (struct tpm_header *)buf->data;
+
+	return be16_to_cpu(head->tag);
+}
+
+/**
+ * tpm_buf_parameters - return the TPM response parameters area of the tpm_buf
+ * @buf: tpm_buf to use
+ *
+ * Where the parameters are located depends on the tag of a TPM
+ * command (it's immediately after the header for TPM_ST_NO_SESSIONS
+ * or 4 bytes after for TPM_ST_SESSIONS). Evaluate this and return a
+ * pointer to the first byte of the parameters area.
+ *
+ * @return: pointer to parameters area
+ */
+u8 *tpm_buf_parameters(struct tpm_buf *buf)
+{
+	int offset = TPM_HEADER_SIZE;
+
+	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
+		offset += 4;
+
+	return &buf->data[offset];
+}
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e8172f81c562..6be263509e81 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -344,6 +344,8 @@ u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
 
+u8 *tpm_buf_parameters(struct tpm_buf *buf);
+
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
-- 
2.35.3


