Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF2524CE7
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 14:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353780AbiELMdC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 08:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353778AbiELMdB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 08:33:01 -0400
X-Greylist: delayed 58837 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 05:32:59 PDT
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4365BD16;
        Thu, 12 May 2022 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652358778;
        bh=IySozlMZXy/1QNYSgDSx5HLq+jIRHXYcbbpihCThx6s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rKE+Lp6Uxyi3yJmORKUqLDYGEKVYhKiNso8at95lUIeg8azuxByuZWwz/T6Wg5Kuy
         ulXO3j5EkYgL3XYf8vg6jNAMGdjOguNYLK4dQq22V+vqixY3K9QDdLkxsY+mXDMvyX
         orkDtOPb1bKA0hUB68gyjIfcxoQHQ/HYaQElawao=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7646A12869F3;
        Thu, 12 May 2022 08:32:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3XK07T6rk3Bg; Thu, 12 May 2022 08:32:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652358777;
        bh=IySozlMZXy/1QNYSgDSx5HLq+jIRHXYcbbpihCThx6s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sfLrRlb76wM8CIFj4r6KmR/cimvHsb3Tz6HoqnEPAmMyABOODn6xzBX9Atdm256jX
         MHx9wT4qBaNvyW6YeLu8vjarX5+rp107Vpcu61EQhJPxnGMzm+dKypq0VcP2XA3q/S
         QJ+ayWjJzwcf5XKtGZUVJlQV2GP11l3VAJ8k2v4E=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1DED3128195F;
        Thu, 12 May 2022 08:32:57 -0400 (EDT)
Message-ID: <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Nayna <nayna@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Date:   Thu, 12 May 2022 08:32:55 -0400
In-Reply-To: <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
References: <20220510112902.23213-1-johannes.holland@infineon.com>
         <YnvTSqRgYkWu0qgp@kernel.org>
         <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-05-12 at 08:21 -0400, Mimi Zohar wrote:
> On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
> > On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
> > > To comply with protocol requirements, minimum polling times must
> > > often
> > > be adhered to. Therefore, a macro like tpm_msleep() should sleep
> > > at
> > > least the given amount of time (not up to the given period). Have
> > > tpm_msleep() sleep at least the given number of milliseconds.
> > > 
> > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > ---
> > >  drivers/char/tpm/tpm.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 2163c6ee0d36..0971b55fffe3 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
> > >  
> > >  static inline void tpm_msleep(unsigned int delay_msec)
> > >  {
> > > -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> > > -		     delay_msec * 1000);
> > > +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
> > > +		     + TPM_TIMEOUT_RANGE_US);
> > >  };
> > >  
> > >  int tpm_chip_start(struct tpm_chip *chip);
> > > -- 
> > > 2.34.1
> > > 
> > 
> > For this I would really like to hear a 2nd opinion from Nayna and
> > Mimi.
> 
> This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value
> as max delay").    Are you experiencing TPM issues that require it?

I am:

https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/

I'm about 24h into a soak test of the patch with no TPM failure so far.
I think it probably needs to run another 24h just to be sure, but it
does seem the theory is sound (my TPM gets annoyed by being poked too
soon) so reverting 5ef924d9e2e8 looks to be the correct action.  The
only other ways I've found to fix this are either revert the
usleep_range patch altogether or increase the timings:

https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@HansenPartnership.com/

Which obviously pushes the min past whatever issue my TPM is having
even with 5ef924d9e2e8 applied.

Given that even the commit message for 5ef924d9e2e8 admits it only
shaves about 12% off the TPM response time, that would appear to be an
optimization too far if it's going to cause some TPMs to fail.

James


