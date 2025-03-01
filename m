Return-Path: <linux-integrity+bounces-5029-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C4A4A7AA
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 02:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C5E3B8E2B
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 01:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40014A0BC;
	Sat,  1 Mar 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU+BfRII"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25385C5E;
	Sat,  1 Mar 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793720; cv=none; b=XhylCvGurilUp636KP/w/ex4ZTZaBWN7QlOiOkYlJn4se2eQGYjgAn2mwDQ+eZo8Q6dPGsmICkjnj5osgigUiUpTfPXfIQ8QO9ovqoy7gSnY2PD21o2hDL5r1CjVTxTCuUdvZTgBy/tjMMWSLc1YvOj5c1uWxQ2uUUmjLoKUu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793720; c=relaxed/simple;
	bh=qZBOn/Wng+BIV3lXMuztkKv+nvAUVZl/1eNFY5+QDRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+t3Wm+ucI+bQAUNgrWEa9qhkBnpJqmYnDf4/ySQclqUkbPegF2Jown3+q0cKuxWcxkgHKcRXNFkqqa0arRmGyvEiIVJosqcxlT+exdvPyRtjs8NPmWrSbuPWD+2ITtxUP/muctgTm9dHDPqkqi7/O1EVFzGkmshygEhT2Huy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU+BfRII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB86C4CED6;
	Sat,  1 Mar 2025 01:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793719;
	bh=qZBOn/Wng+BIV3lXMuztkKv+nvAUVZl/1eNFY5+QDRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SU+BfRIINqmDpUNfjIU7OwJDRljFfSkTl5cW5hyQy7oeJHsmZAHGWziM8WOBs4Iz+
	 FIX7Tc2g0MsEkB2vUOi95T3Rw26xzZR5bHwVR8mlavAB9Ns2bd737MEvW7XCxC2lVy
	 J0ge2QAYzmSfgO6/XvZpIFK9Dzj69WblN5/kFNS8BoCZih04gWPMae/0mDHC4fVjit
	 AuhDxef4Kl/T7r/tXd2z8BorcQyl4zV8qJUclwEp88gWDWQja5NKvKYTZhybFY0flR
	 3GZ29aeI4ceJ41eLVRVsaNBenyDoqhrE55tXWEQ8ofhHzdI19pRGWX4uawdNpMEif6
	 PLi/ICcrVGQ8Q==
Date: Sat, 1 Mar 2025 03:48:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
Message-ID: <Z8JncxQM7Nkit0Q6@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-5-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:18PM +0100, Stefano Garzarella wrote:
> This is primarily designed to support an enlightened driver for the

The commit message is half-way cut.

I.e. it lacks the explanation of "this".

