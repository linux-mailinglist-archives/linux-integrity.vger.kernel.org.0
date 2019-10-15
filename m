Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B41D76CB
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2019 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfJOMrU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Oct 2019 08:47:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:26311 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfJOMrU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Oct 2019 08:47:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 05:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="207538674"
Received: from shacharl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.9.88])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2019 05:47:14 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Date:   Tue, 15 Oct 2019 15:47:02 +0300
Message-Id: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Salt the result that comes from the TPM RNG with random bytes from the
kernel RNG. This will allow to use tpm_get_random() as a substitute for
get_random_bytes().  TPM could have a bug (making results predicatable),
backdoor or even an inteposer in the bus. Salting gives protections
against these concerns.

Cc: David Safford <david.safford@ge.com>
Cc: Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7f105490604c..a135b1cd5a17 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -22,6 +22,7 @@
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/random.h>
 #include <linux/spinlock.h>
 #include <linux/suspend.h>
 #include <linux/freezer.h>
@@ -431,16 +432,24 @@ int tpm_pm_resume(struct device *dev)
 EXPORT_SYMBOL_GPL(tpm_pm_resume);
 
 /**
- * tpm_get_random() - get random bytes from the TPM's RNG
+ * tpm_get_random() - Get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
  * @out:	destination buffer for the random bytes
  * @max:	the max number of bytes to write to @out
  *
- * Return: number of random bytes read or a negative error value.
+ * Get random bytes from the TPM's RNG and salt the result with the same amount
+ * of bytes from the kernel RNG. Salting allows to call this function as a
+ * substitute for get_random_bytes() where appropriate.
+ *
+ * Return:
+ *   number of random bytes on success,
+ *   -errno on error
  */
 int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 {
+	u8 salt[TPM_MAX_RNG_DATA];
 	int rc;
+	int i;
 
 	if (!out || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
@@ -455,6 +464,14 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 		rc = tpm1_get_random(chip, out, max);
 
 	tpm_put_ops(chip);
+
+	if (rc > 0) {
+		get_random_bytes(salt, rc);
+
+		for (i = 0; i < rc; i++)
+			out[i] ^= salt[i];
+	}
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_get_random);
-- 
2.20.1

