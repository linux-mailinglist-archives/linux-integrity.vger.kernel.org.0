Return-Path: <linux-integrity+bounces-7541-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F8C14CF4
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4704EE538
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 13:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18232D0F0;
	Tue, 28 Oct 2025 13:23:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE413314DD;
	Tue, 28 Oct 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657783; cv=none; b=JSZuWIGYucSZb/3bPFImWOrTEPXBQ4tW0HS5wh3JUoyXdXXON8YXI/OzI3XHrVXfxZc935B7iotlppnrylYK3nrcIsYUUGfJx5y7iGudA6788upChuMh7kTH4hwf82ZBqjeYHUN8/mLggdPuDEJovgg/CCusHz0/tNeyr1bnV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657783; c=relaxed/simple;
	bh=xVKZGVqMEj0xdek51jF3cz28uC5ZI8sS3UZo6n7Q/4c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=czebslnw+yWdXqfw/uwaKoLnE2aVbU+UsX0J8QXEWyxh/J3OwUcF0kybZ03bysRRKX+L3frtYcsAce/lW0tuIdWUeI2Alq/IFvmXajIsLxViBlr9FcQhJyMhnrapptf/c2XyZqdfhLIvXugb4CYquEUaPLOavGnilTCU8AEXR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cwrf563d7zYQtnm;
	Tue, 28 Oct 2025 21:22:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0FFE11A0359;
	Tue, 28 Oct 2025 21:22:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESuwwBpYnmgBw--.21541S4;
	Tue, 28 Oct 2025 21:22:55 +0800 (CST)
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
Subject: [PATCH] KEYS: Remove the ad-hoc compilation flag CAAM_DEBUG
Date: Tue, 28 Oct 2025 21:22:54 +0800
Message-Id: <20251028132254.841715-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESuwwBpYnmgBw--.21541S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DGw17AF1rGr1xAw45Awb_yoW8JFW3pa
	n0kFyjgrW7KFyqg3yDCFWxCF13C3s8KFW7GrWqya42gFnrA34UJrWI9F43ur13ZFyxGryj
	vayxZr1Fg3y293DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

Fix the broken design based on Jarkko Sakkinen's suggestions as follows:

1. Remove the ad-hoc compilation flag (i.e., CAAM_DEBUG).
2. Substitute pr_info calls with pr_debug calls.

Closes: https://patchwork.kernel.org/project/linux-integrity/patch/20251024061153.61470-1-yebin@huaweicloud.com/
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 security/keys/trusted-keys/trusted_caam.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index 601943ce0d60..c903ee7328ca 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -28,16 +28,10 @@ static const match_table_t key_tokens = {
 	{opt_err, NULL}
 };
 
-#ifdef CAAM_DEBUG
 static inline void dump_options(const struct caam_pkey_info *pkey_info)
 {
-	pr_info("key encryption algo %d\n", pkey_info->key_enc_algo);
+	pr_debug("key encryption algo %d\n", pkey_info->key_enc_algo);
 }
-#else
-static inline void dump_options(const struct caam_pkey_info *pkey_info)
-{
-}
-#endif
 
 static int get_pkey_options(char *c,
 			    struct caam_pkey_info *pkey_info)
-- 
2.34.1


