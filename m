Return-Path: <linux-integrity+bounces-4817-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F51A35111
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 23:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B846216E1D3
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB426E17B;
	Thu, 13 Feb 2025 22:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbiRJQxj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BA26E149;
	Thu, 13 Feb 2025 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484897; cv=none; b=lTVQeBYNZfUl8iD4s0w8e+Dzn15xP7aMDylPm0UMIjhsUWAU36iQTOj9baRWqnXfiDu7oHfWBaeBAVidCbvJK74h3chmrV0Uk8J9RhySXDT7O1RWgLBXwg5HKA+PQVDhLMg7JUvzOdMQdAaioDiGBqhMhxTpOvJbATuSRLrfIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484897; c=relaxed/simple;
	bh=ZLfPXbKZM4FCdMBnM5k/SM/Al7N8GnrlF3BanJ6cXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWyiUBiMkQgVLzp5UnVhsU+PQ8pY1GjFvPdpeIt1Cz8wHgWX5SVv0hJ0ja37ctwGEHEokLzh/UGHHfWHNlpRQS8Y95AtBePc6nh3P1b1K2kIK0qjIqbUlmNwPiFNN3hDegIqROwt1IW5RATFoaUte2tlwM7pHDihEbG1MMuVOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbiRJQxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D8BC4CED1;
	Thu, 13 Feb 2025 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739484896;
	bh=ZLfPXbKZM4FCdMBnM5k/SM/Al7N8GnrlF3BanJ6cXjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbiRJQxjNd2B1DwlTFszv0Bak68/Zf32X2Odah02RPbK4RDojWxs635j9XeYjS/DC
	 USoBLX1j9SyDU60ZjBAR9xyqjLPgVvw137O9SM6Rx50YXV70XNC1dS0svpBmPo59pl
	 arWswZSuKiHqcTN4qWOA+9jkrXtEa98XJmmvo8YH8a/08nrPJXLncq8bz4JNkzCMj9
	 MC5DItXD+gx7oZYOctg7ZAafvjXSxOSFgtlFs3WAzHt5ZKRhAzFhMG/7t3ZCRs8Opq
	 JyNeCu5d9tKo+Sd8//IDXFwOgr4nzyAM+YkPR9aG6quTdJq5EuqRj7MdkgNmJFecM5
	 CNYvLLXWtjBRQ==
Date: Fri, 14 Feb 2025 00:14:51 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tpm_crb: implement driver compliant to CRB over
 FF-A
Message-ID: <Z65u21hfzG3-beo1@kernel.org>
References: <20250212220548.400447-1-stuart.yoder@arm.com>
 <20250212220548.400447-2-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212220548.400447-2-stuart.yoder@arm.com>

