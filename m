Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17F22E7A2
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgG0IWt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 04:22:49 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38369 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgG0IWt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 04:22:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U3vTrNz_1595838165;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U3vTrNz_1595838165)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Jul 2020 16:22:45 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     christophe.ricard@gmail.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH v2] tpm: Fix the description error of the help information in Kconfig
Date:   Mon, 27 Jul 2020 16:22:45 +0800
Message-Id: <20200727082245.32396-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SPI protocol standardized by the TCG is described in the TCG PTP
specification 1.3 (chapter 6.4.6 SPI Bit Protocol), It was published by
TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf.

The TPM version number in the help message is wrong, which will
cause confusion. This patch fixes it.

Fixes: 0edbfea537d1 ("tpm/tpm_tis_spi: Add support for spi phy")
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/char/tpm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 58b4c573d176..8eedb3e704f3 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -62,7 +62,7 @@ config TCG_TIS_SPI
 	help
 	  If you have a TPM security chip which is connected to a regular,
 	  non-tcg SPI master (i.e. most embedded platforms) that is compliant with the
-	  TCG TIS 1.3 TPM specification (TPM1.2) or the TCG PTP FIFO
+	  TCG TIS 1.3 TPM specification (TPM1.3) or the TCG PTP FIFO
 	  specification (TPM2.0) say Yes and it will be accessible from
 	  within Linux. To compile this driver as a module, choose  M here;
 	  the module will be called tpm_tis_spi.
-- 
2.17.1

