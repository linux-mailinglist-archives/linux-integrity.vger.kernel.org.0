Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C43746F0
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGYGNM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 02:13:12 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36612 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfGYGNL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 02:13:11 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C032672CCE7;
        Thu, 25 Jul 2019 09:13:09 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 935564A4AE8;
        Thu, 25 Jul 2019 09:13:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima-evm-utils: Show used hash algo in verbose mode
Date:   Thu, 25 Jul 2019 09:13:06 +0300
Message-Id: <20190725061306.30515-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190725061306.30515-1-vt@altlinux.org>
References: <20190725061306.30515-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This could be useful for users.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
This will conflict with not accepted `params' rename patch.

 src/evmctl.c    | 2 +-
 src/libimaevm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3766343..75dd163 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -605,7 +605,7 @@ static int hash_ima(const char *file)
 	len += offset;
 
 	if (params.verbose >= LOG_INFO)
-		log_info("hash: ");
+		log_info("hash(%s): ", params.hash_algo);
 
 	if (sigdump || params.verbose >= LOG_INFO)
 		dump(hash, len);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 86c5784..11dbf11 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -822,7 +822,7 @@ int sign_hash_v1(const char *hashalgo, const unsigned char *hash, int size, cons
 		return -1;
 	}
 
-	log_info("hash: ");
+	log_info("hash(%s): ", hashalgo);
 	log_dump(hash, size);
 
 	key = read_priv_key(keyfile, params.keypass);
-- 
2.11.0

