Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8310BD36
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfK0V0T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:26:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33640 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfK0V0T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:26:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id x21so14329260oic.0
        for <linux-integrity@vger.kernel.org>; Wed, 27 Nov 2019 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvIzR24kHBea1uxOpKKhJOT4jJB8qq3HQYSkFgo3U3E=;
        b=vThlKJNpDRPL9EvkUMfozZ8dvzrN+pb71NRt9M+FbIHb/Xz+9FcrMIu4yHm1PEauZa
         I8eA2C10V6PS8qQEX8q22qTBiZ2eac763UwVTnYdKf3iE8vNrP914cHwDmWr0JuiusFq
         VI+Ps4ttc9N082Q70yjK9ZE2HHyAXYmKHiwGC2sU7GZXpTEAp/J6vH7eZJBJ7ppr+x3M
         ufcUicdg/5jdYNyBDasulrzj0g8Xf9nTla0fm1rVwJO0cRZ8Gq8O3MwocCqwAymu3E6V
         FTgEkxA9Uhq59tv2287Qz+s4W8TZdwaDOTg4LnJhfFfIPK+Puei6JaW0O2gb+x5eAI9V
         YAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvIzR24kHBea1uxOpKKhJOT4jJB8qq3HQYSkFgo3U3E=;
        b=DxCmJ3brkDk1J4c9vVPqjVEw/6eeuBcZOoxd75vchw4pOSp+zuKHXq4Wz6/l1TGmv+
         jUvDSTwDLHQY4ajMhqiop7Knz1XoWYyRtQkZNBCilPp5qZfXC4iNBoutRJ/csMGgeAQR
         7P+dWfFJH/C0Bf0k3bEiZCINgvNIKjoiOdGbhoV0njMw9AgZk00zBUB0WWWFbge3mnCn
         E3A59ksoFKI/aRVw4oNMgH2mkdh3HhtEpLfX++ORNXoHDAUhcC0amRDEZ9/v1Fc1iav/
         joiGTRSmqQxgpeKUwvEgNdag0hjmJLO9EaGHQ05D7DV/I3kJC4Z7lNAVsDZWSus50QVB
         VMQg==
X-Gm-Message-State: APjAAAWCJ2k1rkeqqP/AI+gBt+YlncKYZl6vYO5hqXEtq7wk1QLLiEtJ
        9ImBGlB7XvfWk2E4GeEqVVYR3q5kfn6dW/VCzEWqPg==
X-Google-Smtp-Source: APXvYqzjfv3uRACCOCg93jfSkR/I+DVeAiPls/NFEqGCYZ38KdgrJFBtLtMlmlxnWDacs2YcTvlXPCF13m2/1pu3CJ0=
X-Received: by 2002:a05:6808:20c:: with SMTP id l12mr1738564oie.105.1574889978465;
 Wed, 27 Nov 2019 13:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20191112202725.3009814-1-stefanb@linux.vnet.ibm.com>
 <20191114164151.GB9528@linux.intel.com> <20191114164426.GC9528@linux.intel.com>
 <185664a9-58f2-2a4b-4e6b-8d7750a35690@linux.ibm.com> <20191121184949.yvw2gwzlkhjzko64@cantor>
 <20191127211109.GF14290@linux.intel.com>
In-Reply-To: <20191127211109.GF14290@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Nov 2019 13:26:07 -0800
Message-ID: <CAPcyv4gO2T4xcZjYSYJ8-0kDPRnVYWhX_df5E94Cjyksx6WFbg@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: Move setting of TPM_CHIP_FLAG_IRQ into tpm_tis_probe_irq_single
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, jsnitsel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[ add Jerry ]

On Wed, Nov 27, 2019 at 1:11 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Nov 21, 2019 at 11:49:49AM -0700, Jerry Snitselaar wrote:
> > On Sat Nov 16 19, Stefan Berger wrote:
> > > On 11/14/19 11:44 AM, Jarkko Sakkinen wrote:
> > > > On Thu, Nov 14, 2019 at 06:41:51PM +0200, Jarkko Sakkinen wrote:
> > > > > On Tue, Nov 12, 2019 at 03:27:25PM -0500, Stefan Berger wrote:
> > > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > >
> > > > > > Move the setting of the TPM_CHIP_FLAG_IRQ for irq probing into
> > > > > > tpm_tis_probe_irq_single before calling tpm_tis_gen_interrupt.
> > > > > > This move handles error conditions better that may arise if anything
> > > > > > before fails in tpm_tis_probe_irq_single.
> > > > > >
> > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > What about just changing the condition?
> > > > Also cannot take this since it is not a bug (no fixes tag).
> > >
> > > I'll repost but will wait until Jerry has tested it on that machine.
> > >
> > >    Stefan
> > >
> > >
> > > >
> > > > /Jarkko
> > >
> > >
> >
> > It appears they still have the problem. I'm still waiting on logistics
> > to send me a system to debug.
>
> Which hardware is guaranteed to ignite this? I can try to get test hw
> for this from somewhere. Kind of looking into this blinded ATM. Dan?

Jerry had mentioned that this was also occurring on T490s. Otherwise
I'll ping you offline about the system I saw this on internally.
