Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955843D1D58
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhGVEqe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 00:46:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35352 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhGVEqe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 00:46:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UgaSEw1_1626931624;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UgaSEw1_1626931624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Jul 2021 13:27:04 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH ima-evm-utils] ima-evm-utils: Fix incorrect algorithm name in hash_info.gen
Date:   Thu, 22 Jul 2021 13:27:04 +0800
Message-Id: <20210722052704.11031-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is no such an algorithm name as sm3-256. This is an ambiguity
caused by the definition of the macro HASH_ALGO_SM3_256. The sed
command is only a special case of sm3, so sm3 is used to replace
the sm3-256 algorithm name.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/.gitignore    | 1 +
 src/hash_info.gen | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/.gitignore b/src/.gitignore
index 38e8e3c..69d2988 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1 +1,2 @@
 hash_info.h
+tmp_hash_info.h
diff --git a/src/hash_info.gen b/src/hash_info.gen
index 5f7a97f..f72db37 100755
--- a/src/hash_info.gen
+++ b/src/hash_info.gen
@@ -86,7 +86,7 @@ sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
   while read a b; do
     # Normalize text hash name: if it contains underscore between
     # digits replace it with a dash, other underscores are removed.
-    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
+    b=$(echo "$b" | sed "s/sm3_256/sm3/g;s/_//g")
     printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
   done
 echo "};"
-- 
2.19.1.3.ge56e4f7

