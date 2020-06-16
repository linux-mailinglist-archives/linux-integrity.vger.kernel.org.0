Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED461FBFC5
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgFPUPX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 16:15:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:29391 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbgFPUPW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 16:15:22 -0400
IronPort-SDR: ro/oPz5sfyYuL1jgtLaBvYJ3STGcZcfYLP828TODfAiJQAgf47KXB3SdoP0WHwLoOCTpbPvqB5
 N+9gyyduBLeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 13:15:22 -0700
IronPort-SDR: zO86BPN8dVZzX2AotBiXjLH8J1RX/cKdcwl78D/SOYO2HKS/TQ44iSrP4wLU+02s8jtfis94Mu
 rCFFsjpeKCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,519,1583222400"; 
   d="scan'208";a="299035233"
Received: from gosinald-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.36.106])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2020 13:15:17 -0700
Date:   Tue, 16 Jun 2020 23:15:16 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Subject: Re: [PATCHv6 1/3] optee: use uuid for sysfs driver entry
Message-ID: <20200616201516.GF10412@linux.intel.com>
References: <20200601150645.13412-1-maxim.uvarov@linaro.org>
 <20200601150645.13412-2-maxim.uvarov@linaro.org>
 <20200604083655.GA4026@linux.intel.com>
 <CAFA6WYMZx9goq4+yNH5UtrO-nO+R9ohE1dH6jTvKwvME+kKwoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMZx9goq4+yNH5UtrO-nO+R9ohE1dH6jTvKwvME+kKwoQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 04, 2020 at 02:51:03PM +0530, Sumit Garg wrote:
> On Thu, 4 Jun 2020 at 14:07, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Mon, Jun 01, 2020 at 06:06:43PM +0300, Maxim Uvarov wrote:
> > > With the evolving use-cases for TEE bus, now it's required to support
> > > multi-stage enumeration process. But using a simple index doesn't
> > > suffice this requirement and instead leads to duplicate sysfs entries.
> > > So instead switch to use more informative device UUID for sysfs entry
> > > like:
> > > /sys/bus/tee/devices/optee-ta-<uuid>
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Why do you mean by duplicate sysfs entries?
> >
> 
> It's just about the device being added with the same name as of the
> device which is already present on the TEE bus. So this leads to
> duplicate sysfs entry error for device node which is created during
> device_register() execution flow.
> 
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> > >  MAINTAINERS                                       | 1 +
> > >  drivers/tee/optee/device.c                        | 6 +++---
> > >  3 files changed, 12 insertions(+), 3 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > > new file mode 100644
> > > index 000000000000..0ae04ae5374a
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> > > @@ -0,0 +1,8 @@
> > > +What:                /sys/bus/tee/devices/optee-ta-<uuid>/
> > > +Date:           May 2020
> > > +KernelVersion   5.7
> > > +Contact:        tee-dev@lists.linaro.org
> > > +Description:
> > > +             OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> > > +             matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> > > +             are free to create needed API under optee-ta-<uuid> directory.
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ecc0749810b0..6717afef2de3 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> > >  M:   Jens Wiklander <jens.wiklander@linaro.org>
> > >  L:   tee-dev@lists.linaro.org
> > >  S:   Maintained
> > > +F:   Documentation/ABI/testing/sysfs-bus-optee-devices
> > >  F:   drivers/tee/optee/
> > >
> > >  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> > > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > > index e3a148521ec1..ed3d1ddfa52b 100644
> > > --- a/drivers/tee/optee/device.c
> > > +++ b/drivers/tee/optee/device.c
> > > @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> > >       return 0;
> > >  }
> > >
> > > -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > > +static int optee_register_device(const uuid_t *device_uuid)
> > >  {
> > >       struct tee_client_device *optee_device = NULL;
> > >       int rc;
> > > @@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> > >               return -ENOMEM;
> > >
> > >       optee_device->dev.bus = &tee_bus_type;
> > > -     dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> > > +     dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);
> >
> > This code is and already was broken. If dev_set_name() returns -ENOMEM,
> > the name will be a null pointer.
> 
> Is this an expected error scenario? dev_set_name() is invoked at
> numerous places in the kernel without any error check.
> 
> >
> > Also, I don't get how you can just swap the name without potentially
> > breaking the backwards compatiblity towards the user space.
> 
> As of now, there isn't any compatibility concerns with user space as
> these TEE devices are meant to be used by kernel drivers only. TEE
> user-space interface is quite separate (see: Documentation/tee.txt).

OK, probably would make sense to have this in the commit message as a
remark.

/Jarkko
