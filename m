Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40872159D9
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2020 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGFOrw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 10:47:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:35175 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbgGFOrw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 10:47:52 -0400
IronPort-SDR: 13WpvrGfTejv2N6p1adizMtoR7SBYme3eZHlhX+uKiZI3KXdyQ9GMKSm9rkz9JBOJA6yKPHLqU
 af1C7nyhs8BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212408804"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="212408804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 07:47:51 -0700
IronPort-SDR: jFS7KGHVaRAaMznduEL5fQXp/b6JrXmLh7bBjVzc4f+0S77nN/JJ84Mu6X2OqlMKgmg2yQmoLZ
 kIHjP3M6+oLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="283058734"
Received: from jakubzik-mobl.ger.corp.intel.com (HELO localhost) ([10.252.40.237])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2020 07:47:46 -0700
Date:   Mon, 6 Jul 2020 17:47:44 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Peter.Huewe@infineon.com
Cc:     linux-integrity@vger.kernel.org, kjhall@us.ibm.com,
        ferry.toth@elsinga.info, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, akpm@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200706144744.GB6956@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <e9caad58aba44bb3abeac8569a6bd8ed@infineon.com>
 <20200706140051.GB3816@linux.intel.com>
 <20200706144328.GA6956@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706144328.GA6956@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 06, 2020 at 05:43:35PM +0300, Jarkko Sakkinen wrote:
> On Mon, Jul 06, 2020 at 05:00:51PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jul 06, 2020 at 11:46:46AM +0000, Peter.Huewe@infineon.com wrote:
> > > Hi,
> > > NACK
> > > 
> > > > % git --no-pager grep IFX0102 drivers/char/tpm
> > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
> > > > Obviously IFX0102 was added to the HID table for the TCG TIS driver by mistake.
> > > 
> > > The HID IFX0102 was NOT added by mistake.
> > > Let me explain the history a bit:
> > > 
> > > Old SLB 9635 / 9630 TPMs had two ways to interface them
> > > - proprietary 'io' mapped protocol (tpm_infineon) - tis protocol  (tpm_tis)
> > > 
> > > Both match the same HID.
> > > However with the emerging of the tis protocol, the io protocol eventually went away for newer products.
> > > So all TPM1.2 by IFX match the HID0102 and the TCG generic ones PNP0C31
> > > 
> > > So basically you break TPM1.2 support for all (newer) Infineon chips if the platform vendor used the IFX0102 HID as they would speak via tpm_infineon driver.
> > > The bug must be something different, especially as it only seems to happen after suspend resume.
> > 
> > Peter,
> > 
> > Looking at dmesg:
> > 
> > 1. tmp_infineon initializes cleanly
> > 2. tpm_tis fails misserably with bunch error messages
> > 
> > I'm cool with reverting the patch though. Please send a revert patch and
> > explain this in the commit message because right now what you are saying
> > is completely undocumented.
> > 
> > Also, this tpm_infineon issue needs to be fixed properly after the
> > revert.
> > 
> > The bugzilla bug is unrelated to this issue but it causes extra harm
> > fixing any bugs and confusion among the users as the bug discussions
> > proves.
> > 
> > How do we get the quirks for tpm_tis and tpm_infineon so that they can
> > separate each other?
> 
> Also in the revert commit, please add a comment to tpm_tis.c
> about the existing conflict, e.g.
> 
> /*
>  * Legacy Infineon devices can emit illegit warnings as tpm_tis and
>  * tpm_infineon have a conflicting device ID IFX0102.
>  */
> 
> I'm cool reverting it as long as I get a patch with the required
> premises to do so and proper documentation, because the issue is
> still real.

We do have this kind of thing for MSFT0101 in tpm_tis.c: check_acpi_tpm2().

This is not the root cause for the bugzilla bug, but is a bug itself,
and this kind of behaviour should not exist. It makes fixing real bugs
factors harder when you have drivers putting arbirtrary warnings to
klog.


/Jarkko
