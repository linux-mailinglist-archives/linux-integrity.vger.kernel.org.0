Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CBF519778
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbiEDGnV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 02:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiEDGnV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 02:43:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E613FBD
        for <linux-integrity@vger.kernel.org>; Tue,  3 May 2022 23:39:46 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nm8fZ-0007wQ-Ke; Wed, 04 May 2022 08:39:29 +0200
Message-ID: <ac014f19-0c08-c6cf-d639-f55268ba11c2@pengutronix.de>
Date:   Wed, 4 May 2022 08:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v8 3/6] crypto: caam - add in-kernel interface for blob
 generator
To:     Michael Walle <michael@walle.cc>
Cc:     davem@davemloft.net, david@sigma-star.at, dhowells@redhat.com,
        ebiggers@kernel.org, franck.lenormand@nxp.com,
        herbert@gondor.apana.org.au, horia.geanta@nxp.com,
        j.luebbe@pengutronix.de, jarkko@kernel.org, jejb@linux.ibm.com,
        jmorris@namei.org, kernel@pengutronix.de, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        matthias.schiffer@ew.tq-group.com, pankaj.gupta@nxp.com,
        richard@nod.at, serge@hallyn.com, sumit.garg@linaro.org,
        tharvey@gateworks.com, zohar@linux.ibm.com
References: <20220428140145.870527-4-a.fatoum@pengutronix.de>
 <20220503182454.2749454-1-michael@walle.cc>
Content-Language: en-US
In-Reply-To: <20220503182454.2749454-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Michael,

On 03.05.22 20:24, Michael Walle wrote:
>> Add functions to realize encrypting and decrypting into memory alongside
>> the CAAM driver.
>>
>> They will be used in a later commit as a source for the trusted key
>> seal/unseal mechanism.
> 
> Thanks for the work on this and I'm excited to try this. I'm currently
> playing with this and one thing I've noticed is that an export restricted
> CAAM isn't handled properly.

I didn't know there are still crypto export restrictions in place ;o

> That is, there are CAAM's which aren't fully featured. Normally, the
> caam driver will take care of it. For example, see commit f20311cc9c58
> ("crypto: caam - disable pkc for non-E SoCs"). For the trusted keys case,
> it would be nice if the kernel will not even probe (or similar).
>
> Right now, everything seems to work fine, but once I try to add a new key,
> I'll get the following errros:
> 
> # keyctl add trusted mykey "new 32" @u
> add_key: Invalid argument
> [   23.138714] caam_jr 8020000.jr: 20000b0f: CCB: desc idx 11: : Invalid CHA selected.
> [   23.138740] trusted_key: key_seal failed (-22)

Trusted key core will attempt TPM and TEE if enabled before trying CAAM unless
CAAM was explicitly requested. Silently failing in this case would not be
helpful to users. I think an info message (not error, as it'd be annoying to
see it every time booting a restricted SoC) is a good idea.
Thanks for the feedback.

> Again this is expected, because I run it on a non-E version. IMHO, it
> should be that the trusted keys shouldn't be enabled at all. Like it is
> for example if an unknown rng is given:
> 
>   trusted_key: Unsupported RNG. Supported: kernel, default

Other backends return -ENODEV and Trusted key core will ignore and try next
in list. Please give below patch a try. I tested it on normal unrestricted
i.MX6. If that's what you had in mind, I can incorporate it into v9.
If you have any Tested-by's or the like you want me to add, please tell. :)

Cheers,
Ahmad

------------------------------ 8< ------------------------------

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index d0b1a0015308..1d07e056a5dd 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
  */
 
+#define pr_fmt(fmt) "caam blob_gen: " fmt
+
 #include <linux/device.h>
 #include <soc/fsl/caam-blob.h>
 
@@ -147,11 +149,27 @@ EXPORT_SYMBOL(caam_process_blob);
 
 struct caam_blob_priv *caam_blob_gen_init(void)
 {
+	struct caam_drv_private *ctrlpriv;
 	struct device *jrdev;
 
+	/*
+	 * caam_blob_gen_init() may expectedly fail with -ENODEV, e.g. when
+	 * CAAM driver didn't probe or when SoC lacks BLOB support. An
+	 * error would be harsh in this case, so we stick to info level.
+	 */
+
 	jrdev = caam_jr_alloc();
-	if (IS_ERR(jrdev))
-		return ERR_CAST(jrdev);
+	if (IS_ERR(jrdev)) {
+		pr_info("no job ring available\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ctrlpriv = dev_get_drvdata(jrdev->parent);
+	if (!ctrlpriv->blob_present) {
+		dev_info(jrdev, "no hardware blob generation support\n");
+		caam_jr_free(jrdev);
+		return ERR_PTR(-ENODEV);
+	}
 
 	return container_of(jrdev, struct caam_blob_priv, jrdev);
 }
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ca0361b2dbb0..a0a622ca5dd4 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -660,6 +660,10 @@ static int caam_probe(struct platform_device *pdev)
 
 	caam_little_end = !(bool)(rd_reg32(&ctrl->perfmon.status) &
 				  (CSTA_PLEND | CSTA_ALT_PLEND));
+
+	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
+	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
+
 	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ms);
 	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
 		caam_ptr_sz = sizeof(u64);
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
index 3738625c0250..b829066f5063 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -414,6 +414,7 @@ struct caam_perfmon {
 #define CTPR_MS_PG_SZ_MASK	0x10
 #define CTPR_MS_PG_SZ_SHIFT	4
 	u32 comp_parms_ms;	/* CTPR - Compile Parameters Register	*/
+#define CTPR_LS_BLOB           BIT(1)
 	u32 comp_parms_ls;	/* CTPR - Compile Parameters Register	*/
 	u64 rsvd1[2];
 
diff --git a/include/soc/fsl/caam-blob.h b/include/soc/fsl/caam-blob.h
index ec57eec4f2d2..8e821bd56e54 100644
--- a/include/soc/fsl/caam-blob.h
+++ b/include/soc/fsl/caam-blob.h
@@ -38,8 +38,9 @@ struct caam_blob_info {
 
 /**
  * caam_blob_gen_init - initialize blob generation
- * Return: pointer to new caam_blob_priv instance on success
- * and error pointer otherwise
+ * Return: pointer to new &struct caam_blob_priv instance on success
+ * and ``ERR_PTR(-ENODEV)`` if CAAM has no hardware blobbing support
+ * or no job ring could be allocated.
  */
 struct caam_blob_priv *caam_blob_gen_init(void);
 
diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
index 46cb2484ec36..e3415c520c0a 100644
--- a/security/keys/trusted-keys/trusted_caam.c
+++ b/security/keys/trusted-keys/trusted_caam.c
@@ -55,10 +55,8 @@ static int trusted_caam_init(void)
 	int ret;
 
 	blobifier = caam_blob_gen_init();
-	if (IS_ERR(blobifier)) {
-		pr_err("Job Ring Device allocation for transform failed\n");
+	if (IS_ERR(blobifier))
 		return PTR_ERR(blobifier);
-	}
 
 	ret = register_key_type(&key_type_trusted);
 	if (ret)
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
