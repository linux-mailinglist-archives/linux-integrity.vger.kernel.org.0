Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10B02A81D0
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Nov 2020 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgKEPEv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Nov 2020 10:04:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:41756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbgKEPEu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Nov 2020 10:04:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7161ABD1;
        Thu,  5 Nov 2020 15:04:49 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>,
        Maurizio Drocco <maurizio.drocco@ibm.com>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/1] ima: Update doc for TPM 2.0 for calculating boot_aggregate
Date:   Thu,  5 Nov 2020 16:04:36 +0100
Message-Id: <20201105150436.30785-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

20c59ce010f8 ("ima: extend boot_aggregate with kernel
measurements") added registers 8-9 for TPM 2.0. Documented it in the
code, but it should be mentioned in the docs above the function.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

feel free to further change docs (if I wasn't correct).
I omit the fact that reg. 8-9 are only for ! sha1

Kind regards,
Petr

 security/integrity/ima/ima_crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 21989fa0c107..56b587fd4f9d 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -796,10 +796,10 @@ static void ima_pcrread(u32 idx, struct tpm_digest *d)
 }
 
 /*
- * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
- * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but with
- * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
- * allowing firmware to configure and enable different banks.
+ * The boot_aggregate is a cumulative hash over TPM registers 0-7 (TPM 1.2)
+ * or 0-9 (TPM 2.0). With TPM 1.2 the boot_aggregate was based on reading the
+ * SHA1 PCRs, but with TPM 2.0 hash agility, TPM chips could support multiple
+ * TPM PCR banks, allowing firmware to configure and enable different banks.
  *
  * Knowing which TPM bank is read to calculate the boot_aggregate digest
  * needs to be conveyed to a verifier.  For this reason, use the same
-- 
2.29.1

