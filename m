Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA483650AB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 05:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhDTDLM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Apr 2021 23:11:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16605 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTDLM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Apr 2021 23:11:12 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPTCN5CQfz1BGx7;
        Tue, 20 Apr 2021 11:08:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 11:10:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
Date:   Tue, 20 Apr 2021 11:10:45 +0800
Message-ID: <1618888245-31604-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Function returns 'void __iomem *' so use IOMEM_ERR_PTR for returning
an error.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/tpm/tpm_crb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index a9dcf31..1860665 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -464,7 +464,7 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
 
 	/* Detect a 64 bit address on a 32 bit system */
 	if (start != new_res.start)
-		return (void __iomem *) ERR_PTR(-EINVAL);
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	if (!iores)
 		return devm_ioremap_resource(dev, &new_res);
-- 
2.7.4

