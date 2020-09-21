Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E227242E
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Sep 2020 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIUMtv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Sep 2020 08:49:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgIUMtv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 08:49:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 985A2AEFE;
        Mon, 21 Sep 2020 12:50:26 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils 1/1] help: Add missing new line for --ignore-violations
Date:   Mon, 21 Sep 2020 14:49:41 +0200
Message-Id: <20200921124941.8355-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: 62534f2 ("Rename "--validate" to "--ignore-violations"")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c7f6732..1815f55 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2467,7 +2467,7 @@ static void usage(void)
 		"      --caps         use custom Capabilities for EVM(unspecified: from FS, empty: do not use)\n"
 		"      --verify-sig   verify measurement list signatures\n"
 		"      --engine e     preload OpenSSL engine e (such as: gost)\n"
-		"      --ignore-violations ignore ToMToU measurement violations"
+		"      --ignore-violations ignore ToMToU measurement violations\n"
 		"  -v                 increase verbosity level\n"
 		"  -h, --help         display this help and exit\n"
 		"\n");
-- 
2.28.0