> AMD SVSM based vTPM, but it could be used by any TPM driver which
> communicates with a TPM device implemented through the TCG TPM reference
> implementation (https://github.com/TrustedComputingGroup/TPM)
> 
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> James, Claudio are you fine with the Cdb, Sob?
> The code is based to what was in the initial RFC, but I removed the
> tpm_platform module, moved some code in the header, changed some names,
> etc.
> For these reasons I reset the author but added C-o-b.
> Please, let me know if this is okay or if I need to do anything
> else (reset the author, etc.)
> ---
>  include/linux/tpm_tcgsim.h | 136 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 include/linux/tpm_tcgsim.h
> 
> diff --git a/include/linux/tpm_tcgsim.h b/include/linux/tpm_tcgsim.h
> new file mode 100644
> index 000000000000..bd5b123c393b
> --- /dev/null
> +++ b/include/linux/tpm_tcgsim.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + *
> + * Generic interface usable by TPM drivers interacting with devices
> + * implemented through the TCG Simulator.
> + */
> +#ifndef _TPM_TCGSIM_H_
> +#define _TPM_TCGSIM_H_
> +
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +/*
> + * The current TCG Simulator TPM commands we support.  The complete list is
> + * in the TcpTpmProtocol header:
> + *
> + * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h

We should not be dependent on any out-of-tree headers.

> + */
> +
> +#define TPM_SEND_COMMAND		8
> +#define TPM_SIGNAL_CANCEL_ON		9
> +#define TPM_SIGNAL_CANCEL_OFF		10
> +/*
> + * Any platform specific commands should be placed here and should start
> + * at 0x8000 to avoid clashes with the TCG Simulator protocol.  They should
> + * follow the same self describing buffer format below.
> + */
> +
> +#define TPM_TCGSIM_MAX_BUFFER		4096 /* max req/resp buffer size */
> +
> +/**
> + * struct tpm_req - generic request header for single word command
> + *
> + * @cmd:	The command to send
> + */
> +struct tpm_req {
> +	u32 cmd;
> +} __packed;
> +
> +/**
> + * struct tpm_resp - generic response header
> + *
> + * @size:	The response size (zero if nothing follows)
> + *
> + * Note: most TCG Simulator commands simply return zero here with no indication
> + * of success or failure.
> + */
> +struct tpm_resp {
> +	u32 size;
> +} __packed;
> +
> +/**
> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND request
> + *
> + * @hdr:	The request header whit the command (must be TPM_SEND_COMMAND)
> + * @locality:	The locality
> + * @inbuf_size:	The size of the input buffer following
> + * @inbuf:	A buffer of size inbuf_size
> + *
> + * Note that TCG Simulator expects @inbuf_size to be equal to the size of the
> + * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
> + * returned.
> + */
> +struct tpm_send_cmd_req {
> +	struct tpm_req hdr;
> +	u8 locality;
> +	u32 inbuf_size;
> +	u8 inbuf[];
> +} __packed;
> +
> +/**
> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND response
> + *
> + * @hdr:	The response header whit the following size
> + * @outbuf:	A buffer of size hdr.size
> + */
> +struct tpm_send_cmd_resp {
> +	struct tpm_resp hdr;
> +	u8 outbuf[];
> +} __packed;
> +
> +/**
> + * tpm_tcgsim_fill_send_cmd() - fill a struct tpm_send_cmd_req to be sent to the
> + * TCG Simulator.
> + * @req: The struct tpm_send_cmd_req to fill
> + * @locality: The locality
> + * @buf: The buffer from where to copy the payload of the command
> + * @len: The size of the buffer
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static inline int
> +tpm_tcgsim_fill_send_cmd(struct tpm_send_cmd_req *req, u8 locality,
> +			 const u8 *buf, size_t len)
> +{
> +	if (len > TPM_TCGSIM_MAX_BUFFER - sizeof(*req))
> +		return -EINVAL;
> +
> +	req->hdr.cmd = TPM_SEND_COMMAND;
> +	req->locality = locality;
> +	req->inbuf_size = len;
> +
> +	memcpy(req->inbuf, buf, len);
> +
> +	return 0;
> +}
> +
> +/**
> + * tpm_tcgsim_parse_send_cmd() - Parse a struct tpm_send_cmd_resp received from
> + * the TCG Simulator
> + * @resp: The struct tpm_send_cmd_resp to parse
> + * @buf: The buffer where to copy the response
> + * @len: The size of the buffer
> + *
> + * Return: buffer size filled with the response on success, negative error
> + * code on failure.
> + */
> +static inline int
> +tpm_tcgsim_parse_send_cmd(const struct tpm_send_cmd_resp *resp, u8 *buf,
> +			  size_t len)
> +{
> +	if (len < resp->hdr.size)
> +		return -E2BIG;
> +
> +	if (resp->hdr.size > TPM_TCGSIM_MAX_BUFFER - sizeof(*resp))
> +		return -EINVAL;  // Invalid response from the platform TPM
> +
> +	memcpy(buf, resp->outbuf, resp->hdr.size);
> +
> +	return resp->hdr.size;
> +}
> +
> +#endif /* _TPM_TCGSIM_H_ */
> -- 
> 2.48.1
> 

This commit got me lost tbh.

BR, Jarkko

