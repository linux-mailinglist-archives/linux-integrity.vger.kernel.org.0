Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECD612F30
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Oct 2022 04:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJaDAb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Oct 2022 23:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJaDAa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Oct 2022 23:00:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183E7675
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 20:00:29 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N0yX22Q3Yz686KW;
        Mon, 31 Oct 2022 10:58:26 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 31 Oct 2022 04:00:27 +0100
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 03:00:26 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <roberto.sassu@huawei.com>, <krzysztof.struczynski@huawei.com>,
        <stefanb@linux.ibm.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v2 4/4] ima: Extend the real PCR12 with tempPCR value.
Date:   Mon, 31 Oct 2022 11:00:18 +0800
Message-ID: <20221031030018.298906-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221031025507.298323-1-denis.semakin@huawei.com>
References: <20221031025507.298323-1-denis.semakin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 security/integrity/ima/ima_fs.c | 83 +++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cca984301968..02d7b66098ca 100644
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
index d9e91b9f1564..8e517be7bba2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -26,6 +26,7 @@
 #include "ima.h"
 
 extern struct list_head vpcr_list;
+static bool vpcr_mutex_acquired;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -540,13 +541,28 @@ static const struct file_operations ima_active_ops = {
 	.write = ima_write_active,
 };
 
+struct {
+	struct ima_digest_data hdr;
+	char digest[SHA256_DIGEST_SIZE];
+} temp_vpcr_hash = {
+	.hdr = {
+		.algo = HASH_ALGO_SHA256,
+		.length = SHA256_DIGEST_SIZE,
+	},
+};
+
 static void *vpcr_start(struct seq_file *m, loff_t *pos)
 {
 	int err;
 
-	err = mutex_lock_interruptible(&vpcr_list_mutex);
-	if (err)
-		return ERR_PTR(err);
+	if (*pos == 0) {
+		err = mutex_lock_interruptible(&vpcr_list_mutex);
+		if (err) {
+			vpcr_mutex_acquired = false;
+			return ERR_PTR(err);
+		}
+		vpcr_mutex_acquired = true;
+	}
 
 	return seq_list_start(&vpcr_list, *pos);
 }
@@ -558,17 +574,76 @@ static void *vpcr_next(struct seq_file *m, void *v, loff_t *pos)
 
 static void vpcr_stop(struct seq_file *m, void *v)
 {
+	int j;
+	int ret;
+	struct tpm_chip *tpm_chip;
+	struct tpm_digest *temp_tpm;
+	struct tpm_digest pcr12_digest;
+	struct ima_namespace *curr_ns = ima_ns_from_file(m->file);
+
+	if (!vpcr_mutex_acquired)
+		return;
+
+	tpm_chip = curr_ns->ima_tpm_chip;
+	pcr12_digest.alg_id = TPM_ALG_SHA256;
+
+	temp_tpm = kcalloc(tpm_chip->nr_allocated_banks,
+			   sizeof(*curr_ns->digests), GFP_NOFS);
+	if (!temp_tpm)
+		goto ex;
+
+	for (j = 0; j < tpm_chip->nr_allocated_banks; j++) {
+		temp_tpm[j].alg_id = tpm_chip->allocated_banks[j].alg_id;
+
+
+		if (temp_tpm[j].alg_id == TPM_ALG_SHA256)
+			memcpy(&temp_tpm[j].digest, &temp_vpcr_hash.digest,
+			       SHA256_DIGEST_SIZE);
+		else
+			memset(&temp_tpm[j].digest, 0,
+			       hash_digest_size[tpm_chip->allocated_banks[j].crypto_id]);
+	}
+
+	ret = tpm_pcr_extend(tpm_chip, TPM_PCR12, temp_tpm);
+	if (ret != 0) {
+		seq_puts(m, "TPM extend error\n");
+		goto free_mem;
+	}
+
+	ret = tpm_pcr_read(tpm_chip, TPM_PCR12, &pcr12_digest);
+	if (ret != 0) {
+		seq_puts(m, "TPM read error\n");
+		goto free_mem;
+	}
+
+	ima_putc(m, "PCR12: ", strlen("PCR12: "));
+	ima_putc(m, pcr12_digest.digest, SHA256_DIGEST_SIZE);
+
+free_mem:
+	kfree(temp_tpm);
+ex:
 	mutex_unlock(&vpcr_list_mutex);
+	vpcr_mutex_acquired = false;
 }
 
 static int vpcr_show(struct seq_file *m, void *v)
 {
+	int ret = 0;
+	u8 buf[IMA_MAX_DIGEST_SIZE * 2] = {0};
 	struct vpcr_entry *vpcr = list_entry(v, struct vpcr_entry, list);
+	struct ima_namespace *curr_ns = container_of(vpcr, struct ima_namespace,
+						     vpcr);
 
 	ima_putc(m, "cPCR: ", strlen("cPCR: "));
 	ima_putc(m, vpcr->vpcr_tmp, SHA256_DIGEST_SIZE);
 
-	return 0;
+	memcpy(buf, &temp_vpcr_hash.digest, SHA256_DIGEST_SIZE);
+	memcpy(buf + SHA256_DIGEST_SIZE, vpcr->vpcr_tmp,
+	       SHA256_DIGEST_SIZE);
+
+	ret = ima_calc_buffer_hash(curr_ns, buf, SHA256_DIGEST_SIZE * 2,
+				   &temp_vpcr_hash.hdr);
+	return ret;
 }
 
 const struct seq_operations vpcr_seq_ops = {
-- 
2.38.GIT

