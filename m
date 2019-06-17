Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5A4893C
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFQQsN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 12:48:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:21781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfFQQsN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 12:48:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 09:38:44 -0700
X-ExtLoop1: 1
Received: from rameshr1-mobl.gar.corp.intel.com (HELO localhost) ([10.252.60.156])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2019 09:38:42 -0700
Date:   Mon, 17 Jun 2019 19:38:36 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/8] tpm: block messages while suspended
Message-ID: <20190617163810.GA9427@linux.intel.com>
References: <20190613180931.65445-1-swboyd@chromium.org>
 <20190613180931.65445-2-swboyd@chromium.org>
 <20190614152700.GE11241@linux.intel.com>
 <5d03e3ba.1c69fb81.9c2c8.aa89@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d03e3ba.1c69fb81.9c2c8.aa89@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 14, 2019 at 11:13:13AM -0700, Stephen Boyd wrote:
> Quoting Jarkko Sakkinen (2019-06-14 08:27:00)
> > On Thu, Jun 13, 2019 at 11:09:24AM -0700, Stephen Boyd wrote:
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index 1b5436b213a2..48df005228d0 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -132,6 +132,8 @@ struct tpm_chip {
> > >       int dev_num;            /* /dev/tpm# */
> > >       unsigned long is_open;  /* only one allowed */
> > >  
> > > +     unsigned long is_suspended;
> > > +
> > >       char hwrng_name[64];
> > >       struct hwrng hwrng;
> > 
> > I think it would better idea to have a bitmask of some sort that
> > would have bits for 'open' and 'suspended'.
> > 
> 
> Sure. I can combine is_open and is_suspended into some sort of 'unsigned
> long flags' member and then have #define TPM_IS_OPEN 0 and #define
> TPM_IS_SUSPENDED 1 defines?

Sounds sustainable.

/Jarkko
