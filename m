Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F337620F5
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 16:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfGHO4o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 10:56:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:14257 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732019AbfGHO4l (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 10:56:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 07:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="340467747"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.189])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2019 07:56:37 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tpm: Remove a deprecated comments about implicit sysfs locking
Date:   Mon,  8 Jul 2019 17:56:39 +0300
Message-Id: <20190708145639.23279-1-jarkko.sakkinen@linux.intel.com>
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
v2: Forgot tpm-sysfs.c changes to my staging area :-/
 drivers/char/tpm/tpm-chip.c  | 7 ++-----
 drivers/char/tpm/tpm-sysfs.c | 7 -------
 2 files changed, 2 insertions(+), 12 deletions(-)

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
diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index d9caedda075b..edfa89160010 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -329,16 +329,9 @@ static const struct attribute_group tpm_dev_group = {
 
 void tpm_sysfs_add_device(struct tpm_chip *chip)
 {
-	/* XXX: If you wish to remove this restriction, you must first update
-	 * tpm_sysfs to explicitly lock chip->ops.
-	 */
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return;
 
-	/* The sysfs routines rely on an implicit tpm_try_get_ops, device_del
-	 * is called before ops is null'd and the sysfs core synchronizes this
-	 * removal so that no callbacks are running or can run again
-	 */
 	WARN_ON(chip->groups_cnt != 0);
 	chip->groups[chip->groups_cnt++] = &tpm_dev_group;
 }
-- 
2.20.1

