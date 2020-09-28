Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B327B3DA
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1SAO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 14:00:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33320 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgI1SAO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 14:00:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 06D8B8EE17F;
        Mon, 28 Sep 2020 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601316014;
        bh=OAUA+J6QesgBNlToFU8EYrCQnohfzjEcb6tSBiBdbLs=;
        h=Subject:From:To:Cc:Date:From;
        b=ltzAZBQ02AoXcjNFNy7QEEtGMTUwjCNfY8/oK8//4gd/hy8WUKZvr/CdEfilcOHiJ
         GGZQMCtOZyICb780Ae/iXOmx2D9exmz3lFJkD8OgTszTNLzQ3LGSGYKFzzDBTR6pIu
         wF2kGJweFnZ+JRHCwFh7zRAdhvxfFFezhS9vM+1w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0ZUWP3fHpmcB; Mon, 28 Sep 2020 11:00:13 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6254D8EE0F5;
        Mon, 28 Sep 2020 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601316013;
        bh=OAUA+J6QesgBNlToFU8EYrCQnohfzjEcb6tSBiBdbLs=;
        h=Subject:From:To:Cc:Date:From;
        b=Y9YpGDtZ+u4UnoHeairM+vR+xvgXxHqWZjXcF2Eh3gGYhO7+sDOymgZv8UNlN93Nt
         SNsnQsC+GgaM3qXDPG5tPp4g/Xoe8KI3y40Zv8+nsiw4uUK4oIg0ve/+lAdBNWFgC3
         m521XTSsp1Ta+UxtgLohDkNajyYLjQQAtlycz/OE=
Message-ID: <9bad3da0c31ae2620aaae0d75748c3387afa3d47.camel@HansenPartnership.com>
Subject: [PATCH] tpm_tis: Add a check for invalid status
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Mon, 28 Sep 2020 11:00:12 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some TIS based TPMs can return 0xff to status reads if the locality
hasn't been properly requested.  Detect this condition by checking the
bits that the TIS spec specifies must return zero are clear and return
zero in that case.  Also drop a warning so the problem can be
identified in the calling path and fixed (usually a missing
try_get_ops()).

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---

This is the patch I've been using to catch and kill all the points in
the stack where we're not properly using get/put ops on the tpm chip.

 drivers/char/tpm/tpm_tis_core.c | 11 +++++++++++
 drivers/char/tpm/tpm_tis_core.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 65ab1b027949..92c51c6cfd1b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -239,6 +239,17 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
 	if (rc < 0)
 		return 0;
 
+	if (unlikely((status & TPM_STS_READ_ZERO) != 0)) {
+		/*
+		 * If this trips, the chances are the read is
+		 * returning 0xff because the locality hasn't been
+		 * acquired.  Usually because tpm_try_get_ops() hasn't
+		 * been called before doing a TPM operation.
+		 */
+		WARN_ONCE(1, "TPM returned invalid status\n");
+		return 0;
+	}
+
 	return status;
 }
 
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819f5d7b..9b2d32a59f67 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -34,6 +34,7 @@ enum tis_status {
 	TPM_STS_GO = 0x20,
 	TPM_STS_DATA_AVAIL = 0x10,
 	TPM_STS_DATA_EXPECT = 0x08,
+	TPM_STS_READ_ZERO = 0x23, /* bits that must be zero on read */
 };
 
 enum tis_int_flags {
-- 
2.26.2


