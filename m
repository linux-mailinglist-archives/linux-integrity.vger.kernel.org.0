Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C65B2B6E
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Sep 2022 03:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIIBTF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Sep 2022 21:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIIBTD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Sep 2022 21:19:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15B1098F6;
        Thu,  8 Sep 2022 18:19:01 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MNyhs1SJZzlVrj;
        Fri,  9 Sep 2022 09:15:09 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 09:19:00 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v4 0/2] ima: Handle -ESTALE returned by ima_filter_rule_match()
Date:   Fri, 9 Sep 2022 09:15:14 +0800
Message-ID: <20220909011516.55957-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA happens to measure extra files if LSM based rules are specified and
the corresponding LSM is updating its policy.

The root cause is explained in the second patch.

GUO Zihua (2):
  ima: Simplify ima_lsm_copy_rule
  ima: Handle -ESTALE returned by ima_filter_rule_match()

 security/integrity/ima/ima_policy.c | 38 +++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

---

v4:
  Use a tempory rule instead of updating the rule in place. To do that,
also update ima_lsm_copy_rule so we can make use of it.

v3:
  Update current rule instead of just retrying, as suggested by Mimi

v2:
  Fixes message errors pointed out by Mimi

-- 
2.17.1

