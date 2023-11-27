Return-Path: <linux-integrity+bounces-238-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631A7FAA08
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F551C20C40
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Nov 2023 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B13DBB7;
	Mon, 27 Nov 2023 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LxNH0Bbd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DF510D8;
	Mon, 27 Nov 2023 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701112485;
	bh=AFTu4kCVpQW+240gbyhTAzKqckFwaJgY5sujDYN2wQg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=LxNH0BbdnnellSzVKtGNDxp4DoNyx2xDDdQPlr21yr+YfbqO774gfIpwNtnZ7G4w2
	 FD6IA4/HYXv7tQAqbNwztgDd990jfxdhk2RZE3jW6zOqo8cX96+iSJHHz0SLcOCHTH
	 g9Hvg+zxb+Jq5oIlQ24OFkx4Ve0mzmLvqMBsRWUQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 06B001286376;
	Mon, 27 Nov 2023 14:14:45 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id p2-0o9hCDmsz; Mon, 27 Nov 2023 14:14:44 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5E3C81285EC7;
	Mon, 27 Nov 2023 14:14:44 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v5 10/17] tpm: add buffer function to point to returned parameters
Date: Mon, 27 Nov 2023 14:08:47 -0500
Message-Id: <20231127190854.13310-11-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
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

---
v4: add kdoc
v5: update kdoc add review
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


