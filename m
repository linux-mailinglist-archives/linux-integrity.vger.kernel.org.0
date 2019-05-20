Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6B23C28
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2019 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfETPal (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 11:30:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41841 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbfETPal (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 11:30:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so24479265edd.8;
        Mon, 20 May 2019 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bN649PnW1PWzC8Fg26z/hSZIP/qFRj6NKkvoAODsOrE=;
        b=d2aFjG3nHZWqptKrYC9OtYqLstw8Z4yOzUqMxATAODLZb5QXlLgXSRa5DWF+f6iQ3d
         wLE9xgkL59DBBVcV3ccvzISsEEin1o4Mpvm3Kb7nZl1GOJYlL+oc1y3yUcryorJAOF7r
         CDqVQw3+9Mmgz+2KHPsFdm6krl3OMSi8mcw0F4jgzF50nkdtlrJsK4VCvHKeaFfVs8Sf
         tLj7Rdbn1sPYw3INJ4mgS5BhANhRE3xtCnhFrUB7IR7jctmL2Ed03Nif4NjaUF7Uct0Y
         DhsFAKDxVVcX7Nq2nvm0HCAmHDb8ra89eLpM0nkGg/nJ94slHhOajbzqfsqjUQ2kLTb7
         4jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bN649PnW1PWzC8Fg26z/hSZIP/qFRj6NKkvoAODsOrE=;
        b=M/kYk5UbmwcydYIMtMUJp7T5HWrZpIz5CxqVors+PJg+5QDpCyKAqafK0kQVuUxFQm
         VIXcP61+Z1spW8pdV/9B9GL10Qer3YySTWawIq1acWCt//JN3gmI0AezL4yag6AEtGQG
         Ek7XDJM70XFeXR0fgODMpPYKWpS3dOHu0cUa5wjw/sc6U4BYA8r9BtXEUIkKky1WYWfp
         Ui9JZJj01wi90ZR2iNHCXeIGOxKNo6XZtNzKhB/UFnx8zWf4oM7e0p3CHmeDIszEoqjS
         JlgLld1wZ3zl0xetFklYh5RcdL88N871f0PDuohHJ/3ZI+la1scFKfxQcG0AnHDaxaVa
         PExg==
X-Gm-Message-State: APjAAAXMOUCt+UmwPEZm+bEBBZEWFjkWhJMRpxRDjcWQcj1mkc0CKHgZ
        2hVRTiEx+tNkjpu70yZC/SrcdUIvGzK4yko+jSg=
X-Google-Smtp-Source: APXvYqzs7Tjntcx3iipzFlRMO/sEzoDaDMHRfb5JZyWCTx+ZHus7BzU+dTD3Ft2474FZ3lSzVUxV9ntpJm9UwRH0uI8=
X-Received: by 2002:aa7:c4d2:: with SMTP id p18mr76378529edr.232.1558366238987;
 Mon, 20 May 2019 08:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190415155636.32748-1-sashal@kernel.org> <20190415155636.32748-2-sashal@kernel.org>
In-Reply-To: <20190415155636.32748-2-sashal@kernel.org>
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
Date:   Mon, 20 May 2019 18:30:27 +0300
Message-ID: <CAByghJYbubRroZu85SbvkTqE65F=-o0dt2trjhTB9G9qJmffKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ftpm: firmware TPM running in TEE
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sasha,

Just my two cents here after a quick look:

On Mon, Apr 15, 2019 at 6:58 PM Sasha Levin <sashal@kernel.org> wrote:
>
> This patch adds support for a software-only implementation of a TPM
> running in TEE.
>
> There is extensive documentation of the design here:
> https://www.microsoft.com/en-us/research/publication/ftpm-software-implem=
entation-tpm-chip/ .
>
> As well as reference code for the firmware available here:
> https://github.com/Microsoft/ms-tpm-20-ref/tree/master/Samples/ARM32-Firm=
wareTPM
>
> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/char/tpm/Kconfig        |   5 +
>  drivers/char/tpm/Makefile       |   1 +
>  drivers/char/tpm/tpm_ftpm_tee.c | 366 ++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_ftpm_tee.h |  47 ++++
>  4 files changed, 419 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.c
>  create mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 536e55d3919f..5638726641eb 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -164,6 +164,11 @@ config TCG_VTPM_PROXY
>           /dev/vtpmX and a server-side file descriptor on which the vTPM
>           can receive commands.
>
> +config TCG_FTPM_TEE
> +       tristate "TEE based fTPM Interface"
> +       depends on TEE

depends on OPTEE also.

> +       ---help---
> +         This driver proxies for fTPM running in TEE
>
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index a01c4cab902a..c354cdff9c62 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_TCG_TIS_ST33ZP24) +=3D st33zp24/
>  obj-$(CONFIG_TCG_XEN) +=3D xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) +=3D tpm_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) +=3D tpm_vtpm_proxy.o
> +obj-$(CONFIG_TCG_FTPM_TEE) +=3D tpm_ftpm_tee.o
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_=
tee.c
> new file mode 100644
> index 000000000000..f33cdfeb5376
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +#include <linux/tpm.h>
minor: alphabetical order (simplify detecting duplicate include files etc)

