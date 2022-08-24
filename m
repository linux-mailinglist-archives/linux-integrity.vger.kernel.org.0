Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F63259FDF1
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiHXPLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Aug 2022 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiHXPLv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Aug 2022 11:11:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A390809
        for <linux-integrity@vger.kernel.org>; Wed, 24 Aug 2022 08:11:50 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCTxg6MBrz682wj;
        Wed, 24 Aug 2022 23:08:23 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:11:48 +0200
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 16:11:47 +0100
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <anton.sirazetdinov@huawei.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <roberto.sassu@huawei.com>,
        <krzysztof.struczynski@huawei.com>, <stefanb@linux.ibm.com>,
        <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v1 4/4] ima: Extend the real PCR12 with tempPCR value.
Date:   Wed, 24 Aug 2022 23:11:40 +0800
Message-ID: <20220824151140.234654-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For each namespace do this calculation:
	tempPCR := HASH(tempPCR || tempValue);

And finally extend the real PCR12P:
	PCR12 := PCR_Extend(PCR12,tempPCR);

Then read the PCR12 and return its value to user-space.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima.h    |  2 +-
 security/integrity/ima/ima_fs.c | 46 ++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 81385aee04f1..257c60ffed23 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -27,7 +27,7 @@
 
 enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
-enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
+enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10, TPM_PCR12 = 12 };
 
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index aaa65ee0d9d5..1fab4eed3692 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -559,6 +559,9 @@ static ssize_t ima_vpcr_read(struct file *filp, char __user *buf, size_t count,
 			     loff_t *ppos)
 {
 	struct vpcr_entry *vpcr;
+	struct tpm_digest *temp_tpm;
+	struct tpm_digest pcr12_digest;
+	struct tpm_chip *ns_tpm_chip;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[SHA256_DIGEST_SIZE];
@@ -568,17 +571,20 @@ static ssize_t ima_vpcr_read(struct file *filp, char __user *buf, size_t count,
 		u8 dig[CPCR_PFX_LEN + SHA256_DIGEST_SIZE + 1];
 	} *vpcr_buff = NULL;
 
-	int ret, i = 0;
+	int ret, j, i = 0;
 	size_t vpcr_buff_size = 0;
 	loff_t size = SHA256_DIGEST_SIZE * 2;
 	struct ima_namespace *init_ns = &init_ima_ns;
 	struct ima_namespace *curr_ns = ima_ns_from_file(filp);
 
+	ns_tpm_chip = curr_ns->ima_tpm_chip;
+
 	if (*ppos != 0)
 		return 0;
 
 	temp_vpcr_hash.hdr.algo = HASH_ALGO_SHA256;
 	temp_vpcr_hash.hdr.length = SHA256_DIGEST_SIZE;
+	pcr12_digest.alg_id = TPM_ALG_SHA256;
 
 	if (mutex_lock_interruptible(&vpcr_list_mutex))
 		return -EINTR;
@@ -616,6 +622,38 @@ static ssize_t ima_vpcr_read(struct file *filp, char __user *buf, size_t count,
 		i++;
 	}
 
+	/**
+	 * TPM banks for extend
+	 */
+	temp_tpm = kcalloc(ns_tpm_chip->nr_allocated_banks,
+			   sizeof(*curr_ns->digests), GFP_NOFS);
+	if (!temp_tpm) {
+		ret = -ENOMEM;
+		goto free_mem;
+	}
+
+	for (j = 0; j < ns_tpm_chip->nr_allocated_banks; j++) {
+		temp_tpm[j].alg_id = ns_tpm_chip->allocated_banks[j].alg_id;
+		if (temp_tpm[j].alg_id == TPM_ALG_SHA256)
+			memcpy(&temp_tpm[j].digest, &temp_vpcr_hash.digest,
+			       SHA256_DIGEST_SIZE);
+		else
+			memset(&temp_tpm[j].digest, 0,
+			       hash_digest_size[ns_tpm_chip->allocated_banks[j].crypto_id]);
+	}
+
+	ret = tpm_pcr_extend(ns_tpm_chip, TPM_PCR12, temp_tpm);
+	if (ret != 0) {
+		ret = -EINTR;
+		goto free_mem;
+	}
+
+	ret = tpm_pcr_read(ns_tpm_chip, TPM_PCR12, &pcr12_digest);
+	if (ret != 0) {
+		ret = -EINTR;
+		goto free_mem;
+	}
+
 	vpcr_buff_size += PCR12_PFX_LEN + SHA256_DIGEST_SIZE + 1;
 	vpcr_buff = krealloc(vpcr_buff, vpcr_buff_size, GFP_NOFS);
 	if (!vpcr_buff) {
@@ -624,10 +662,14 @@ static ssize_t ima_vpcr_read(struct file *filp, char __user *buf, size_t count,
 	}
 
 	memcpy(&vpcr_buff[i].dig, PCR12_PFX, PCR12_PFX_LEN);
+	memcpy(&vpcr_buff[i].dig[PCR12_PFX_LEN], &pcr12_digest.digest,
+	       SHA256_DIGEST_SIZE);
+
 	mutex_unlock(&vpcr_list_mutex);
 	ret = simple_read_from_buffer(buf, count, ppos, vpcr_buff,
 				      vpcr_buff_size);
 	kfree(vpcr_buff);
+	kfree(temp_tpm);
 
 	return ret;
 
@@ -636,6 +678,8 @@ static ssize_t ima_vpcr_read(struct file *filp, char __user *buf, size_t count,
 	if (vpcr_buff)
 		kfree(vpcr_buff);
 
+	kfree(temp_tpm);
+
 	return ret;
 }
 
-- 
2.25.1

