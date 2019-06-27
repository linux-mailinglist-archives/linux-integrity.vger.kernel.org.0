Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC758378
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0NaJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jun 2019 09:30:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0NaJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jun 2019 09:30:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so5739952wme.4
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbYrjwHXJqiMsGuqj1zgA9NwpJhH7d+2wc890aAsl00=;
        b=nO5Os47pOlhih/DxECOGkBUdP0PXcYx6vg/vZU54lwJU59dZEDWjWj/wt2Jml1BuB9
         +xoPB6fGqbtnIHnJtvRZyVgd4zenYWr3e8Si3Ic+IrPYLYzQrMJEwSlOL1zXuKo+dl6Y
         A7/W+p6pWMaRN1+FHQmm03oVZynY5OeAHaaEknzvBFTqzd10MMmMwxGYBmsBHZSBMJxP
         uC0qkNV3fw3KEaVto2Enxm21RlgETtiF4a8RsE/tSKcGKHI6e5dRpibzwUMkXyCuSQSR
         CBYSUjYi4LFw1C4MmffB6/4XhUEpAASpe6Y2IfjYtKMG9z2xswedDy9AOgoLYxs/CBtW
         uMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbYrjwHXJqiMsGuqj1zgA9NwpJhH7d+2wc890aAsl00=;
        b=AqbTgRwwTB/WhwINTsgzGerBKx93q3FJ4DZpJSOMqeWqh9jFdGyVA/nQGBYTkyXDK3
         BYrqJk5EtyMCE7XrOoElYt6cqKAOxDz7vr/GpS2Ao8fEOsvA/GIfW19BxsiEMzu2B0wC
         TBNfpN4ZcrFUWWXwnM6S4ljaxouFXzP7dJgdtK41sMimExR+0jJ0o7QrRb86HIa/roIu
         gYfobbEl3LFb53cwYSvSoekkOQaiLXAgH6dt7k2r6Vb0/WkmSbdRmO0joUW6z8TDXAWt
         OS5/1s77vCRFBVRGNSbHdHKPOKEW8rP2I0sutltjlCcf+lnoCf+AAWke2gA8mvOTnUu+
         LpQw==
X-Gm-Message-State: APjAAAV4dQDlbhXDIIBNd1sE0k3xr2lCQmsztwEbo0nG6vCw2468+gEr
        +gGEKXd4fHcG03tR8vongSDNmg==
X-Google-Smtp-Source: APXvYqwZOx5RZwHiOiIQlUmqhhpdb6ZkCj4cnxwcvKKNMjpu1O9snvmVvwk0T8UH3sBPLjNdBK2SbQ==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr2208144wmb.173.1561642207629;
        Thu, 27 Jun 2019 06:30:07 -0700 (PDT)
Received: from apalos (athedsl-4461147.home.otenet.gr. [94.71.2.75])
        by smtp.gmail.com with ESMTPSA id x20sm5380562wrg.52.2019.06.27.06.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 06:30:07 -0700 (PDT)
Date:   Thu, 27 Jun 2019 16:30:04 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190627133004.GA3757@apalos>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,
> On Wed, 2019-06-26 at 19:56 -0400, Sasha Levin wrote:
> > > You've used so much on this so shouldn't this have that somewhat new
> > > co-developed-by tag? I'm also wondering can this work at all
> > 
> > Honestly, I've just been massaging this patch more than "authoring" it.
> > If you feel strongly about it feel free to add a Co-authored patch with
> > my name, but in my mind this is just Thiru's work.
> 
> This is just my subjective view but writing code is easier than making
> it work in the mainline in 99% of cases. If this patch was doing
> something revolutional, lets say a new outstanding scheduling algorithm,
> then I would think otherwise. It is not. You without question deserve
> both credit and also the blame (if this breaks everything) :-)
> 
> > > process-wise if the original author of the patch is also the only tester
> > > of the patch?
> > 
> > There's not much we can do about this... Linaro folks have tested this
> > without the fTPM firmware, so at the very least it won't explode for
> > everyone. If for some reason non-microsoft folks see issues then we can
> > submit patches on top to fix this, we're not just throwing this at you
> > and running away.
> 
> So why any of those Linaro folks can't do it? I can add after tested-by
> tag parentheses something explaining that context of testing. It is
> reasonable given the circumstances.
There's 2 teams from Microsoft trying to do this [1]. We tested the previous
implementation (which problems on probing as built-in). We had to change some
stuff in the OP-TEE fTPM implementation [2] and test it in QEMU.

What i quickly did with this module was to replace the kernel of the previous
build with the new one. Unfortunately i couldn't get it to work, but i don't
know if it's the module or the changes in the fTPM OP-TEE part. Since you have
tested it my guess is that it has something to do with the OP-TEE part. I don't
have any objections in this going in. On the contrary i think the functionality
is really useful. I don't have hardware to test this at the moment, but once i
get it, i'll give it a spin.

The part i tested is that the probing works as expected when no fTPM
implementation is running on secure world.
Since it has been tested and doesn't break anything we can always fix corner,
cases afterwards with more extensive testing

[1]
https://github.com/ms-iot/linux/blob/ms-optee-ocalls-merge/drivers/char/tpm/tpm_ftpm_optee.c
[2] https://github.com/jbech-linaro/manifest/blob/ftpm/README.md

Thanks
/Ilias

> 
> I can also give an explanation in my next PR along the lines what you
> are saying. This would definitely work for me.
> 
> /Jarkko
> 
