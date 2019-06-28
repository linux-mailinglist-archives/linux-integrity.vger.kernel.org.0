Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8569593A8
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 07:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfF1Fua (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jun 2019 01:50:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36369 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfF1Fu3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jun 2019 01:50:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so4738774ljj.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2019 22:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbFBRaRExGspP5FBHqiodiH1th1SFCHyj3/EvKVMOx0=;
        b=VKNi1swUOq5lK8dq5fqpEDERV76IAnNdVZ5XZGkHh0446kzeu1AUrTBtfcWnqjwz7s
         CFLCv+VQfnCjIW21Uxjhk9kIItpOCpOBVaNjc4RN6PTb/zpOPrs2Jj7LcyAqecc21QRV
         2zT0yeebkvwCzjWi2Tq7+2u7CBR3i7VsePNdHChsH3C/xrJfBA9rwWPDAi8E7lXECpz8
         Q1nuzUYvZIvaVHYYNFAHG986q7tr+zKqYG229xXRcT4HSClajfzb3LUyrKnMstHdN24Y
         IWVk/TCCmQCNkoJVw/Yul28cipc8m3F/AL+0q4ind6UeYydAvf+v66mhP8+vCEXX70QX
         +NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbFBRaRExGspP5FBHqiodiH1th1SFCHyj3/EvKVMOx0=;
        b=EemIGuS3822lEfJyOtAoY/HA8tZ55bgK4zIBxfOfMDsDx8gfVvGHlflO6L+d2eQVEo
         Y+x4Bjv6DUcs6wRnnxYEYQkacoyaxjy6rRDRmZWQwo0VvHn99lTttu/2dyN9q9Eum3MK
         759buPgWXopgqtklexKIqcCY4FFJUo17P7gBy0sQWuzd056f8SpA9u/QPAfnA+8Ku9aZ
         jM+pTcETYCLyOSxGt3WqjgeFoqW+jf/yGkPjSzanlRPmcGBjtE2pGpX7GCEmKCUpovwk
         gPlMjPrYZ0iNL+0bpMj2Gfc8lJt4siuXidMzKOHa9xfxF6RsdKLLnzuzuTMryDlnm2ba
         SORg==
X-Gm-Message-State: APjAAAVcVg/ubf1Xr4xoO4KArVt6yYJPTjN4vyHRZQ3MyO4Bn4bg03FW
        /VW9YFtP+s+kNR0321+304MaK9iXC00nCV3yY3gk9w==
X-Google-Smtp-Source: APXvYqyEmJlYN3SMPXRrWfgX1NnF/P7C1CPVt4Z22T7CZtmDkBsqof9nh+eUEiF4lozTqMf3BR8KLe04tRokqvKZ1VQ=
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr4842583lja.238.1561701027991;
 Thu, 27 Jun 2019 22:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190625201341.15865-1-sashal@kernel.org> <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm> <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
In-Reply-To: <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 28 Jun 2019 11:20:16 +0530
Message-ID: <CAFA6WYM=YFec7rx6QSWtaZYeY8LrcjQ3bbMMtF0r6jbBaHX+Bw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        tee-dev@lists.linaro.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko and Sasha,

On Thu, 27 Jun 2019 at 18:47, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
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

Simply because the hardware I have (Developerbox) doesn't provide
enough flash space (as per current memory map) for this fTPM driver to
be loaded as early TA along with OP-TEE binary. So I can't get any
further point than sanity probe failure check for which I think a
tested-by won't be appropriate.

-Sumit

>
> I can also give an explanation in my next PR along the lines what you
> are saying. This would definitely work for me.
>
> /Jarkko
>
