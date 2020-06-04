Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8ED1EE5BD
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgFDNtO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgFDNtO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 09:49:14 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98502C08C5C1
        for <linux-integrity@vger.kernel.org>; Thu,  4 Jun 2020 06:49:13 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o2so3559370vsr.0
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPpd656MMu8iYjQVT9EVikmUCKNI1MpL/95nbG8yam0=;
        b=FUIHNPOT5csqv9Us/qhndOP+YTIa0XIraDHChXaWO83kbAFuzy/iT+2f0KbSPCQg6M
         HSmO7hZ+YvSMNs8CRVUZbbznfbFph4rO0H6kOiVLdAm5+CkONCXN8VuKcGdYxhjAkF7j
         RmUZIQ+hhGrECM3A9lu4azLIkiXjclwmkc8bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPpd656MMu8iYjQVT9EVikmUCKNI1MpL/95nbG8yam0=;
        b=tOf7WsRX/CiGCvMA8bKrr4VuommKlnFI5Ss+JFUWmwx4GupeZL14vKpN8siqqNILOv
         IXEGh/gOaL4pzL5QBjGjvdB6BCs3uHRxnisK4duxHEdCV2IMfisoGchVx0PC/6G726qU
         LEG6xG/mjs02L08oZqujoRlQwED6gs1IPAr3KWT3+Y4af/ddQ3+/bsKuemTABrl8E6Pf
         igXtvnHLehgmY02l/HlOx6cMhF2PbHDtfdEKygwouWUS4X3ROmxTQtie/rRb9w/+nzHS
         paBXsrryWMl/lhAT2SbjjM4xzOIt8hGd8Dsc9XdviTuaCjCoGcg3DNu+2IZJsbPtryww
         R5FQ==
X-Gm-Message-State: AOAM531GJyOvM/MTBuaTUQC4VMYRxjka4D2UenKS551H5TjQ+PrcfmS8
        rwLe04Hmd8YvyM8ood9dd4KcdmiQG1o=
X-Google-Smtp-Source: ABdhPJw3BHVoylmCdeG7WnVE5HPUQ/hLTDfUOAQEhxbu6V9J/OqOm7plX+tC2i92rGfM9t2dC8NT3Q==
X-Received: by 2002:a05:6102:1081:: with SMTP id s1mr3298672vsr.215.1591278552600;
        Thu, 04 Jun 2020 06:49:12 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id k68sm584136vsc.32.2020.06.04.06.49.10
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:49:11 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id q2so3558917vsr.1
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 06:49:10 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr3607360vsx.169.1591278550114;
 Thu, 04 Jun 2020 06:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151912.1.Id689a39ce8d1ec6f29f4287277ad977ff4f57d7d@changeid>
 <20200601014646.GA794847@linux.intel.com> <CAD=FV=VaET7ZXE0f6ciKmE=p1R1DMF9jCue9_XAD4870byKGog@mail.gmail.com>
 <20200604094012.GA8989@linux.intel.com>
In-Reply-To: <20200604094012.GA8989@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Jun 2020 06:48:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vgjs4gALALWYVLEYfbFtXi69FrVYziJ9x=YA5RjrV1ww@mail.gmail.com>
Message-ID: <CAD=FV=Vgjs4gALALWYVLEYfbFtXi69FrVYziJ9x=YA5RjrV1ww@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Don't send anything during flow control
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Thu, Jun 4, 2020 at 2:40 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 03:54:03PM -0700, Doug Anderson wrote:
> > Does that answer your question, or were you worried about us needing
> > to init iobuf[0] to 0 in some other case?
> >
> > -Doug
>
> No, but it should be treated as a bug fix for CR50 implementation i.e.
> for 797c0113c9a481d4554988d70b5b52fae657262f, or is there some reason
> why it shouldn't?

As talked about in the commit message, I think this is a slight
cleanup for non-Cr50 too.  Specifically if we end up running through
the TPM_RETRY loop a second time we weren't re-initting "phy->iobuf[0]
= 0;"  That means that the 2nd time through the loop we were actually
sending the TPM back the byte that the TPM sent us the first time
through the loop.

Presumably this doesn't matter much, but it still feels nicer not to
be sending the TPM's bytes back to it when we're not really supposed
to.

Also, as mentioned in the commit message, I haven't observed this
fixing any problems.  I only came up with it from code inspection
while trying to track something else down.


-Doug
