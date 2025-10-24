Return-Path: <linux-integrity+bounces-7518-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 83489C04744
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 08:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C139635121C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 06:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF775265606;
	Fri, 24 Oct 2025 06:12:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9CC141;
	Fri, 24 Oct 2025 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286329; cv=none; b=tU7sHSISaMiaFFeG7kJZ23tRB9pWiCAuQK37uOGidEzBdCjTqPj+6RH/pgClr03hfM6WBJ+N3tdP0xOxuClVHoJr2OLF6l8XOATdF6Ri9zJnlyhRkjwsR5BqZ2ZDKrFYD0kWjDxDAbIYtcc6qr4pfGUOLshXloJjo9SVHX0iP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286329; c=relaxed/simple;
	bh=JHUJkSdHanYTCFYFFsB2WciSNPaCojLOlMIkm/lc3bs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oY7SOhoLwr92wJBUOBbCRtbk3JaxDrCP7iMmaSKiEp58wqv4nMoMb74jASQfCwgOKWs9SXA72db2MrQcypFMN1OlsNj96XOSg3CJa35kTy5uDIR0oI96m/nQjzKKJC09tunnjr6bgkMqCcTr58+Vuk58WHi2y4tYguGWO8hj+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctCFj09JszKHMVb;
	Fri, 24 Oct 2025 14:11:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6AE191A0194;
	Fri, 24 Oct 2025 14:11:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP2 (Coremail) with SMTP id Syh0CgCHK0SpGPto3WC1BQ--.60135S4;
	Fri, 24 Oct 2025 14:11:55 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: a.fatoum@pengutronix.de,
	kernel@pengutronix.de,
	James.Bottomley@HansenPartnership.com,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH] KEYS: fix compilation warnings in the dump_options() function
Date: Fri, 24 Oct 2025 14:11:53 +0800
Message-Id: <20251024061153.61470-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHK0SpGPto3WC1BQ--.60135S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW5CF1DCrykJrW8JF4fKrg_yoW8tF17pa
	1Yka4UXrWjyF9Fg3yUGF4kCa43C395KFW7Gws7tayYgFnxA347XFyUurWa9r13ZFySgryU
	Za4jyF1Fgwsrur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
security/keys/trusted-keys/trusted_caam.c: In function ‘dump_options’:
security/keys/trusted-keys/trusted_caam.c:37:20: note: the ABI of passing struct with a flexible array member has changed in GCC 4.4
   37 | static inline void dump_options(struct caam_pkey_info pkey_info)
      |                    ^~~~~~~~~~~~

To solve the above problem, pass 'struct caam_pkey_info*' type parameter
to the dump_options() function.

Fixes: 9eb25ca6c973 ("KEYS: trusted: caam based protected key")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 security/keys/trusted-keys/trusted_caam.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index 090099d1b04d..dd7a69bcf6a3 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -29,12 +29,12 @@ static const match_table_t key_tokens = {
 };
 
 #ifdef CAAM_DEBUG
-static inline void dump_options(struct caam_pkey_info pkey_info)
+static inline void dump_options(struct caam_pkey_info *pkey_info)
 {
-	pr_info("key encryption algo %d\n", pkey_info.key_enc_algo);
+	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
 }
 #else
-static inline void dump_options(struct caam_pkey_info pkey_info)
+static inline void dump_options(struct caam_pkey_info *pkey_info)
 {
 }
 #endif
@@ -108,7 +108,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
 		ret = get_pkey_options(datablob, &info.pkey_info);
 		if (ret < 0)
 			return 0;
-		dump_options(info.pkey_info);
+		dump_options(&info.pkey_info);
 	}
 
 	ret = caam_encap_blob(blobifier, &info);
@@ -140,7 +140,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
 		ret = get_pkey_options(datablob, &info.pkey_info);
 		if (ret < 0)
 			return 0;
-		dump_options(info.pkey_info);
+		dump_options(&info.pkey_info);
 
 		p->key_len = p->blob_len + sizeof(struct caam_pkey_info);
 		memcpy(p->key, &info.pkey_info, sizeof(struct caam_pkey_info));
-- 
2.34.1


