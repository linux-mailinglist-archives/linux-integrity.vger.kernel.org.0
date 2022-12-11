Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E9B649610
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Dec 2022 21:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiLKUFO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Dec 2022 15:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLKUFM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Dec 2022 15:05:12 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E312BC1B;
        Sun, 11 Dec 2022 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670789110;
        bh=pv73TiLGplzNdhkAXOVPGimvtQc2GuttymY4jT6xk8Y=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=lIZyJU9muuYVQ1W2W70nGe6YycrR2UoaByjEX2lC6xDAmew0wHKynxo1q4DaNKNXy
         QeLzuVwE+6ILw4hdNBwiTbvd7rIBGIbhNRCBBcwWjZwmxhHTmEExMGSFXgjUTu1w8l
         gax9O5bJY7shNLWklU+OeLeWa0seLo/j7QQsRnls=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DCE631281B54;
        Sun, 11 Dec 2022 15:05:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xgVhxvSzijXx; Sun, 11 Dec 2022 15:05:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1670789110;
        bh=pv73TiLGplzNdhkAXOVPGimvtQc2GuttymY4jT6xk8Y=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=lIZyJU9muuYVQ1W2W70nGe6YycrR2UoaByjEX2lC6xDAmew0wHKynxo1q4DaNKNXy
         QeLzuVwE+6ILw4hdNBwiTbvd7rIBGIbhNRCBBcwWjZwmxhHTmEExMGSFXgjUTu1w8l
         gax9O5bJY7shNLWklU+OeLeWa0seLo/j7QQsRnls=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EC88A1281A47;
        Sun, 11 Dec 2022 15:05:09 -0500 (EST)
Message-ID: <2df35484a032188223ea9001a08bf39f6545f768.camel@HansenPartnership.com>
Subject: Re: [PATCH 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        linux-integrity@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Date:   Sun, 11 Dec 2022 15:05:07 -0500
In-Reply-To: <202212101224.wxWpB9ou-lkp@intel.com>
References: <202212101224.wxWpB9ou-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2022-12-10 at 08:17 +0300, Dan Carpenter wrote:
> Hi James,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:   
> https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/add-integrity-and-security-to-TPM2-transactions/20221210-001335
> patch link:   
> https://lore.kernel.org/r/20221209160611.30207-7-James.Bottomley%40HansenPartnership.com
> patch subject: [PATCH 06/11] tpm: Add full HMAC and encrypt/decrypt
> session handling code
> config: x86_64-randconfig-m001
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> 
> New smatch warnings:
> drivers/char/tpm/tpm2-sessions.c:294 tpm_buf_append_salt() warn:
> possible memory leak of 'secret'
> drivers/char/tpm/tpm2-sessions.c:890 tpm2_start_auth_session() warn:
> possible memory leak of 'auth'
> 
> Old smatch warnings:
> drivers/char/tpm/tpm2-sessions.c:331 tpm_buf_append_salt() warn:
> possible memory leak of 'secret'

Hm, yes, I thought I'd fixed it up, but apparently not.

This differential should fix all the leaks.  I'll add it to the next
revision.  I also found a non standard name algorithm problem with
session handle appends, so I need to fix that as well.

Sorry about forgetting to fix this,

James


---

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 89dd9494bf9a..914c49abab03 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -291,7 +291,7 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	kpp = crypto_alloc_kpp("ecdh-nist-p256", CRYPTO_ALG_INTERNAL, 0);
 	if (IS_ERR(kpp)) {
 		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
-		return;
+		goto out_free;
 	}
 
 	buf_len = crypto_ecdh_key_len(&p);
@@ -329,6 +329,8 @@ static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
 	KDFe(secret, "SECRET", x, chip->ec_point_x, auth->salt);
  out:
 	crypto_free_kpp(kpp);
+ out_free:
+	kfree(secret);
 }
 
 /**
@@ -887,7 +889,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip, struct tpm2_auth **authp)
 	rc = tpm2_load_context(chip, chip->tpmkeycontext, &offset,
 			       &nullkey);
 	if (rc)
-		return rc;
+		goto out;
 
 	auth->chip = chip;
 	auth->session = TPM_HEADER_SIZE;

