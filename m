Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649A527FEBB
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 14:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgJAMB2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 08:01:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:34834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbgJAMB2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 08:01:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CC40AF98;
        Thu,  1 Oct 2020 12:01:27 +0000 (UTC)
Date:   Thu, 1 Oct 2020 14:01:25 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20201001120125.GE32109@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930115939.GB7612@linux.intel.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

> On Wed, Sep 30, 2020 at 07:53:14AM +0200, Petr Vorel wrote:
> > Hi Jarkko,

> > > Hi, is there something specific I should look at in this patch set?

> > I'm sorry to bother you with LTP specific code. Can you have a quick look if I
> > didn't overlook anything obvious in reading PCR files (read_pcr_tpm*())?

> > I'm surprised that it's working on my TPM 2.0 which does not export
> > /sys/kernel/security/tpm0/binary_bios_measurements (using evmctl).

> Thank you, this was actually really important remark and reminder.

> OK so I think James' patch is stuck because of me, i.e.

> https://lore.kernel.org/linux-integrity/20200911114820.GB6877@linux.intel.com/

> I'm sorry about this. The final final conclusion is that the way it
> exports PCRs is just fine.
That's a great, thank you for going to upstream James' patch.
James, thanks for implementing it!

> Can you test this version?
Sure, I'll test it next week.

> https://patchwork.kernel.org/patch/11759729/


> I can then add reviewd-by and apply it and you don't have to do any sort
> of stupid hacks.
I'll need to keep these hacks for older kernels, but it's great that there is a
better solution.

Other thing: do you know anybody practically uses more TPM devices in single
machine? I'm asking that I work with tpm0 in ima_tpm.sh, but maybe I should
allow user to redefine it to choose different device (or even run tests for all
available devices).

Kind regards,
Petr

> /Jarkkko
