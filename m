Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12E17313
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2019 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEHICi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 May 2019 04:02:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHICi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 May 2019 04:02:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so12431963wrp.2
        for <linux-integrity@vger.kernel.org>; Wed, 08 May 2019 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lW7WPvS0BGszPgf22bfJoZtgKKh2N28a/QSwohBZbr8=;
        b=lr+O5/B0mr3yFBj3gucyu+7aRM6kkirSd0HWcJrx1iOguC0CdFSymKqv56EcXwGw0/
         Pm9EmV2CSSH3Fnv37oBNPGCTTOoo8NDkzbP4efMm+tcvdiSx66GzbeW2sfnyINs1wX5I
         PkhEDqhfVjl9VRv6lddMh+POF/EhIcDx21mQbcNiKZ7k6z8IAUrbRR1zDG69wSipQVM+
         r3tyClDm6HP9BGRSwBRb5EcvnNCxAelsaCC4kb/+t9QXIlBmYabC7n3bdTKMcwDKoaQO
         LD74S7jaGvjBkYVmZyuB/LimjmQLPaUIa1u6cvgqVWRvMBOB3WL9aP1fFUZqz9h57djj
         8THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lW7WPvS0BGszPgf22bfJoZtgKKh2N28a/QSwohBZbr8=;
        b=TYFpywfybiRbOPGFX0vE/NaoyOUNFNNoID0U/hc/ogXUKotK5XNBBTeQt4Zdekiwg+
         ag3DKQ/GPHisIoOEpB6hmPMXcYaObHvWtkzJ/xUSilUZnZWtFdX8vgeXGgPCt4jZ/X6/
         nf2wMdnDCMOYRLRapCC/BWU6M5RvtCJS4IYSCrAtdU3tH7hf6yb16BaUeP/KLKbhfmFy
         OiKSbbtTdCFKvCznhiAp1c8Ums/8OMlCn4KUvcMvpA2Nak6jR+nKopR5KMrnyfvPMrYT
         Hn0PAn8Ts3ML3D2JRIz5TuGjbhCkfI2il2znk4E5LYu1dPz4aAqrqBx3p6oZZT13Ir4e
         eZjQ==
X-Gm-Message-State: APjAAAVEi4HDj1899jm9TWh9dVsMVe6CRcDdB1f0FnqFSjVXBoGUBZNQ
        QhuCFgdzJtzt3ajnHExkQ0iQYw==
X-Google-Smtp-Source: APXvYqxTM7m8BRMjwLTWwpw8EixNZYqSmNK8dFtS5CxerzYfaEU5rADDWyznr8Pqz9IiBpzJA2BlFQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr569812wrn.156.1557302556362;
        Wed, 08 May 2019 01:02:36 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j190sm2658814wmb.19.2019.05.08.01.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:02:34 -0700 (PDT)
Date:   Wed, 8 May 2019 09:02:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Message-ID: <20190508080232.vzdyvmrqx2apfvlf@holly.lan>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190507174020.GH1747@sasha-vm>
 <CAFA6WYPk5Bm11RfaC72g_C8rnMQEPyp-MhtopmDM3Of31v1Z_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPk5Bm11RfaC72g_C8rnMQEPyp-MhtopmDM3Of31v1Z_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 08, 2019 at 10:11:54AM +0530, Sumit Garg wrote:
> + TEE ML
> 
> Hi Sasha,
> 
> Firstly apologies for my comments here as I recently joined
> linux-integrity ML so I don't have other patches in my inbox. Also, it
> would be nice if you could cc TEE ML in future patches, so that people
> are aware of such interesting use-cases and may provide some feedback.

If this kind is desire exists then shouldn't it be captured in
MAINTAINERS?


Daniel.

> 
> On Tue, 7 May 2019 at 23:10, Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> > >From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> > >
> > >Changes since v2:
> > >
> > > - Drop the devicetree bindings patch (we don't add any new ones).
> > > - More code cleanups based on Jason Gunthorpe's review.
> > >
> > >Sasha Levin (2):
> > >  ftpm: firmware TPM running in TEE
> > >  ftpm: add documentation for ftpm driver
> >
> > Ping? Does anyone have any objections to this?
> >
> 
> From [PATCH v3 1/2] ftpm: firmware TPM running in TEE:
> 
> > +static const struct of_device_id of_ftpm_tee_ids[] = {
> > + { .compatible = "microsoft,ftpm" },
> > + { }
> > +};
> > +MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> > +
> > +static struct platform_driver ftpm_tee_driver = {
> > + .driver = {
> > + .name = DRIVER_NAME,
> > + .of_match_table = of_match_ptr(of_ftpm_tee_ids),
> > + },
> > + .probe = ftpm_tee_probe,
> > + .remove = ftpm_tee_remove,
> > +};
> > +
> > +module_platform_driver(ftpm_tee_driver);
> 
> Here this fTPM driver (seems to communicate with OP-TEE based TA)
> should register on TEE bus [1] rather than platform bus as its actual
> dependency is on TEE driver rather than using deferred probe to meet
> its dependency. Have a look at OP-TEE based RNG driver here [2].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0fc1db9d105915021260eb241661b8e96f5c0f1a
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fe8b1cc6a03c46b3061e808256d39dcebd0d0f0
> 
> -Sumit
> 
> > --
> > Thanks,
> > Sasha
