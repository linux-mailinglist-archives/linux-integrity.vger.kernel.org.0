Return-Path: <linux-integrity+bounces-5451-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BCCA71F20
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 20:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B395189859A
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 19:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1438254AF7;
	Wed, 26 Mar 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7H1zHfe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718ED253B67;
	Wed, 26 Mar 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017233; cv=none; b=l+RTEifZEJndSgTACGn0GoTJpyuJEmeooRq2kbMt4svZRbcTVLRgbVVvyfk96194iHZTpkHvXkbozchlMr1ufj6U13Sgd03yz0G6SKyhA842O/yjX19y818Zv7SwhpgzA+ulGm/iABLCL01Xt98wJZbQ35/5NO+t3JAxF3L+4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017233; c=relaxed/simple;
	bh=5iHQPfbctrSC7dSBsYc3jaiqsRDAIya5ZCYxpgK5Nc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnR7OaVbRq4yJ9OSsnfQzmTTPX4VI8Pr1Al1Xmu6guwtH2ygHRt0eUK950YkPlhVHfLk/QI3zM8u7Rj/eWn7zpXV829jHOJ2U0qS7051xmvUUZcYYT6Ajp/5DnKCHek8CpLFqF2yxbFxJeL64Jq0E7toPGJgUbgY2MqJjLSWIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7H1zHfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE0C4CEE2;
	Wed, 26 Mar 2025 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743017232;
	bh=5iHQPfbctrSC7dSBsYc3jaiqsRDAIya5ZCYxpgK5Nc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7H1zHfeFlt52dwrzEEh5mv4LpX2PNy/dOB7Wd8PNZ7PD5XIkS3iBjuyc2MkouA1n
	 FjVoON4CpOEBhrutKCQUlPg77r4OQ/5HDF3ZX1hug+vUzGHYmbYXN0Iit67t7lMV1l
	 JtXWIA4m/cuUp5IdkWk7onZt9TtIcVOKVNbEg43VmW8CIYQnjpWwtPiH+yBhz4aYkh
	 tC3lFgJYcDDzRV5uw0Ss5b2KkJEzoQlnKJ7fgnx4qqb9WTzHlu+6guLfT0UVAECEZY
	 5/c1KkVMAGQJoGvyr7ovucnmCvciKuS97wmmyJtpemYl0wrWSZJyAZGotWeXXrjo/L
	 egHC64ZXFLB2Q==
Date: Wed, 26 Mar 2025 21:27:08 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Message-ID: <Z-RVDPlrQ-OWzBo5@kernel.org>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324104653.138663-3-sgarzare@redhat.com>

