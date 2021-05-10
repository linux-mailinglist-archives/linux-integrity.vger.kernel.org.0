Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B419379120
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbhEJOlv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 10:41:51 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:58289 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343611AbhEJOjz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 10:39:55 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 10:37:47 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 14AESvE2010698;
        Mon, 10 May 2021 17:28:57 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 2582E63A17; Mon, 10 May 2021 17:29:03 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1] tpm2: add longer timeout for verify signature command
Date:   Mon, 10 May 2021 17:27:19 +0300
Message-Id: <20210510142719.48153-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210510142719.48153-1-amirmizi6@gmail.com>
References: <20210510142719.48153-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

TPM2_CC_VERIFY_SIGNATURE(0x177) Current timeout does not apply to usage with
RSA 3070-bit keys.
Additional time may be required for usage with RSA 3070-bit keys. Therefore, the
timeout of TPM2_CC_VERIFY_SIGNATURE is set to 3 minutes (TPM_LONG_LONG).

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index eff1f12..235a454 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -87,7 +87,7 @@ static u8 tpm2_ordinal_duration_index(u32 ordinal)
 		return TPM_MEDIUM;
 
 	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
-		return TPM_LONG;
+		return TPM_LONG_LONG;
 
 	case TPM2_CC_PCR_EXTEND:              /* 182 */
 		return TPM_MEDIUM;
-- 
2.7.4

