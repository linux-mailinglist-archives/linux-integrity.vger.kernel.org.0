Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CAB75CD0
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 04:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGZCPX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 22:15:23 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:63250 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGZCPX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 22:15:23 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-09.nifty.com with ESMTP id x6Q2BjnO020605;
        Fri, 26 Jul 2019 11:11:45 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6Q2B03k020523;
        Fri, 26 Jul 2019 11:11:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6Q2B03k020523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564107063;
        bh=nOKtkgXfIVcWv2vTVE3jpIpHqbVnmkI/DmNIReebTe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHlRhbNo1ln2bJlCtBH2WZ40lxEa9J4wi+PaKV3i8SSd0c35WyDiSS6wXPknju9om
         8B8KdYixmjkrlC5Y6Ki7VXcaWnIylTAeNDz8PKh2SR6P64FwOoCUdtcsSDZKBzN/kU
         MrVLStkWF9L0N0+rdsKhfrwFXXrc152JFzW5S+j0usjaQtNNxiUJ32BF/K7V7/dMt+
         EjjbSFxnpIM47qP/GFmAuyG5F2ZjWyRO2ZwyhxRmUKIcy36bpYd8Ujzq7PCMG4EZmI
         t1vn5ogE8MceqLOboNsb9S82127dFNyWK3QFji0MklniUOJlSBaH7HCRWy6sMZd0dZ
         5UOYvSEDoRPxw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dave Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/5] integrity: remove pointless subdir-$(CONFIG_...)
Date:   Fri, 26 Jul 2019 11:10:55 +0900
Message-Id: <20190726021058.4212-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726021058.4212-1-yamada.masahiro@socionext.com>
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ima/ and evm/ sub-directories contain built-in objects, so
obj-$(CONFIG_...) is the correct way to descend into them.

subdir-$(CONFIG_...) is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 security/integrity/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index b6d6273a4176..35e6ca773734 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -14,7 +14,5 @@ integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 					platform_certs/load_uefi.o
 integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
 
-subdir-$(CONFIG_IMA)			+= ima
 obj-$(CONFIG_IMA)			+= ima/
-subdir-$(CONFIG_EVM)			+= evm
 obj-$(CONFIG_EVM)			+= evm/
-- 
2.17.1

