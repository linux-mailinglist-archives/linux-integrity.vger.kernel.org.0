Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F091FD9AE
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 01:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQXiA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 19:38:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:7144 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgFQXiA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 19:38:00 -0400
IronPort-SDR: BBFZnbB5vBg1oliEtwKNsC01vHmy1P8e7BXT0FwAA+t1Xn6I34tw83bZVbyZ0dJK9f4LlUjYsf
 n2kZx+EMTwMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 16:38:00 -0700
IronPort-SDR: 9udcIeQ/AhDiQtSp6pKpzPBRgYHEH9Bg1XRnHRe1czU/QLTfHe4bsebxkhmxjEdol1AMF07O9l
 ifiG6TUrVHNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="317669933"
Received: from kleeve-mobl.ger.corp.intel.com (HELO localhost) ([10.252.50.166])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 16:37:56 -0700
Date:   Thu, 18 Jun 2020 02:37:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200617233755.GI62794@linux.intel.com>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616082907.GA2305431@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616082907.GA2305431@jade>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 16, 2020 at 10:29:07AM +0200, Jens Wiklander wrote:
> Hi Maxim and Jarkko,
> 
> On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > ping.
> > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > were merged. These kernel patches look like they are hanging
> > somewhere...
> 
> I'm almost OK with this patchset, except that
> Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
> for the new kernel version and TEE mailing list which we're changing right
> now.
> 
> The last patch touches files I'm not maintainer of. That patch depends
> on the previous patches so it makes sense to keep them together.  If a
> TPM device driver maintainer would ack that patch I can take it via my
> tree. Or we can do it the other way around (with a v9 patchset),
> whichever is preferred.
> 
> Cheers,
> Jens

Probably easier if you pick all three and I ack the one touching TPM.

/Jarkko
