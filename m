Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44003612F2C
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Oct 2022 04:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJaC77 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Oct 2022 22:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJaC75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Oct 2022 22:59:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C804657D
        for <linux-integrity@vger.kernel.org>; Sun, 30 Oct 2022 19:59:56 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N0yWP37kPz686FT;
        Mon, 31 Oct 2022 10:57:53 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 31 Oct 2022 03:59:54 +0100
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 02:59:53 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>,
        <yusongping@huawei.com>, <hukeping@huawei.com>,
        <roberto.sassu@huawei.com>, <krzysztof.struczynski@huawei.com>,
        <stefanb@linux.ibm.com>, <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v2 2/4] ima: Use tpm_chip from init IMA namespace.
Date:   Mon, 31 Oct 2022 10:59:46 +0800
Message-ID: <20221031025946.298754-1-denis.semakin@huawei.com>
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

For now a child namespace uses the same tpm chip descriptor
from init namespace.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima_init_ima_ns.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index d29d113a322c..8093c61697a4 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -58,6 +58,14 @@ int ima_init_namespace(struct ima_namespace *ns)
 		mutex_init(&vpcr_list_mutex);
 		list_add(&ns->vpcr.list, &vpcr_list);
 	} else {
+		/**
+		 * Here we just assign tpm_chip from init_ima_ns
+		 * with new IMA namespace.
+		 * In future a new API should be used I think
+		 * Stefan's ima_ns_set_tpm_chip() and etc. to get
+		 * TPM chip descriptor and provider.
+		 */
+		ns->ima_tpm_chip = init_ima_ns.ima_tpm_chip;
 		mutex_lock(&vpcr_list_mutex);
 		list_add_tail(&ns->vpcr.list, &vpcr_list);
 		mutex_unlock(&vpcr_list_mutex);
-- 
2.38.GIT

