Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25D67633
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfGLV2r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 17:28:47 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:32826 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLV2r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 17:28:47 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4D03672CCD9;
        Sat, 13 Jul 2019 00:28:45 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id B7A334A4AE8;
        Sat, 13 Jul 2019 00:28:44 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 3/5] ima-evm-utils: Fix memory leak in get_password
Date:   Sat, 13 Jul 2019 00:28:31 +0300
Message-Id: <20190712212833.29280-3-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190712212833.29280-1-vt@altlinux.org>
References: <20190712212833.29280-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Free password buffer when return NULL.
Partially fix CID 229894.
---
 src/evmctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index e07cff4..c556d05 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1827,6 +1827,7 @@ static char *get_password(void)
 
 	if (tcsetattr(fileno(stdin), TCSANOW, &tmp_flags) != 0) {
 		perror("tcsetattr");
+		free(password);
 		return NULL;
 	}
 
@@ -1836,6 +1837,7 @@ static char *get_password(void)
 	/* restore terminal */
 	if (tcsetattr(fileno(stdin), TCSANOW, &flags) != 0) {
 		perror("tcsetattr");
+		free(password);
 		return NULL;
 	}
 
-- 
2.11.0

