Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327A220987F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 04:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbgFYCbT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 22:31:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:57768 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389250AbgFYCbT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 22:31:19 -0400
IronPort-SDR: 3bOysL34f31f4HEjrvQVbQ4dSBzFo8KlOu4IVIipZnxfxRexoggPDt55ramIN0l+O6+gQmlJJv
 /uE7l1CReMhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="132163057"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="132163057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 19:31:18 -0700
IronPort-SDR: 1j6DOtZVsRj3V4H0d+8MgWUsYZhBFVYMokiivN8IBlgi/VOGT+cJ7fEF5+P5Kyz5XGTwRj9ITU
 k2849bsBhqUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="452854664"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2020 19:31:13 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] tpm_tis: Remove the HID IFX0102
Date:   Thu, 25 Jun 2020 05:31:11 +0300
Message-Id: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Acer C720 running Linux v5.3 reports this in klog:

tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
tpm tpm0: tpm_try_transmit: send(): error -5
tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
tpm_tis tpm_tis: Could not get TPM timeouts and durations
tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
tpm tpm0: tpm_try_transmit: send(): error -5
tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
tpm_tis 00:08: Could not get TPM timeouts and durations
ima: No TPM chip found, activating TPM-bypass!
tpm_inf_pnp 00:08: Found TPM with ID IFX0102

% git --no-pager grep IFX0102 drivers/char/tpm
drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */

Obviously IFX0102 was added to the HID table for the TCG TIS driver by
mistake.

Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
Cc: Kylene Jo Hall <kjhall@us.ibm.com>
Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v2:
git diff -R HEAD~1 -- drivers/char/tpm/tpm2-space.c  | patch -p1
git diff -R HEAD~1 -- include/linux/tpm.h  | patch -p1
 drivers/char/tpm/tpm_tis.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342a317d..c58ea10fc92f 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -238,7 +238,6 @@ static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
 static struct pnp_device_id tpm_pnp_tbl[] = {
 	{"PNP0C31", 0},		/* TPM */
 	{"ATM1200", 0},		/* Atmel */
-	{"IFX0102", 0},		/* Infineon */
 	{"BCM0101", 0},		/* Broadcom */
 	{"BCM0102", 0},		/* Broadcom */
 	{"NSC1200", 0},		/* National */
-- 
2.25.1

