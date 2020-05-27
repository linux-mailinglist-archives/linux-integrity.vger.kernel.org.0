Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B41E4EAC
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 21:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgE0T4B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 15:56:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:54808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgE0T4A (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 15:56:00 -0400
IronPort-SDR: OLiFCzD0QNUl3GKHgKPnZYawLoAxjQkm1hMFhbX6hBnRy2CnbLBZ4MbMFPZu2cejM7U6oiSIb5
 yL+nW34FkmQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 12:56:00 -0700
IronPort-SDR: MC8ILC1TC7Qhwe+8pdr6GxO9hKgIuvS2YOS6VReHKjsjVAlr06/UORj6Qi8OHXLPyyzwV8wRNo
 7DrqrPMqwPLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="256854105"
Received: from lkakolx-mobl.ger.corp.intel.com ([10.249.43.73])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2020 12:55:56 -0700
Message-ID: <096698e5493ffe714357b0d6926b900418f71dd0.camel@linux.intel.com>
Subject: Re: [PATCHv3 1/3] optee: do drivers initialization before and after
 tee-supplicant run
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        jens.wiklander@linaro.org, linux-integrity@vger.kernel.org,
        arnd@linaro.org, sumit.garg@linaro.org
Date:   Wed, 27 May 2020 22:55:54 +0300
In-Reply-To: <20200525115235.5405-2-maxim.uvarov@linaro.org>
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
         <20200525115235.5405-2-maxim.uvarov@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-25 at 14:52 +0300, Maxim Uvarov wrote:
> Some drivers (like ftpm) can operate only after tee-supplicant
> runs becase of tee-supplicant provides things like storage
> services.  This patch splits probe of non tee-supplicant dependable
> drivers to early stage, and after tee-supplicant run probe other
> drivers.

Fix the typos and remove extra spaces (one space after '.').

Why "tee-supplicant" and not "TEE-supplicant"?

> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 28 +++++++++++++++++++++++++---
>  drivers/tee/optee/device.c        | 17 +++++++++++------
>  drivers/tee/optee/optee_private.h | 10 +++++++++-
>  3 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 99698b8a3a74..d059e3ac491c 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/workqueue.h>
>  #include "optee_private.h"
>  #include "optee_smc.h"
>  #include "shm_pool.h"
> @@ -218,6 +219,15 @@ static void optee_get_version(struct tee_device *teedev,
>  	*vers = v;
>  }
>  
> +static void optee_bus_scan(struct work_struct *work)
> +{
> +	int rc;
> +
> +	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP);
> +	if (rc)
> +		pr_err("optee_enumerate_devices failed %d\n", rc);
> +}

Is pr_err() required really here? Why not just pr_info()?

Why have it all and not just ftrace when needed? There is series going
on to add CONFIG_FTRACE_FUNC_PROTOTYPE to that to get return values and
arguments.

> +
>  static int optee_open(struct tee_context *ctx)
>  {
>  	struct optee_context_data *ctxdata;
> @@ -241,8 +251,18 @@ static int optee_open(struct tee_context *ctx)
>  			kfree(ctxdata);
>  			return -EBUSY;
>  		}
> -	}
>  
> +		if (!optee->scan_bus_done) {
> +			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> +			optee->scan_bus_wq = create_workqueue("optee_bus_scan");
> +			if (!optee->scan_bus_wq) {
> +				pr_err("optee: couldn't create workqueue\n");

Neither get pr_err() here. Please remove this one completely.

> +				return -ECHILD;
> +			}
> +			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
> +			optee->scan_bus_done = true;
> +		}
> +	}
>  	mutex_init(&ctxdata->mutex);
>  	INIT_LIST_HEAD(&ctxdata->sess_list);
>  
> @@ -296,8 +316,10 @@ static void optee_release(struct tee_context *ctx)
>  
>  	ctx->data = NULL;
>  
> -	if (teedev == optee->supp_teedev)
> +	if (teedev == optee->supp_teedev) {
> +		destroy_workqueue(optee->scan_bus_wq);
>  		optee_supp_release(&optee->supp);
> +	}
>  }
>  
>  static const struct tee_driver_ops optee_ops = {
> @@ -675,7 +697,7 @@ static int optee_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, optee);
>  
> -	rc = optee_enumerate_devices();
> +	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
>  	if (rc) {
>  		optee_remove(pdev);
>  		return rc;
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index e3a148521ec1..d4931dad07aa 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -21,7 +21,6 @@
>   * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
>   * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
>   */
> -#define PTA_CMD_GET_DEVICES		0x0
>  
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  {
> @@ -32,7 +31,8 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  }
>  
>  static int get_devices(struct tee_context *ctx, u32 session,
> -		       struct tee_shm *device_shm, u32 *shm_size)
> +		       struct tee_shm *device_shm, u32 *shm_size,
> +		       u32 func)
>  {
>  	int ret = 0;
>  	struct tee_ioctl_invoke_arg inv_arg;
> @@ -42,7 +42,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
>  	memset(&param, 0, sizeof(param));
>  
>  	/* Invoke PTA_CMD_GET_DEVICES function */
> -	inv_arg.func = PTA_CMD_GET_DEVICES;
> +	inv_arg.func = func;
>  	inv_arg.session = session;
>  	inv_arg.num_params = 4;
>  
> @@ -87,7 +87,7 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
>  	return rc;
>  }
>  
> -int optee_enumerate_devices(void)
> +static int __optee_enumerate_devices(u32 func)
>  {
>  	const uuid_t pta_uuid =
>  		UUID_INIT(0x7011a688, 0xddde, 0x4053,
> @@ -118,7 +118,7 @@ int optee_enumerate_devices(void)
>  		goto out_ctx;
>  	}
>  
> -	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
> +	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size, func);
>  	if (rc < 0 || !shm_size)
>  		goto out_sess;
>  
> @@ -130,7 +130,7 @@ int optee_enumerate_devices(void)
>  		goto out_sess;
>  	}
>  
> -	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
> +	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size, func);
>  	if (rc < 0)
>  		goto out_shm;
>  
> @@ -158,3 +158,8 @@ int optee_enumerate_devices(void)
>  
>  	return rc;
>  }
> +
> +int optee_enumerate_devices(u32 func)
> +{
> +	return  __optee_enumerate_devices(func);
> +}
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index d9c5037b4e03..8b71839a357e 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -78,6 +78,9 @@ struct optee_supp {
>   * @memremaped_shm	virtual address of memory in shared memory pool
>   * @sec_caps:		secure world capabilities defined by
>   *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
> + * @scan_bus_done	flag if device registation was already done.
> + * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
> + * @scan_bus_work	workq to scan optee bus and register optee drivers
>   */
>  struct optee {
>  	struct tee_device *supp_teedev;
> @@ -89,6 +92,9 @@ struct optee {
>  	struct tee_shm_pool *pool;
>  	void *memremaped_shm;
>  	u32 sec_caps;
> +	bool   scan_bus_done;
> +	struct workqueue_struct *scan_bus_wq;
> +	struct work_struct scan_bus_work;
>  };
>  
>  struct optee_session {
> @@ -173,7 +179,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
>  void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
>  			   size_t page_offset);
>  
> -int optee_enumerate_devices(void);
> +#define PTA_CMD_GET_DEVICES		0x0
> +#define PTA_CMD_GET_DEVICES_SUPP	0x1
> +int optee_enumerate_devices(u32 func);
>  
>  /*
>   * Small helpers

No exalanation of "scan bus" neither in the comments nor in the code.

/Jarkko

