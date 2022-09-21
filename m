Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7B5BFE91
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIUNB4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIUNBw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 09:01:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CB8C45C;
        Wed, 21 Sep 2022 06:01:50 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXdjH1byBzMn8Z;
        Wed, 21 Sep 2022 20:57:07 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 21:01:48 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v5 0/2] ima: Handle -ESTALE returned by ima_filter_rule_match()
Date:   Wed, 21 Sep 2022 20:58:02 +0800
Message-ID: <20220921125804.59490-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 security/integrity/ima/ima_policy.c | 51 ++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 16 deletions(-)
---

v5:
  Updated code to avoid reusing rule. Fixed a potential mem leak caused
by race condition. Updated commit message for the first patch based on
Mimi's feedback.

v4:
  Use a tempory rule instead of updating the rule in place. To do that,
also update ima_lsm_copy_rule so we can make use of it.

v3:
  Update current rule instead of just retrying, as suggested by Mimi

v2:
  Fixes message errors pointed out by Mimi

-- 
2.17.1

