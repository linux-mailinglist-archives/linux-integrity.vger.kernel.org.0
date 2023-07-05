Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDC37489CE
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jul 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGERF2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jul 2023 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjGERF1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jul 2023 13:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055E11725
        for <linux-integrity@vger.kernel.org>; Wed,  5 Jul 2023 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688576679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lNtqVtq3CW0Wp8eBEgwV9smImqmNbt9TBHf6lNmzdg4=;
        b=V97G+yI6K2RY98E7KkISxqbOJovFLTTYCMdO0t5Bf4rFfDkUabLR1+stKQoImUxQD47xa4
        EeDUzQZn8pnQR5vzBQ8oaOtag4w6jRlz9w+eKuTNdow0xRqKg7Df7bnv1BupvFwx1FmtbU
        ZdEjGq1kVkqgAwVznXMuJpML067qzKQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-TzQr6Dy-MbmuB1eNUjyQzA-1; Wed, 05 Jul 2023 13:04:38 -0400
X-MC-Unique: TzQr6Dy-MbmuB1eNUjyQzA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7659cb9c3b3so594931885a.1
        for <linux-integrity@vger.kernel.org>; Wed, 05 Jul 2023 10:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688576677; x=1691168677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNtqVtq3CW0Wp8eBEgwV9smImqmNbt9TBHf6lNmzdg4=;
        b=Zw36x5732evx7mlzpdnFVMSiASxk3rZQtn1TVbLLPR8SIBLyrtTtJI7UvAqzHky6ag
         rpH5NxQ5OKnOixLuauJXlyRHWhKO1H03YLyCC/yW9OETXelb27NmW8+GbCua67Q208wM
         La++05mPB0o3dYLNSFp3YR1rWUu5/KQtEk4C3qn3kxr9DIfcpZ8CjPhD/XOiv9ZkcIY/
         PwNGRR9JfYTW1SaOXTIQ1UJyOvRniEgNijVLU/tXHhR9vHdL9HUIXB2plINXf5/CFDWT
         4t2ethM4KQK4+uJkOqOe+8yJO2lmHbApD2BVrS2+PDo+4h2iFZ50l9Gy5SL5anSvnxwh
         3CoA==
X-Gm-Message-State: ABy/qLZu0T/95EhvcNoWaaH9b6Sa14erGP6gkCD3aoKUxXPhqioOAjTv
        9gv/jrXCU15zfMg0s5SDSw5JcDJgV7M+lB8qUxDwl8irkhjLq9bLVXuVs28T/Vly0kYJzqr2Apm
        g5WSiA+hIoEszLbAvoHYPeGbaqgZz
X-Received: by 2002:a05:620a:25c6:b0:765:6782:cafd with SMTP id y6-20020a05620a25c600b007656782cafdmr16465215qko.69.1688576677603;
        Wed, 05 Jul 2023 10:04:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESx6o6W0ACxK5vH67XXdE29it+PxjmfDkN1gnu9OVyeJo4tWEB/sW3eukyUvUa5QAmnQTT/A==
X-Received: by 2002:a05:620a:25c6:b0:765:6782:cafd with SMTP id y6-20020a05620a25c600b007656782cafdmr16465194qko.69.1688576677313;
        Wed, 05 Jul 2023 10:04:37 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a16a100b007579ea33cdesm6622312qkj.62.2023.07.05.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:04:36 -0700 (PDT)
Date:   Wed, 5 Jul 2023 10:04:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tpm: return false from tpm_amd_is_rng_defective on
 non-x86 platforms
Message-ID: <mbbb2mdlmkhnkgmw37glklmllzelolmdvmdgz5pziidromxsh5@gkflot73u6gd>
References: <20230629204147.1852823-1-jsnitsel@redhat.com>
 <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 30, 2023 at 01:07:00PM +0300, Jarkko Sakkinen wrote:
> On Thu Jun 29, 2023 at 11:41 PM EEST, Jerry Snitselaar wrote:
> > tpm_amd_is_rng_defective is for dealing with an issue related to the
> > AMD firmware TPM, so on non-x86 architectures just have it inline and
> > return false.
> >
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: stable@vger.kernel.org
> > Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
> > Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> > Closes: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
> > Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index cd48033b804a..cf5499e51999 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -518,6 +518,7 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
> >   * 6.x.y.z series: 6.0.18.6 +
> >   * 3.x.y.z series: 3.57.y.5 +
> >   */
> > +#ifdef CONFIG_X86
> >  static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> >  {
> >  	u32 val1, val2;
> > @@ -566,6 +567,12 @@ static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> >  
> >  	return true;
> >  }
> > +#else
> > +static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_X86 */
> >  
> >  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> >  {
> > -- 
> > 2.38.1
> 
> Sanity check, this was the right patch, right?
> 
> I'll apply it.
> 
> BR, Jarkko

Sorry, I've been dealing with a family health issue the past week. It wasn't clear
to me why chip->ops was null when I first took a look, but I think I understand
now looking at it again this morning. The stack trace shows it in the device_shutdown() path:

    [ 34.381674] NIP [c0000000009db1e4] tpm_amd_is_rng_defective+0x74/0x240
    [ 34.381681] LR [c0000000009db928] tpm_chip_unregister+0x138/0x160
    [ 34.381685] Call Trace:
    [ 34.381686] [c00000009742faa0] [c0000000009db928] tpm_chip_unregister+0x138/0x160
    [ 34.381690] [c00000009742fae0] [c0000000009eab94] tpm_ibmvtpm_remove+0x34/0x130
    [ 34.381695] [c00000009742fb50] [c000000000115738] vio_bus_remove+0x58/0xd0
    [ 34.381701] [c00000009742fb90] [c000000000a01ecc] device_shutdown+0x21c/0x39c
    [ 34.381705] [c00000009742fc20] [c0000000001a2684] kernel_restart_prepare+0x54/0x70
    [ 34.381710] [c00000009742fc40] [c000000000292c48] kernel_kexec+0xa8/0x100
    [ 34.381714] [c00000009742fcb0] [c0000000001a2cd4] __do_sys_reboot+0x214/0x2c0
    [ 34.381718] [c00000009742fe10] [c000000000034adc] system_call_exception+0x13c/0x340
    [ 34.381723] [c00000009742fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

So I think what happened is:

device_shutdown -> dev->class->shutdown_pre (tpm_class_shutdown) // clears chip->ops
                -> dev->bus->shutdown (vio_bus_shutdown) -> vio_bus_remove -> viodrv->remove (tpm_ibmvtpm_remove) -> tpm_chip_unregister -> tpm_amd_is_rng_defective -> oops!


I guess anything that gets called in the tpm_chip_unregister path
should be doing a check of chip->ops prior to using it. So I think
Mario's patch would still be a good thing to have.

Regards,
Jerry

