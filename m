Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5815751B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2019 01:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFZX5B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jun 2019 19:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfFZX5B (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jun 2019 19:57:01 -0400
Received: from localhost (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87CB820815;
        Wed, 26 Jun 2019 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561593418;
        bh=51GE/F0ZL1080kWax5gOMUrLxFYoaOqZOI0eWpX9URw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnsIPnXW08fnGx8sS6b6iFVFEjyoHg3cfRNS0h8i17gbVh+CzI1Uz8JGzoP2O/lGE
         CyS4OO5L5vgC6cnzMcjtzwgIyDeIWSXCdPgH0Ii8vMscVY+iym9GIgR56rg3jNH4Dt
         GYilr8o3C4C7sgWPP0B7h3S2jlqcisW4/vSF4tZI=
Date:   Wed, 26 Jun 2019 19:56:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190626235653.GL7898@sasha-vm>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 27, 2019 at 02:31:35AM +0300, Jarkko Sakkinen wrote:
>On Tue, 2019-06-25 at 16:13 -0400, Sasha Levin wrote:
>> This patch adds support for a software-only implementation of a TPM
>> running in TEE.
>>
>> There is extensive documentation of the design here:
>>
>https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/
>> .
>>
>> As well as reference code for the firmware available here:
>>
>https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM
>>
>> Tested-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
>> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>You've used so much on this so shouldn't this have that somewhat new
>co-developed-by tag? I'm also wondering can this work at all

Honestly, I've just been massaging this patch more than "authoring" it.
If you feel strongly about it feel free to add a Co-authored patch with
my name, but in my mind this is just Thiru's work.

>process-wise if the original author of the patch is also the only tester
>of the patch?

There's not much we can do about this... Linaro folks have tested this
without the fTPM firmware, so at the very least it won't explode for
everyone. If for some reason non-microsoft folks see issues then we can
submit patches on top to fix this, we're not just throwing this at you
and running away.

>> ---
>>  drivers/char/tpm/Kconfig        |   5 +
>>  drivers/char/tpm/Makefile       |   1 +
>>  drivers/char/tpm/tpm_ftpm_tee.c | 356 ++++++++++++++++++++++++++++++++
>>  drivers/char/tpm/tpm_ftpm_tee.h |  40 ++++
>>  4 files changed, 402 insertions(+)
>>  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
>>  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 88a3c06fc153..17bfbf9f572f 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -164,6 +164,11 @@ config TCG_VTPM_PROXY
>>  	  /dev/vtpmX and a server-side file descriptor on which the vTPM
>>  	  can receive commands.
>>
>> +config TCG_FTPM_TEE
>> +	tristate "TEE based fTPM Interface"
>> +	depends on TEE && OPTEE
>> +	---help---
>> +	  This driver proxies for firmware TPM running in TEE.
>>
>>  source "drivers/char/tpm/st33zp24/Kconfig"
>>  endif # TCG_TPM
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index a01c4cab902a..c354cdff9c62 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -33,3 +33,4 @@ obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
>>  obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>> +obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
>> new file mode 100644
>> index 000000000000..0312c10767bd
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
>> @@ -0,0 +1,356 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) Microsoft Corporation
>
>The statement does not contain the years. I'm also wondering in more
>generic sense that with Git, which in its inner structure contains all
>the metadata to deriving this type of information, is this more like a
>legacy thing or why should be put these statements to new files?

There is a significant amount of newly added 2019 copyright tags in the
kernel, and this is just following suit.

>> + *
>> + * Implements a firmware TPM as described here:
>> + *
>>
>https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/
>> + *
>> + * A reference implementation is available here:
>> + *
>>
>https://github.com/microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/tee_drv.h>
>> +#include <linux/tpm.h>
>> +#include <linux/uuid.h>
>> +
>> +#include "tpm.h"
>> +#include "tpm_ftpm_tee.h"
>> +
>> +#define DRIVER_NAME "ftpm-tee"
>
>Should be open coded where it is used because this does not bring any
>practical value.

Good point, this was used more with debug statements that were sprinkled
around, but not anymore.

>> +
>> +/*
>> + * TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896
>> + *
>> + * Randomly generated, and must correspond to the GUID on the TA side.
>> + * Defined here in the reference implementation:
>> + *
>>
>https://github.com/microsoft/ms-tpm-20-ref/blob/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/include/fTPM.h#L42
>> + */
>> +
>
>Probably should delete this empty line.
>
>> +static const uuid_t ftpm_ta_uuid =
>> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
>> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
>> +
>> +/**
>> + * ftpm_tee_tpm_op_recv - retrieve fTPM response.
>> + *
>
>Should not have an empty line here.

Really? The rest of the kdoc comments under drivers/char/tpm/ have an
empty line after function name.

I've looked at tpm_crb.c which you authored for reference.

>> + * @chip: the tpm_chip description as specified in driver/char/tpm/tpm.h.
>> + * @buf: the buffer to store data.
>> + * @count: the number of bytes to read.
>
>Should be aligned with a tab character.

I'll address this throughout the comments in the file.

>> + *
>> + * Return:
>> + * 	In case of success the number of bytes received.
>> + *	On failure, -errno.
>> + */
>> +static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>> +{
>> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +	size_t len;
>> +
>> +	len = pvt_data->resp_len;
>> +	if (count < len) {
>> +		dev_err(&chip->dev,
>> +			"%s:Invalid size in recv: count=%zd, resp_len=%zd\n",
>                            ^ a single white space also here
>
>> +			__func__, count, len);
>> +		return -EIO;
>> +	}
>> +
>> +	memcpy(buf, pvt_data->resp_buf, len);
>> +	pvt_data->resp_len = 0;
>> +
>> +	return len;
>> +}
>> +
>> +/**
>> + * ftpm_tee_tpm_op_send - send TPM commands through the TEE shared memory.
>> + *
>
>Should not have an empty line here.
>
>> + * @chip: the tpm_chip description as specified in driver/char/tpm/tpm.h
>> + * @buf: the buffer to send.
>> + * @len: the number of bytes to send.
>
>Should be aligned with a tab character.
>
>> + *
>> + * Return:
>> + * 	In case of success, returns 0.
>> + *	On failure, -errno
>> + */
>> +static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
>> +{
>> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +	size_t resp_len;
>> +	int rc;
>> +	u8 *temp_buf;
>> +	struct tpm_header *resp_header;
>> +	struct tee_ioctl_invoke_arg transceive_args;
>> +	struct tee_param command_params[4];
>> +	struct tee_shm *shm = pvt_data->shm;
>> +
>> +	if (len > MAX_COMMAND_SIZE) {
>> +		dev_err(&chip->dev,
>> +			"%s:len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM
>                            ^ a single white space also here
>
>> TA\n",
>> +			__func__, len);
>> +		return -EIO;
>> +	}
>> +
>> +	memset(&transceive_args, 0, sizeof(transceive_args));
>> +	memset(command_params, 0, sizeof(command_params));
>> +	pvt_data->resp_len = 0;
>> +
>> +	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
>> +	transceive_args = (struct tee_ioctl_invoke_arg) {
>> +		.func = FTPM_OPTEE_TA_SUBMIT_COMMAND,
>> +		.session = pvt_data->session,
>> +		.num_params = 4,
>> +	};
>> +
>> +	/* Fill FTPM_OPTEE_TA_SUBMIT_COMMAND parameters */
>> +	command_params[0] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>> +		.u.memref = {
>> +			.shm = shm,
>> +			.size = len,
>> +			.shm_offs = 0,
>> +		},
>> +	};
>> +
>> +	temp_buf = tee_shm_get_va(shm, 0);
>> +	if (IS_ERR(temp_buf)) {
>> +		dev_err(&chip->dev, "%s:tee_shm_get_va failed for transmit\n",
>                                        ^ a single white space also here
>
>> +			__func__);
>> +		return PTR_ERR(temp_buf);
>> +	}
>> +	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
>> +
>> +	memcpy(temp_buf, buf, len);
>
>How about:
>
>	}
>
>	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
>	memcpy(temp_buf, buf, len);
>
>Just looked a bit dirty how the stuff was grouped.

