Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF07812BDDE
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Dec 2019 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfL1PPb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 28 Dec 2019 10:15:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:50203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1PPb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 28 Dec 2019 10:15:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2019 07:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,367,1571727600"; 
   d="scan'208";a="269297741"
Received: from agrennax-mobl.ger.corp.intel.com (HELO localhost) ([10.251.86.43])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Dec 2019 07:15:27 -0800
Date:   Sat, 28 Dec 2019 17:15:26 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20191228151526.GA6971@linux.intel.com>
References: <1577122577157232@kroah.com>
 <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> Dan, please also test the branch and tell if other patches are needed.
> I'm a bit blind with this as I don't have direct access to the faulting
> hardware. Thanks. [*]
> 
> [*] https://lkml.org/lkml/2019/12/27/12

Given that:

1. I cannot reproduce the bug locally.
2. Neither of the patches have any appropriate tags (tested-by and
   reviewed-by). [*]

I'm sorry but how am I expected to include these patches?

[*] https://patchwork.kernel.org/project/linux-integrity/list/?series=208305

/Jarkko
