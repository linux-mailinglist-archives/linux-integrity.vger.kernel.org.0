Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615B83C436F
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGLFUD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 01:20:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33996 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhGLFUD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 01:20:03 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4F99972C8B4;
        Mon, 12 Jul 2021 08:17:14 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 3DC7E4A46ED;
        Mon, 12 Jul 2021 08:17:14 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils 2/3] CI: Do not use sudo when it does not needed
Date:   Mon, 12 Jul 2021 08:16:43 +0300
Message-Id: <20210712051644.2469633-2-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <20210712051644.2469633-1-vt@altlinux.org>
References: <20210712051644.2469633-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some distributions, such as ALT, cannot use sudo under root by default.
Error message will appear:

  root is not in the sudoers file.  This incident will be reported.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tests/install-swtpm.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git tests/install-swtpm.sh tests/install-swtpm.sh
index 2666748..51aa377 100755
--- tests/install-swtpm.sh
+++ tests/install-swtpm.sh
@@ -1,5 +1,13 @@
-#!/bin/sh
-set -ex
+#!/bin/sh -ex
+
+# No need to run via sudo if we already have permissions.
+# Also, some distros do not have sudo configured for root:
+#   `root is not in the sudoers file.  This incident will be reported.'
+if [ -w /usr/local/bin ]; then
+	SUDO=
+else
+	SUDO=sudo
+fi
 
 version=1637
 
@@ -9,5 +17,5 @@ cd ibmtpm$version
 tar --no-same-owner -xvzf ../download
 cd src
 make -j$(nproc)
-sudo cp tpm_server /usr/local/bin/
+$SUDO cp tpm_server /usr/local/bin/
 cd ../..
-- 
2.29.3

