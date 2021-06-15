Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF813A79DF
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFOJQY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 05:16:24 -0400
Received: from smtp1.axis.com ([195.60.68.17]:30212 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhFOJQX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 05:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1623748459;
  x=1655284459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZioGxoS30UGTMxh0YlC+V9a3psok5zllOcCyvoePeY=;
  b=bDosFGD52rRmdKiAurai0dN+89401b5OFAQS93U3C34cmFW4RYDeyGAG
   X6M+V8xRJ53lHwzjNjnAVS26AiD2mSecVFwXM+VV6wmeDmjHZzyot7XE/
   tjfpUXLFkaH6p8y7MbCxrjjHZP1c01LAdjFlfYCrZs9n9JvLR+r/u2vKK
   Trc37EXtYhG4whm3rCv09tXxMScqmGjN2UWTx2aPNlmi9hOL238Xc7BrA
   L9FpxEqzaAOWjtOZagUSLaNDNai22ZJgiGSknk1Jfamld3TdK5rXuseyR
   lihizVNXGrc5td1ia1CVelG5lIr8Iy6NozRDBrjXx32mJ5DjxiSHGEbG/
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] tpm: Fix crash on tmprm release
Date:   Tue, 15 Jun 2021 11:14:09 +0200
Message-ID: <20210615091410.17007-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210615091410.17007-1-vincent.whitchurch@axis.com>
References: <20210615091410.17007-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the tpm_tis module is removed (or a system shutdown is triggered)
while the tpmrm device is use, the kernel crashes due to chip->ops being
NULL:

 # exec 3<>/dev/tpmrm0
 # rmmod tpm_tis
 # exit
 ==================================================================
 BUG: KASAN: null-ptr-deref in tpm_chip_start+0x2d/0x120 [tpm]
 Read of size 8 at addr 0000000000000060 by task sh/994

 Call Trace:
  kasan_report.cold.13+0x10f/0x111
  tpm_chip_start+0x2d/0x120 [tpm]
  tpm2_del_space+0x2c/0xa0 [tpm]
  tpmrm_release+0x3f/0x50 [tpm]
  __fput+0x110/0x3c0
  task_work_run+0x94/0xd0
  do_exit+0x683/0x13e0
  do_group_exit+0x8b/0x140
  do_syscall_64+0x3c/0x80
 ==================================================================

Fix this by making tpm2_del_space() use tpm_try_get_ops().  The latter
already includes the calls to tpm_chip_start() and tpm_chip_stop().

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/char/tpm/tpm2-space.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 784b8b3cb903..e1111261021f 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,12 +58,10 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-	mutex_lock(&chip->tpm_mutex);
-	if (!tpm_chip_start(chip)) {
+	if (!tpm_try_get_ops(chip)) {
 		tpm2_flush_sessions(chip, space);
-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}
-	mutex_unlock(&chip->tpm_mutex);
 	kfree(space->context_buf);
 	kfree(space->session_buf);
 }
-- 
2.28.0

