Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BB1B45C3
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDVNBk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Apr 2020 09:01:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:10462 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDVNBk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 09:01:40 -0400
IronPort-SDR: vPxbnUpkYERInsHliMZfVe5Ks4vJ0iNsJg5DxTL0DfvnCInOBsJFiTAdF7nIZRtDkNz55M+9AD
 uYy8lAOXpRYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 06:01:39 -0700
IronPort-SDR: RMT5qV6boQujN1WL1nAGNeMAy8ec4xqBGnY9CyTbkUR/vtrwFCfyGXAuGCC9gkVTR76IztjYqp
 2dp50XvP43OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="457133226"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2020 06:01:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B22658F; Wed, 22 Apr 2020 16:01:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tpm/tpm_ftpm_tee: Use UUID API for exporting the UUID
Date:   Wed, 22 Apr 2020 16:01:35 +0300
Message-Id: <20200422130135.38555-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is export_uuid() function which exports uuid_t to the u8 array.
Use it instead of open coding variant.

This allows to hide the uuid_t internals.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 22bf553ccf9df..2491a2cb54a22 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct platform_device *pdev)
 
 	/* Open a session with fTPM TA */
 	memset(&sess_arg, 0, sizeof(sess_arg));
-	memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
+	export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
 	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
 	sess_arg.num_params = 0;
 
-- 
2.26.1

