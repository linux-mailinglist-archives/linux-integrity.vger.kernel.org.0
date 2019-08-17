Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094D39137E
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2019 00:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfHQWcf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Aug 2019 18:32:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56454 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfHQWcf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Aug 2019 18:32:35 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E25BC72CCE6;
        Sun, 18 Aug 2019 01:32:32 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id AF06D4A4AE7;
        Sun, 18 Aug 2019 01:32:32 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] ima-evm-utils: Change log text of hash in hash_ima
Date:   Sun, 18 Aug 2019 01:32:29 +0300
Message-Id: <20190817223229.22623-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Output value is not just a hash, but hash prefixed with header. User may
be confused to see invalid hash value. Thus, change text so that is
obvious this is not a raw hash.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index ef1f289..53711f4 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -606,7 +606,7 @@ static int hash_ima(const char *file)
 	len += offset;
 
 	if (imaevm_params.verbose >= LOG_INFO)
-		log_info("hash(%s): ", imaevm_params.hash_algo);
+		log_info("hdr+hash(%s): ", imaevm_params.hash_algo);
 
 	if (sigdump || imaevm_params.verbose >= LOG_INFO)
 		imaevm_hexdump(hash, len);
-- 
2.11.0

