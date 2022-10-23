Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6CA609147
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 07:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJWF0l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 01:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWF0k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 01:26:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6296EF2D;
        Sat, 22 Oct 2022 22:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02AAF60B14;
        Sun, 23 Oct 2022 05:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A9EC433D6;
        Sun, 23 Oct 2022 05:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666502799;
        bh=YyQMDEejPGZYx8p4Xq1tA0q8Sq/LtL9ohhkKWCtCGZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niYHUErcTXTU8VApGnc69TE3T/wqJF75rT8BNf92v0LWoFNQ5EOcTBD1PoOJQs0t9
         LXZgiKGYMUy9Xuime5eAhWoqGvGVs6oFQNLrtvgRtKPd9D9TpqvSt0hDm9oZF8yKa+
         Bhehr4cYfJQXF6XumoagnylXYl1s9egNTA5vYAkA0EK1nweO9Q+tLQCIhrvNX2P+VY
         yINEMEoI1wLbqHhXHddUy5lqeOTaOn1VOV1G698hoEafKNP+eAaRZ7i6rtNkfeddBB
         OppzLJ5uthtW4OBuIOSCMNsF6d0OesaWMcNpQ3pDSwhPH0YTb06dHeOkidJZSC1t/5
         kcGQ9zTA7xHsw==
Date:   Sun, 23 Oct 2022 08:26:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Message-ID: <Y1TQiIw0m+8BSzMs@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
 <20221018062508.GB25237@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018062508.GB25237@wunner.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 18, 2022 at 08:25:08AM +0200, Lukas Wunner wrote:
> On Tue, Oct 18, 2022 at 01:57:29AM +0200, Lino Sanfilippo wrote:
> > Implement a usage counter for the (default) locality used by the TPM TIS
> > driver:
> > Request the locality from the TPM if it has not been claimed yet, otherwise
> > only increment the counter. Also release the locality if the counter is 0
> > otherwise only decrement the counter. Ensure thread-safety by protecting
> > the counter with a mutex.
> > 
> > This allows to request and release the locality from a thread and the
> > interrupt handler at the same time without the danger to interfere with
> > each other.
> [...]
> > +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
> >  {
> >  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >  
> > -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> > +	mutex_lock(&priv->locality_count_mutex);
> > +	priv->locality_count--;
> > +	if (priv->locality_count == 0)
> > +		tpm_tis_release_locality_locked(priv, l);
> > +	mutex_unlock(&priv->locality_count_mutex);
> >  
> >  	return 0;
> >  }
> 
> Hm, any reason not to use struct kref for the locality counter?
> Provides correct memory ordering (no mutex needed) and allows for
> calling a release function too upon reaching 0.

I proposed for last version kref. I have no idea why this is still
using mutex. And now I apparently have proposed rcu for the whole
struct (forgot what I had put my feedback for earlier version).

This keeps being confusing patch as the commit message does not
really go to the bottom line why mutex is really the best possible
choice here.

BR, Jarkko
