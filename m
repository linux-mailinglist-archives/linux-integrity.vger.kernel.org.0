Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9191217F69
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 08:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgGHGHm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 02:07:42 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60160 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729741AbgGHGHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 02:07:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U25CVmN_1594188459;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U25CVmN_1594188459)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 14:07:39 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils 2/3] ima-evm-utils: beautify the code to make it more readable
Date:   Wed,  8 Jul 2020 14:07:37 +0800
Message-Id: <20200708060738.43558-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708060738.43558-1-tianjia.zhang@linux.alibaba.com>
References: <20200708060738.43558-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use enum type instead of hard-coded numbers to improve code readability.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index a9419ee..8f2ebcf 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -579,7 +579,7 @@ static int get_hash_algo_from_sig(unsigned char *sig)
 {
 	uint8_t hashalgo;
 
-	if (sig[0] == 1) {
+	if (sig[0] == DIGSIG_VERSION_1) {
 		hashalgo = ((struct signature_hdr *)sig)->hash;
 
 		if (hashalgo >= DIGEST_ALGO_MAX)
@@ -593,7 +593,7 @@ static int get_hash_algo_from_sig(unsigned char *sig)
 		default:
 			return -1;
 		}
-	} else if (sig[0] == 2) {
+	} else if (sig[0] == DIGSIG_VERSION_2) {
 		hashalgo = ((struct signature_v2_hdr *)sig)->hash_algo;
 		if (hashalgo >= PKEY_HASH__LAST)
 			return -1;
@@ -625,7 +625,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
 
-	if (sig[0] != 0x03) {
+	if (sig[0] != EVM_IMA_XATTR_DIGSIG) {
 		log_err("xattr ima has no signature\n");
 		return -1;
 	}
-- 
2.17.1

