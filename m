Return-Path: <linux-integrity+bounces-5226-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B299DA5BD3F
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 11:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A413A6F71
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD88231A30;
	Tue, 11 Mar 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L20BzaMm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51942065;
	Tue, 11 Mar 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687679; cv=none; b=qTvS1UWRO/ncB0eqUPZ666sobm3kO81JIu0+Um6WiisRxtMuVoy4nbJRsdx4BHD40M3xLkwNHb38Y7OwwPlhNNBZTDLLajaBaJ3PdBD/tYmQi4LvyiN+Zc4mz0e3Y1H1f8kb4LcFIdE551Jc7XHMpRjrAektk+N1BQOW3Vb68Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687679; c=relaxed/simple;
	bh=lFmsRBdUP3YPjBoluZocaCzD1BiaN6yiSoOp1Pz5FAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1gGCqe9FoSkRj3Jq9jrXkAdxdvHkzOUzUv2YPe8uLf9dFgX2L7Evnyd+7M9IpjwRq9S8kuXEI+YOF5xfhdr48RSwbgJuSQsODTG0R/6M8gN56oRl7ZYiegNZszbkTF+D3w0R2u7XWr030zyatE3gRQy4BOSNZocKH3zlvanVFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L20BzaMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2963C4CEED;
	Tue, 11 Mar 2025 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687679;
	bh=lFmsRBdUP3YPjBoluZocaCzD1BiaN6yiSoOp1Pz5FAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L20BzaMmOo3mt4XeCu8bTQA5aYTDrCQnIpI+E0tKdwUHgM+SS712akvSJXEnE9JEc
	 ZyXdUzsgVjOKtbjV4Qu7xCeR2cWENoGVMzFNbvsJqFNUFy1zwbABOPbR5mI4czzl+p
	 ZMDXBOL2b0HnvTBEUfCt+yadpPdoRFIEMHIHa358zU4vsPnzC2yZZckGlfihjvGIFW
	 kLioYZJ4MtZ3kim2Xkax/SjQAp2Gn09/zY1s4ioRtKOFlYzuRuJrs3r0q8uHFUEDJU
	 if3Q4gb5Y5b3QyI6aSfBxVjbeKIbro1AEI+sWyEcjCBXdFUprw4jbqAhBgJIfpNm+/
	 02l1+Fh+8NRnw==
Date: Tue, 11 Mar 2025 12:07:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Tom Lendacky <thomas.lendacky@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Message-ID: <Z9ALe-kPZ5o_pim7@kernel.org>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311094225.35129-3-sgarzare@redhat.com>

On Tue, Mar 11, 2025 at 10:42:23AM +0100, Stefano Garzarella wrote:
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
> v3:
> - renamed header and prefix to make clear it's related to the SVSM vTPM
>   protocol
> - renamed fill/parse functions [Tom]
> - removed link to the spec because those URLs are unstable [Borislav]
> ---
>  include/linux/svsm_vtpm.h | 141 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 include/linux/svsm_vtpm.h
> 
> diff --git a/include/linux/svsm_vtpm.h b/include/linux/svsm_vtpm.h
> new file mode 100644
> index 000000000000..2ce9b1cb827e
> --- /dev/null
> +++ b/include/linux/svsm_vtpm.h
> @@ -0,0 +1,141 @@
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
> +#ifndef _SVSM_VTPM_H_
> +#define _SVSM_VTPM_H_
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
> +#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
> +

Across the board below data structures: I'd svsm_vtpm_ prefix them.
The rational is quite practical: it would easier to grep them later
on.

> +/**
> + * struct tpm_req - generic request header for single word command
> + *
> + * @cmd:	The command to send
> + */
> +struct tpm_req {
> +	u32 cmd;
> +} __packed;

__packed is useless here.

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

Ditto.

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

Useless nesting that makes this obfuscated: you can just as well put
that single field here, i.e.

	u32 cmd;

> +	u8 locality;
> +	u32 inbuf_size;
> +	u8 inbuf[];

Why not just buf?

> +} __packed;

Since we don't care about TCG Simulator compatibility I'd expect that
these are ordered in a way that they align nicely. E.g.,

struct svsm_vtpm_request {
	u32 command;
	u16 locality;
	u16 buffer_size;
	u8 buffer[];
};

64k should enough for any possible TPM command.

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

Why this does not have size? Here also __packed is useless even with the
pre-existing layout, and something like svsm_tpm_response would be a
factor more reasonable name.

> +
> +/**
> + * svsm_vtpm_fill_cmd_req() - fill a struct tpm_send_cmd_req to be sent to SVSM

> + * @req: The struct tpm_send_cmd_req to fill
> + * @locality: The locality
> + * @buf: The buffer from where to copy the payload of the command
> + * @len: The size of the buffer
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static inline int
> +svsm_vtpm_fill_cmd_req(struct tpm_send_cmd_req *req, u8 locality,
> +		       const u8 *buf, size_t len)

svsm_vtpm_fill_request()

> +{
> +	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
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
> + * svsm_vtpm_parse_cmd_resp() - Parse a struct tpm_send_cmd_resp received from
> + * SVSM
> + * @resp: The struct tpm_send_cmd_resp to parse
> + * @buf: The buffer where to copy the response
> + * @len: The size of the buffer
> + *
> + * Return: buffer size filled with the response on success, negative error
> + * code on failure.
> + */
> +static inline int
> +svsm_vtpm_parse_cmd_resp(const struct tpm_send_cmd_resp *resp, u8 *buf,
> +			 size_t len)

svsm_vtpm_parse_response()

> +{
> +	if (len < resp->hdr.size)
> +		return -E2BIG;
> +
> +	if (resp->hdr.size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
> +		return -EINVAL;  // Invalid response from the platform TPM
> +
> +	memcpy(buf, resp->outbuf, resp->hdr.size);
> +
> +	return resp->hdr.size;
> +}
> +
> +#endif /* _SVSM_VTPM_H_ */
> -- 
> 2.48.1
> 

BR, Jarkko

