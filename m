Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DDC2941CF
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Oct 2020 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408896AbgJTSCt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408895AbgJTSCs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 14:02:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B19C0613CE
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2020 11:02:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so3303669wrs.5
        for <linux-integrity@vger.kernel.org>; Tue, 20 Oct 2020 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=3C43ehene0sz3wj0W6VYck8XLVUCMtd4AQSAoxmbLuA=;
        b=Q92lI3jOIPh6gwlYPTUULybXuQr0NKVDgfSaLMv1mwiJMhOrXhWe7gbJ+odadb4wvN
         2rd3uHY3vk7AD8NKvBanG5SA8LRgJHsGkIP2pDhsDqWqfjVlJlsTKkVe+NYyhN1ZKp5x
         gESYZfXOdrJ6doXjXvWXbPlUn9qpbYQanEg5cSFmudqhmgIri24EVVGSAWuX7vdIXkfQ
         aRSAlgFuYa4+ietk/KaCD88134GHQSEPyawGBmxrt5meypQ4sne1Ax0oq71wa7q6tNhp
         MwaFjTf/QJ6t5HjSrQpQf3twZm5b3BDACviUKsulwZBD4zIHTBmtv3CSrTiBWst4JR03
         WBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=3C43ehene0sz3wj0W6VYck8XLVUCMtd4AQSAoxmbLuA=;
        b=dNuj8ogm2STZwSvI/zaJUj4UR9GwrS0Ib8KFW4fkckCjpfERPxGR2BctrYnvUzaX7g
         g5XkVghClgZjDTIfOvPqWxuOIBgdWimsB8FNimwuURL/gaYEVmG4/swNfRfOXTHYfS+L
         A0kRzL/Qe3Fal0kth4Hr+HrbPElujwc25E5XCIfM9z0vTSz4nH5nlGQnsTD45rKMoKkC
         XL7CA9ib3CE8QE++EccdepzoLt4bZ8VC7HKS50JdCXM7qmKHqPG5vUC84LHyCTzOnTB7
         vTeGblgcMDaBSOQxqLDf3c/gEtXxiDDg7cPYSHW6oIcUW1zN+ONyP75NSENIFr/rYf1n
         kysg==
X-Gm-Message-State: AOAM531giyjNSPRWtg9HMwpEPmnYnbfG3GaPWugmV2+O3+CEm047DgNc
        Wt2XgxPzCZ7AFvce3FG0KxA=
X-Google-Smtp-Source: ABdhPJxc0G93I08VXBdtJfsQuOjes3t5BwQxwlQJV8EOgXpk2wv21udJYYllHsY7KSt4/eLQ8Crx+g==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr5011712wrx.10.1603216964827;
        Tue, 20 Oct 2020 11:02:44 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id d129sm2769353wmd.5.2020.10.20.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:02:40 -0700 (PDT)
Date:   Tue, 20 Oct 2020 20:02:31 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA
 not enabled
Message-ID: <20201020180231.GA14580@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
 <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Dmitry,

> [Cc'ing Dmitry Eremin-Solenikov]

> Hi Petr,

> On Mon, 2020-10-19 at 22:08 +0200, Petr Vorel wrote:
> > This is required, because when TPM HW available (i.e. -c /dev/tpm0),
> > evmctl ima_boot_aggregate returns sha1:xxxx.

> > skip requires to move cleanup().

> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

> Nice.
> > ---
> > Hi Mimi,

> > this Fixes problems on current Debian, which has still disabled CONFIG_IMA
> > (FYI [1]). I was not able to figure out how to get it working with
> > sample-* files, but maybe there is a way.

> > Although it sound strange, people may want to build and check evmctl
> > even on a system with disabled CONFIG_IMA (both Debian and Ubuntu have
> > outdated ima-evm-utils (1.1)).

> Oops, I need to keep Dmitry in the loop better.  I'm hoping to release
> v1.3 shortly.
Thanks!
@Dmitry do you wish to be Cc: before release or any other time?

> > Kind regards,
> > Petr

> > [1] https://bugs.debian.org/972459 linux: Reenable CONFIG_IMA

> I wasn't aware that because of lockdown, IMA was disabled.  Thank you
> for reporting and updating the IMA w/lockdown status.
Feel free to comment it, please. It'd be nice to have IMA in Debian (not sure
about Ubuntu status).

@Dmitry: do you plan to update Debian package? (you're the listed maintainer,
although the package was signed by Wartan Hachaturow).

> Mimi

Kind regards,
Petr
