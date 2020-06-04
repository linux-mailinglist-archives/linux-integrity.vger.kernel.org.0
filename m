Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736611EDFDF
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgFDIhC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 04:37:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:38350 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgFDIhC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 04:37:02 -0400
IronPort-SDR: MGUUjyyv7ep65Qdb6engGOCSdxNSz9nTQ+2KVkNzuMXePHa0oaNJrLG2yu5F41xSb7zI5PNFVs
 Nbvz03AokKJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 01:37:02 -0700
IronPort-SDR: umU7JkR4go6XKX3rFPKdOm7SYTj7s6zF0R9Nn5IBO+OgexTgplino9hflqMrIn8M2JM7rBUdET
 66B540yDxkew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="304646950"
Received: from alachman-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.44.241])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2020 01:36:56 -0700
Date:   Thu, 4 Jun 2020 11:36:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Subject: Re: [PATCHv6 1/3] optee: use uuid for sysfs driver entry
Message-ID: <20200604083655.GA4026@linux.intel.com>
References: <20200601150645.13412-1-maxim.uvarov@linaro.org>
 <20200601150645.13412-2-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601150645.13412-2-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 01, 2020 at 06:06:43PM +0300, Maxim Uvarov wrote:
> With the evolving use-cases for TEE bus, now it's required to support
> multi-stage enumeration process. But using a simple index doesn't
> suffice this requirement and instead leads to duplicate sysfs entries.
> So instead switch to use more informative device UUID for sysfs entry
> like:
> /sys/bus/tee/devices/optee-ta-<uuid>
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Why do you mean by duplicate sysfs entries?

> ---
>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
>  MAINTAINERS                                       | 1 +
>  drivers/tee/optee/device.c                        | 6 +++---
>  3 files changed, 12 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> new file mode 100644
> index 000000000000..0ae04ae5374a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -0,0 +1,8 @@
> +What:		/sys/bus/tee/devices/optee-ta-<uuid>/
> +Date:           May 2020
> +KernelVersion   5.7
> +Contact:        tee-dev@lists.linaro.org
> +Description:
> +		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> +		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> +		are free to create needed API under optee-ta-<uuid> directory.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc0749810b0..6717afef2de3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
>  M:	Jens Wiklander <jens.wiklander@linaro.org>
>  L:	tee-dev@lists.linaro.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:	drivers/tee/optee/
>  
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index e3a148521ec1..ed3d1ddfa52b 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>  	return 0;
>  }
>  
> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> +static int optee_register_device(const uuid_t *device_uuid)
>  {
>  	struct tee_client_device *optee_device = NULL;
>  	int rc;
> @@ -75,7 +75,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>  		return -ENOMEM;
>  
>  	optee_device->dev.bus = &tee_bus_type;
> -	dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> +	dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid);

This code is and already was broken. If dev_set_name() returns -ENOMEM,
the name will be a null pointer.

Also, I don't get how you can just swap the name without potentially
breaking the backwards compatiblity towards the user space.

/Jarkko
