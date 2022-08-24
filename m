Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C835A033B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiHXVVv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Aug 2022 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiHXVVu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Aug 2022 17:21:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D72165B7
        for <linux-integrity@vger.kernel.org>; Wed, 24 Aug 2022 14:21:49 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCfDB0SGqz67Prq;
        Thu, 25 Aug 2022 05:21:30 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 23:21:47 +0200
Received: from mscphispre00062.huawei.com (10.123.70.102) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 22:21:46 +0100
From:   Denis Semakin <denis.semakin@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <anton.sirazetdinov@huawei.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <roberto.sassu@huawei.com>,
        <krzysztof.struczynski@huawei.com>, <stefanb@linux.ibm.com>,
        <denis.semakin@huawei-partners.com>
Subject: [RFC PATCH v1 2/4] ima: Use tpm_chip from init IMA namespace.
Date:   Thu, 25 Aug 2022 05:21:38 +0800
Message-ID: <20220824212138.264376-1-denis.semakin@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824151005.234388-1-denis.semakin@huawei.com>
References: <20220824151005.234388-1-denis.semakin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.70.102]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
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

For now a child namespace uses the same tpm chip descriptor
from init namespace.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
---
 security/integrity/ima/ima_init_ima_ns.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 1b20e07556e6..da0875765dff 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -59,6 +59,14 @@ int ima_init_namespace(struct ima_namespace *ns)
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
2.25.1

