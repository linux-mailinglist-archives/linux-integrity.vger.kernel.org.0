Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4E223B16
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQMEa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 08:04:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgGQME3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 08:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF8FBB03F;
        Fri, 17 Jul 2020 12:04:32 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] Add sanity check for file parameter of ima_boot_aggregate
Date:   Fri, 17 Jul 2020 14:04:22 +0200
Message-Id: <20200717120422.71299-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parameter expects to be a copy of
/sys/kernel/security/tpm0/binary_bios_measurements (i.e. regular file,
not a directory, block or character device, socket, ...)

Fixes: f49e982 ("ima-evm-utils: read the TPM 1.2 binary_bios_measurements")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

feel free to modify this patchset to fits your needs (unless I'm wrong
and this should not be applied at all).

Kind regards,
Petr

 src/evmctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 04dc2ad..3ad5039 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2082,6 +2082,13 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 	int len;
 	int i;
 
+	struct stat s;
+	stat(file, &s);
+	if (!S_ISREG(s.st_mode)) {
+		log_errno("Not a regular file or link to regular file.\n");
+		return 1;
+	}
+
 	fp = fopen(file, "r");
 	if (!fp) {
 		log_errno("Failed to open TPM 1.2 event log.\n");
-- 
2.27.0.rc0

