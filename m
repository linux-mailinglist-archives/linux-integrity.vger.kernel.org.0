Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB06033F2A3
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhCQOab (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 10:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhCQOa0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 10:30:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E0C06174A
        for <linux-integrity@vger.kernel.org>; Wed, 17 Mar 2021 07:30:25 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lMXBg-0006lj-Uf; Wed, 17 Mar 2021 15:30:16 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1lMXBf-0007Ir-3V; Wed, 17 Mar 2021 15:30:15 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: trusted: tee: fix build error due to missing include
Date:   Wed, 17 Mar 2021 15:29:05 +0100
Message-Id: <20210317142904.27855-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

MODULE_DEVICE_TABLE is defined in <linux/module.h>, which is not
included. Add the include to fix the build error its lack caused.

Cc: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 security/keys/trusted-keys/trusted_tee.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index 62983d98a252..2ce66c199e1d 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/key-type.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_drv.h>
-- 
2.29.2

