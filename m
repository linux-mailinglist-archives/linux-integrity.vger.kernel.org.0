Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C82160A6
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2020 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGFUxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 16:53:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:16032 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGFUxw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 16:53:52 -0400
IronPort-SDR: hwa9+/vKRiCtvKB0/W8a8IxkACnrZdd/8a8zcnMjyPY4nzOtCZOzU0s4X9+poL/+SC+x5yx2xV
 ylRrrugK/mYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="232362466"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="232362466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 13:53:51 -0700
IronPort-SDR: E0A58mmh5vXpNDErkpyLxbGc8sINyC/s/Ii4eeqVyrD4JHY/4dT2OMtchvkAgBPnOyprVGh4NB
 4o/1zfYamshg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="357567436"
Received: from sarsteda-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.52.124])
  by orsmga001.jf.intel.com with ESMTP; 06 Jul 2020 13:53:47 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")
Date:   Mon,  6 Jul 2020 23:53:42 +0300
Message-Id: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
and tpm_infineon use the same device ID. Revert the commit and add a
remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
module parameter").

Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
Reported-by: Peter Huewe <peterhuewe@gmx.de>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index c58ea10fc92f..0b214963539d 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -235,9 +235,17 @@ static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
 	return tpm_tis_init(&pnp_dev->dev, &tpm_info);
 }
 
+/*
+ * There is a known bug caused by 93e1b7d42e1e ("[PATCH] tpm: add HID module
+ * parameter"). This commit added IFX0102 device ID, which is also used by
+ * tpm_infineon but ignored to add quirks to probe which driver ought to be
+ * used.
+ */
+
 static struct pnp_device_id tpm_pnp_tbl[] = {
 	{"PNP0C31", 0},		/* TPM */
 	{"ATM1200", 0},		/* Atmel */
+	{"IFX0102", 0},		/* Infineon */
 	{"BCM0101", 0},		/* Broadcom */
 	{"BCM0102", 0},		/* Broadcom */
 	{"NSC1200", 0},		/* National */
-- 
2.25.1

