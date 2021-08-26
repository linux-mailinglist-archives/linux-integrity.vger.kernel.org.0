Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093113F7FAB
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhHZBLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 21:11:10 -0400
Received: from mx21.baidu.com ([220.181.3.85]:58002 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235172AbhHZBLJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 21:11:09 -0400
Received: from BC-Mail-Ex22.internal.baidu.com (unknown [172.31.51.16])
        by Forcepoint Email with ESMTPS id D1B142C855F18396FE99;
        Thu, 26 Aug 2021 09:10:19 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex22.internal.baidu.com (172.31.51.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 26 Aug 2021 09:10:19 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 26 Aug 2021 09:10:19 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>, <jgg@ziepe.ca>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH v2] tpm: tis: Kconfig: Add helper dependency on COMPILE_TEST
Date:   Thu, 26 Aug 2021 09:10:12 +0800
Message-ID: <20210826011012.2772-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

COMPILE_TEST is helpful to find compilation errors in other platform(e.g.X86).
In this case, the support of COMPILE_TEST is added, so this module could
be compiled in other platform(e.g.X86), without ARCH_SYNQUACER configuration.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: extend the commit message.

 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index d6ba644f6b00..4a5516406c22 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -76,7 +76,7 @@ config TCG_TIS_SPI_CR50
 
 config TCG_TIS_SYNQUACER
 	tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
-	depends on ARCH_SYNQUACER
+	depends on ARCH_SYNQUACER || COMPILE_TEST
 	select TCG_TIS_CORE
 	help
 	  If you have a TPM security chip that is compliant with the
-- 
2.25.1

