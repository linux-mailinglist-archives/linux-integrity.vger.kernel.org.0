Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F306F464B1A
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 10:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhLAKC4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 05:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348380AbhLAKCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 05:02:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F37C061574
        for <linux-integrity@vger.kernel.org>; Wed,  1 Dec 2021 01:59:29 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1msMOL-0000TW-VX; Wed, 01 Dec 2021 10:59:09 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1msMOI-00Ccql-PN; Wed, 01 Dec 2021 10:59:06 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     andreas@rammhold.de, James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v4] KEYS: trusted: Fix trusted key backends when building as module
Date:   Wed,  1 Dec 2021 10:59:00 +0100
Message-Id: <20211201095900.3009225-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andreas Rammhold <andreas@rammhold.de>

Before this commit the kernel could end up with no trusted key sources
even though both of the currently supported backends (TPM and TEE) were
compiled as modules. This manifested in the trusted key type not being
registered at all.

When checking if a CONFIG_… preprocessor variable is defined we only
test for the builtin (=y) case and not the module (=m) case. By using
the IS_REACHABLE() macro we do test for both cases.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Timeline so far:
  - 2021-05-09: Regression hits mainline with v5.13-rc1
  - 2021-07-16: Issue reported. v1 of this patch sent out
  - 2021-07-21: Ahmad sends out alternative patch to fix issue
  - 2021-07-27: Jarkko (Maintainer) NACKs Ahmad's patch because of scope
  - 2021-07-29: v2 with fixes sent out
  - 2021-07-29: Jarkko gives his Reviewed-by and requests one more v3
  - 2021-07-31: v3 sent out
  - 2021-09-13: Pinged, no maintainer feedback
  - 2021-09-27: Pinged, Mimi (Maintainer) comments due to to misunderstanding.
                Question about why this is not picked up ignored
  - 2021-10-11: Pinged, no maintainer feedback
  - 2021-11-01: Resend with timeline, but dropped R-b's, no maintainer feedback
  - 2021-12-01: This resend with timeline and tags

v3 -> v4:
  * Add my Tested-by
  * Add Reviewed-by's missed during v3 RESEND
  * Update timeline and resent in agreement with Andreas
v3 -> v3 RESEND:
  * Add timeline
v2 -> v3:
  * Fixed patch formatting
v1 -> v2:
  * Fixed commit message
  * Switched from IS_DEFINED() to IS_REACHABLE()
---
 security/keys/trusted-keys/trusted_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index d5c891d8d353..5b35f1b87644 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
-#if defined(CONFIG_TCG_TPM)
+#if IS_REACHABLE(CONFIG_TCG_TPM)
 	{ "tpm", &trusted_key_tpm_ops },
 #endif
-#if defined(CONFIG_TEE)
+#if IS_REACHABLE(CONFIG_TEE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
 };
-- 
2.30.2

