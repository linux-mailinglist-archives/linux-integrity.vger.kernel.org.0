Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF69C5ACD53
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Sep 2022 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiIEH6s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Sep 2022 03:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiIEH6m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Sep 2022 03:58:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4846DA6;
        Mon,  5 Sep 2022 00:58:40 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MLglw59lFz1P6gV;
        Mon,  5 Sep 2022 15:54:52 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 15:58:37 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/4] Use DECLARE_FLEX_ARRAY() helper for ima
Date:   Mon, 5 Sep 2022 15:58:33 +0800
Message-ID: <20220905075837.1083216-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series contains a few cleanup patches, to replace fake flexible-array
declarations with DECLARE_FLEX_ARRAY() helper for ima. Thanks!

Link: https://github.com/KSPP/linux/issues/193

Gaosheng Cui (4):
  ima: Use DECLARE_FLEX_ARRAY() helper in ima_modsig
  ima: Use DECLARE_FLEX_ARRAY() helper in ima_template_entry
  ima: Use DECLARE_FLEX_ARRAY() helper in ima_policy
  integrity: Use DECLARE_FLEX_ARRAY() helper in integrity.h

 security/integrity/ima/ima.h        | 2 +-
 security/integrity/ima/ima_modsig.c | 2 +-
 security/integrity/ima/ima_policy.c | 2 +-
 security/integrity/integrity.h      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

