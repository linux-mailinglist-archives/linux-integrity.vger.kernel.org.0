Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB6233682
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG3QQS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 12:16:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:64342 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QQR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 12:16:17 -0400
IronPort-SDR: fgvtjP16U8Wv37bAcPr/ZDMzcfGBvtb1I1wdunauTQR2wb4V9uyR36o3ni0F7j00l+jzbIc31y
 e5qSzaWobJDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139626771"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="139626771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:16:17 -0700
IronPort-SDR: X7dCWv3U7XaQoV17WTFQMx5DfHxPR/yfct38muIT9MSK7x9EsJa6IzqVRrsUQXD2F7BLCuxUI8
 FbgCM5vQbuaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="313477283"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2020 09:16:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BF8DE119; Thu, 30 Jul 2020 19:16:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tpm: use %*ph to print small buffer
Date:   Thu, 30 Jul 2020 19:16:13 +0300
Message-Id: <20200730161613.41607-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/tpm/tpm-sysfs.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d52bf4df0bca..e2ff0b273a0f 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -56,31 +56,20 @@ static ssize_t pubek_show(struct device *dev, struct device_attribute *attr,
 	out = (struct tpm_readpubek_out *)&tpm_buf.data[10];
 	str +=
 	    sprintf(str,
-		    "Algorithm: %02X %02X %02X %02X\n"
-		    "Encscheme: %02X %02X\n"
-		    "Sigscheme: %02X %02X\n"
-		    "Parameters: %02X %02X %02X %02X "
-		    "%02X %02X %02X %02X "
-		    "%02X %02X %02X %02X\n"
+		    "Algorithm: %4ph\n"
+		    "Encscheme: %2ph\n"
+		    "Sigscheme: %2ph\n"
+		    "Parameters: %12ph\n"
 		    "Modulus length: %d\n"
 		    "Modulus:\n",
-		    out->algorithm[0], out->algorithm[1], out->algorithm[2],
-		    out->algorithm[3],
-		    out->encscheme[0], out->encscheme[1],
-		    out->sigscheme[0], out->sigscheme[1],
-		    out->parameters[0], out->parameters[1],
-		    out->parameters[2], out->parameters[3],
-		    out->parameters[4], out->parameters[5],
-		    out->parameters[6], out->parameters[7],
-		    out->parameters[8], out->parameters[9],
-		    out->parameters[10], out->parameters[11],
+		    out->algorithm,
+		    out->encscheme,
+		    out->sigscheme,
+		    out->parameters,
 		    be32_to_cpu(out->keysize));
 
-	for (i = 0; i < 256; i++) {
-		str += sprintf(str, "%02X ", out->modulus[i]);
-		if ((i + 1) % 16 == 0)
-			str += sprintf(str, "\n");
-	}
+	for (i = 0; i < 256; i += 16)
+		str += sprintf(str, "%16ph\n", &out->modulus[i]);
 
 out_buf:
 	tpm_buf_destroy(&tpm_buf);
-- 
2.27.0

