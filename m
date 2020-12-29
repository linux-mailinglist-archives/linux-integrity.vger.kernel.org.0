Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C432E711B
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Dec 2020 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgL2NwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Dec 2020 08:52:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9696 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgL2NwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Dec 2020 08:52:19 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D4wly4ZVzzkx7l;
        Tue, 29 Dec 2020 21:50:22 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:51:15 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jgg@ziepe.ca>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tpm: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:51:54 +0800
Message-ID: <20201229135154.23648-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/char/tpm/tpm1-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index ca7158fa6e6c..4d8415e3b778 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -794,7 +794,7 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
  */
 int tpm1_get_pcr_allocation(struct tpm_chip *chip)
 {
-	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
+	chip->allocated_banks = kzalloc(sizeof(*chip->allocated_banks),
 					GFP_KERNEL);
 	if (!chip->allocated_banks)
 		return -ENOMEM;
-- 
2.22.0

