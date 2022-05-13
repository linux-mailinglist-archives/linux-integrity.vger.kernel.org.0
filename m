Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6D52654F
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiEMO5z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiEMO5y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 10:57:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26B17054
        for <linux-integrity@vger.kernel.org>; Fri, 13 May 2022 07:57:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1npWjS-0002Ml-Bx; Fri, 13 May 2022 16:57:30 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1npWjR-0026H6-Ln; Fri, 13 May 2022 16:57:28 +0200
Received: from afa by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1npWjP-008jCu-3j; Fri, 13 May 2022 16:57:27 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     kernel@pengutronix.de, Michael Walle <michael@walle.cc>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        John Ernberg <john.ernberg@actia.se>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v10 3/7] crypto: caam - determine whether CAAM supports blob encap/decap
Date:   Fri, 13 May 2022 16:57:01 +0200
Message-Id: <20220513145705.2080323-4-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Depending on SoC variant, a CAAM may be available, but with some futures
fused out. The LS1028A (non-E) SoC is one such SoC and while it
indicates BLOB support, BLOB operations will ultimately fail, because
there is no AES support. Add a new blob_present member to reflect
whether both BLOB support and the AES support it depends on is
available.

These will be used in a follow-up commit to allow blob driver
initialization to error out on SoCs without the necessary hardware
support instead of failing at runtime with a cryptic

  caam_jr 8020000.jr: 20000b0f: CCB: desc idx 11: : Invalid CHA selected.

Co-developed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Michael Walle <michael@walle.cc>
Tested-by: Michael Walle <michael@walle.cc> # on ls1028a (non-E and E)
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v9 -> v10:
  - added Michael's Tested-by
  - Check for AES support on CAAM era < 10, as LS1046A/LSA1012A have
    such CAAMs, which can be partially disabled.
v8 -> v9:
  - New patch

To: "Horia Geantă" <horia.geanta@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jan Luebbe <j.luebbe@pengutronix.de>
Cc: David Gstir <david@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>
Cc: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Michael Walle <michael@walle.cc>
Cc: John Ernberg <john.ernberg@actia.se>
Cc: linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c   | 17 +++++++++++++++--
 drivers/crypto/caam/intern.h |  1 +
 drivers/crypto/caam/regs.h   |  4 +++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ca0361b2dbb0..38c4d88a9d03 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -820,12 +820,25 @@ static int caam_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (ctrlpriv->era < 10)
+	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
+	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
+
+	/*
+	 * Some SoCs like the LS1028A (non-E) indicate CTPR_LS_BLOB support,
+	 * but fail when actually using it due to missing AES support, so
+	 * check both here.
+	 */
+	if (ctrlpriv->era < 10) {
 		rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
 			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
-	else
+		ctrlpriv->blob_present = ctrlpriv->blob_present &&
+			(rd_reg32(&ctrl->perfmon.cha_num_ls) & CHA_ID_LS_AES_MASK);
+	} else {
 		rng_vid = (rd_reg32(&ctrl->vreg.rng) & CHA_VER_VID_MASK) >>
 			   CHA_VER_VID_SHIFT;
+		ctrlpriv->blob_present = ctrlpriv->blob_present &&
+			(rd_reg32(&ctrl->vreg.aesa) & CHA_VER_MISC_AES_NUM_MASK);
+	}
 
 	/*
 	 * If SEC has RNG version >= 4 and RNG state handle has not been
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 7d45b21bd55a..e92210e2ab76 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -92,6 +92,7 @@ struct caam_drv_private {
 	 */
 	u8 total_jobrs;		/* Total Job Rings in device */
 	u8 qi_present;		/* Nonzero if QI present in device */
+	u8 blob_present;	/* Nonzero if BLOB support present in device */
 	u8 mc_en;		/* Nonzero if MC f/w is active */
 	int secvio_irq;		/* Security violation interrupt number */
 	int virt_en;		/* Virtualization enabled in CAAM */
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 3738625c0250..66d6dad841bb 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -320,7 +320,8 @@ struct version_regs {
 #define CHA_VER_VID_MASK	(0xffull << CHA_VER_VID_SHIFT)
 
 /* CHA Miscellaneous Information - AESA_MISC specific */
-#define CHA_VER_MISC_AES_GCM	BIT(1 + CHA_VER_MISC_SHIFT)
+#define CHA_VER_MISC_AES_NUM_MASK	GENMASK(7, 0)
+#define CHA_VER_MISC_AES_GCM		BIT(1 + CHA_VER_MISC_SHIFT)
 
 /* CHA Miscellaneous Information - PKHA_MISC specific */
 #define CHA_VER_MISC_PKHA_NO_CRYPT	BIT(7 + CHA_VER_MISC_SHIFT)
@@ -414,6 +415,7 @@ struct caam_perfmon {
 #define CTPR_MS_PG_SZ_MASK	0x10
 #define CTPR_MS_PG_SZ_SHIFT	4
 	u32 comp_parms_ms;	/* CTPR - Compile Parameters Register	*/
+#define CTPR_LS_BLOB           BIT(1)
 	u32 comp_parms_ls;	/* CTPR - Compile Parameters Register	*/
 	u64 rsvd1[2];
 
-- 
2.30.2