Makes sense.

>> +
>> +	command_params[1] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
>> +		.u.memref = {
>> +			.shm = shm,
>> +			.size = MAX_RESPONSE_SIZE,
>> +			.shm_offs = MAX_COMMAND_SIZE,
>> +		},
>> +	};
>> +
>> +	rc = tee_client_invoke_func(pvt_data->ctx, &transceive_args,
>> +					command_params);
>
>Aligment is not right in the 2nd like?
>
>> +	if ((rc < 0) || (transceive_args.ret != 0)) {
>> +		dev_err(&chip->dev, "%s:SUBMIT_COMMAND invoke error: 0x%x\n",
>
>The white space char again...
>
>> +			__func__, transceive_args.ret);
>> +		return (rc < 0) ? rc : transceive_args.ret;
>> +	}
>> +
>> +	temp_buf = tee_shm_get_va(shm, command_params[1].u.memref.shm_offs);
>> +	if (IS_ERR(temp_buf)) {
>> +		dev_err(&chip->dev, "%s:tee_shm_get_va failed for receive\n",
>> +			__func__);
>> +		return PTR_ERR(temp_buf);
>> +	}
>> +
>> +	resp_header = (struct tpm_header *)temp_buf;
>> +	resp_len = be32_to_cpu(resp_header->length);
>> +
>> +	/* sanity check resp_len */
>> +	if (resp_len < TPM_HEADER_SIZE) {
>> +		dev_err(&chip->dev, "%s:tpm response header too small\n",
>> +			__func__);
>> +		return -EIO;
>> +	}
>> +	if (resp_len > MAX_RESPONSE_SIZE) {
>> +		dev_err(&chip->dev,
>> +			"%s:resp_len=%zd exceeds MAX_RESPONSE_SIZE\n",
>> +			__func__, resp_len);
>> +		return -EIO;
>> +	}
>> +
>> +	/* sanity checks look good, cache the response */
>> +	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
>> +	pvt_data->resp_len = resp_len;
>> +
>> +	return 0;
>> +}
>> +
>> +static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
>> +{
>> +	/* not supported */
>> +}
>> +
>> +static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
>> +{
>> +	return 0;
>> +}
>> +
>> +static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
>> +{
>> +	return 0;
>> +}
>> +
>> +static const struct tpm_class_ops ftpm_tee_tpm_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.recv = ftpm_tee_tpm_op_recv,
>> +	.send = ftpm_tee_tpm_op_send,
>> +	.cancel = ftpm_tee_tpm_op_cancel,
>> +	.status = ftpm_tee_tpm_op_status,
>> +	.req_complete_mask = 0,
>> +	.req_complete_val = 0,
>> +	.req_canceled = ftpm_tee_tpm_req_canceled,
>> +};
>> +
>> +/*
>> + * Check whether this driver supports the fTPM TA in the TEE instance
>> + * represented by the params (ver/data) to this function.
>> + */
>> +static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void
>> *data)
>> +{
>> +	/*
>> +	 * Currently this driver only support GP Complaint OPTEE based fTPM TA
>> +	 */
>> +	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
>> +		(ver->gen_caps & TEE_GEN_CAP_GP))
>> +		return 1;
>> +	else
>> +		return 0;
>> +}
>> +
>> +/**
>> + * ftpm_tee_probe - initialize the fTPM
>> + * @pdev: the platform_device description.
>> + *
>> + * Return:
>> + * 	On success, 0. On failure, -errno.
>> + */
>> +static int ftpm_tee_probe(struct platform_device *pdev)
>> +{
>> +	int rc;
>> +	struct tpm_chip *chip;
>> +	struct device *dev = &pdev->dev;
>> +	struct ftpm_tee_private *pvt_data = NULL;
>> +	struct tee_ioctl_open_session_arg sess_arg;
>> +
>> +	pvt_data = devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
>> +				GFP_KERNEL);
>> +	if (!pvt_data)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, pvt_data);
>> +
>> +	/* Open context with TEE driver */
>> +	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
>> +						NULL);
>> +	if (IS_ERR(pvt_data->ctx)) {
>> +		if (ERR_PTR(pvt_data->ctx) == -ENOENT)
>> +			return -EPROBE_DEFER;
>> +		dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
>> +		return ERR_PTR(pvt_data->ctx);
>> +	}
>> +
>> +	/* Open a session with fTPM TA */
>> +	memset(&sess_arg, 0, sizeof(sess_arg));
>> +	memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
>> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
>> +	sess_arg.num_params = 0;
>> +
>> +	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
>> +	if ((rc < 0) || (sess_arg.ret != 0)) {
>> +		dev_err(dev, "%s:tee_client_open_session failed, err=%x\n",
>> +			__func__, sess_arg.ret);
>> +		rc = -EINVAL;
>> +		goto out_tee_session;
>> +	}
>> +	pvt_data->session = sess_arg.session;
>> +
>> +	/* Allocate dynamic shared memory with fTPM TA */
>> +	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
>> +				(MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE),
>> +				TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
>
>The alignment goes a bit off also here. Seems to fit to 80 chars even
>when it is nicely aligned (had to test):
>
>	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
>				      MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE,
>				      TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
>
>Also had one pair of redundant parentheses.

