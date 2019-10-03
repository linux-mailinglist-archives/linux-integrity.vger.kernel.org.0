Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03BDCAE74
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfJCSqo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 14:46:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:50000 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfJCSqo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 14:46:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 11:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="191349656"
Received: from okiselev-mobl1.ccr.corp.intel.com (HELO localhost) ([10.251.93.117])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2019 11:46:40 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-stable@vger.kernel.org
Cc:     Vadim Sukhomlinov <sukhomlinov@google.com>, stable@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
Date:   Thu,  3 Oct 2019 21:46:23 +0300
Message-Id: <20191003184623.25580-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191003184623.25580-1-jarkko.sakkinen@linux.intel.com>
References: <20191003184623.25580-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Vadim Sukhomlinov <sukhomlinov@google.com>

commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream

TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
future TPM operations. TPM 1.2 behavior was different, future TPM
operations weren't disabled, causing rare issues. This patch ensures
that future TPM operations are disabled.

Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
Cc: stable@vger.kernel.org
Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
[dianders: resolved merge conflicts with mainline]
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0eca20c5a80c..dcf5bb153495 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -158,12 +158,13 @@ static int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
+	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		down_write(&chip->ops_sem);
 		tpm2_shutdown(chip, TPM2_SU_CLEAR);
 		chip->ops = NULL;
-		up_write(&chip->ops_sem);
 	}
+	chip->ops = NULL;
+	up_write(&chip->ops_sem);
 
 	return 0;
 }
-- 
2.20.1

