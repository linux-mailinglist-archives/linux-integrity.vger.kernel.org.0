Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B8243ECC
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMSZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 061A0AE8C;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 5/9] install-swtpm.sh: Update ibmtpm to version 1637
Date:   Thu, 13 Aug 2020 20:25:28 +0200
Message-Id: <20200813182532.6931-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tests/install-swtpm.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index 2afcf17..2d8293a 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -1,9 +1,11 @@
 #!/bin/sh
-
 set -ex
-wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1332.tar.gz/download
-mkdir ibmtpm1332
-cd ibmtpm1332
+
+version=1637
+
+wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm${version}.tar.gz/download
+mkdir ibmtpm$version
+cd ibmtpm$version
 tar -xvzf ../download
 cd src
 make -j$(nproc)
-- 
2.28.0

