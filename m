Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874F328E332
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgJNPXy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 11:23:54 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:42136 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbgJNPXy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 11:23:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EB2771280094;
        Wed, 14 Oct 2020 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602689033;
        bh=+QgxuPSTJ+d7kdLCEwk+t3H7ZGNugA7+7MXq+FKch3w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kn6gPkCfnNs8Fj74aXVmZ6ozCBtg0NKMYj/wGfn+wvd4PmwhnoWN66d7uBtaCvwCv
         KqfNrfgTCwg7Y+XIb/IYR5tLMb9J5TRCZQN+Azrbsc/245T3iYWSBETWAKJIBQjILy
         pgP2+gGYpgYcXmMee6e5gTKtlDfew92ioXMBKtL8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Njq5Gxm5wV2S; Wed, 14 Oct 2020 08:23:53 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 532631280093;
        Wed, 14 Oct 2020 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602689033;
        bh=+QgxuPSTJ+d7kdLCEwk+t3H7ZGNugA7+7MXq+FKch3w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kn6gPkCfnNs8Fj74aXVmZ6ozCBtg0NKMYj/wGfn+wvd4PmwhnoWN66d7uBtaCvwCv
         KqfNrfgTCwg7Y+XIb/IYR5tLMb9J5TRCZQN+Azrbsc/245T3iYWSBETWAKJIBQjILy
         pgP2+gGYpgYcXmMee6e5gTKtlDfew92ioXMBKtL8=
Message-ID: <82a5c6e4a9f7fe037f12cd2eba7512bd8b04f21a.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Date:   Wed, 14 Oct 2020 08:23:52 -0700
In-Reply-To: <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201013011745.GA41176@linux.intel.com>
         <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
         <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
         <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
         <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
> On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
> > James Bottomley @ 2020-10-13 08:24 MST:
> > > On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
> > > > Jarkko Sakkinen @ 2020-10-12 18:17 MST:
[...]
> > > > >   Jerry, once you have some bandwidth (no rush, does not land
> > > > > before rc2), it would be great that if you could try this.
> > > > > I'm emphasizing this just because of the intersection. I
> > > > > think it would also make senset to get tested-by from Nayna.
> > > > 
> > > > I will run some tests on some other systems I have access to.
> > > > As noted in the other email I did a quick test with a t490s
> > > > with an older bios that exhibits the problem originally
> > > > reported when Stefan's patch enabled interrupts.
> > > 
> > > Well, it means there's still some other problem.  I was hoping
> > > that because the rainbow pass system originally exhibited the
> > > same symptoms (interrupt storm) fixing it would also fix the t490
> > > and the ineffective EOI bug looked like a great candidate for
> > > being the root cause.
> > > 
> > 
> > Adding Hans to the list.
> > 
> > IIUC in the t490s case the problem lies with the hardware itself.
> > Hans, is that correct?
> 
> More or less. AFAIK / have been told by Lenovo it is an issue with
> the configuration of the inerrupt-type of the GPIO pin used for the
> IRQ, which is a firmware issue which could be fixed by a BIOS update
> (the pin is setup as a direct-irq pin for the APIC, so the OS has no
> control of the IRQ type since with APIC irqs this is all supposed to
> be setup properly before hand).
> 
> But it is a model specific issue, if we denylist IRQ usage on this
> Lenovo model (and probably a few others) then we should be able to
> restore the IRQ code to normal functionality for all other device
> models which declare an IRQ in their resource tables.

I can do that with a quirk, but how do I identify the device?  TPM
manufacturer and version? or do I have to use something like the ACPI
bios version?

James


