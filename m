Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F02DA05E
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440629AbgLNTY6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 14:24:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:53852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440832AbgLNTYu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 14:24:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A653FAC10;
        Mon, 14 Dec 2020 19:24:07 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] pcr_tsspcrread: Add missing new line
Date:   Mon, 14 Dec 2020 20:23:59 +0100
Message-Id: <20201214192359.9849-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: 80d3fda ("ima-evm-utils: Check for tsspcrread in runtime")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

sorry for introducing error.

Kind regards,
Petr
 src/pcr_tsspcrread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
index 462f270..183dfc2 100644
--- a/src/pcr_tsspcrread.c
+++ b/src/pcr_tsspcrread.c
@@ -60,11 +60,11 @@ int tpm2_pcr_supported(void)
 		log_info("Using %s to read PCRs.\n", CMD);
 
 	if (get_cmd_path(CMD, path, sizeof(path))) {
-		log_debug("Couldn't find '%s' in $PATH", CMD);
+		log_debug("Couldn't find '%s' in $PATH\n", CMD);
 		return 0;
 	}
 
-	log_debug("Found '%s' in $PATH", CMD);
+	log_debug("Found '%s' in $PATH\n", CMD);
 	return 1;
 }
 
-- 
2.29.2