> +
> +#include "tpm.h"
> +#include "tpm_ftpm_tee.h"
> +
> +#define DRIVER_NAME "ftpm-tee"
> +
Please add a comment about TA UUID (what is it etc.), and where it is
defined in the ms-tpm-ta repository.

> +/* TA_FTPM_UUID: BC50D971-D4C9-42C4-82CB-343FB7F37896 */
> +static const uuid_t ftpm_ta_uuid =3D
> +       UUID_INIT(0xBC50D971, 0xD4C9, 0x42C4,
> +                 0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
> +
> +/*
> + * Note: ftpm_tee_tpm_op_recv and ftpm_tee_tpm_op_send are called from t=
he
> + * same routine tpm_try_transmit in tpm-interface.c. These calls are pro=
tected
> + * by chip->tpm_mutex =3D> There is no need for protecting any data shar=
ed
> + * between these routines ex: struct ftpm_tee_private
> + */
> +
> +/**
> + * ftpm_tee_tpm_op_recv retrieve fTPM response.
> + * @param: chip, the tpm_chip description as specified in driver/char/tp=
m/tpm.h.
> + * @param: buf,        the buffer to store data.
> + * @param: count, the number of bytes to read.
> + * @return: In case of success the number of bytes received.
> + *         In other case, a < 0 value describing the issue.
> + */
> +static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t c=
ount)
> +{
> +       struct ftpm_tee_private *pvt_data =3D dev_get_drvdata(chip->dev.p=
arent);
> +       size_t len;
> +
> +       len =3D pvt_data->resp_len;
> +       if (count < len) {
> +               dev_err(&chip->dev,
> +                       "%s:Invalid size in recv: count=3D%zd, resp_len=
=3D%zd\n",
> +                       __func__, count, len);
> +               return -EIO;
> +       }
> +
> +       memcpy(buf, pvt_data->resp_buf, len);
> +       pvt_data->resp_len =3D 0;
> +
> +       return len;
> +}
> +
> +/**
> + * ftpm_tee_tpm_op_send send TPM commands through the TEE shared memory.
> + *
> + * @param: chip, the tpm_chip description as specified in driver/char/tp=
m/tpm.h
> + * @param: buf,        the buffer to send.
> + * @param: len, the number of bytes to send.
> + * @return: In case of success, returns 0.
> + *         In other case, a < 0 value describing the issue.
> + */
> +static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t l=
en)
> +{
> +       struct ftpm_tee_private *pvt_data =3D dev_get_drvdata(chip->dev.p=
arent);
> +       size_t resp_len;
> +       int rc;
> +       u8 *temp_buf;
> +       struct tpm_header *resp_header;
> +       struct tee_ioctl_invoke_arg transceive_args;
> +       struct tee_param command_params[4];
> +       struct tee_shm *shm =3D pvt_data->shm;
> +
> +       if (len > MAX_COMMAND_SIZE) {
> +               dev_err(&chip->dev,
> +                       "%s:len=3D%zd exceeds MAX_COMMAND_SIZE supported =
by fTPM TA\n",
> +                       __func__, len);
> +               return -EIO;
> +       }
> +
> +       memset(&transceive_args, 0, sizeof(transceive_args));
> +       memset(command_params, 0, sizeof(command_params));
> +       pvt_data->resp_len =3D 0;
> +
> +       /* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
> +       transceive_args =3D (struct tee_ioctl_invoke_arg) {
> +               .func =3D FTPM_OPTEE_TA_SUBMIT_COMMAND,
> +               .session =3D pvt_data->session,
> +               .num_params =3D 4,
> +       };
> +
> +       /* Fill FTPM_OPTEE_TA_SUBMIT_COMMAND parameters */
> +       command_params[0] =3D (struct tee_param) {
> +               .attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
> +               .u.memref =3D {
> +                       .shm =3D shm,
> +                       .size =3D len,
> +                       .shm_offs =3D 0,
> +               },
> +       };
> +
> +       temp_buf =3D tee_shm_get_va(shm, 0);
> +       if (IS_ERR(temp_buf)) {
> +               dev_err(&chip->dev, "%s:tee_shm_get_va failed for transmi=
t\n",
> +                       __func__);
> +               return PTR_ERR(temp_buf);
> +       }
> +       memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
> +
> +       memcpy(temp_buf, buf, len);
> +
> +       command_params[1] =3D (struct tee_param) {
> +               .attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +               .u.memref =3D {
> +                       .shm =3D shm,
> +                       .size =3D MAX_RESPONSE_SIZE,
> +                       .shm_offs =3D MAX_COMMAND_SIZE,
> +               },
> +       };
> +
> +       rc =3D tee_client_invoke_func(pvt_data->ctx, &transceive_args,
> +                                       command_params);
> +       if ((rc < 0) || (transceive_args.ret !=3D 0)) {
> +               dev_err(&chip->dev, "%s:SUBMIT_COMMAND invoke error: 0x%x=
\n",
> +                       __func__, transceive_args.ret);
> +               return (rc < 0) ? rc : transceive_args.ret;
> +       }
> +
> +       temp_buf =3D tee_shm_get_va(shm, command_params[1].u.memref.shm_o=
ffs);
> +       if (IS_ERR(temp_buf)) {
> +               dev_err(&chip->dev, "%s:tee_shm_get_va failed for receive=
\n",
> +                       __func__);
> +               return PTR_ERR(temp_buf);
> +       }
> +
> +       resp_header =3D (struct tpm_header *)temp_buf;
> +       resp_len =3D be32_to_cpu(resp_header->length);
> +
> +       /* sanity check resp_len */
> +       if (resp_len < TPM_HEADER_SIZE) {
> +               dev_err(&chip->dev, "%s:tpm response header too small\n",
> +                       __func__);
> +               return -EIO;
> +       }
> +       if (resp_len > MAX_RESPONSE_SIZE) {
> +               dev_err(&chip->dev,
> +                       "%s:resp_len=3D%zd exceeds MAX_RESPONSE_SIZE\n",
> +                       __func__, resp_len);
> +               return -EIO;
> +       }
> +
> +       /* sanity checks look good, cache the response */
> +       memcpy(pvt_data->resp_buf, temp_buf, resp_len);
> +       pvt_data->resp_len =3D resp_len;
> +
> +       return 0;
> +}
> +
> +static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
> +{
> +       /* not supported */
> +}
Check my patch 4f062dc1b75 ("tee: add cancellation support to client
interface"), with this API you can easily implement cancellation using
tee_client_cancel_req(...).
Within MS fwTPM TA implementation it also can be implemented by
checking the cancellation flag calling GP API
TEE_GetCancellationFlag() (AFAIK this should be done in
_plat__IsCanceled(void) wrapper function).

> +
> +static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
> +{
> +       return 0;
> +}
> +
> +static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
> +{
> +       return 0;
> +}
> +
> +static const struct tpm_class_ops ftpm_tee_tpm_ops =3D {
> +       .flags =3D TPM_OPS_AUTO_STARTUP,
> +       .recv =3D ftpm_tee_tpm_op_recv,
> +       .send =3D ftpm_tee_tpm_op_send,
> +       .cancel =3D ftpm_tee_tpm_op_cancel,
> +       .status =3D ftpm_tee_tpm_op_status,
> +       .req_complete_mask =3D 0,
> +       .req_complete_val =3D 0,
> +       .req_canceled =3D ftpm_tee_tpm_req_canceled,
> +};
> +
> +/*
> + * Check whether this driver supports the fTPM TA in the TEE instance
> + * represented by the params (ver/data) to this function.
> + */
> +static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void=
 *data)