On Wed, Feb 12, 2025 at 04:05:44PM -0600, Stuart Yoder wrote:
> The Arm specification TPM Service CRB over FF-A specification
> defines the FF-A messages to interact with a CRB-based TPM
> implemented as an FF-A secure partition.
> 
> Spec URL:
> https://developer.arm.com/documentation/den0138/latest/
> 
> This driver is probed when a TPM Secure Partition is
> discovered by the FF-A subsystem. It exposes APIs
> used by the TPM CRB driver to send notifications to
> the TPM.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/Kconfig       |   9 +
>  drivers/char/tpm/Makefile      |   1 +
>  drivers/char/tpm/tpm_ffa_crb.c | 310 +++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_ffa_crb.h |  30 ++++
>  4 files changed, 350 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_ffa_crb.c
>  create mode 100644 drivers/char/tpm/tpm_ffa_crb.h
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e059..af5ba7c63927 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -210,6 +210,15 @@ config TCG_CRB
>  	  from within Linux.  To compile this driver as a module, choose
>  	  M here; the module will be called tpm_crb.
>  
> +config TCG_ARM_FFA_CRB
> +	tristate "TPM CRB over Arm FF-A Transport"
> +	depends on ARM_FFA_TRANSPORT
> +	default y if (TCG_CRB && ARM_FFA_TRANSPORT)
> +	help
> +	  If the Arm FF-A transport is used to access the TPM say Yes.
> +	  To compile this driver as a module, choose M here; the module
> +	  will be called tpm_ffa_crb.
> +
>  config TCG_VTPM_PROXY
>  	tristate "VTPM Proxy Interface"
>  	depends on TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c75243..21f2eb5a485e 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -42,5 +42,6 @@ obj-$(CONFIG_TCG_IBMVTPM) += tpm_ibmvtpm.o
>  obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
>  obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
> +obj-$(CONFIG_TCG_ARM_FFA_CRB) += tpm_ffa_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> diff --git a/drivers/char/tpm/tpm_ffa_crb.c b/drivers/char/tpm/tpm_ffa_crb.c
> new file mode 100644
> index 000000000000..56bd77864a47
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_ffa_crb.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + *
> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> + *
> + * This device driver implements the TPM CRB start method
> + * as defined in the TPM Service Command Response Buffer
> + * Interface Over FF-A (DEN0138).
> + */
> +
> +#define pr_fmt(fmt) "FFA_CRB: " fmt
> +
> +#include <linux/arm_ffa.h>
> +#include "tpm_ffa_crb.h"
> +
> +/* TPM service function status codes */
> +#define FFA_CRB_OK			0x05000001
> +#define FFA_CRB_OK_RESULTS_RETURNED	0x05000002
> +#define FFA_CRB_NOFUNC			0x8e000001
> +#define FFA_CRB_NOTSUP			0x8e000002
> +#define FFA_CRB_INVARG			0x8e000005
> +#define FFA_CRB_INV_CRB_CTRL_DATA	0x8e000006
> +#define FFA_CRB_ALREADY			0x8e000009
> +#define FFA_CRB_DENIED			0x8e00000a
> +#define FFA_CRB_NOMEM			0x8e00000b
> +
> +#define FFA_CRB_VERSION_MAJOR	1
> +#define FFA_CRB_VERSION_MINOR	0
> +
> +/* version encoding */
> +#define FFA_CRB_MAJOR_VERSION_MASK  GENMASK(30, 16)
> +#define FFA_CRB_MINOR_VERSION_MASK  GENMASK(15, 0)
> +#define FFA_CRB_MAJOR_VERSION(x)    ((u16)(FIELD_GET(FFA_CRB_MAJOR_VERSION_MASK, (x))))
> +#define FFA_CRB_MINOR_VERSION(x)    ((u16)(FIELD_GET(FFA_CRB_MINOR_VERSION_MASK, (x))))
> +
> +/*
> + * Normal world sends requests with FFA_MSG_SEND_DIRECT_REQ and
> + * responses are returned with FFA_MSG_SEND_DIRECT_RESP for normal
> + * messages.
> + *
> + * All requests with FFA_MSG_SEND_DIRECT_REQ and FFA_MSG_SEND_DIRECT_RESP
> + * are using the AArch32 SMC calling convention with register usage as
> + * defined in FF-A specification:
> + * w0:    Function ID (0x8400006F or 0x84000070)
> + * w1:    Source/Destination IDs
> + * w2:    Reserved (MBZ)
> + * w3-w7: Implementation defined, free to be used below
> + */
> +
> +/*
> + * Returns the version of the interface that is available
> + * Call register usage:
> + * w3:    Not used (MBZ)
> + * w4:    TPM service function ID, FFA_CRB_GET_INTERFACE_VERSION
> + * w5-w7: Reserved (MBZ)
> + *
> + * Return register usage:
> + * w3:    Not used (MBZ)
> + * w4:    TPM service function status
> + * w5:    TPM service interface version
> + *        Bits[31:16]: major version
> + *        Bits[15:0]: minor version
> + * w6-w7: Reserved (MBZ)
> + *
> + * Possible function status codes in register w4:
> + *     CRB_FFA_OK_RESULTS_RETURNED: The version of the interface has been
> + *                                  returned.
> + */
> +#define FFA_CRB_GET_INTERFACE_VERSION 0x0f000001
> +
> +/*
> + * Return information on a given feature of the TPM service
> + * Call register usage:
> + * w3:    Not used (MBZ)
> + * w4:    TPM service function ID, FFA_CRB_START
> + * w5:    Start function qualifier
> + *            Bits[31:8] (MBZ)
> + *            Bits[7:0]
> + *              0: Notifies TPM that a command is ready to be processed
> + *              1: Notifies TPM that a locality request is ready to be processed
> + * w6:    TPM locality, one of 0..4
> + *            -If the start function qualifier is 0, identifies the locality
> + *             from where the command originated.
> + *            -If the start function qualifier is 1, identifies the locality
> + *             of the locality request
> + * w6-w7: Reserved (MBZ)
> + *
> + * Return register usage:
> + * w3:    Not used (MBZ)
> + * w4:    TPM service function status
> + * w5-w7: Reserved (MBZ)
> + *
> + * Possible function status codes in register w4:
> + *     FFA_CRB_OK: the TPM service has been notified successfully
> + *     FFA_CRB_INVARG: one or more arguments are not valid
> + *     FFA_CRB_INV_CRB_CTRL_DATA: CRB control data or locality control
> + *         data at the given TPM locality is not valid
> + *     FFA_CRB_DENIED: the TPM has previously disabled locality requests and
> + *         command processing at the given locality
> + */
> +#define FFA_CRB_START 0x0f000201
> +
> +struct ffa_crb {
> +	struct ffa_device *ffa_dev;
> +	u16 major_version;
> +	u16 minor_version;
> +	struct mutex msg_data_lock;
> +	struct ffa_send_direct_data direct_msg_data;
> +};
> +
> +static struct ffa_crb *ffa_crb;
> +
> +static int ffa_crb_to_linux_errno(int errno)
> +{
> +	int rc;
> +
> +	switch (errno) {
> +	case FFA_CRB_OK:
> +		rc = 0;
> +		break;
> +	case FFA_CRB_OK_RESULTS_RETURNED:
> +		rc = 0;
> +		break;
> +	case FFA_CRB_NOFUNC:
> +		rc = -ENOENT;
> +		break;
> +	case FFA_CRB_NOTSUP:
> +		rc = -EPERM;
> +		break;
> +	case FFA_CRB_INVARG:
> +		rc = -EINVAL;
> +		break;
> +	case FFA_CRB_INV_CRB_CTRL_DATA:
> +		rc = -ENOEXEC;
> +		break;
> +	case FFA_CRB_ALREADY:
> +		rc = -EEXIST;
> +		break;
> +	case FFA_CRB_DENIED:
> +		rc = -EACCES;
> +		break;
> +	case FFA_CRB_NOMEM:
> +		rc = -ENOMEM;
> +		break;
> +	default:
> +		rc = -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +
> +int ffa_crb_init(void)
> +{
> +	if (ffa_crb == NULL)
> +		return -ENOENT;
> +
> +	if (IS_ERR_VALUE(ffa_crb))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ffa_crb_init);
> +
> +static int __ffa_crb_send_recieve(unsigned long func_id,
> +		unsigned long a0, unsigned long a1, unsigned long a2)
> +{
> +	int ret;
> +	const struct ffa_msg_ops *msg_ops;
> +
> +	if (ffa_crb == NULL)
> +		return -ENOENT;
> +
> +	msg_ops = ffa_crb->ffa_dev->ops->msg_ops;
> +
> +	memset(&ffa_crb->direct_msg_data, 0x00,
> +			sizeof(struct ffa_send_direct_data));
> +
> +	ffa_crb->direct_msg_data.data1 = func_id;
> +	ffa_crb->direct_msg_data.data2 = a0;
> +	ffa_crb->direct_msg_data.data3 = a1;
> +	ffa_crb->direct_msg_data.data4 = a2;
> +
> +	ret = msg_ops->sync_send_receive(ffa_crb->ffa_dev,
> +			&ffa_crb->direct_msg_data);
> +	if (!ret)
> +		ret = ffa_crb_to_linux_errno(ffa_crb->direct_msg_data.data1);
> +
> +	return ret;
> +}
> +
> +int ffa_crb_get_interface_version(uint16_t *major, uint16_t *minor)
> +{
> +	int rc;
> +
> +	if (ffa_crb == NULL)
> +		return -ENOENT;
> +
> +	if (IS_ERR_VALUE(ffa_crb))
> +		return -ENODEV;
> +
> +	if (major == NULL || minor == NULL)
> +		return -EINVAL;
> +
> +	guard(mutex)(&ffa_crb->msg_data_lock);
> +
> +	rc = __ffa_crb_send_recieve(FFA_CRB_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
> +	if (!rc) {
> +		*major = FFA_CRB_MAJOR_VERSION(ffa_crb->direct_msg_data.data2);
> +		*minor = FFA_CRB_MINOR_VERSION(ffa_crb->direct_msg_data.data2);
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(ffa_crb_get_interface_version);
> +
> +int ffa_crb_start(int request_type, int locality)
> +{
> +	if (ffa_crb == NULL)
> +		return -ENOENT;
> +
> +	if (IS_ERR_VALUE(ffa_crb))
> +		return -ENODEV;
> +
> +	guard(mutex)(&ffa_crb->msg_data_lock);
> +
> +	return __ffa_crb_send_recieve(FFA_CRB_START, request_type, locality, 0x00);
> +}
> +EXPORT_SYMBOL_GPL(ffa_crb_start);
> +
> +static int ffa_crb_probe(struct ffa_device *ffa_dev)
> +{
> +	int rc;
> +	struct ffa_crb *p;
> +
> +	/* only one instance of a TPM partition is supported */
> +	if (ffa_crb && !IS_ERR_VALUE(ffa_crb))
> +		return -EEXIST;
> +
> +	ffa_crb = ERR_PTR(-ENODEV); // set ffa_crb so we can detect probe failure
> +
> +	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
> +		pr_err("TPM partition doesn't support direct message receive.\n");
> +		return -EINVAL;
> +	}
> +
> +	p = kzalloc(sizeof(*ffa_crb), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +	ffa_crb = p;
> +
> +	mutex_init(&ffa_crb->msg_data_lock);
> +	ffa_crb->ffa_dev = ffa_dev;
> +	ffa_dev_set_drvdata(ffa_dev, ffa_crb);
> +
> +	/* if TPM is aarch32 use 32-bit SMCs */
> +	if (!ffa_partition_check_property(ffa_dev, FFA_PARTITION_AARCH64_EXEC))
> +		ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
> +
> +	/* verify compatibility of TPM service version number */
> +	rc = ffa_crb_get_interface_version(&ffa_crb->major_version,
> +			&ffa_crb->minor_version);
> +	if (rc) {
> +		pr_err("failed to get crb interface version. rc:%d", rc);
> +		goto out;
> +	}
> +
> +	pr_info("ABI version %u.%u", ffa_crb->major_version,
> +		ffa_crb->minor_version);
> +
> +	if ((ffa_crb->major_version != FFA_CRB_VERSION_MAJOR) ||
> +	    (ffa_crb->minor_version < FFA_CRB_VERSION_MINOR)) {
> +		pr_err("Incompatible ABI version");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	kfree(ffa_crb);
> +	ffa_crb = ERR_PTR(-ENODEV);
> +	return -EINVAL;
> +}
> +
> +static void ffa_crb_remove(struct ffa_device *ffa_dev)
> +{
> +	kfree(ffa_crb);
> +	ffa_crb = NULL;
> +}
> +
> +static const struct ffa_device_id ffa_crb_device_id[] = {
> +	/* 17b862a4-1806-4faf-86b3-089a58353861 */
> +	{ UUID_INIT(0x17b862a4, 0x1806, 0x4faf,
> +		    0x86, 0xb3, 0x08, 0x9a, 0x58, 0x35, 0x38, 0x61) },
> +	{}
> +};
> +
> +static struct ffa_driver ffa_crb_driver = {
> +	.name = "ffa-crb",
> +	.probe = ffa_crb_probe,
> +	.remove = ffa_crb_remove,
> +	.id_table = ffa_crb_device_id,
> +};
> +
> +module_ffa_driver(ffa_crb_driver);
> +
> +MODULE_AUTHOR("Arm");
> +MODULE_DESCRIPTION("FFA CRB driver");
> +MODULE_VERSION("1.0");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_ffa_crb.h b/drivers/char/tpm/tpm_ffa_crb.h
> new file mode 100644
> index 000000000000..42327d285165
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_ffa_crb.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + *
> + * Authors:
> + * Stuart Yoder <stuart.yoder@arm.com>
> + *
> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> + *
> + * This device driver implements the TPM CRB start method
> + * as defined in the TPM Service Command Response Buffer
> + * Interface Over FF-A (DEN0138).
> + */
> +#ifndef _FFA_CRB_H
> +#define _FFA_CRB_H
> +
> +#if IS_ENABLED(CONFIG_TCG_ARM_FFA_CRB)
> +int ffa_crb_init(void);
> +int ffa_crb_get_interface_version(uint16_t *major, uint16_t *minor);
> +int ffa_crb_start(int request_type, int locality);
> +#else
> +static inline int ffa_crb_init(void) { return 0; }
> +static inline int ffa_crb_get_interface_version(uint16_t *major, uint16_t *minor) { return 0; }
> +static inline int ffa_crb_start(int request_type, int locality) { return 0; }
> +#endif
> +
> +#define FFA_CRB_START_TYPE_COMMAND 0
> +#define FFA_CRB_START_TYPE_LOCALITY_REQUEST 1
> +
> +#endif
> -- 
> 2.34.1
> 
> 

tpm_crb_ffa_*

BR, Jarkko

