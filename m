Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04E778CA
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jul 2019 14:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfG0MzD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jul 2019 08:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfG0MzD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jul 2019 08:55:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0175C8553D;
        Sat, 27 Jul 2019 12:55:03 +0000 (UTC)
Received: from localhost (ovpn-116-13.gru2.redhat.com [10.97.116.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A2645C206;
        Sat, 27 Jul 2019 12:55:02 +0000 (UTC)
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        dmitry.kasatkin@gmail.com
Subject: [PATCH] ima-evm-utils: fix trailing chars from configure script
Date:   Sat, 27 Jul 2019 09:55:01 -0300
Message-Id: <20190727125501.30914-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 27 Jul 2019 12:55:03 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Two chars were left in a AC_DEFINE() in configure.ac, leading to an error
message during ./configure call:

checking for tsspcrread... yes
./configure: line 9894: ],: command not found

Signed-off-by: Bruno E. O. Meneguele <bmeneg@redhat.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index eedf90e..7747481 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,7 +32,7 @@ AC_CHECK_HEADERS(openssl/conf.h)
 
 AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
 if test "x$TSSPCRREAD" = "xyes"; then
-	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binary installed])],
+	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binary installed])
 fi
 
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not found. You need the c-library development package.])])
-- 
2.21.0