On Mon, Mar 24, 2025 at 11:46:47AM +0100, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by
> the AMD SVSM spec [1].
> 
> The vTPM protocol follows the Official TPM 2.0 Reference Implementation
> (originally by Microsoft, now part of the TCG) simulator protocol.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
> 
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
> - used svsm_vtpm_ prefix consistently [Jarkko]
> - removed __packed where not needed [Jarkko]
> - expanded headers to avoid obfuscation [Jarkko]
> - used `buf` instead of `inbuf`/`outbuf` [Jarkko]
> - added more documentation quoting the specification
> - removed TPM_* macros since we only use TPM_SEND_COMMAND in one place
>   and don't want dependencies on external headers, but put the value
>   directly as specified in the AMD SVSM specification
> - header renamed in tpm_svsm.h so it will fall under TPM DEVICE DRIVER
>   section [Borislav, Jarkko]
> v3:
> - renamed header and prefix to make clear it's related to the SVSM vTPM
>   protocol
> - renamed fill/parse functions [Tom]
> - removed link to the spec because those URLs are unstable [Borislav]
> ---
>  include/linux/tpm_svsm.h | 149 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 include/linux/tpm_svsm.h
> 
> diff --git a/include/linux/tpm_svsm.h b/include/linux/tpm_svsm.h
> new file mode 100644
> index 000000000000..38e341f9761a
> --- /dev/null
> +++ b/include/linux/tpm_svsm.h
> @@ -0,0 +1,149 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + *
> + * Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by the
> + * AMD SVSM spec [1].
> + *
> + * The vTPM protocol follows the Official TPM 2.0 Reference Implementation
> + * (originally by Microsoft, now part of the TCG) simulator protocol.
> + *
> + * [1] "Secure VM Service Module for SEV-SNP Guests"
> + *     Publication # 58019 Revision: 1.00
> + */
> +#ifndef _TPM_SVSM_H_
> +#define _TPM_SVSM_H_
> +
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
> +
> +/**
> + * struct svsm_vtpm_request - Generic request for single word command
> + * @cmd:	The command to send
> + *
> + * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
> + * Table 15: vTPM Common Request/Response Structure
> + *     Byte      Size       In/Out    Description
> + *     Offset    (Bytes)
> + *     0x000     4          In        Platform command
> + *                          Out       Platform command response size
> + */
> +struct svsm_vtpm_request {
> +	u32 cmd;
> +};
> +
> +/**
> + * struct svsm_vtpm_response - Generic response
> + * @size:	The response size (zero if nothing follows)
> + *
> + * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
> + * Table 15: vTPM Common Request/Response Structure
> + *     Byte      Size       In/Out    Description
> + *     Offset    (Bytes)
> + *     0x000     4          In        Platform command
> + *                          Out       Platform command response size
> + *
> + * Note: most TCG Simulator commands simply return zero here with no indication
> + * of success or failure.
> + */
> +struct svsm_vtpm_response {
> +	u32 size;
> +};
> +
> +/**
> + * struct svsm_vtpm_cmd_request - Structure for a TPM_SEND_COMMAND request
> + * @cmd:	The command to send (must be TPM_SEND_COMMAND)
> + * @locality:	The locality
> + * @buf_size:	The size of the input buffer following
> + * @buf:	A buffer of size buf_size
> + *
> + * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
> + * Table 16: TPM_SEND_COMMAND Request Structure
> + *     Byte      Size       Meaning
> + *     Offset    (Bytes)
> + *     0x000     4          Platform command (8)
> + *     0x004     1          Locality (must-be-0)
> + *     0x005     4          TPM Command size (in bytes)
> + *     0x009     Variable   TPM Command
> + *
> + * Note: the TCG Simulator expects @buf_size to be equal to the size of the
> + * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is returned.
> + */
> +struct svsm_vtpm_cmd_request {
> +	u32 cmd;
> +	u8 locality;
> +	u32 buf_size;
> +	u8 buf[];
> +} __packed;
> +
> +/**
> + * struct svsm_vtpm_cmd_response - Structure for a TPM_SEND_COMMAND response
> + * @buf_size:	The size of the output buffer following
> + * @buf:	A buffer of size buf_size
> + *
> + * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
> + * Table 17: TPM_SEND_COMMAND Response Structure
> + *     Byte      Size       Meaning
> + *     Offset    (Bytes)
> + *     0x000     4          Response size (in bytes)
> + *     0x004     Variable   Response
> + */
> +struct svsm_vtpm_cmd_response {
> +	u32 buf_size;
> +	u8 buf[];
> +};
> +
> +/**
> + * svsm_vtpm_cmd_request_fill() - Fill a TPM_SEND_COMMAND request to be sent to SVSM
> + * @req: The struct svsm_vtpm_cmd_request to fill
> + * @locality: The locality
> + * @buf: The buffer from where to copy the payload of the command
> + * @len: The size of the buffer
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static inline int
> +svsm_vtpm_cmd_request_fill(struct svsm_vtpm_cmd_request *req, u8 locality,
> +			   const u8 *buf, size_t len)
> +{
> +	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
> +		return -EINVAL;
> +
> +	req->cmd = 8; /* TPM_SEND_COMMAND */
> +	req->locality = locality;
> +	req->buf_size = len;
> +
> +	memcpy(req->buf, buf, len);
> +
> +	return 0;
> +}
> +
> +/**
> + * svsm_vtpm_cmd_response_parse() - Parse a TPM_SEND_COMMAND response received from SVSM
> + * @resp: The struct svsm_vtpm_cmd_response to parse
> + * @buf: The buffer where to copy the response
> + * @len: The size of the buffer
> + *
> + * Return: buffer size filled with the response on success, negative error
> + * code on failure.
> + */
> +static inline int
> +svsm_vtpm_cmd_response_parse(const struct svsm_vtpm_cmd_response *resp, u8 *buf,
> +			     size_t len)
> +{
> +	if (len < resp->buf_size)
> +		return -E2BIG;
> +
> +	if (resp->buf_size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
> +		return -EINVAL;  // Invalid response from the platform TPM
> +
> +	memcpy(buf, resp->buf, resp->buf_size);
> +
> +	return resp->buf_size;
> +}
> +
> +#endif /* _TPM_SVSM_H_ */
> -- 
> 2.49.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

