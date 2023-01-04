Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E565CDE5
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jan 2023 08:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjADHzA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Jan 2023 02:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjADHzA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jan 2023 02:55:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B3C6D;
        Tue,  3 Jan 2023 23:54:58 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nn20W3WVbz16MNW;
        Wed,  4 Jan 2023 15:53:31 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 15:54:56 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <zohar@linux.ibm.com>
CC:     <paul@paul-moore.com>, <linux-integrity@vger.kernel.org>,
        <luhuaxin1@huawei.com>
Subject: [PATCH v4 0/3] ima: Fix IMA mishandling of LSM based rule during
Date:   Wed, 4 Jan 2023 15:52:14 +0800
Message-ID: <20230104075217.32746-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Backports the following three patches to fix the issue of IMA mishandling
LSM based rule during LSM policy update, causing a file to match an
unexpected rule.

v4:
  Make use of the exisiting ima_free_rule() instead of backported
ima_lsm_free_rule(). Which resolves additional memory leak issues.

v3:
  Backport "LSM: switch to blocking policy update notifiers" as well, as
the prerequsite of "ima: use the lsm policy update notifier".

v2:
  Re-adjust the bacported logic.

GUO Zihua (1):
  ima: Handle -ESTALE returned by ima_filter_rule_match()

Janne Karhunen (2):
  LSM: switch to blocking policy update notifiers
  ima: use the lsm policy update notifier

 drivers/infiniband/core/device.c    |   4 +-
 include/linux/security.h            |  12 +--
 security/integrity/ima/ima.h        |   2 +
 security/integrity/ima/ima_main.c   |   8 ++
 security/integrity/ima/ima_policy.c | 136 ++++++++++++++++++++++------
 security/security.c                 |  23 +++--
 security/selinux/hooks.c            |   2 +-
 security/selinux/selinuxfs.c        |   2 +-
 8 files changed, 143 insertions(+), 46 deletions(-)

-- 
2.17.1

