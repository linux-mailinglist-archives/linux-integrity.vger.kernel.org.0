Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50912FEF6
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 23:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgACW40 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 17:56:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:13800 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgACW40 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 17:56:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 14:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="420143466"
Received: from hkarray-mobl.ger.corp.intel.com ([10.252.22.101])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2020 14:56:21 -0800
Message-ID: <d9bfe857cdde1ad041792c7d7586fcc5a8031b3a.camel@linux.intel.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Jan 2020 00:56:20 +0200
In-Reply-To: <20200103202458.lhd5qu2onl67kilb@cantor>
References: <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
         <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
         <20191228151526.GA6971@linux.intel.com>
         <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
         <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
         <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
         <20191231010256.kymv4shwmx5jcmey@cantor>
         <20191231155944.GA4790@linux.intel.com>
         <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
         <20200102171922.GA20989@linux.intel.com>
         <20200103202458.lhd5qu2onl67kilb@cantor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-03 at 13:24 -0700, Jerry Snitselaar wrote:
> On Thu Jan 02 20, Jarkko Sakkinen wrote:
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
> > 
> > [*] https://bugzilla.kernel.org/show_bug.cgi?id=205935
> > 
> > /Jarkko
> > 
> 
> You can add my ack to the reverts.

OK, will do. Thanks.

/Jarkko