Just in case math breaks! (fixed).

>
>> +	if (IS_ERR(pvt_data->shm)) {
>> +		dev_err(dev, "%s:tee_shm_alloc failed\n", __func__);
>
>The white space character.
>
>> +		rc = -ENOMEM;
>> +		goto out_shm_alloc;
>> +	}
>> +
>> +	/* Allocate new struct tpm_chip instance */
>> +	chip = tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);
>> +	if (IS_ERR(chip)) {
>> +		dev_err(dev, "%s:tpm_chip_alloc failed\n", __func__);
>
>The white space character.
>
>> +		rc = PTR_ERR(chip);
>> +		goto out_chip_alloc;
>> +	}
>> +
>> +	pvt_data->chip = chip;
>> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
>> +
>> +	/* Create a character device for the fTPM */
>> +	rc = tpm_chip_register(pvt_data->chip);
>> +	if (rc) {
>> +		dev_err(dev, "%s:tpm_chip_register failed with rc=%d\n",
>
>The white space character.
>
>> +			__func__, rc);
>> +		goto out_chip;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_chip:
>> +	put_device(&pvt_data->chip->dev);
>> +out_chip_alloc:
>> +	tee_shm_free(pvt_data->shm);
>> +out_shm_alloc:
>> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);
>> +out_tee_session:
>> +	tee_client_close_context(pvt_data->ctx);
>> +
>> +	return rc;
>> +}
>> +
>> +/**
>> + * ftpm_tee_remove - remove the TPM device
>> + * @pdev: the platform_device description.
>> + *
>> + * Return:
>> + * 	0 in case of success.
>
>"0 always" ? Left me puzzling with questions in that form.

Technically it's true :) (fixed).

>> + */
>> +static int ftpm_tee_remove(struct platform_device *pdev)
>> +{
>> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
>> +
>> +	/* Release the chip */
>> +	tpm_chip_unregister(pvt_data->chip);
>> +
>> +	/* frees chip */
>> +	put_device(&pvt_data->chip->dev);
>> +
>> +	/* Free the shared memory pool */
>> +	tee_shm_free(pvt_data->shm);
>> +
>> +	/* close the existing session with fTPM TA*/
>> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);
>> +
>> +	/* close the context with TEE driver */
>> +	tee_client_close_context(pvt_data->ctx);
>> +
>> +        /* memory allocated with devm_kzalloc() is freed automatically */
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id of_ftpm_tee_ids[] = {
>> +	{ .compatible = "microsoft,ftpm" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
>> +
>> +static struct platform_driver ftpm_tee_driver = {
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
>> +	},
>> +	.probe = ftpm_tee_probe,
>> +	.remove = ftpm_tee_remove,
>> +};
>> +
>> +module_platform_driver(ftpm_tee_driver);
>> +
>> +MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
>
>I'm also wondering why we put MODULE_AUTHOR() to new modules...

It shows up in modinfo and is a nice way to credit the author IMHO.

>> +MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
>> new file mode 100644
>> index 000000000000..b09ee7be4545
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) Microsoft Corporation
>> + */
>> +
>> +#ifndef __TPM_FTPM_TEE_H__
>> +#define __TPM_FTPM_TEE_H__
>> +
>> +#include <linux/tee_drv.h>
>> +#include <linux/tpm.h>
>> +#include <linux/uuid.h>
>> +
>> +/* The TAFs ID implemented in this TA */
>> +#define FTPM_OPTEE_TA_SUBMIT_COMMAND  (0)
>> +#define FTPM_OPTEE_TA_EMULATE_PPI     (1)
>> +
>> +/* max. buffer size supported by fTPM  */
>> +#define  MAX_COMMAND_SIZE       4096
>> +#define  MAX_RESPONSE_SIZE      4096
>
>Two whitespace chars after "#define".

Fixed.

>> +
>> +/**
>> + * struct ftpm_tee_private - fTPM's private data
>> + * @chip:     struct tpm_chip instance registered with tpm framework.
>> + * @state:    internal state
>> + * @session:  fTPM TA session identifier.
>> + * @resp_len: cached response buffer length.
>> + * @resp_buf: cached response buffer.
>> + * @ctx:      TEE context handler.
>> + * @shm:      Memory pool shared with fTPM TA in TEE.
>> + */
>> +struct ftpm_tee_private {
>> +	struct tpm_chip *chip;
>> +	u32 session;
>> +	size_t resp_len;
>> +	u8 resp_buf[MAX_RESPONSE_SIZE];
>> +	struct tee_context *ctx;
>> +	struct tee_shm *shm;
>> +};
>> +
>> +#endif /* __TPM_FTPM_TEE_H__ */
>
>/Jarkko

--
Thanks,
Sasha
