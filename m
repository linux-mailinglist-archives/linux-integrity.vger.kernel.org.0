Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131B1FFB53
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgFRSur (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:50:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRSuq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:50:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C233AD76;
        Thu, 18 Jun 2020 18:50:45 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH ima-evm-utils 3/3] logging: Print also LOG_INFO messages
Date:   Thu, 18 Jun 2020 20:50:38 +0200
Message-Id: <20200618185038.21837-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618185038.21837-1-pvorel@suse.cz>
References: <20200618185038.21837-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

as some errors are using it, e.g. in previous fix
just errno would be printed:

./src/evmctl ima_boot_aggregate
Failed to read any TPM PCRs
errno: No such file or directory (2)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

Just attempt to do quick fix. I guess reconsidering levels as code has
changed would be better, but require more work.

Kind regards,
Petr

 src/libimaevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 683cfb8..4bcce13 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -82,7 +82,7 @@ static const char *const pkey_hash_algo_kern[PKEY_HASH__LAST] = {
 };
 
 struct libimaevm_params imaevm_params = {
-	.verbose = LOG_INFO - 1,
+	.verbose = LOG_INFO,
 	.x509 = 1,
 	.hash_algo = "sha1",
 };
-- 
2.27.0

