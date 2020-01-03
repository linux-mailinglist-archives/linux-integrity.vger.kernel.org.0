Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1241612FE79
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgACVwM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 16:52:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:46125 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgACVwL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 16:52:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 13:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="421551310"
Received: from hkarray-mobl.ger.corp.intel.com ([10.252.22.101])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jan 2020 13:51:59 -0800
Message-ID: <0d1363c75d3c358817840003b8c6bb97db798990.camel@linux.intel.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 03 Jan 2020 23:51:52 +0200
In-Reply-To: <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
References: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
         <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
         <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
         <20191228151526.GA6971@linux.intel.com>
         <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
         <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
         <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
         <20191231010256.kymv4shwmx5jcmey@cantor>
         <20191231155944.GA4790@linux.intel.com>
         <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
         <20200102171922.GA20989@linux.intel.com>
         <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-02 at 11:20 -0800, Dan Williams wrote:
> On Thu, Jan 2, 2020 at 9:21 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
> > > > Christian, were you having any issues with interrupts? You system was going
> > > > into this code as well.
> > > 
> > > Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
> > > with UEFI firmware and the problem has disappeared. Please let me know if there
> > > is anything else I can do to help.
> > > 
> > > Christian
> > 
> > Takashi wrote yesterday [*]:
> > 
> > "I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
> > patches"
> 
> Nice, I also built one of those. Just waiting for access to the system
> again to gather results.
> 
> > [*] https://bugzilla.kernel.org/show_bug.cgi?id=205935
> > 
> > /Jarkko

Thanks, I'll check this also during weekend once (given the timezone
differences) i.e. if you can provide me result, I can also compose a
pull request during the weekend and send it.

/Jarkko

