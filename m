Return-Path: <linux-integrity+bounces-5283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552FA6146E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB0A1B62313
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42971200119;
	Fri, 14 Mar 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8zAwdf4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F93B7A8;
	Fri, 14 Mar 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964535; cv=none; b=A6lJpzygKY8a6pY9ph4hz78F2E2HScyUj6kLXtXIO4g/NYPtr6sNvVIWX+oZ3vqwWNi/PgSyBWOe1lP8ZWe3wtvoVEBvhHcvRakJMgKovB7ff/2hWtU+necgGnvhnE9X+aabLvW4VfFopyY/zuS2EoiBF0lbSljj1Uj+If56hZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964535; c=relaxed/simple;
	bh=dPRozqUMCMlrai6HQIPjDl4kLipU3Yl7huxuozEgPEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv91rM7AdKLmT5GEWV+iBB7w7F9WRb9bIXCGUYpRgLGyTt1oN+l1sP8pZkdTvybJdRmuqgOld0XZ5u1x3zDY4Xm2VTxP5WQAmZyS/Rpym/9cCO9SIWjMWhSz7FoUToBjdg9CS+U4V4lcCO1mvJp5VE8uhr+6JflRpaELjuZgshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8zAwdf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E183DC4CEE3;
	Fri, 14 Mar 2025 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741964534;
	bh=dPRozqUMCMlrai6HQIPjDl4kLipU3Yl7huxuozEgPEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8zAwdf4chnoLMMON9P77bTQx6Qh+Z1SyotCsOkXWUooRpqi++qI3cx0C5jVwC3wn
	 a5XEnLZ0qlaZVmX6dZCH4+9qd9ZSDRXhjBhB57xeeFrXUwQAPcC0RA4OtQBpBWsvs6
	 He3D2av0Avqy/khwpvsx33AJCwsPeJMIIW+cwxn1UsyxamBTnX16J9iNN/5EgO+z6y
	 V1JWvcovTrRLp/ASgwL4aaqJSbUQyYdmRp732401yuT77pRtLDCaMVok487KSRvwDp
	 osvclEbkHdlMEmfbt1ol3mcYjIxPimlb18xUwAhWSs+3c10v8nI+7KVRe1TtKNIZAl
	 Ami0j7ByVca2A==
Date: Fri, 14 Mar 2025 17:02:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/5] tpm_crb: ffa_tpm: implement driver compliant to
 CRB over FF-A
Message-ID: <Z9RE8bOGqpSCcc6e@kernel.org>
References: <20250312215828.664402-1-stuart.yoder@arm.com>
 <20250312215828.664402-2-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312215828.664402-2-stuart.yoder@arm.com>

On Wed, Mar 12, 2025 at 04:58:24PM -0500, Stuart Yoder wrote:
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
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

nit: should have been removed given the build issue (to make
apparent the need for review).

> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/Kconfig       |   9 +
>  drivers/char/tpm/Makefile      |   1 +
>  drivers/char/tpm/tpm_crb_ffa.c | 348 +++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_crb_ffa.h |  25 +++
>  4 files changed, 383 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
>  create mode 100644 drivers/char/tpm/tpm_crb_ffa.h
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e059..fe4f3a609934 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -210,6 +210,15 @@ config TCG_CRB
>  	  from within Linux.  To compile this driver as a module, choose
>  	  M here; the module will be called tpm_crb.
>  
> +config TCG_ARM_CRB_FFA
> +	tristate "TPM CRB over Arm FF-A Transport"
> +	depends on ARM_FFA_TRANSPORT && TCG_CRB
> +	default TCG_CRB
> +	help
> +	  If the Arm FF-A transport is used to access the TPM say Yes.
> +	  To compile this driver as a module, choose M here; the module
> +	  will be called tpm_crb_ffa.
> +
>  config TCG_VTPM_PROXY
>  	tristate "VTPM Proxy Interface"
>  	depends on TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c75243..2b004df8c04b 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -42,5 +42,6 @@ obj-$(CONFIG_TCG_IBMVTPM) += tpm_ibmvtpm.o
>  obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
>  obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
> +obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> new file mode 100644
> index 000000000000..3169a87a56b6
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_crb_ffa.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + *
> + * This device driver implements the TPM CRB start method
> + * as defined in the TPM Service Command Response Buffer
> + * Interface Over FF-A (DEN0138).
> + */
> +
> +#define pr_fmt(fmt) "CRB_FFA: " fmt
> +
> +#include <linux/arm_ffa.h>
> +#include "tpm_crb_ffa.h"
> +
> +/* TPM service function status codes */
> +#define CRB_FFA_OK			0x05000001
> +#define CRB_FFA_OK_RESULTS_RETURNED	0x05000002
> +#define CRB_FFA_NOFUNC			0x8e000001
> +#define CRB_FFA_NOTSUP			0x8e000002
> +#define CRB_FFA_INVARG			0x8e000005
> +#define CRB_FFA_INV_CRB_CTRL_DATA	0x8e000006
> +#define CRB_FFA_ALREADY			0x8e000009
> +#define CRB_FFA_DENIED			0x8e00000a
> +#define CRB_FFA_NOMEM			0x8e00000b
> +
> +#define CRB_FFA_VERSION_MAJOR	1
> +#define CRB_FFA_VERSION_MINOR	0
> +
> +/* version encoding */
> +#define CRB_FFA_MAJOR_VERSION_MASK  GENMASK(30, 16)
> +#define CRB_FFA_MINOR_VERSION_MASK  GENMASK(15, 0)
> +#define CRB_FFA_MAJOR_VERSION(x)    ((u16)(FIELD_GET(CRB_FFA_MAJOR_VERSION_MASK, (x))))
> +#define CRB_FFA_MINOR_VERSION(x)    ((u16)(FIELD_GET(CRB_FFA_MINOR_VERSION_MASK, (x))))
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
> + * w4:    TPM service function ID, CRB_FFA_GET_INTERFACE_VERSION
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
> +#define CRB_FFA_GET_INTERFACE_VERSION 0x0f000001
> +
> +/*
> + * Return information on a given feature of the TPM service
> + * Call register usage:
> + * w3:    Not used (MBZ)
> + * w4:    TPM service function ID, CRB_FFA_START
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
> + *     CRB_FFA_OK: the TPM service has been notified successfully
> + *     CRB_FFA_INVARG: one or more arguments are not valid
> + *     CRB_FFA_INV_CRB_CTRL_DATA: CRB control data or locality control
> + *         data at the given TPM locality is not valid
> + *     CRB_FFA_DENIED: the TPM has previously disabled locality requests and
> + *         command processing at the given locality
> + */
> +#define CRB_FFA_START 0x0f000201
> +
> +struct tpm_crb_ffa {
> +	struct ffa_device *ffa_dev;
> +	u16 major_version;
> +	u16 minor_version;
> +	/* lock to protect sending of FF-A messages: */
> +	struct mutex msg_data_lock;
> +	struct ffa_send_direct_data direct_msg_data;
> +};
> +
> +static struct tpm_crb_ffa *tpm_crb_ffa;
> +
> +static int tpm_crb_ffa_to_linux_errno(int errno)
> +{
> +	int rc;
> +
> +	switch (errno) {
> +	case CRB_FFA_OK:
> +		rc = 0;
> +		break;
> +	case CRB_FFA_OK_RESULTS_RETURNED:
> +		rc = 0;
> +		break;
> +	case CRB_FFA_NOFUNC:
> +		rc = -ENOENT;
> +		break;
> +	case CRB_FFA_NOTSUP:
> +		rc = -EPERM;
> +		break;
> +	case CRB_FFA_INVARG:
> +		rc = -EINVAL;
> +		break;
> +	case CRB_FFA_INV_CRB_CTRL_DATA:
> +		rc = -ENOEXEC;
> +		break;
> +	case CRB_FFA_ALREADY:
> +		rc = -EEXIST;
> +		break;
> +	case CRB_FFA_DENIED:
> +		rc = -EACCES;
> +		break;
> +	case CRB_FFA_NOMEM:
> +		rc = -ENOMEM;
> +		break;
> +	default:
> +		rc = -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * tpm_crb_ffa_init - called by the CRB driver to do any needed initialization
> + *
> + * This function is called by the tpm_crb driver during the tpm_crb
> + * driver's initialization. If the tpm_crb_ffa has not been probed
> + * yet, returns -ENOENT in order to force a retry.  If th ffa_crb
> + * driver had been probed  but failed with an error, returns -ENODEV
> + * in order to prevent further retries.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int tpm_crb_ffa_init(void)
> +{
> +	if (!tpm_crb_ffa)
> +		return -ENOENT;
> +
> +	if (IS_ERR_VALUE(tpm_crb_ffa))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);
> +
> +static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
> +				      unsigned long a0,
> +				      unsigned long a1,
> +				      unsigned long a2)
> +{
> +	const struct ffa_msg_ops *msg_ops;
> +	int ret;
> +
> +	if (!tpm_crb_ffa)
> +		return -ENOENT;
> +
> +	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> +
> +	memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> +	       sizeof(struct ffa_send_direct_data));
> +
> +	tpm_crb_ffa->direct_msg_data.data1 = func_id;
> +	tpm_crb_ffa->direct_msg_data.data2 = a0;
> +	tpm_crb_ffa->direct_msg_data.data3 = a1;
> +	tpm_crb_ffa->direct_msg_data.data4 = a2;
> +
> +	ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> +			&tpm_crb_ffa->direct_msg_data);
> +	if (!ret)
> +		ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
> +
> +	return ret;
> +}
> +
> +/**
> + * tpm_crb_ffa_get_interface_version() - gets the ABI version of the TPM service
> + * @major: Pointer to caller-allocated buffer to hold the major version
> + *         number the ABI
> + * @minor: Pointer to caller-allocated buffer to hold the minor version
> + *         number the ABI
> + *
> + * Returns the major and minor version of the ABI of the FF-A based TPM.
> + * Allows the caller to evaluate its compatibility with the version of
> + * the ABI.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
> +{
> +	int rc;
> +
> +	if (!tpm_crb_ffa)
> +		return -ENOENT;
> +
> +	if (IS_ERR_VALUE(tpm_crb_ffa))
> +		return -ENODEV;
> +
> +	if (!major || !minor)
> +		return -EINVAL;
> +
> +	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
> +
> +	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
> +	if (!rc) {
> +		*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> +		*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm_crb_ffa_get_interface_version);
> +
> +/**
> + * tpm_crb_ffa_start() - signals the TPM that a field has changed in the CRB
> + * @request_type: Identifies whether the change to the CRB is in the command
> + *                fields or locality fields.
> + * @locality: Specifies the locality number.
> + *
> + * Used by the CRB driver
> + * that might be useful to those using or modifying it.  Begins with
> + * empty comment line, and may include additional embedded empty
> + * comment lines.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int tpm_crb_ffa_start(int request_type, int locality)
> +{
> +	if (!tpm_crb_ffa)
> +		return -ENOENT;
> +
> +	if (IS_ERR_VALUE(tpm_crb_ffa))
> +		return -ENODEV;
> +
> +	guard(mutex)(&tpm_crb_ffa->msg_data_lock);
> +
> +	return __tpm_crb_ffa_send_recieve(CRB_FFA_START, request_type, locality, 0x00);
> +}
> +EXPORT_SYMBOL_GPL(tpm_crb_ffa_start);
> +
> +static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> +{
> +	struct tpm_crb_ffa *p;
> +	int rc;
> +
> +	/* only one instance of a TPM partition is supported */
> +	if (tpm_crb_ffa && !IS_ERR_VALUE(tpm_crb_ffa))
> +		return -EEXIST;
> +
> +	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure
> +
> +	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
> +		pr_err("TPM partition doesn't support direct message receive.\n");
> +		return -EINVAL;
> +	}
> +
> +	p = kzalloc(sizeof(*tpm_crb_ffa), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +	tpm_crb_ffa = p;
> +
> +	mutex_init(&tpm_crb_ffa->msg_data_lock);
> +	tpm_crb_ffa->ffa_dev = ffa_dev;
> +	ffa_dev_set_drvdata(ffa_dev, tpm_crb_ffa);
> +
> +	/* if TPM is aarch32 use 32-bit SMCs */
> +	if (!ffa_partition_check_property(ffa_dev, FFA_PARTITION_AARCH64_EXEC))
> +		ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
> +
> +	/* verify compatibility of TPM service version number */
> +	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
> +					       &tpm_crb_ffa->minor_version);
> +	if (rc) {
> +		pr_err("failed to get crb interface version. rc:%d", rc);
> +		goto out;
> +	}
> +
> +	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
> +		tpm_crb_ffa->minor_version);
> +
> +	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
> +	    (tpm_crb_ffa->minor_version > 0 &&
> +	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
> +		pr_err("Incompatible ABI version");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	kfree(tpm_crb_ffa);
> +	tpm_crb_ffa = ERR_PTR(-ENODEV);
> +	return -EINVAL;
> +}
> +
> +static void tpm_crb_ffa_remove(struct ffa_device *ffa_dev)
> +{
> +	kfree(tpm_crb_ffa);
> +	tpm_crb_ffa = NULL;
> +}
> +
> +static const struct ffa_device_id tpm_crb_ffa_device_id[] = {
> +	/* 17b862a4-1806-4faf-86b3-089a58353861 */
> +	{ UUID_INIT(0x17b862a4, 0x1806, 0x4faf,
> +		    0x86, 0xb3, 0x08, 0x9a, 0x58, 0x35, 0x38, 0x61) },
> +	{}
> +};
> +
> +static struct ffa_driver tpm_crb_ffa_driver = {
> +	.name = "ffa-crb",
> +	.probe = tpm_crb_ffa_probe,
> +	.remove = tpm_crb_ffa_remove,
> +	.id_table = tpm_crb_ffa_device_id,
> +};
> +
> +module_ffa_driver(tpm_crb_ffa_driver);
> +
> +MODULE_AUTHOR("Arm");
> +MODULE_DESCRIPTION("TPM CRB FFA driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/char/tpm/tpm_crb_ffa.h b/drivers/char/tpm/tpm_crb_ffa.h
> new file mode 100644
> index 000000000000..645c41ede10e
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_crb_ffa.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + *
> + * This device driver implements the TPM CRB start method
> + * as defined in the TPM Service Command Response Buffer
> + * Interface Over FF-A (DEN0138).
> + */
> +#ifndef _TPM_CRB_FFA_H
> +#define _TPM_CRB_FFA_H
> +
> +#if IS_REACHABLE(CONFIG_TCG_ARM_CRB_FFA)

Yes, this is correct given that it returns false on "vmlinux -> module"
situation ("vmlinux -> vmlinux" and "module -> module" still work).

> +int tpm_crb_ffa_init(void);
> +int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor);
> +int tpm_crb_ffa_start(int request_type, int locality);
> +#else
> +static inline int tpm_crb_ffa_init(void) { return 0; }
> +static inline int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor) { return 0; }
> +static inline int tpm_crb_ffa_start(int request_type, int locality) { return 0; }
> +#endif
> +
> +#define CRB_FFA_START_TYPE_COMMAND 0
> +#define CRB_FFA_START_TYPE_LOCALITY_REQUEST 1
> +
> +#endif
> -- 
> 2.34.1
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[applying next week]

BR, Jarkko

