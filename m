Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A4503125
	for <lists+linux-integrity@lfdr.de>; Sat, 16 Apr 2022 01:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353086AbiDOVAf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Apr 2022 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352698AbiDOVAJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Apr 2022 17:00:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B335A8C
        for <linux-integrity@vger.kernel.org>; Fri, 15 Apr 2022 13:57:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1nfT0A-0002iH-W7; Fri, 15 Apr 2022 22:57:11 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nfT0A-003FIt-BG; Fri, 15 Apr 2022 22:57:08 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1nfT07-000C0M-J0; Fri, 15 Apr 2022 22:57:07 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v7 5/6] doc: trusted-encrypted: describe new CAAM trust source
Date:   Fri, 15 Apr 2022 22:56:46 +0200
Message-Id: <20220415205647.46056-6-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415205647.46056-1-a.fatoum@pengutronix.de>
References: <20220415205647.46056-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Update documentation for trusted key use with the Cryptographic
Acceleration and Assurance Module (CAAM), an IP on NXP SoCs.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v6 -> v7:
  - docs update split off as new Patch (Jarkko)
  - fixed typo in "Trusted Keys usage: CAAM" section

To: Jonathan Corbet <corbet@lwn.net>
To: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <jejb@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 .../security/keys/trusted-encrypted.rst       | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 2fe6fd1a2bbd..0bfb4c339748 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -35,6 +35,13 @@ safe.
          Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
          fuses and is accessible to TEE only.
 
+     (3) CAAM (Cryptographic Acceleration and Assurance Module: IP on NXP SoCs)
+
+         When High Assurance Boot (HAB) is enabled and the CAAM is in secure
+         mode, trust is rooted to the OTPMK, a never-disclosed 256-bit key
+         randomly generated and fused into each SoC at manufacturing time.
+         Otherwise, a common fixed test key is used instead.
+
   *  Execution isolation
 
      (1) TPM
@@ -46,6 +53,10 @@ safe.
          Customizable set of operations running in isolated execution
          environment verified via Secure/Trusted boot process.
 
+     (3) CAAM
+
+         Fixed set of operations running in isolated execution environment.
+
   * Optional binding to platform integrity state
 
      (1) TPM
@@ -63,6 +74,11 @@ safe.
          Relies on Secure/Trusted boot process for platform integrity. It can
          be extended with TEE based measured boot process.
 
+     (3) CAAM
+
+         Relies on the High Assurance Boot (HAB) mechanism of NXP SoCs
+         for platform integrity.
+
   *  Interfaces and APIs
 
      (1) TPM
@@ -74,10 +90,13 @@ safe.
          TEEs have well-documented, standardized client interface and APIs. For
          more details refer to ``Documentation/staging/tee.rst``.
 
+     (3) CAAM
+
+         Interface is specific to silicon vendor.
 
   *  Threat model
 
-     The strength and appropriateness of a particular TPM or TEE for a given
+     The strength and appropriateness of a particular trust source for a given
      purpose must be assessed when using them to protect security-relevant data.
 
 
@@ -104,6 +123,12 @@ selected trust source:
      from platform specific hardware RNG or a software based Fortuna CSPRNG
      which can be seeded via multiple entropy sources.
 
+  *  CAAM: Kernel RNG
+
+     The normal kernel random number generator is used. To seed it from the
+     CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the device
+     is probed.
+
 Users may override this by specifying ``trusted.rng=kernel`` on the kernel
 command-line to override the used RNG with the kernel's random number pool.
 
@@ -193,6 +218,19 @@ Usage::
 specific to TEE device implementation.  The key length for new keys is always
 in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
 
+Trusted Keys usage: CAAM
+------------------------
+
+Usage::
+
+    keyctl add trusted name "new keylen" ring
+    keyctl add trusted name "load hex_blob" ring
+    keyctl print keyid
+
+"keyctl print" returns an ASCII hex copy of the sealed key, which is in a
+CAAM-specific format.  The key length for new keys is always in bytes.
+Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
+
 Encrypted Keys usage
 --------------------
 
-- 
2.30.2

