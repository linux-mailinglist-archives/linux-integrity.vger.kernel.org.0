Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A01FFB52
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgFRSuq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRSup (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E2C2ACED;
        Thu, 18 Jun 2020 18:50:44 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils 2/3] Don't run tsspcrread on systems without TPM
Date:   Thu, 18 Jun 2020 20:50:37 +0200
Message-Id: <20200618185038.21837-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

as we don't have any algorithm:

./src/evmctl ima_boot_aggregate
sh: -c: line 0: syntax error near unexpected token `('
sh: -c: line 0: `tsspcrread -halg (null) -ha 0 -ns 2> /dev/null'
sh: -c: line 0: syntax error near unexpected token `('
sh: -c: line 0: `tsspcrread -halg (null) -ha 0 -ns 2> /dev/null'
errno: No such file or directory (2)

Now it just prints:
errno: No such file or directory (2)

Fixes: dc00c92 ("ima-evm-utils: calculate the per TPM bank
boot_aggregate")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

not really sure if this is a best place to handle the problem.

Kind regards,
Petr

 src/evmctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 94ec56b..03eeb6e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1796,6 +1796,12 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	for (i = 0; i < num_banks; i++) {
 		err = 0;
 		for (j = 0; j < NUM_PCRS && !err; j++) {
+			if (!bank[i].algo_name) {
+				log_debug("No algo_name for PCR: %d\n", i);
+				bank[i].supported = 0;
+				continue;
+			}
+
 			err = tpm2_pcr_read(bank[i].algo_name, j,
 					    bank[i].pcr[j], bank[i].digest_size,
 					    &errmsg);
-- 
2.27.0

