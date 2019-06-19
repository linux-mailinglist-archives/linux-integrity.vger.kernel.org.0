Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9B4B6A8
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfFSLFg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 07:05:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41871 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfFSLFg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 07:05:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so2890436wrm.8
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OEgbZHXKFVOiBGifDF7y9cq8vaM9iMYAOkmDJ6zAJa0=;
        b=Jg4cYOD0Mxvwwk0COCACmQLpEYSbMWmHKFc3xYTIGZ9PSGzorxP9WKFu//fyi9g/lh
         Ftb5NuB6Kp7HAdwEf7nPKmn9Ze7Cki+oekIyAzopEDbaPqeE7zu8TN5Q4L657KNDn4Mu
         Bdm+yphqHtZicswlAHU5hlH4xKVJ8TUuX0Wdh4cRZKjRgqC7aztSMfxFXntL1IfiJcpJ
         d9gn2K/iGuu92gdNprz7AiK2FBjQCAP+cf4T9faHPJdu1IR2HsVOVzbOy4DHxt9DqWS8
         Tjh7gpND1qu5LzShqKlkfoBaSOMzVgBsvOimlyAV5DQFrVu9G0bbpwKeh2KKQwT3D1pv
         yksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OEgbZHXKFVOiBGifDF7y9cq8vaM9iMYAOkmDJ6zAJa0=;
        b=TfEuil7THveSeHZUWy7k5BlLr7O1a3xCp2EVGQRATuFkyy3BuHZVP/E3vpRJbW8Fxo
         /2mdbGaJ7J2dryLLLchN58fzttLWbdz1bYEdhieskxO8npO+FBivFqYWRYiZLyPcHH0s
         R2PVweqn7cze1KAiAW9ybMu5LQF2tBI8c0mWqerg6Sp2OgjIhKbWt1gH6LqgCG3EV6uj
         tKLM1OOs9eWt1Bm85jRzN6SJDnWCwEG0NGir548qYQNjiAXExlEoyQ4fRjGmsJtlNj37
         qOs3EFu6cfvWFfuYc0LqwTtcYpXKnSh7P4TYDt6Y1b+9RL6YQdCT5NjZ2vqkjm46wCfd
         dnYA==
X-Gm-Message-State: APjAAAUsXGdzYhoFLyMmODjhR8c0jGlveYUlSpD5NyQ6ybuWah31hJ0t
        GCFEWgK4+gU/MOzWXaltk5eVNA==
X-Google-Smtp-Source: APXvYqy2EEpNOT6kc8IgnoSIug7k4snJSzBiPUycMc7DKi3eLUFIWoDHYXpRcqhl0JcU49PIeWFhsA==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr32778075wrm.87.1560942329107;
        Wed, 19 Jun 2019 04:05:29 -0700 (PDT)
Received: from apalos (athedsl-4461147.home.otenet.gr. [94.71.2.75])
        by smtp.gmail.com with ESMTPSA id c1sm1773396wrh.1.2019.06.19.04.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:05:28 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:25 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org
