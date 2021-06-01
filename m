Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E504397315
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFAMTw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 08:19:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2822 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhFAMTw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 08:19:52 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvWK15brGzWqPw;
        Tue,  1 Jun 2021 20:13:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 20:18:07 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 20:18:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
CC:     <jarkko@kernel.org>
Subject: [PATCH -next] tpm: fix  some doc warnings in tpm1-cmd.c
Date:   Tue, 1 Jun 2021 20:22:30 +0800
Message-ID: <20210601122230.3205331-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix the following make W=1 warnings:

  drivers/char/tpm/tpm1-cmd.c:325: warning: expecting prototype for tpm_startup(). Prototype was for tpm1_startup() instead
  drivers/char/tpm/tpm1-cmd.c:621: warning: expecting prototype for tpm_continue_selftest(). Prototype was for tpm1_continue_selftest() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/char/tpm/tpm1-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca7158fa6e6c..f7dc986fa4a0 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -312,7 +312,7 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 #define TPM_ST_CLEAR 1
 
 /**
- * tpm_startup() - turn on the TPM
+ * tpm1_startup() - turn on the TPM
  * @chip: TPM chip to use
  *
  * Normally the firmware should start the TPM. This function is provided as a
@@ -611,7 +611,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 
 #define TPM_ORD_CONTINUE_SELFTEST 83
 /**
- * tpm_continue_selftest() - run TPM's selftest
+ * tpm1_continue_selftest() - run TPM's selftest
  * @chip: TPM chip to use
  *
  * Returns 0 on success, < 0 in case of fatal error or a value > 0 representing
-- 
2.25.1

