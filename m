Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F74D75CCB
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 04:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfGZCOi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 22:14:38 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:30429 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGZCOi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 22:14:38 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-08.nifty.com with ESMTP id x6Q2Bjtw013844;
        Fri, 26 Jul 2019 11:11:45 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03m020523;
        Fri, 26 Jul 2019 11:11:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03m020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107065;
        bh=2py97rXQmeBJv0x49nST5dYu797IUCM7mWTUZUS20lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXTzbm4uOdkuSdZBWHV2rF+A3QgFM7x2x+mWb3z+COmAhltTh4e67vwYhx6iyiTA6
         /FEanUpRLEBSYNwyQGaPJ3+cA1R/J8VyXHEmA63HfXDQjgjPS1qURaoACzCHNwuJ3n
         Q0yRW6ff5zMqvLj+AHdWPTvEyy7gd4h8flSJFV6DyNwwd/viWiL8IEK3Wh5WOBeZ6U
         Ic/pQxZYWBYTgLB614/VwvRA4VBheSEBj7bFlOkYBP7ZhbEhLf9OC53M5gSKpYelUL
         /B4C9AdZydWf5TCmq0GKUS+lcVOL4pfVfMVBR9l98AJ2T0oowPWqOfVNzx0+Gwpu4K
         Emm/8uq34ANBQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 4/5] IMA: use obj-y for non-modular objects
Date:   Fri, 26 Jul 2019 11:10:57 +0900
Message-Id: <20190726021058.4212-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726021058.4212-1-yamada.masahiro@socionext.com>
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

CONFIG_IMA is a boolean option, so none of these objects is linked
into a module.

All the objects in this directory are compiled only when CONFIG_IMA=y
since this directory is guarded by the parent Makefile:

  obj-$(CONFIG_IMA)                       += ima/

So, there is no point in creating the composite object, ima.o

Flatten the code into the obj-$(CONFIG_...) form.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 security/integrity/ima/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index d921dc4f9eb0..5517486c9154 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -4,10 +4,8 @@
 # Measurement Architecture(IMA).
 #
 
-obj-$(CONFIG_IMA) += ima.o
-
-ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
+obj-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o
-ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
-ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
+obj-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
+obj-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
-- 
2.17.1