> +{
> +       /*
> +        * Currently this driver only support GP Complaint OPTEE based fT=
PM TA
> +        */
This can be done implicitly by providing tee_ioctl_version_data struct
with proper values as the last param when the context is opened
(tee_client_open_context() invocation).
Something like this:

struct tee_ioctl_version_data vers =3D {
      .impl_id =3D TEE_OPTEE_CAP_TZ,
      .impl_caps =3D TEE_IMPL_ID_OPTEE,
      .gen_caps =3D TEE_GEN_CAP_GP,
};

And then:
tee_client_open_context(NULL, ftpm_tee_match, NULL, &vers);

> +       if ((ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE) &&
> +               (ver->gen_caps & TEE_GEN_CAP_GP))
> +               return 1;
> +       else
> +               return 0;
> +}
> +
> +/*
> + * Undo what has been done in ftpm_tee_probe
> + */
> +static void ftpm_tee_deinit(struct ftpm_tee_private *pvt_data)
> +{
> +       /* Release the chip */
> +       tpm_chip_unregister(pvt_data->chip);
> +
> +       /* frees chip */
> +       if (pvt_data->chip)
> +               put_device(&pvt_data->chip->dev);
> +
> +       if (pvt_data->ctx) {
> +               /* Free the shared memory pool */
> +               tee_shm_free(pvt_data->shm);
> +
> +               /* close the existing session with fTPM TA*/
> +               tee_client_close_session(pvt_data->ctx, pvt_data->session=
);
> +
> +               /* close the context with TEE driver */
> +               tee_client_close_context(pvt_data->ctx);
> +       }
> +
> +       /* memory allocated with devm_kzalloc() is freed automatically */
> +}
> +
> +/**
> + * ftpm_tee_probe initialize the fTPM
> + * @param: pdev, the platform_device description.
> + * @return: 0 in case of success.
> + *      or a negative value describing the error.
> + */
> +static int ftpm_tee_probe(struct platform_device *pdev)
> +{
> +       int rc;
> +       struct tpm_chip *chip;
> +       struct device *dev =3D &pdev->dev;
> +       struct ftpm_tee_private *pvt_data =3D NULL;
> +       struct tee_ioctl_open_session_arg sess_arg;
> +
> +       pvt_data =3D devm_kzalloc(dev, sizeof(struct ftpm_tee_private),
> +                               GFP_KERNEL);
> +       if (!pvt_data)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(dev, pvt_data);
> +
> +       /* Open context with TEE driver */
> +       pvt_data->ctx =3D tee_client_open_context(NULL, ftpm_tee_match, N=
ULL,
> +                                               NULL);
Check my comments above about tee_ioctl_version_data struct.

> +       if (IS_ERR(pvt_data->ctx)) {
> +               dev_err(dev, "%s:tee_client_open_context failed\n", __fun=
c__);
> +               return -EPROBE_DEFER;
> +       }
> +
> +       /* Open a session with fTPM TA */
> +       memset(&sess_arg, 0, sizeof(sess_arg));
> +       memcpy(sess_arg.uuid, ftpm_ta_uuid.b, TEE_IOCTL_UUID_LEN);
> +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_PUBLIC;
> +       sess_arg.num_params =3D 0;
> +
> +       rc =3D tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> +       if ((rc < 0) || (sess_arg.ret !=3D 0)) {
> +               dev_err(dev, "%s:tee_client_open_session failed, err=3D%x=
\n",
> +                       __func__, sess_arg.ret);
> +               rc =3D -EINVAL;
> +               goto out_tee_session;
> +       }
> +       pvt_data->session =3D sess_arg.session;
> +
> +       /* Allocate dynamic shared memory with fTPM TA */
> +       pvt_data->shm =3D tee_shm_alloc(pvt_data->ctx,
> +                               (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE),
> +                               TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
Why not to keep stuff in two different shm buffers instead (one for
cmd buffer, another for response)?
It will definitely simplify the implementation from both fwtpm driver
and TA sides.

> +       if (IS_ERR(pvt_data->shm)) {
> +               dev_err(dev, "%s:tee_shm_alloc failed\n", __func__);
> +               rc =3D -ENOMEM;
> +               goto out_shm_alloc;
> +       }
> +
> +       /* Allocate new struct tpm_chip instance */
> +       chip =3D tpm_chip_alloc(dev, &ftpm_tee_tpm_ops);
> +       if (IS_ERR(chip)) {
> +               dev_err(dev, "%s:tpm_chip_alloc failed\n", __func__);
> +               rc =3D PTR_ERR(chip);
> +               goto out_chip_alloc;
> +       }
> +
> +       pvt_data->chip =3D chip;
> +       pvt_data->chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> +
> +       /* Create a character device for the fTPM */
> +       rc =3D tpm_chip_register(pvt_data->chip);
> +       if (rc) {
> +               dev_err(dev, "%s:tpm_chip_register failed with rc=3D%d\n"=
,
> +                       __func__, rc);
> +               goto out_chip;
> +       }
> +
> +       return 0;
> +
> +out_chip:
> +       put_device(&pvt_data->chip->dev);
> +out_chip_alloc:
> +       tee_shm_free(pvt_data->shm);
> +out_shm_alloc:
> +       tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +out_tee_session:
> +       tee_client_close_context(pvt_data->ctx);
> +
> +       return rc;
> +}
> +
> +/**
> + * ftpm_tee_remove remove the TPM device
> + * @param: pdev, the platform_device description.
> + * @return: 0 in case of success.
> + */
> +static int ftpm_tee_remove(struct platform_device *pdev)
> +{
> +       struct ftpm_tee_private *pvt_data =3D dev_get_drvdata(&pdev->dev)=
;
> +
> +       /* Release the chip */
> +       tpm_chip_unregister(pvt_data->chip);
> +
> +       /* frees chip */
> +       put_device(&pvt_data->chip->dev);
> +
> +       /* Free the shared memory pool */
> +       tee_shm_free(pvt_data->shm);
> +
> +       /* close the existing session with fTPM TA*/
> +       tee_client_close_session(pvt_data->ctx, pvt_data->session);
> +
> +       /* close the context with TEE driver */
> +       tee_client_close_context(pvt_data->ctx);
> +
> +        /* memory allocated with devm_kzalloc() is freed automatically *=
/
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id of_ftpm_tee_ids[] =3D {
> +       { .compatible =3D "microsoft,ftpm" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
> +
> +static struct platform_driver ftpm_tee_driver =3D {
> +       .driver =3D {
> +               .name =3D DRIVER_NAME,
> +               .of_match_table =3D of_match_ptr(of_ftpm_tee_ids),
> +       },
> +       .probe =3D ftpm_tee_probe,
> +       .remove =3D ftpm_tee_remove,
> +};
> +
> +module_platform_driver(ftpm_tee_driver);
> +
> +MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
> +MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_=
tee.h
> new file mode 100644
> index 000000000000..9de513e72dbb
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_ftpm_tee.h
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
... header files, instead, use traditional (/* */) comments for
reasons related to tooling [1]
/* SPDX-License-Identifier: GPL-2.0  */

> +/*
> + * Copyright (C) Microsoft Corporation
> + */
> +
> +#ifndef __TPM_FTPM_TEE_H__
> +#define __TPM_FTPM_TEE_H__
> +
> +#include <linux/tee_drv.h>
> +#include <linux/uuid.h>
> +#include <linux/tpm.h>
minor: alphabetical order of includes?

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
> +       struct tpm_chip *chip;
> +       u32 session;
> +       size_t resp_len;
> +       u8 resp_buf[MAX_RESPONSE_SIZE];
> +       struct tee_context *ctx;
> +       struct tee_shm *shm;
> +};
> +
> +/*
> + * Note: ftpm_tee_tpm_op_recv and ftpm_tee_tpm_op_send are called from t=
he
> + * same routine tpm_try_transmit in tpm-interface.c. These calls are pro=
tected
> + * by chip->tpm_mutex =3D> There is no need for protecting any data shar=
ed
> + * between these routines ex: struct ftpm_tee_private
> + */
> +
> +#endif /* __TPM_FTPM_TEE_H__ */
> --
> 2.19.1
>

And also a question, a while ago I implemented a similar fTPM driver
in U-boot and managed to get it working with MS TPM2.0 TA (integrated
into OP-TEE blob as Early TA) ,and eMMC RPMB was used under the hood
as a secure storage.
This also needed some minor changes in the TA.

Let me know if you're planning to introduce/or generally interested in
having a similar driver in U-boot mainline (I think it's better to
have a driver synced with the one in the Linux mainline, just in a
sake of avoiding possible code divergence), if there are no such plans
- I'll send on my own patch-series based on this driver ASAP when it's
accepted.

[1] https://lwn.net/Articles/739183/

Thanks!
--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+380 (93) 836 40 67
http://ua.linkedin.com/in/iopaniuk
