Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF4248A66
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHRPs2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:48:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728241AbgHRPsR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:48:17 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 055F67BBDC167B873813;
        Tue, 18 Aug 2020 16:48:08 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:48:06 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:48:09 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 29/30] ima: Add dummy boot aggregate to per ima namespace measurement list
Date:   Tue, 18 Aug 2020 17:42:29 +0200
Message-ID: <20200818154230.14016-20-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Add dummy boot aggregate entry to the ima measurement list, for every
new ima namespace, when the first process is born into that namespace.

There is at most one TPM chip in the system and one measurement list
associated to one of its PCRs. IMA namespace IDs can be re-used after
namespace is destroyed. The per namespace boot aggregate entry marks
the moment of the ima namespace creation. It is useful when host's
root parses the global measurement list to find entries for destroyed
containers. If the ima namespace ID is reused, the user will know, that
the given entry belongs to a different container.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 security/integrity/ima/ima_ns.c | 61 +++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 11e1d896f603..9b9c34e71cc6 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -48,6 +48,65 @@ static void dec_ima_namespaces(struct ucounts *ucounts)
 	return dec_ucount(ucounts, UCOUNT_IMA_NAMESPACES);
 }
 
+static int ima_ns_add_boot_aggregate(struct ima_namespace *ima_ns)
+{
+	static const char op[] = "ns_add_boot_aggregate";
+	static const char ns_aggregate_name_prefix[] = "ns_aggregate_";
+	const char *audit_cause = "ENOMEM";
+	struct ima_template_entry *entry;
+	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
+	struct ima_event_data event_data = { .iint = iint };
+	int result = -ENOMEM;
+	int violation = 0;
+	struct {
+		struct ima_digest_data hdr;
+		char digest[TPM_DIGEST_SIZE];
+	} hash;
+	unsigned int ns_id = get_ns_id(ima_ns);
+	char *ns_aggregate_name;
+
+	ns_aggregate_name = kmalloc(sizeof(ns_aggregate_name_prefix) +
+				    sizeof(unsigned int),
+				    GFP_KERNEL);
+	if (!ns_aggregate_name)
+		goto err_out;
+
+	sprintf(ns_aggregate_name, "%s%u", ns_aggregate_name_prefix, ns_id);
+
+	event_data.filename = ns_aggregate_name;
+	event_data.ns_id = ns_id;
+
+	memset(iint, 0, sizeof(*iint));
+	memset(&hash, 0, sizeof(hash));
+	iint->ima_hash = &hash.hdr;
+	iint->ima_hash->algo = HASH_ALGO_SHA1;
+	iint->ima_hash->length = SHA1_DIGEST_SIZE;
+
+	result = ima_alloc_init_template(&event_data, &entry, NULL);
+	if (result < 0) {
+		audit_cause = "alloc_entry";
+		goto err_out;
+	}
+
+	result = ima_store_template(entry, violation, NULL,
+				    ns_aggregate_name,
+				    CONFIG_IMA_MEASURE_PCR_IDX,
+				    ima_ns);
+	if (result < 0) {
+		ima_free_template_entry(entry);
+		audit_cause = "store_entry";
+	}
+
+err_out:
+	if (result < 0)
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
+				    ns_aggregate_name, op, audit_cause,
+				    result, 0);
+	kfree(ns_aggregate_name);
+
+	return result;
+}
+
 #ifdef CONFIG_IMA_LOAD_X509
 static int ima_ns_load_x509(struct ima_namespace *ima_ns)
 {
@@ -404,6 +463,8 @@ static int imans_activate(struct ima_namespace *ima_ns)
 	list_add_tail(&ima_ns->list, &ima_ns_list);
 	up_write(&ima_ns_list_lock);
 
+	ima_ns_add_boot_aggregate(ima_ns);
+
 	destroy_child_config(ima_ns);
 out:
 	mutex_unlock(&frozen_lock);
-- 
2.20.1

