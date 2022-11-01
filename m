Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AEA61429F
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKABHE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKABHD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7015816;
        Mon, 31 Oct 2022 18:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9609C61502;
        Tue,  1 Nov 2022 01:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887B9C433D7;
        Tue,  1 Nov 2022 01:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667264822;
        bh=miL2Sw4WCgEQl7HTxKCpsgKgGrQ8eRDYEO4TfVAtTSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjqU8zBw7XRoIYyb5ZXHFXGlVANuqE3SMlH292X9xWOBpvhDBnjt4y0K0iVZr4y2N
         YO376lZTH5COwBa8vAXpsebNU8eTP7A3E0lyVzPPYJ3iky413EvAIx39e4a0CwKfqV
         h/8JIe1S4EFM1TX7ZEJMRHqKEQDxssPS/7Q1rxHkMbDgDdSaQXlNlasbtcykS09Ose
         kaHAd9E7CiQQebXDL76g/iQyFTZoLns9xr8zrhmFQrTi/P5bFNh6vUcBjgT3AOctJB
         XvVwU5Awy8KgYVO5yny5ciuy4IrxUuKuRBGZ8ytmRQMQ1+HTDXc2mWWoQSNqvWrSwp
         fFDv8B+c29gFQ==
Date:   Tue, 1 Nov 2022 03:06:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Lukas Wunner <lukas@wunner.de>, peterhuewe@gmx.de, jgg@ziepe.ca,
        stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Message-ID: <Y2BxMUrXbds3MQ2X@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
 <20221018062508.GB25237@wunner.de>
 <Y1TQiIw0m+8BSzMs@kernel.org>
 <0094438d-cf8e-da81-c969-119f90baf3db@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0094438d-cf8e-da81-c969-119f90baf3db@gmx.de>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 25, 2022 at 02:25:39AM +0200, Lino Sanfilippo wrote:
> 
> 
> On 23.10.22 07:26, Jarkko Sakkinen wrote:
> > On Tue, Oct 18, 2022 at 08:25:08AM +0200, Lukas Wunner wrote:
> >> On Tue, Oct 18, 2022 at 01:57:29AM +0200, Lino Sanfilippo wrote:
> >>> Implement a usage counter for the (default) locality used by the TPM TIS
> >>> driver:
> >>> Request the locality from the TPM if it has not been claimed yet, otherwise
> >>> only increment the counter. Also release the locality if the counter is 0
> >>> otherwise only decrement the counter. Ensure thread-safety by protecting
> >>> the counter with a mutex.
> >>>
> >>> This allows to request and release the locality from a thread and the
> >>> interrupt handler at the same time without the danger to interfere with
> >>> each other.
> >> [...]
> >>> +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
> >>>  {
> >>>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >>>
> >>> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> >>> +	mutex_lock(&priv->locality_count_mutex);
> >>> +	priv->locality_count--;
> >>> +	if (priv->locality_count == 0)
> >>> +		tpm_tis_release_locality_locked(priv, l);
> >>> +	mutex_unlock(&priv->locality_count_mutex);
> >>>
> >>>  	return 0;
> >>>  }
> >>
> >> Hm, any reason not to use struct kref for the locality counter?
> >> Provides correct memory ordering (no mutex needed) and allows for
> >> calling a release function too upon reaching 0.
> >
> > I proposed for last version kref. I have no idea why this is still
> > using mutex. And now I apparently have proposed rcu for the whole
> > struct (forgot what I had put my feedback for earlier version).
> >
> > This keeps being confusing patch as the commit message does not
> > really go to the bottom line why mutex is really the best possible
> > choice here.
> >
> 
> 
> I actually tried to implement this via kref but then came to the
> conclusion it is rather not a good choice for our case. Please
> see my response to your former request to implement this via kref:
> 
> https://lore.kernel.org/all/09eefdab-f677-864a-99f7-869d7a8744c2@gmx.de/

OK, my bad I missed this, sorry.

BR, Jarkko
