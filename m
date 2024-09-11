Return-Path: <linux-integrity+bounces-3520-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E6975232
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8C5281501
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D35192D7A;
	Wed, 11 Sep 2024 12:29:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AD199926;
	Wed, 11 Sep 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057787; cv=none; b=KIWMlIAfYvWcPJLTXol259msG/gj011Y1dWsVNGwN1gEM04mX9nBKQw2W2q0U7SrBCVi6iMsbUK8n/5M1qz32u9pGLDF9CT3O/VG/wGfOaZlZeXPRbbshRqKaGfGr+5J9Der4jdoLq9waxUmxSzfk4OPO2tqH+HKccaPeT7+gF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057787; c=relaxed/simple;
	bh=zadhMIMAhHYJ1waNtdLmU4A5krbN3rV+oKsxvuPZD4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzyyX5jIKRPn3vjO+nhrOiIJHW+uv0Snm283dwZEVoFfdzbT+BuYYFL5T5SqbaehOQ2ZB0EqXr/gyTzcaxZhsyHU6yzMB7ZLViInVAJFsUJ1w2+LuFWy+k2IZnY1NcN98ZqJazdFG8x/whIePa8CtJpCzQQj/ppgt2HYahQIZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X3fXP2KMBz9v7Q2;
	Wed, 11 Sep 2024 20:10:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 53315140123;
	Wed, 11 Sep 2024 20:29:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S3;
	Wed, 11 Sep 2024 13:29:39 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 01/14] mpi: Introduce mpi_key_length()
Date: Wed, 11 Sep 2024 14:28:58 +0200
Message-Id: <20240911122911.1381864-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17KFy3ur47KF1UAFWfAFb_yoW5Jr17pF
	4Ykw45JrWkJr1SkFyfC3Z5Ga45C3Wv9F1UKrZrJw17J39IkrnxWFZ7ua4Yva18Gr1xAF1U
	X3y3WFZ5Crn5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jehFxU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQHzQABsD

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the new function to get the number of bits and bytes from an MPI.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/mpi.h       |  2 ++
 lib/crypto/mpi/mpicoder.c | 33 ++++++++++++++++++++++++++-------
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index eb0d1c1db208..a7dd4c9d8120 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -90,6 +90,8 @@ enum gcry_mpi_format {
 };
 
 MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
+int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
+		   unsigned int *nbits_arg, unsigned int *nbytes_arg);
 MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
 int mpi_fromstr(MPI val, const char *str);
 MPI mpi_scanval(const char *string);
diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
index 3cb6bd148fa9..92447a1c8bf9 100644
--- a/lib/crypto/mpi/mpicoder.c
+++ b/lib/crypto/mpi/mpicoder.c
@@ -79,22 +79,41 @@ MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes)
 }
 EXPORT_SYMBOL_GPL(mpi_read_raw_data);
 
-MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
+int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
+		   unsigned int *nbits_arg, unsigned int *nbytes_arg)
 {
 	const uint8_t *buffer = xbuffer;
-	unsigned int nbits, nbytes;
-	MPI val;
+	unsigned int nbits;
 
-	if (*ret_nread < 2)
-		return ERR_PTR(-EINVAL);
+	if (ret_nread < 2)
+		return -EINVAL;
 	nbits = buffer[0] << 8 | buffer[1];
 
 	if (nbits > MAX_EXTERN_MPI_BITS) {
 		pr_info("MPI: mpi too large (%u bits)\n", nbits);
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
-	nbytes = DIV_ROUND_UP(nbits, 8);
+	if (nbits_arg)
+		*nbits_arg = nbits;
+	if (nbytes_arg)
+		*nbytes_arg = DIV_ROUND_UP(nbits, 8);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mpi_key_length);
+
+MPI mpi_read_from_buffer(const void *xbuffer, unsigned int *ret_nread)
+{
+	const uint8_t *buffer = xbuffer;
+	unsigned int nbytes;
+	MPI val;
+	int ret;
+
+	ret = mpi_key_length(xbuffer, *ret_nread, NULL, &nbytes);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	if (nbytes + 2 > *ret_nread) {
 		pr_info("MPI: mpi larger than buffer nbytes=%u ret_nread=%u\n",
 				nbytes, *ret_nread);
-- 
2.34.1


