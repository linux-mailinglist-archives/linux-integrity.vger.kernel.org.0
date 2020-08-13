Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE737243ED0
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMSZn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:54180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHMSZm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3175CAEA6;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 6/9] Remove install-tpm2-tss.sh
Date:   Thu, 13 Aug 2020 20:25:29 +0200
Message-Id: <20200813182532.6931-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2-software is being packaged in major distros nowadays.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tests/install-tpm2-tss.sh | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100755 tests/install-tpm2-tss.sh

diff --git a/tests/install-tpm2-tss.sh b/tests/install-tpm2-tss.sh
deleted file mode 100755
index 7a71b57..0000000
--- a/tests/install-tpm2-tss.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-
-git clone https://github.com/tpm2-software/tpm2-tss.git
-cd tpm2-tss
-./bootstrap
-./configure
-make -j$(nproc)
-sudo make install
-sudo ldconfig
-cd ..
-rm -rf tpm2-tss
-
-git clone https://github.com/tpm2-software/tpm2-tools.git
-cd tpm2-tools
-./bootstrap && ./configure --prefix=/usr
-make -j$(nproc)
-sudo make install
-cd ..
-rm -rf tpm2-tools
-- 
2.28.0

