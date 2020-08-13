Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7240243ECF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMSZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BCD1AEAA;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 7/9] autogen.sh: Cleanup
Date:   Thu, 13 Aug 2020 20:25:30 +0200
Message-Id: <20200813182532.6931-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

m4 directory exists, force parameter is not needed.
Remove commented out "old way".

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 autogen.sh | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/autogen.sh b/autogen.sh
index d01bb43..902f2bc 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -1,16 +1,4 @@
 #! /bin/sh
-
 set -e
 
-# new way
-# strange, but need this for Makefile.am, because it has -I m4
-test -d m4 || mkdir m4
-autoreconf -f -i
-
-# old way
-#libtoolize --automake --copy --force
-#aclocal
-#autoconf --force
-#autoheader --force
-#automake --add-missing --copy --force-missing --gnu
-
+autoreconf -i
-- 
2.28.0