Subject: Re: [PATCH v5 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190619110525.GA23364@apalos>
References: <20190614202127.26812-1-sashal@kernel.org>
 <20190614202127.26812-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614202127.26812-2-sashal@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sasha, 

Can you please include me and Sumit in future iterations of this?
We've both commented and did some testing, we'd prefer not scanning the mailing
list for new versions.

[...]
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation
> + *
> + * Implements a firmware TPM as described here:
> + * https://www.microsoft.com/en-us/research/publication/ftpm-software-implementation-tpm-chip/
> + *
> + * A reference implementation is available here:
> + * https://github.com/microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +#include "tpm.h"
> +#include "tpm_ftpm_tee.h"
> +
> +#define DRIVER_NAME "ftpm-tee"
> +
> +/*
> + * TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896
> + *
> + * Randomly generated, and must correspond to the GUID on the TA side.
> + * Defined here in the reference implementation:
> + * https://github.com/microsoft/ms-tpm-20-ref/blob/master/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/include/fTPM.h#L42
> + */
> +
> +static const uuid_t ftpm_ta_uuid =
> +	UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
> +		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
> +
> +/**
> + * ftpm_tee_tpm_op_recv - retrieve fTPM response.
> + *
> + * @chip: the tpm_chip description as specified in driver/char/tpm/tpm.h.
> + * @buf: the buffer to store data.
> + * @count: the number of bytes to read.
> + *
> + * Return:
> + * 	In case of success the number of bytes received.
> + *	On failure, -errno.
> + */
> +static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	size_t len;
> +
> +	len = pvt_data->resp_len;
> +	if (count < len) {
> +		dev_err(&chip->dev,
> +			"%s:Invalid size in recv: count=%zd, resp_len=%zd\n",
> +			__func__, count, len);
> +		return -EIO;
> +	}
> +
> +	memcpy(buf, pvt_data->resp_buf, len);
> +	pvt_data->resp_len = 0;
> +
> +	return len;
> +}
> +
> +/**
> + * ftpm_tee_tpm_op_send - send TPM commands through the TEE shared memory.
> + *
> + * @chip: the tpm_chip description as specified in driver/char/tpm/tpm.h
> + * @buf: the buffer to send.
> + * @len: the number of bytes to send.
> + *
> + * Return:
> + * 	In case of success, returns 0.
> + *	On failure, -errno
> + */
> +static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	size_t resp_len;
> +	int rc;
> +	u8 *temp_buf;
> +	struct tpm_header *resp_header;
> +	struct tee_ioctl_invoke_arg transceive_args;
> +	struct tee_param command_params[4];
> +	struct tee_shm *shm = pvt_data->shm;
> +
> +	if (len > MAX_COMMAND_SIZE) {
> +		dev_err(&chip->dev,
> +			"%s:len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
> +			__func__, len);
> +		return -EIO;
> +	}
> +
> +	memset(&transceive_args, 0, sizeof(transceive_args));
> +	memset(command_params, 0, sizeof(command_params));
> +	pvt_data->resp_len = 0;
> +
> +	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
> +	transceive_args = (struct tee_ioctl_invoke_arg) {
> +		.func = FTPM_OPTEE_TA_SUBMIT_COMMAND,
> +		.session = pvt_data->session,
> +		.num_params = 4,
> +	};
> +
> +	/* Fill FTPM_OPTEE_TA_SUBMIT_COMMAND parameters */
> +	command_params[0] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +		.u.memref = {
> +			.shm = shm,
> +			.size = len,
> +			.shm_offs = 0,
> +		},
> +	};
> +
> +	temp_buf = tee_shm_get_va(shm, 0);
> +	if (IS_ERR(temp_buf)) {
> +		dev_err(&chip->dev, "%s:tee_shm_get_va failed for transmit\n",
> +			__func__);
> +		return PTR_ERR(temp_buf);
> +	}
> +	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
> +
> +	memcpy(temp_buf, buf, len);
> +
> +	command_params[1] = (struct tee_param) {
> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +		.u.memref = {
> +			.shm = shm,
> +			.size = MAX_RESPONSE_SIZE,
> +			.shm_offs = MAX_COMMAND_SIZE,
> +		},
> +	};
> +
> +	rc = tee_client_invoke_func(pvt_data->ctx, &transceive_args,
> +					command_params);
> +	if ((rc < 0) || (transceive_args.ret != 0)) {
> +		dev_err(&chip->dev, "%s:SUBMIT_COMMAND invoke error: 0x%x\n",
> +			__func__, transceive_args.ret);
> +		return (rc < 0) ? rc : transceive_args.ret;
> +	}
> +
> +	temp_buf = tee_shm_get_va(shm, command_params[1].u.memref.shm_offs);
> +	if (IS_ERR(temp_buf)) {
> +		dev_err(&chip->dev, "%s:tee_shm_get_va failed for receive\n",
> +			__func__);
> +		return PTR_ERR(temp_buf);
> +	}
> +
> +	resp_header = (struct tpm_header *)temp_buf;
> +	resp_len = be32_to_cpu(resp_header->length);
> +
> +	/* sanity check resp_len */
> +	if (resp_len < TPM_HEADER_SIZE) {
> +		dev_err(&chip->dev, "%s:tpm response header too small\n",
> +			__func__);
> +		return -EIO;
> +	}
> +	if (resp_len > MAX_RESPONSE_SIZE) {
> +		dev_err(&chip->dev,
> +			"%s:resp_len=%zd exceeds MAX_RESPONSE_SIZE\n",
> +			__func__, resp_len);
> +		return -EIO;
> +	}
> +
> +	/* sanity checks look good, cache the response */
> +	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
> +	pvt_data->resp_len = resp_len;
> +
> +	return 0;
> +}
> +
> +static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
> +{
> +	/* not supported */
> +}
> +
> +static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
> +{
> +	return 0;
> +}
> +
> +static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
> +{
> +	return 0;
> +}
> +
> +static const struct tpm_class_ops ftpm_tee_tpm_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.recv = ftpm_tee_tpm_op_recv,
> +	.send = ftpm_tee_tpm_op_send,
> +	.cancel = ftpm_tee_tpm_op_cancel,
> +	.status = ftpm_tee_tpm_op_status,
> +	.req_complete_mask = 0,
> +	.req_complete_val = 0,
> +	.req_canceled = ftpm_tee_tpm_req_canceled,
> +};
> +
> +/*
> + * Check whether this driver supports the fTPM TA in the TEE instance
> + * represented by the params (ver/data) to this function.
> + */
> +static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
> +{
> +	/*
> +	 * Currently this driver only support GP Complaint OPTEE based fTPM TA
> +	 */
> +	if ((ver->impl_id == TEE_IMPL_ID_OPTEE) &&
> +		(ver->gen_caps & TEE_GEN_CAP_GP))
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/*
> + * Undo what has been done in ftpm_tee_probe
> + */
> +static void ftpm_tee_deinit(struct ftpm_tee_private *pvt_data)
I don't see this functions being used anywhere and my compiler complains. 
ftpm_tee_remove() is doing similar things, should this one be removed?

> +{
> +	/* Release the chip */
> +	tpm_chip_unregister(pvt_data->chip);
> +
> +	/* frees chip */
> +	if (pvt_data->chip)
> +		put_device(&pvt_data->chip->dev);
> +
> +	if (pvt_data->ctx) {
> +		/* Free the shared memory pool */
> +		tee_shm_free(pvt_data->shm);
> +
> +		/* close the existing session with fTPM TA*/
> +		tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +
> +		/* close the context with TEE driver */
> +		tee_client_close_context(pvt_data->ctx);
> +	}
> +
> +	/* memory allocated with devm_kzalloc() is freed automatically */
> +}
> +
> +/**
> + * ftpm_tee_probe - initialize the fTPM
> + * @pdev: the platform_device description.
> + *
> + * Return:
> + * 	On success, 0. On failure, -errno.
> + */
> +static int ftpm_tee_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct tpm_chip *chip;
> +	struct device *dev = &pdev->dev;
> +	struct ftpm_tee_private *pvt_data = NULL;
> +	struct tee_ioctl_open_session_arg sess_arg;
> +
> +	pvt_data = devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
> +				GFP_KERNEL);
> +	if (!pvt_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, pvt_data);
> +
> +	/* Open context with TEE driver */
> +	pvt_data->ctx = tee_client_open_context(NULL, ftpm_tee_match, NULL,
> +						NULL);
> +	if (IS_ERR(pvt_data->ctx)) {
> +		if (ERR_PTR(pvt_data->ctx) == -ENOENT)
> +			return -EPROBE_DEFER;
> +		dev_err(dev, "%s:tee_client_open_context failed\n", __func__);
> +		return ERR_PTR(pvt_data->ctx);
> +	}
> +
> +	/* Open a session with fTPM TA */
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> +	sess_arg.num_params = 0;
> +
> +	rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret != 0)) {
> +		dev_err(dev, "%s:tee_client_open_session failed, err=%x\n",
> +			__func__, sess_arg.ret);
> +		rc = -EINVAL;
> +		goto out_tee_session;
> +	}
> +	pvt_data->session = sess_arg.session;
> +
> +	/* Allocate dynamic shared memory with fTPM TA */
> +	pvt_data->shm = tee_shm_alloc(pvt_data->ctx,
> +				(MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE),
> +				TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +	if (IS_ERR(pvt_data->shm)) {
> +		dev_err(dev, "%s:tee_shm_alloc failed\n", __func__);
> +		rc = -ENOMEM;
> +		goto out_shm_alloc;
> +	}
> +
> +	/* Allocate new struct tpm_chip instance */
> +	chip = tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);
> +	if (IS_ERR(chip)) {
> +		dev_err(dev, "%s:tpm_chip_alloc failed\n", __func__);
> +		rc = PTR_ERR(chip);
> +		goto out_chip_alloc;
> +	}
> +
> +	pvt_data->chip = chip;
> +	pvt_data->chip->flags |= TPM_CHIP_FLAG_TPM2;
> +
> +	/* Create a character device for the fTPM */
> +	rc = tpm_chip_register(pvt_data->chip);
> +	if (rc) {
> +		dev_err(dev, "%s:tpm_chip_register failed with rc=%d\n",
> +			__func__, rc);
> +		goto out_chip;
> +	}
> +
> +	return 0;
> +
> +out_chip:
> +	put_device(&pvt_data->chip->dev);
> +out_chip_alloc:
> +	tee_shm_free(pvt_data->shm);
> +out_shm_alloc:
> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +out_tee_session:
> +	tee_client_close_context(pvt_data->ctx);
> +
> +	return rc;
> +}
> +
> +/**
> + * ftpm_tee_remove - remove the TPM device
> + * @pdev: the platform_device description.
> + *
> + * Return:
> + * 	0 in case of success.
> + */
> +static int ftpm_tee_remove(struct platform_device *pdev)
> +{
> +	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
> +
> +	/* Release the chip */
> +	tpm_chip_unregister(pvt_data->chip);
> +
> +	/* frees chip */
> +	put_device(&pvt_data->chip->dev);
> +
> +	/* Free the shared memory pool */
> +	tee_shm_free(pvt_data->shm);
> +
> +	/* close the existing session with fTPM TA*/
> +	tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +
> +	/* close the context with TEE driver */
> +	tee_client_close_context(pvt_data->ctx);
> +
> +        /* memory allocated with devm_kzalloc() is freed automatically */
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_ftpm_tee_ids[] = {
> +	{ .compatible = "microsoft,ftpm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> +
> +static struct platform_driver ftpm_tee_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
> +	},
> +	.probe = ftpm_tee_probe,
> +	.remove = ftpm_tee_remove,
> +};
> +
> +module_platform_driver(ftpm_tee_driver);
> +
> +MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
> +MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
> new file mode 100644
> index 000000000000..b09ee7be4545
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Microsoft Corporation
> + */
> +
> +#ifndef __TPM_FTPM_TEE_H__
> +#define __TPM_FTPM_TEE_H__
> +
> +#include <linux/tee_drv.h>
> +#include <linux/tpm.h>
> +#include <linux/uuid.h>
> +
> +/* The TAFs ID implemented in this TA */
> +#define FTPM_OPTEE_TA_SUBMIT_COMMAND  (0)
> +#define FTPM_OPTEE_TA_EMULATE_PPI     (1)
> +
> +/* max. buffer size supported by fTPM  */
> +#define  MAX_COMMAND_SIZE       4096
> +#define  MAX_RESPONSE_SIZE      4096
> +
> +/**
> + * struct ftpm_tee_private - fTPM's private data
> + * @chip:     struct tpm_chip instance registered with tpm framework.
> + * @state:    internal state
> + * @session:  fTPM TA session identifier.
> + * @resp_len: cached response buffer length.
> + * @resp_buf: cached response buffer.
> + * @ctx:      TEE context handler.
> + * @shm:      Memory pool shared with fTPM TA in TEE.
> + */
> +struct ftpm_tee_private {
> +	struct tpm_chip *chip;
> +	u32 session;
> +	size_t resp_len;
> +	u8 resp_buf[MAX_RESPONSE_SIZE];
> +	struct tee_context *ctx;
> +	struct tee_shm *shm;
> +};
> +
> +#endif /* __TPM_FTPM_TEE_H__ */
> -- 
> 2.20.1
> 

Regards
/Ilias
