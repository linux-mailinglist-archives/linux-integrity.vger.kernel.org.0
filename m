Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64BC399BF4
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCHvw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 03:51:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3527 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHvw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 03:51:52 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwdK26ktTzZcQF;
        Thu,  3 Jun 2021 15:47:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:50:04 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:50:03 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] tpm_tis: Use DEFINE_RES_MEM() to simplify code
Date:   Thu, 3 Jun 2021 15:49:55 +0800
Message-ID: <20210603074955.11653-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210603074955.11653-1-thunder.leizhen@huawei.com>
References: <20210603074955.11653-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use DEFINE_RES_MEM() to save a couple of lines of code, which is simpler
and more readable. The start address does not need to appear twice.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/char/tpm/tpm_tis.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 4ed6e660273a414..d3f2e5364c275f4 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -363,11 +363,7 @@ static int tpm_tis_force_device(void)
 {
 	struct platform_device *pdev;
 	static const struct resource x86_resources[] = {
-		{
-			.start = 0xFED40000,
-			.end = 0xFED40000 + TIS_MEM_LEN - 1,
-			.flags = IORESOURCE_MEM,
-		},
+		DEFINE_RES_MEM(0xFED40000, TIS_MEM_LEN)
 	};
 
 	if (!force)
-- 
2.26.0.106.g9fadedd


