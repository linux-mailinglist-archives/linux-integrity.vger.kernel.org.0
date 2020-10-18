Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E375292036
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Oct 2020 23:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgJRVjf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Oct 2020 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVje (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Oct 2020 17:39:34 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EBC061755
        for <linux-integrity@vger.kernel.org>; Sun, 18 Oct 2020 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HOtKMmGXOBkbcW7jf+XVTB4IS9IYOkiwOpD68vmgVCs=; b=1b/3/guH+51RYEAULGqnQb/yzU
        xvuuVNRm4eHX6bnv6dQEatSv8rhcapiz+LCKBkJIDV9PN8nvjsT2i/ZDRMBAW6Z/kC02OXUkmYXuZ
        k3v4XWu6FDpmeutEhx331Iex/MZj3CG0qSucAseagsZEKUwlJk4Zg9LEojzsecpv9vMg3z+66y85G
        A6Mi2AQIe50hlS9E8pzUfHdGmUBkbXkpJH9DS4Tr9cunZONJUfgbMZzOm/GTdQRPOTFkhGhw8SrZG
        C/G6eMF5MjG5MAEh8KrDxI+a+dNml2b1JdagXivgPY/wWKxtUdalNMJyV+ViypkGa6+Kls6Y6NxDa
        dHcCx8Uw==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1kUFvg-0002HG-6A; Mon, 19 Oct 2020 00:09:24 +0300
Date:   Mon, 19 Oct 2020 00:09:23 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        equired@linux.intel.com,
        justmentioningitbecauseIthinkthatwouldbeagood@linux.intel.com,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Borislav Petkov <bp@alien8.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Hans de Goede <jwrdegoede@fedoraproject.org>
Subject: Re: [PATCH v2 0/5] tpm_tis: fix interrupts (again)
Message-ID: <20201018210923.GB575510@kapsi.fi>
References: <87tuuyf97r.fsf@jsnitsel.users.ipa.redhat.com>
 <e6930fa6df318ee2f51e13f6402d264fedb5d9ab.camel@HansenPartnership.com>
 <87lfgaf6ww.fsf@jsnitsel.users.ipa.redhat.com>
 <5f9ead56-78ff-e8b4-d646-654c9a08c519@redhat.com>
 <82a5c6e4a9f7fe037f12cd2eba7512bd8b04f21a.camel@HansenPartnership.com>
 <cd221dae-1c37-76d9-8ba2-1e4ceb528292@redhat.com>
 <87ft6gg41b.fsf@jsnitsel.users.ipa.redhat.com>
 <2553a8f3-6a71-7b05-52ab-8c346e2cb6ec@redhat.com>
 <87sgagv82r.fsf@jsnitsel.users.ipa.redhat.com>
 <b6863c56-fc13-d0e4-6747-ae09ea3d45a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6863c56-fc13-d0e4-6747-ae09ea3d45a3@redhat.com>
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 15, 2020 at 09:38:24AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/14/20 10:58 PM, Jerry Snitselaar wrote:
> > 
> > Hans de Goede @ 2020-10-14 09:46 MST:
> > 
> > > Hi,
> > > 
> > > On 10/14/20 6:34 PM, Jerry Snitselaar wrote:
> > > > Hans de Goede @ 2020-10-14 09:04 MST:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > On 10/14/20 5:23 PM, James Bottomley wrote:
> > > > > > On Wed, 2020-10-14 at 17:03 +0200, Hans de Goede wrote:
> > > > > > > On 10/13/20 6:05 PM, Jerry Snitselaar wrote:
> > > > > > > > James Bottomley @ 2020-10-13 08:24 MST:
> > > > > > > > > On Tue, 2020-10-13 at 08:15 -0700, Jerry Snitselaar wrote:
> > > > > > > > > > Jarkko Sakkinen @ 2020-10-12 18:17 MST:
> > > > > > [...]
> > > > > > > > > > >      Jerry, once you have some bandwidth (no rush, does not land
> > > > > > > > > > > before rc2), it would be great that if you could try this.
> > > > > > > > > > > I'm emphasizing this just because of the intersection. I
> > > > > > > > > > > think it would also make senset to get tested-by from Nayna.
> > > > > > > > > > 
> > > > > > > > > > I will run some tests on some other systems I have access to.
> > > > > > > > > > As noted in the other email I did a quick test with a t490s
> > > > > > > > > > with an older bios that exhibits the problem originally
> > > > > > > > > > reported when Stefan's patch enabled interrupts.
> > > > > > > > > 
> > > > > > > > > Well, it means there's still some other problem.  I was hoping
> > > > > > > > > that because the rainbow pass system originally exhibited the
> > > > > > > > > same symptoms (interrupt storm) fixing it would also fix the t490
> > > > > > > > > and the ineffective EOI bug looked like a great candidate for
> > > > > > > > > being the root cause.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Adding Hans to the list.
> > > > > > > > 
> > > > > > > > IIUC in the t490s case the problem lies with the hardware itself.
> > > > > > > > Hans, is that correct?
> > > > > > > 
> > > > > > > More or less. AFAIK / have been told by Lenovo it is an issue with
> > > > > > > the configuration of the inerrupt-type of the GPIO pin used for the
> > > > > > > IRQ, which is a firmware issue which could be fixed by a BIOS update
> > > > > > > (the pin is setup as a direct-irq pin for the APIC, so the OS has no
> > > > > > > control of the IRQ type since with APIC irqs this is all supposed to
> > > > > > > be setup properly before hand).
> > > > > > > 
> > > > > > > But it is a model specific issue, if we denylist IRQ usage on this
> > > > > > > Lenovo model (and probably a few others) then we should be able to
> > > > > > > restore the IRQ code to normal functionality for all other device
> > > > > > > models which declare an IRQ in their resource tables.
> > > > > > I can do that with a quirk, but how do I identify the device?  TPM
> > > > > > manufacturer and version? or do I have to use something like the ACPI
> > > > > > bios version?
> > > > > 
> > > > > I'm not sure if the TPM ids are unique to one model/series of laptops.
> > > > > 
> > > > > So my idea for this was to match on DMI strings, specifically
> > > > > use a DMI match on the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION
> > > > > strings (normally one would use DMI_PRODUCT_NAME but for Lenovo
> > > > > devices the string which you expect to be in DMI_PRODUCT_NAME
> > > > > is actually in DMI_PRODUCT_VERSION).
> > > > > 
> > > > > You can easily get the strings for your device by doing:
> > > > > 
> > > > > cat /sys/class/dmi/id/sys_vendor
> > > > > cat /sys/class/dmi/id/product_version
> > > > > 
> > > > > Regards,
> > > > > 
> > > > > Hans
> > > > Plus use dmi_get_date(DMI_BIOS_DATE,...) to check
> > > > if the bios is older than the fixed bios? Has Lenovo
> > > > released the fixed bios?
> > > 
> > > Maybe, the fixed BIOS-es which I have seen (for the X1C8,
> > > broken BIOS was a pre-production BIOS) "fixed" this by
> > > no longer listing an IRQ in the ACPI resources for the TPM.
> > > 
> > > Which means that the new BIOS still being on the deny list
> > > does not matter since the IRQ support won't work anyways as
> > > we no longer get an IRQ assigned.
> > > 
> > > So I don't think this is necessary and it will just complicate
> > > things unnecessarily. This whole saga has already taken way
> > > too long to fix. So IMHO the simplest fix where we just deny
> > > list the broken models independent of BIOS versions and move
> > > on seems best.
> > > 
> > > Regards,
> > > 
> > > Hans
> > 
> > This worked for me:
> 
> That looks good to me, can you submit this upstream please ?
> 
> If you Cc me I'll give it my Reviewed-by.
> 
> Regards,
> 
> Hans

Yes, this does look like sustainable patch.

PS. Email has been migration ongoing. That's the reason for inconsistent
responses.

/Jarkko
