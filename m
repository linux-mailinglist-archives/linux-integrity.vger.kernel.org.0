Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BF243EC9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMSZl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgHMSZl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F16FADC1;
        Thu, 13 Aug 2020 18:26:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 1/9] configure: Fix tss2-esys check
Date:   Thu, 13 Aug 2020 20:25:24 +0200
Message-Id: <20200813182532.6931-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check tss2-esys with Esys_Free() instead of Esys_PCR_Read().
That should be the newest dependency.

That means we depend on tss2-esys >= 2.1.0 instead of 2.0.0.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 971a712..8e13b61 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,9 +30,9 @@ AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
 
-AC_CHECK_LIB([tss2-esys], [Esys_PCR_Read])
+AC_CHECK_LIB([tss2-esys], [Esys_Free])
 AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
-AM_CONDITIONAL([USE_PCRTSS], [test "x$ac_cv_lib_tss2_esys_Esys_PCR_Read" = "xyes"])
+AM_CONDITIONAL([USE_PCRTSS], [test "x$ac_cv_lib_tss2_esys_Esys_Free" = "xyes"])
 
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not found. You need the libkeyutils development package.])])
@@ -77,6 +77,6 @@ echo
 echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
-echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_PCR_Read"
+echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_Free"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo
-- 
2.28.0

