Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01AAC5E825
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2019 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCPvc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Jul 2019 11:51:32 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42152 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPvc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Jul 2019 11:51:32 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DB7AC72CC6C;
        Wed,  3 Jul 2019 18:51:29 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id E95654A4A29;
        Wed,  3 Jul 2019 18:51:28 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 9/9] ima-evm-utils: Log hash_algo with hash value in verbose mode
Date:   Wed,  3 Jul 2019 18:50:15 +0300
Message-Id: <20190703155015.14262-10-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190703155015.14262-1-vt@altlinux.org>
References: <20190703155015.14262-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It's useful to know not just a hash value but also which algorithm is
used.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/libimaevm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index caf1237..51d6c33 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -460,7 +460,7 @@ int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	const char *st;
 
 	if (params.verbose > LOG_INFO) {
-		log_info("hash: ");
+		log_info("hash(%s): ", params.hash_algo);
 		log_dump(hash, size);
 	}
 
@@ -880,7 +880,7 @@ int sign_hash_v2(const char *algo, const unsigned char *hash, int size, const ch
 		return -1;
 	}
 
-	log_info("hash: ");
+	log_info("hash(%s): ", params.hash_algo);
 	log_dump(hash, size);
 
 	pkey = read_priv_pkey(keyfile, params.keypass);
-- 
2.11.0

