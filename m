Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F7B620EA
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfGHOzd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 10:55:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:28983 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGHOzd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 10:55:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 07:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="340467463"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2019 07:55:29 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Remove a deprecated comments about implicit sysfs locking
Date:   Mon,  8 Jul 2019 17:55:27 +0300
Message-Id: <20190708145527.22905-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove all comments about implicit locking tpm-sysfs.c as the file was
updated in Linux v5.1 to use explicit locking.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-chip.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index bf868260f435..9311f88afbb4 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -287,12 +287,9 @@ static void tpm_devs_release(struct device *dev)
  * @dev: device to which the chip is associated.
  *
  * Issues a TPM2_Shutdown command prior to loss of power, as required by the
- * TPM 2.0 spec.
- * Then, calls bus- and device- specific shutdown code.
+ * TPM 2.0 spec. Then, calls bus- and device- specific shutdown code.
  *
- * XXX: This codepath relies on the fact that sysfs is not enabled for
- * TPM2: sysfs uses an implicit lock on chip->ops, so this could race if TPM2
- * has sysfs support enabled before TPM sysfs's implicit locking is fixed.
+ * Return: always 0 (i.e. success)
  */
 static int tpm_class_shutdown(struct device *dev)
 {
-- 
2.20.1

