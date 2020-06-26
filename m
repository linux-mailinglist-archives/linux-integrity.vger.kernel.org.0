Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7020ABD2
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 07:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgFZF1E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 01:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZF1E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 01:27:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F37C08C5C1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 22:27:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t25so4423649lji.12
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 22:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWSmhFAjgCJ/4MERZDdmV3HHdWRMsmmhbC6NHwQFBlg=;
        b=rb8Q+1dSzwKbczJC5klufjbDjum1q93zdZOH735pHh1ahl0p0Wjlgwz7/o0lxO2jxs
         Qf2E5FdecXLm4csarrYSzG97tKlHAZAwikBjrkkB8JyAte0JamXRvT3iIZ/QaXOEN8+x
         ar+vbtnyb4fgUOCQLQtZ5pcMBOIK9XkrfdELE5kUxx42alUIBef2Ny0mFjlNGcqncndB
         Y5yCF2b6L6Vany4DXOCVDwXSr/8xuxxXOY9RZRJ++3YlmBaBGq3YmB/enn7n9/NSlBU1
         tBsRWmOpKPWCoabOLlsc4uDNLq5+ESq6j6476gVUQHGaUFF937Q3kgzUzwGQGXVsYfUa
         azyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWSmhFAjgCJ/4MERZDdmV3HHdWRMsmmhbC6NHwQFBlg=;
        b=hDxTrTfb1J9C7EEvAOHdhENvSVqiCqwlTizAgMeeGiz5RXb7YIbcx5gaT8JUU3PcvN
         GIEFfwBfRbUqHxEZdyAmjQ8Ya7G9PRHyFHWYgBt75KvPSBeg1kUo+N6VsEy1Z09ObZ4G
         1xVYhHvTCmUsRu/5srY+3/anMZ3qLF9c1siXgTPaIW56lx7fbcZLLrgDeqLEHZje6K/l
         roJcMAI1su4O2eUG6Ieo/QSXcDw/zPIp0A9AE/ci8ndPObWUS1C0iWdtcpDWAxtfCv1z
         0UL9RtvNFqahaonDIRaUsqICjtVCJT91T4iDYLCsvEmGAbkxvlX7Lbb09UVCSuTbaDTA
         PGxA==
X-Gm-Message-State: AOAM531ZceAONt0bjNjgoQDnzBnyQYrjv0ZosZ6eP0HJbcPy7qKqLeHM
        rYM4UHjfiZqBQYfxz7bIBbNASerlt8MCQ4SZC/u9dw==
X-Google-Smtp-Source: ABdhPJxkDD58JMKImt/kwvHSRCvi2eSoQBTY2+Uvb1xPAxHBhkNbqSdrTW0Xrq6J8pZ/kHZwkeOyw/4CAJReOUqaXu8=
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr511914ljl.256.1593149222348;
 Thu, 25 Jun 2020 22:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com>
 <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org> <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
 <CAFA6WYNpVvkzgbBfXc1C10mKC6C6q_G1+c-ypg4s1pb0KDPCvg@mail.gmail.com>
 <1592507935.15159.5.camel@HansenPartnership.com> <CAFA6WYMqOS+P-c4FznQ5vOKvonnKN4Z6BqTipOkrY3gMENLfeA@mail.gmail.com>
 <1592578844.4369.5.camel@HansenPartnership.com> <CAFA6WYPCmZZ1HK-w8fQ2xaNywAZz9W21_fBOnbc35dT30sn7oQ@mail.gmail.com>
 <1593012069.28403.11.camel@HansenPartnership.com> <3aa8705a-0342-25ea-00c4-d5370d91ddb4@forissier.org>
 <CAD8XO3ZDv-RZ-VPv-AFMRkMD_3uW9XYLeZQf0btGVK8m7GX2Dg@mail.gmail.com>
In-Reply-To: <CAD8XO3ZDv-RZ-VPv-AFMRkMD_3uW9XYLeZQf0btGVK8m7GX2Dg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 26 Jun 2020 10:56:50 +0530
Message-ID: <CAFA6WYPUzSNYjrktSPdzLDsKeO8Tipi6CuSjjN-MgdsvU2KzOA@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 25 Jun 2020 at 18:22, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Wed, 24 Jun 2020 at 18:44, Jerome Forissier <jerome@forissier.org> wrote:
> >
> >
> >
> > On 6/24/20 5:21 PM, James Bottomley wrote:
> > > On Wed, 2020-06-24 at 16:17 +0530, Sumit Garg wrote:
> > >> Apologies for delay in my reply as I was busy with some other stuff.
> > >>
> > >> On Fri, 19 Jun 2020 at 20:30, James Bottomley
> > >> <James.Bottomley@hansenpartnership.com> wrote:
> > > [...]
> > >>> it's about consistency with what the kernel types mean.  When some
> > >>> checker detects your using little endian operations on a big endian
> > >>> structure (like in the prink for instance) they're going to keep
> > >>> emailing you about it.
> > >>
> > >> As mentioned above, using different terminology is meant to cause
> > >> more confusion than just difference in endianness which is manageable
> > >> inside TEE.
> > >>
> > >> And I think it's safe to say that the kernel implements UUID in big
> > >> endian format and thus uses %pUb whereas OP-TEE implements UUID in
> > >> little endian format and thus uses %pUl.
> > >
> > > So what I think you're saying is that if we still had uuid_be and
> > > uuid_le you'd use uuid_le, because that's exactly the structure
> > > described in the docs.  But because we renamed
> > >
> > > uuid_be -> uuid_t
> > > uuid_le -> guid_t
> > >
> > > You can't use guid_t as a kernel type because it has the wrong name?
> >
> > Let me try to clear the confusion that I introduce myself I believe :-/
> > IMO:
> >
> > - optee_register_device(const uuid_t *device_uuid) *is* the correct
> > prototype.
> > - device_uuid is *guaranteed* to be BE because OP-TEE makes this
> > guarantee (it converts from its internal LE representation to BE when
> > enumerating the devices, but it doesn't matter to the kernel).
> > - Therefore %pUb is the correct format.
> >
> > I'm sorry for doubting the BE order initially. I am so used to OP-TEE
> > using LE internally, that I missed the fact that we have an explicit
> > conversion...
> >
> > Does this sound good?
> >
> > Thanks,
> > --
> > Jerome
>
> I think your description is correct. But I think this problem  would
> be solved outside of the current patchset.
> All places should use one single format (LE):
> -  internal optee representation;
> -  device enumeration pta;
> -  this kernel driver which creates sysfs entry and sets
> uid_copy(&optee_device->id.uuid, device_uuid);
> -  matching function;
> -  drivers use UUID_INIT();
>
> In that way everything will be consistent. But it will require
> changing other pieces, not just the kernel. While
> these patches add functionality to support current device enumeration
> in optee os.
> So I think this version is ok to be applied.

I guess here you meant v9 patch-set. If yes then it's fine with me as well.

-Sumit

>
> Regards,
> Maxim.
