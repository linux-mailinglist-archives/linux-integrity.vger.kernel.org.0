Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A152C1C32
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Nov 2020 04:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgKXDqL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 22:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKXDqK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 22:46:10 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F072720857;
        Tue, 24 Nov 2020 03:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606189569;
        bh=RSXTf9SubKcd85uMsg6Gbq1+/EGRW74DKmlEXBxEEbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiYq5Rlx74PZztgXDLzdCzbhSdvsCj6d6r+v53pxUGZJllBF0QLIYt+ru+pX6DvLh
         MnSHyM7QtVBnG3E89ms6+F6rFma9uyuNCigE6xkzlt5xJwPW0VB8tJZn9PHIbZckz4
         XVHpybvgYZoa3WYB/bH/Jf+5bTy6NpBv9gC6GRUI=
Date:   Tue, 24 Nov 2020 05:46:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com, dhowells@redhat.com, jens.wiklander@linaro.org,
        corbet@lwn.net, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Message-ID: <20201124034601.GB40379@kernel.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
> 
> Refer to Documentation/tee.txt for detailed information about TEE.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/keys/trusted_tee.h                |  55 ++++++
>  security/keys/trusted-keys/Makefile       |   1 +
>  security/keys/trusted-keys/trusted_core.c |   4 +
>  security/keys/trusted-keys/trusted_tee.c  | 278 ++++++++++++++++++++++++++++++
>  4 files changed, 338 insertions(+)
>  create mode 100644 include/keys/trusted_tee.h
>  create mode 100644 security/keys/trusted-keys/trusted_tee.c
> 
> diff --git a/include/keys/trusted_tee.h b/include/keys/trusted_tee.h
> new file mode 100644
> index 0000000..2e2bb15
> --- /dev/null
> +++ b/include/keys/trusted_tee.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019-2020 Linaro Ltd.
> + *
> + * Author:
> + * Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#ifndef __TEE_TRUSTED_KEY_H
> +#define __TEE_TRUSTED_KEY_H
> +
> +#include <linux/tee_drv.h>
> +
> +#define DRIVER_NAME "tee-trusted-key"
> +
> +/*
> + * Get random data for symmetric key
> + *
> + * [out]     memref[0]        Random data
> + */
> +#define TA_CMD_GET_RANDOM	0x0
> +
> +/*
> + * Seal trusted key using hardware unique key
> + *
> + * [in]      memref[0]        Plain key
> + * [out]     memref[1]        Sealed key datablob
> + */
> +#define TA_CMD_SEAL		0x1
> +
> +/*
> + * Unseal trusted key using hardware unique key
> + *
> + * [in]      memref[0]        Sealed key datablob
> + * [out]     memref[1]        Plain key
> + */
> +#define TA_CMD_UNSEAL		0x2
> +
> +/**
> + * struct trusted_key_private - TEE Trusted key private data
> + * @dev:		TEE based Trusted key device.
> + * @ctx:		TEE context handler.
> + * @session_id:		Trusted key TA session identifier.
> + * @shm_pool:		Memory pool shared with TEE device.
> + */
> +struct trusted_key_private {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	u32 session_id;
> +	struct tee_shm *shm_pool;
> +};
> +
> +extern struct trusted_key_ops tee_trusted_key_ops;
> +
> +#endif
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
> index 49e3bcf..012dd78 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
>  trusted-y += trusted_core.o
>  trusted-y += trusted_tpm1.o
>  trusted-y += trusted_tpm2.o
> +trusted-y += trusted_tee.o
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index aa4f2a0..15b1b0f3 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -8,6 +8,7 @@
>  
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
> +#include <keys/trusted_tee.h>
>  #include <keys/trusted_tpm.h>
>  #include <linux/capability.h>
>  #include <linux/err.h>
> @@ -29,6 +30,9 @@ static const struct trusted_key_source trusted_key_sources[] = {
>  #if defined(CONFIG_TCG_TPM)
>  	{ "tpm", &tpm_trusted_key_ops },
>  #endif
> +#if defined(CONFIG_TEE)
> +	{ "tee", &tee_trusted_key_ops },
> +#endif
>  };
>  
>  DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> new file mode 100644
> index 0000000..da8785a
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2020 Linaro Ltd.
> + *
> + * Author:
> + * Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/key-type.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/uuid.h>
> +
> +#include <keys/trusted-type.h>
> +#include <keys/trusted_tee.h>
> +
> +static struct trusted_key_private pvt_data;
> +
> +/*
> + * Have the TEE seal(encrypt) the symmetric key
> + */
> +static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
> +{
> +	int ret;
> +	struct tee_ioctl_invoke_arg inv_arg;
> +	struct tee_param param[4];
> +	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> +				      p->key_len, TEE_SHM_DMA_BUF |
> +				      TEE_SHM_KERNEL_MAPPED);
> +	if (IS_ERR(reg_shm_in)) {
> +		dev_err(pvt_data.dev, "key shm register failed\n");
> +		return PTR_ERR(reg_shm_in);
> +	}
> +
> +	reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
> +				       sizeof(p->blob), TEE_SHM_DMA_BUF |
> +				       TEE_SHM_KERNEL_MAPPED);
> +	if (IS_ERR(reg_shm_out)) {
> +		dev_err(pvt_data.dev, "blob shm register failed\n");
> +		ret = PTR_ERR(reg_shm_out);
> +		goto out;
> +	}
> +
> +	inv_arg.func = TA_CMD_SEAL;
> +	inv_arg.session = pvt_data.session_id;
> +	inv_arg.num_params = 4;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> +	param[0].u.memref.shm = reg_shm_in;
> +	param[0].u.memref.size = p->key_len;
> +	param[0].u.memref.shm_offs = 0;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +	param[1].u.memref.shm = reg_shm_out;
> +	param[1].u.memref.size = sizeof(p->blob);
> +	param[1].u.memref.shm_offs = 0;
> +
> +	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> +	if ((ret < 0) || (inv_arg.ret != 0)) {
> +		dev_err(pvt_data.dev, "TA_CMD_SEAL invoke err: %x\n",
> +			inv_arg.ret);
> +		ret = -EFAULT;
> +	} else {
> +		p->blob_len = param[1].u.memref.size;
> +	}
> +
> +out:
> +	if (reg_shm_out)
> +		tee_shm_free(reg_shm_out);
> +	if (reg_shm_in)
> +		tee_shm_free(reg_shm_in);
> +
> +	return ret;
> +}
> +
> +/*
> + * Have the TEE unseal(decrypt) the symmetric key
> + */
> +static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
> +{
> +	int ret;
> +	struct tee_ioctl_invoke_arg inv_arg;
> +	struct tee_param param[4];
> +	struct tee_shm *reg_shm_in = NULL, *reg_shm_out = NULL;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
> +				      p->blob_len, TEE_SHM_DMA_BUF |
> +				      TEE_SHM_KERNEL_MAPPED);
> +	if (IS_ERR(reg_shm_in)) {
> +		dev_err(pvt_data.dev, "blob shm register failed\n");
> +		return PTR_ERR(reg_shm_in);
> +	}
> +
> +	reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> +				       sizeof(p->key), TEE_SHM_DMA_BUF |
> +				       TEE_SHM_KERNEL_MAPPED);
> +	if (IS_ERR(reg_shm_out)) {
> +		dev_err(pvt_data.dev, "key shm register failed\n");
> +		ret = PTR_ERR(reg_shm_out);
> +		goto out;
> +	}
> +
> +	inv_arg.func = TA_CMD_UNSEAL;
> +	inv_arg.session = pvt_data.session_id;
> +	inv_arg.num_params = 4;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> +	param[0].u.memref.shm = reg_shm_in;
> +	param[0].u.memref.size = p->blob_len;
> +	param[0].u.memref.shm_offs = 0;
> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +	param[1].u.memref.shm = reg_shm_out;
> +	param[1].u.memref.size = sizeof(p->key);
> +	param[1].u.memref.shm_offs = 0;
> +
> +	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> +	if ((ret < 0) || (inv_arg.ret != 0)) {
> +		dev_err(pvt_data.dev, "TA_CMD_UNSEAL invoke err: %x\n",
> +			inv_arg.ret);
> +		ret = -EFAULT;
> +	} else {
> +		p->key_len = param[1].u.memref.size;
> +	}
> +
> +out:
> +	if (reg_shm_out)
> +		tee_shm_free(reg_shm_out);
> +	if (reg_shm_in)
> +		tee_shm_free(reg_shm_in);
> +
> +	return ret;
> +}
> +
> +/*
> + * Have the TEE generate random symmetric key
> + */
> +static int trusted_tee_get_random(unsigned char *key, size_t key_len)
> +{
> +	int ret;
> +	struct tee_ioctl_invoke_arg inv_arg;
> +	struct tee_param param[4];
> +	struct tee_shm *reg_shm = NULL;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	reg_shm = tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
> +				   TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> +	if (IS_ERR(reg_shm)) {
> +		dev_err(pvt_data.dev, "key shm register failed\n");
> +		return PTR_ERR(reg_shm);
> +	}
> +
> +	inv_arg.func = TA_CMD_GET_RANDOM;
> +	inv_arg.session = pvt_data.session_id;
> +	inv_arg.num_params = 4;
> +
> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +	param[0].u.memref.shm = reg_shm;
> +	param[0].u.memref.size = key_len;
> +	param[0].u.memref.shm_offs = 0;
> +
> +	ret = tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> +	if ((ret < 0) || (inv_arg.ret != 0)) {
> +		dev_err(pvt_data.dev, "TA_CMD_GET_RANDOM invoke err: %x\n",
> +			inv_arg.ret);
> +		ret = -EFAULT;
> +	} else {
> +		ret = param[0].u.memref.size;
> +	}
> +
> +	tee_shm_free(reg_shm);
> +
> +	return ret;
> +}
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int trusted_key_probe(struct device *dev)
> +{
> +	struct tee_client_device *rng_device = to_tee_client_device(dev);
> +	int ret;
> +	struct tee_ioctl_open_session_arg sess_arg;
> +
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +
> +	pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
> +					       NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;
> +
> +	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> +	sess_arg.num_params = 0;
> +
> +	ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> +	if ((ret < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		ret = -EINVAL;
> +		goto out_ctx;
> +	}
> +	pvt_data.session_id = sess_arg.session;
> +
> +	ret = register_key_type(&key_type_trusted);
> +	if (ret < 0)
> +		goto out_sess;
> +
> +	pvt_data.dev = dev;
> +
> +	return 0;
> +
> +out_sess:
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> +out_ctx:
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return ret;
> +}
> +
> +static int trusted_key_remove(struct device *dev)
> +{
> +	unregister_key_type(&key_type_trusted);
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return 0;
> +}
> +
> +static const struct tee_client_device_id trusted_key_id_table[] = {
> +	{UUID_INIT(0xf04a0fe7, 0x1f5d, 0x4b9b,
> +		   0xab, 0xf7, 0x61, 0x9b, 0x85, 0xb4, 0xce, 0x8c)},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
> +
> +static struct tee_client_driver trusted_key_driver = {
> +	.id_table	= trusted_key_id_table,
> +	.driver		= {
> +		.name		= DRIVER_NAME,
> +		.bus		= &tee_bus_type,
> +		.probe		= trusted_key_probe,
> +		.remove		= trusted_key_remove,
> +	},
> +};
> +
> +static int trusted_tee_init(void)
> +{
> +	return driver_register(&trusted_key_driver.driver);
> +}
> +
> +static void trusted_tee_exit(void)
> +{
> +	driver_unregister(&trusted_key_driver.driver);
> +}
> +
> +struct trusted_key_ops tee_trusted_key_ops = {


Nit: trusted_key_tee_ops

> +	.migratable = 0, /* non-migratable */
> +	.init = trusted_tee_init,
> +	.seal = trusted_tee_seal,
> +	.unseal = trusted_tee_unseal,
> +	.get_random = trusted_tee_get_random,
> +	.exit = trusted_tee_exit,
> +};
> -- 
> 2.7.4
> 
> 
/Jarkko
