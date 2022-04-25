Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F150DDD7
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Apr 2022 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiDYK3I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiDYK3G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 06:29:06 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423B5DA34
        for <linux-integrity@vger.kernel.org>; Mon, 25 Apr 2022 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1650882363;
  x=1682418363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bs7yvfW9NfR2it+tPLq4jgvRZozeukWf85GrO+jxcQM=;
  b=j0+/KEknXnxr10CHxhtnbdWud5KmUUGkqB++U5t7UlXZ7/menj2PkRAa
   asHPqrnA99hJrHhOp+Y5zhJfiwfylxdwMt7xpm6nUvNOEqKfNA75pSq0b
   JChGX+qo0jkJDbEbfzDtfkY4sZbEFxf2uTH5gkEvrvCgJsXMyvvBo+GWi
   JqHsQMLkdkWLo7+kiubj7hCkNRAzVY76FSAZQp3iK96+xtwunSBIk8OgD
   ZHWc4/NcejYIrv3Sb7tHtmTNBbawtNHcHlDzhIc54lDAUd8BPzhadfjxY
   wQvx3YZruBw3kD3ZYtUlwJT7hWeKeWi2rO1Vcb5yW2K9GdPpuThHEoOWW
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH] tpm: Add check for Failure mode for TPM2 modules
Date:   Mon, 25 Apr 2022 12:25:52 +0200
Message-ID: <20220425102552.663069-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In commit 0aa698787aa2 ("tpm: Add Upgrade/Reduced mode support for
TPM2 modules") it was said that:

"If the TPM is in Failure mode, it will successfully respond to both
tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM
is in Failure mode."

But a check was never added in the commit when calling
tpm2_get_cc_attrs_tbl() to conclude that the TPM is in Failure mode.
This commit corrects this by adding a check.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/char/tpm/tpm2-cmd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4704fa553098..9da433521a0b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -743,6 +743,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 	}
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
+	if (rc < 0 && rc != -ENOMEM) {
+		dev_info(&chip->dev, "TPM in field failure mode, requires firmware upgrade\n");
+		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
+		rc = 0;
+	}
 
 out:
 	if (rc == TPM2_RC_UPGRADE) {
-- 
2.30.2

