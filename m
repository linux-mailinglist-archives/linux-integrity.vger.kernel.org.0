Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD44E612F2A
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Oct 2022 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJaC7m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Oct 2022 22:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJaC7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Oct 2022 22:59:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA937673
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 19:59:40 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N0yWY1z3sz685ZG;
        Mon, 31 Oct 2022 10:58:01 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 31 Oct 2022 03:59:38 +0100
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 02:59:37 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <roberto.sassu@huawei.com>, <krzysztof.struczynski@huawei.com>,
        <stefanb@linux.ibm.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v2 1/4] ima: Introduce PCR virtualization for IMA namespace.
Date:   Mon, 31 Oct 2022 10:59:23 +0800
Message-ID: <20221031025923.298708-1-denis.semakin@huawei.com>
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

Define a structure for virtual PCR and corresponding
function.
This function is called when IMA extends the real PCR register
and perform following operations:

1) Extends virtual PCR value in structure vpcr_entry;
2) XOR this vPCR with random secret;
3) Store xored value in specific field.

vpcr_digest :=  HASH256(vpcr_digest || new_digest);
vpcr_temp := vpcr_digest XOR vpcr_secret;

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima.h             | 11 +++++
 security/integrity/ima/ima_init_ima_ns.c | 13 ++++++
 security/integrity/ima/ima_ns.c          |  3 ++
 security/integrity/ima/ima_queue.c       | 55 ++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7f263c9b5d31..cca984301968 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -119,6 +119,16 @@ struct ima_h_table {
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 
+struct vpcr_entry {
+	u8 vpcr_tmp[SHA256_DIGEST_SIZE];
+	u8 vpcr_digest[SHA256_DIGEST_SIZE];
+	u8 secret[SHA256_DIGEST_SIZE];
+	struct list_head list;
+};
+
+extern struct mutex vpcr_list_mutex;
+extern struct list_head vpcr_list;
+
 struct ima_namespace {
 	unsigned long ima_ns_flags;
 /* Bit numbers for above flags; use BIT() to get flag */
@@ -165,6 +175,7 @@ struct ima_namespace {
 	 * and IMA default algo.
 	 */
 	int ima_extra_slots;
+	struct vpcr_entry vpcr;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 986f594dd179..d29d113a322c 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -6,8 +6,12 @@
  *   Stefan Berger <stefanb@linux.vnet.ibm.com>
  */
 
+#include <linux/random.h>
 #include "ima.h"
 
+LIST_HEAD(vpcr_list);
+struct mutex vpcr_list_mutex;
+
 int ima_init_namespace(struct ima_namespace *ns)
 {
 	int ret;
@@ -50,8 +54,17 @@ int ima_init_namespace(struct ima_namespace *ns)
 		ns->ima_tpm_chip = tpm_default_chip();
 		if (ns->ima_tpm_chip)
 			pr_info("No TPM chip found, activating TPM-bypass!\n");
+
+		mutex_init(&vpcr_list_mutex);
+		list_add(&ns->vpcr.list, &vpcr_list);
+	} else {
+		mutex_lock(&vpcr_list_mutex);
+		list_add_tail(&ns->vpcr.list, &vpcr_list);
+		mutex_unlock(&vpcr_list_mutex);
 	}
 
+	get_random_bytes(&ns->vpcr.secret, sizeof(ns->vpcr.secret));
+
 	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
 
 	return 0;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 9f6ee3423d34..3f65bfbba98d 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -32,6 +32,9 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	ima_free_policy_rules(ns);
 	ima_free_ns_status_tree(ns);
 	ima_free_measurements(ns);
+	mutex_lock(&vpcr_list_mutex);
+	list_del(&ns->vpcr.list);
+	mutex_unlock(&vpcr_list_mutex);
 }
 
 void ima_free_ima_ns(struct ima_namespace *ns)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index b7a3f608ee9d..6f1fcd4ee307 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -17,6 +17,7 @@
 
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <crypto/algapi.h>
 #include "ima.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
@@ -127,6 +128,55 @@ unsigned long ima_get_binary_runtime_size(struct ima_namespace *ns)
 		return ns->binary_runtime_size + sizeof(struct ima_kexec_hdr);
 }
 
+/**
+ * This function extends the virtual PCR for namespace.
+ * It calculates the HASH for given digest, store it in structure
+ * and XOR it with random secret.
+ * vpcr_digest := HASH(vpcr_digest || new_digest);
+ * vpcr_temp := vpcr_digest XOR vpcr_secret;
+ */
+
+static int ima_vpcr_extend(struct ima_namespace *ns,
+			   struct tpm_digest *digests_arg, int pcr)
+{
+	int ret = 0;
+	u8 buf[IMA_MAX_DIGEST_SIZE * 2];
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash = {};
+
+	size_t dig_len = hash_digest_size[ima_hash_algo];
+	loff_t size = SHA256_DIGEST_SIZE + dig_len;
+
+	/* paranoic zeroing */
+	memset(buf, 0, sizeof(buf));
+	memset(&hash.digest, 0, sizeof(hash.digest));
+
+	/* Use SHA256 hash for vPCR */
+	hash.hdr.algo = HASH_ALGO_SHA256;
+	hash.hdr.length = SHA256_DIGEST_SIZE;
+
+	memcpy(buf, ns->vpcr.vpcr_digest, SHA256_DIGEST_SIZE);
+	memcpy(buf + SHA256_DIGEST_SIZE, &digests_arg->digest[ns->ima_hash_algo_idx],
+	       dig_len);
+
+	ret = ima_calc_buffer_hash(ns, buf, size, &hash.hdr);
+	if (ret < 0)
+		goto out;
+
+	if (mutex_lock_interruptible(&vpcr_list_mutex))
+		return -EINTR;
+
+	memcpy(ns->vpcr.vpcr_digest, &hash.digest, SHA256_DIGEST_SIZE);
+	crypto_xor_cpy(ns->vpcr.vpcr_tmp, ns->vpcr.vpcr_digest,
+		       ns->vpcr.secret, SHA256_DIGEST_SIZE);
+	mutex_unlock(&vpcr_list_mutex);
+out:
+
+	return ret;
+}
+
 static int ima_pcr_extend(struct ima_namespace *ns,
 			  struct tpm_digest *digests_arg, int pcr)
 {
@@ -135,9 +185,14 @@ static int ima_pcr_extend(struct ima_namespace *ns,
 	if (!ns->ima_tpm_chip)
 		return result;
 
+	result = ima_vpcr_extend(ns, digests_arg, pcr);
+	if (result != 0)
+		pr_err("Error extending vPCR, result: %d\n", result);
+
 	result = tpm_pcr_extend(ns->ima_tpm_chip, pcr, digests_arg);
 	if (result != 0)
 		pr_err("Error Communicating to TPM chip, result: %d\n", result);
+
 	return result;
 }
 
-- 
2.38.GIT

