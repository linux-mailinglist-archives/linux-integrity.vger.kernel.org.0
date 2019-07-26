Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3BD75CEB
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 04:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfGZCXQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 22:23:16 -0400
Received: from condef-04.nifty.com ([202.248.20.69]:56001 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGZCXQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 22:23:16 -0400
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 22:23:15 EDT
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-04.nifty.com with ESMTP id x6Q2Bfev016282;
        Fri, 26 Jul 2019 11:11:41 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03n020523;
        Fri, 26 Jul 2019 11:11:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03n020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107066;
        bh=tnYEZud056hAhoewZO62tSceN4oWh0Eu5vKNqgUHTuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAQTARqBJdu5M8oLYd9bZGW5wUIXU99lD2ThtL6eLuFOMuxsHICMGHymnGXmleVYg
         Qa74aWIuWW6Sy5XLCpWzGV3rzgw2M5BplNz2l7owILS32xrbkw713nPjK+MobFaugG
         Ppf0wkHQYTPKDkYTF9hsbNZIMxzYT2gVQmhkQzEttDwwpKbogmjgpS0xxjjrTwAGiD
         aB5qreWN5KaHdUPdDN/C1Cnmv/FO/LW4b/1Gr359v3j5x2ycE4oH+Dy0sMBBUQt69K
         wk+ZYdETNjLFXjjtyaKw7R6nh6tHDhf/Ms3iRL4cvNbtrEeoI5A4XcFPKj7u0AEh2v
         GFccDlB1DNNnA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 5/5] EVM: use obj-y for non-modular objects
Date:   Fri, 26 Jul 2019 11:10:58 +0900
Message-Id: <20190726021058.4212-6-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726021058.4212-1-yamada.masahiro@socionext.com>
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

CONFIG_EVM is a boolean option, so none of these objects is linked
into a module.

All the objects in this directory are compiled only when CONFIG_EVM=y
since this directory is guarded by the parent Makefile:

  obj-$(CONFIG_EVM)                       += evm/

So, there is no point in creating the composite object, evm.o

Flatten the code into the obj-$(CONFIG_...) form.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 security/integrity/evm/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/integrity/evm/Makefile b/security/integrity/evm/Makefile
index a56f5613be79..ace8e4ef5a96 100644
--- a/security/integrity/evm/Makefile
+++ b/security/integrity/evm/Makefile
@@ -2,7 +2,5 @@
 #
 # Makefile for building the Extended Verification Module(EVM)
 #
-obj-$(CONFIG_EVM) += evm.o
-
-evm-y := evm_main.o evm_crypto.o evm_secfs.o
-evm-$(CONFIG_FS_POSIX_ACL) += evm_posix_acl.o
+obj-y := evm_main.o evm_crypto.o evm_secfs.o
+obj-$(CONFIG_FS_POSIX_ACL) += evm_posix_acl.o
-- 
2.17.1

