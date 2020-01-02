Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D924D12E939
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jan 2020 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgABRU7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 12:20:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:20085 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgABRU7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 12:20:59 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 09:20:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,387,1571727600"; 
   d="scan'208";a="216043280"
Received: from krominsx-mobl.ger.corp.intel.com (HELO localhost) ([10.252.21.64])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jan 2020 09:20:55 -0800
Date:   Thu, 2 Jan 2020 19:20:53 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Christian Bundy <christianbundy@fraction.io>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20200102171922.GA20989@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
> > Christian, were you having any issues with interrupts? You system was going
> > into this code as well.
> 
> Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
> with UEFI firmware and the problem has disappeared. Please let me know if there
> is anything else I can do to help.
> 
> Christian

Takashi wrote yesterday [*]:

"I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
patches"

[*] https://bugzilla.kernel.org/show_bug.cgi?id=205935

/Jarkko
