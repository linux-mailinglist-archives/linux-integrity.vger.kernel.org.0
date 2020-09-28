Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E899427B816
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 01:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgI1X2z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 19:28:55 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37090 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgI1X2o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 55FAD8EE17F;
        Mon, 28 Sep 2020 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601331101;
        bh=DpX83A3nI7twE7mk6u87ScMheN7K/uTDeVJIgFTISRc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L8+r3vmNtMT36r/ZvW34d88wcvEkqjhyXNxhvLFI/V9Z2NyqwLf3O2IH3QeFo3EQ+
         0iUGnnSa+zL6Zj+XQGpKaevJTDXKvsWDgDQbMO0uz5KH5GHavnMw7jAYrBgDfuChlG
         1BwLRA4cl5bGGpW/z2eh9gNC+1okVEo0o+4iXBGI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6W5FWwnSupRN; Mon, 28 Sep 2020 15:11:41 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 36BC78EE0F5;
        Mon, 28 Sep 2020 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601331101;
        bh=DpX83A3nI7twE7mk6u87ScMheN7K/uTDeVJIgFTISRc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L8+r3vmNtMT36r/ZvW34d88wcvEkqjhyXNxhvLFI/V9Z2NyqwLf3O2IH3QeFo3EQ+
         0iUGnnSa+zL6Zj+XQGpKaevJTDXKvsWDgDQbMO0uz5KH5GHavnMw7jAYrBgDfuChlG
         1BwLRA4cl5bGGpW/z2eh9gNC+1okVEo0o+4iXBGI=
Message-ID: <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Mon, 28 Sep 2020 15:11:39 -0700
In-Reply-To: <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
         <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
         <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
         <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
         <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
         <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
         <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
[...]
> > However, there is another possibility: it's something to do with
> > the byte read; I notice you don't require the same slowdown for the
> > burst count read, which actually reads the status register and
> > burst count as a read32.  If that really is the case, for the atmel
> > would substituting a read32 and just throwing the upper bytes away
> > in tpm_tis_status() allow us to keep the current timings?  I can
> > actually try doing this and see if it fixes my nuvoton.
> 
> If would be helpful if you can find the solution without reducing
> performance. I think it is a separate problem to address though.
> Maybe not worth to mix them in the same fix.

Well, if it works, no other fix is needed.

This is what I'm currently trying out on my nuvoton with the timings
reverted to being those in the vanilla kernel.  So far it hasn't
crashed, but I haven't run it for long enough to be sure yet.

James

---

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 6b884badabe7..c4dbac8edc9b 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -233,9 +233,9 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc;
-	u8 status;
+	u32 status;
 
-	rc = tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
+	rc = tpm_tis_read32(priv, TPM_STS(priv->locality), &status);
 	if (rc < 0)
 		return 0;
 

