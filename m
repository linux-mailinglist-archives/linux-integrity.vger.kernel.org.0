Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E849962D99A
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 12:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiKQLjg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 06:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbiKQLjH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 06:39:07 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA64C272;
        Thu, 17 Nov 2022 03:39:05 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NCdCG32KTzJnmj;
        Thu, 17 Nov 2022 19:35:54 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 19:39:04 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 19:39:03 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hanjun Guo" <guohanjun@huawei.com>
Subject: [PATCH v2 0/3] ACPI table release for TPM drivers
Date:   Thu, 17 Nov 2022 19:23:39 +0800
Message-ID: <1668684222-38457-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ACPI table should be released to avoid the memory leak,
here are patches for TPM drivers to add the missed acpi_put_table(),
which will fix the memory leak.

v2:
Add Cc: stable@vger.kernel.org to the commit message, and cc LKML
for all the patches, suggested by Jarkko.

Hanjun Guo (3):
  tpm: acpi: Call acpi_put_table() to fix memory leak
  tpm: tpm_crb: Add the missed acpi_put_table() to fix memory leak
  tpm: tpm_tis: Add the missed acpi_put_table() to fix memory leak

 drivers/char/tpm/eventlog/acpi.c | 12 +++++++++---
 drivers/char/tpm/tpm_crb.c       | 29 ++++++++++++++++++++---------
 drivers/char/tpm/tpm_tis.c       |  9 +++++----
 3 files changed, 34 insertions(+), 16 deletions(-)

-- 
1.7.12.4

