Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23942CF7CA
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Dec 2020 01:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgLEAH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 19:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLEAH0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 19:07:26 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DE9C0613D1;
        Fri,  4 Dec 2020 16:06:46 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE8961280B60;
        Fri,  4 Dec 2020 16:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607126805;
        bh=+4daNnoifoPt3+krlY8/jTtTh/XHP2d4pPOqjTWgpII=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=OPggrwG7JNJIcnOU3JNJ6edNbfB4AhB6awcH1Un2Y2ToAu3eLVuFL1dcdaJHVVCrZ
         ws/KsCOa2ztTKazAJl94NWYdaHPvegx112PS/dbT7ML6EsNlYuiRAgNTnqYO9J2Sjc
         K5EPyKErWagGprvpsD35JAhsnccBU7muCH7dnrqE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G5OWr2Ntt5qM; Fri,  4 Dec 2020 16:06:45 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2BC2F1280B59;
        Fri,  4 Dec 2020 16:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607126805;
        bh=+4daNnoifoPt3+krlY8/jTtTh/XHP2d4pPOqjTWgpII=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=OPggrwG7JNJIcnOU3JNJ6edNbfB4AhB6awcH1Un2Y2ToAu3eLVuFL1dcdaJHVVCrZ
         ws/KsCOa2ztTKazAJl94NWYdaHPvegx112PS/dbT7ML6EsNlYuiRAgNTnqYO9J2Sjc
         K5EPyKErWagGprvpsD35JAhsnccBU7muCH7dnrqE=
Message-ID: <e2b07ef9132f150f6d8ee169e249b2ce33a0db10.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm
 detected
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Fri, 04 Dec 2020 16:06:44 -0800
In-Reply-To: <87czzpw88m.fsf@redhat.com>
References: <20201130232338.106892-1-jsnitsel@redhat.com>
         <20201201025807.162241-1-jsnitsel@redhat.com> <87czzujjg1.fsf@redhat.com>
         <878sahmh5w.fsf@redhat.com> <20201202164931.GA91318@kernel.org>
         <87sg8noixh.fsf@redhat.com> <87lfefe7vm.fsf@redhat.com>
         <87ft4mpryt.fsf@redhat.com>
         <8a7d2fda891e45b098b603064d45dd7d53898fd4.camel@HansenPartnership.com>
         <87czzpw88m.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-12-04 at 14:51 -0700, Jerry Snitselaar wrote:
> James Bottomley @ 2020-12-03 14:05 MST:
> 
> > On Thu, 2020-12-03 at 13:14 -0700, Jerry Snitselaar wrote:
> > > Jerry Snitselaar @ 2020-12-02 23:11 MST:
> > [...]
> > > > The interrupt storm detection code works on the T490s. I'm not
> > > > sure what is going on with the L490. I will see if I can get
> > > > access to one.
> > > > 
> > > > Jerry
> > > 
> > > Lenovo verified that the L490 hangs.
> > 
> > Just to confirm, that's this system:
> > 
> > https://www.lenovo.com/us/en/laptops/thinkpad/thinkpad-l/ThinkPad-L490/p/22TP2TBL490
> > 
> > We could ask if lenovo will give us one, but if not we could pull a
> > Jens.  [the backstory is that when Jens was doing queueing in the
> > block layer, there were lots of SATA devices that didn't work quite
> > right but you couldn't tell unless you actually tried them
> > out.  Getting manufacturers to send samples is rather arduous, so
> > he took to ordering them online, testing them out, and then
> > returning them for a full refund within the allowed window]
> > 
> > It looks like Lenovo has a nice christmas returns policy:
> > 
> > https://www.lenovo.com/us/en/shopping-faq/#returns
> > 
> > James
> 
> Yes, that is the one. I'm seeing if we have any located somewhere, or
> if Lenovo will loan me one.

OK, that would be best since it's your patch.  We've got 12 days left
to get the free returns policy, so if you haven't managed to find one
by the end of next week, I'll order one and play with it ... you could
always put your manager's credit card down for one as well ...
especially as it should get refunded ...

>  I think for the time being the patch that disabled interrupts for
> the T490s could be changed to it for the L490 instead. I'll post a v3
> of my current patchset. It would probably make sense for it to go in
> with your patches when they land.

Absolutely ... we can't turn interrupts on and then have a load of hung
laptops we already knew about ...

James


