Return-Path: <linux-integrity+bounces-5068-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E5A4E3E4
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB5617CC6E
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC29283680;
	Tue,  4 Mar 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggalFGBA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213B259CB6
	for <linux-integrity@vger.kernel.org>; Tue,  4 Mar 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101858; cv=none; b=LrSRx9ieXvwhJE1X9ie24T/noruFuJxGS0n+mhL/cJlNNo+eBrM0yrV/XiuhcGQQvf6gGJK4riZWjFsNre+w++qTgOacOIrAdrBcW/UjFB3RNH7leoDxZz18krRK2O1z4iJA26D1n9GdGs6u+AVT8zLfcMQtOeU6tqLie17JhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101858; c=relaxed/simple;
	bh=9Jnaaj+MupYsXtZ5FbywLqogWLKCVBeU+mapvXdmuLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTNpkDM8cKNMoC5Bf0wPm/eDW7Mb0XjCXRQq2w1FjMwTGxu66QyEFkOfnWQC4XSNt4royIA/ngwZbpsrhuZbr2NGdoRo6FURdoY23hEf/Puf8lMRctF3aIrMnGFFoSiD8uwWq0xNqoVE/qt/IF5d7ySeUATG+Q1ZeqL4ToI5n1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggalFGBA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741101855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvFubViMNlvElEXntbaUBxPleCcZNXXI9ACRXmzKeq0=;
	b=ggalFGBA1dh3bu4i1jNbTgIS+PCtrM6q8qlHlnesW+XfqLIgyYqfSky2Wt9b2I3l978p5r
	N0fzMfiOvEjRKdEKSHLTj3TtOYv7/OSleQogquoI79X8Lw3A0pLX4pJGaKSSUyRqsUXcka
	x0Vx+juOqaDNwfys8EOjtOnrColNLjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-wAR9OPcwOqGYwhX5XtaNIA-1; Tue, 04 Mar 2025 10:23:59 -0500
X-MC-Unique: wAR9OPcwOqGYwhX5XtaNIA-1
X-Mimecast-MFC-AGG-ID: wAR9OPcwOqGYwhX5XtaNIA_1741101838
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f7db84faso2740142f8f.2
        for <linux-integrity@vger.kernel.org>; Tue, 04 Mar 2025 07:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101838; x=1741706638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvFubViMNlvElEXntbaUBxPleCcZNXXI9ACRXmzKeq0=;
        b=iiPl7ywb9WNOaNqDnELZa+vM84xlrHET1c8U0bTZ9qljO7y1zqe+goT3SFd8VoxEgL
         LuaPK/odzJE6bSi3VRgrXL1EsA2N7I/vibe1sBGgtgxmpCplE3Xo559njzJwBm+YShGF
         +TTdCb9e1UkblkL92/SpaZj78S/fCqtQV+c115KG4T6hqOWmRYVoglu8eia5GKNtZTQJ
         Tb0f/YedTosAvMigMl2WFyHLulAM6AxGjXgj9cE250vzcjia2LnHD3Dv4AnCAH6hu3U7
         yoHOkCAj3EpW7+yKHHuVAjM+rPe8yv1RUdxqqaDXu9u4BXGEcW3FBet0ZFhQZbFtoMtU
         jimQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3dazCDVjuftENerIt6Gx26+o8dS3N8/8vxvEtg6tD4OByWJEunehhhYXlWmPCfN2NqNddl1dz1L5WVbIBZBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvX1RWFm/nzr+GbScY0cY1EJdYlRUNTejdIkFywgQvPd8XT0lq
	lnnDqoMsHCYi4ZTy4ue7uEIMDGbEg66fJDUAh7tsXDe1ir1e6hhpdIIlTM8JXADl32oh2eoYElZ
	mXaCDHl0mlsp/K9xI/f5zn0Kyqv1Gy1Kz8bmiOSFTGistb6a+z4p13sCd2Sx97mjbQQ==
X-Gm-Gg: ASbGncuT/l80FDnqaCceYAecl47nGwxZ+QCrOGQ0u6oCHUVGe2r31svMn35epRJLInn
	2qG63fiX9YzyrzjgwOd8Y2Sh/yJthYme6MLhToAIxdvwyWn90yJEGPZt4D5b8QiizesBe+/tZRI
	yd3LIEBuaFkD3wNAzewqkQH84PHxNDAo7/2zkIHVW+RL/8mLYd5IzHgeNlf6U+CHGkgsA8b48oC
	gYOhSe5BmIZNRVV+rnrT9DvRMzNTo33trIPPUKyH0fMLl/30Oiy4DVw0D1v3itcdOowMjxvoJuW
	8Zt5iaHLnCWA8Xz6bWaQzP6tdoclE4ZBRJLd3i46UnaNvVpLwuGMBMeA45jcgYCu
X-Received: by 2002:adf:fc11:0:b0:38c:5fbf:10ca with SMTP id ffacd0b85a97d-390eca06cf4mr15878890f8f.39.1741101837761;
        Tue, 04 Mar 2025 07:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXUbzP/MD3DaiOBhULX8asTjjiwbkIGLuALrZE+TAO2F//xDur+SEeYf1Lx6gpZrq9uCm1kg==
X-Received: by 2002:adf:fc11:0:b0:38c:5fbf:10ca with SMTP id ffacd0b85a97d-390eca06cf4mr15878837f8f.39.1741101837140;
        Tue, 04 Mar 2025 07:23:57 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6cdsm17907254f8f.84.2025.03.04.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:23:56 -0800 (PST)
Date: Tue, 4 Mar 2025 16:23:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
Message-ID: <7dltjdc4csdao5djx2jkjnvm72ubhagjwvgrpyqrr3aeo5cicn@cxrxusjpgce7>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-5-sgarzare@redhat.com>
 <Z8JncxQM7Nkit0Q6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8JncxQM7Nkit0Q6@kernel.org>

On Sat, Mar 01, 2025 at 03:48:35AM +0200, Jarkko Sakkinen wrote:
>On Fri, Feb 28, 2025 at 06:07:18PM +0100, Stefano Garzarella wrote:
>> This is primarily designed to support an enlightened driver for the
>
>The commit message is half-way cut.
>
>I.e. it lacks the explanation of "this".
>
>> AMD SVSM based vTPM, but it could be used by any TPM driver which
>> communicates with a TPM device implemented through the TCG TPM reference
>> implementation (https://github.com/TrustedComputingGroup/TPM)
>>
>> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> James, Claudio are you fine with the Cdb, Sob?
>> The code is based to what was in the initial RFC, but I removed the
>> tpm_platform module, moved some code in the header, changed some names,
>> etc.
>> For these reasons I reset the author but added C-o-b.
>> Please, let me know if this is okay or if I need to do anything
>> else (reset the author, etc.)
>> ---
>>  include/linux/tpm_tcgsim.h | 136 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 136 insertions(+)
>>  create mode 100644 include/linux/tpm_tcgsim.h
>>
>> diff --git a/include/linux/tpm_tcgsim.h b/include/linux/tpm_tcgsim.h
>> new file mode 100644
>> index 000000000000..bd5b123c393b
>> --- /dev/null
>> +++ b/include/linux/tpm_tcgsim.h
>> @@ -0,0 +1,136 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>> + *
>> + * Generic interface usable by TPM drivers interacting with devices
>> + * implemented through the TCG Simulator.
>> + */
>> +#ifndef _TPM_TCGSIM_H_
>> +#define _TPM_TCGSIM_H_
>> +
>> +#include <linux/errno.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +/*
>> + * The current TCG Simulator TPM commands we support.  The complete list is
>> + * in the TcpTpmProtocol header:
>> + *
>> + * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h
>
>We should not be dependent on any out-of-tree headers.
>
>> + */
>> +
>> +#define TPM_SEND_COMMAND		8
>> +#define TPM_SIGNAL_CANCEL_ON		9
>> +#define TPM_SIGNAL_CANCEL_OFF		10
>> +/*
>> + * Any platform specific commands should be placed here and should start
>> + * at 0x8000 to avoid clashes with the TCG Simulator protocol.  They should
>> + * follow the same self describing buffer format below.
>> + */
>> +
>> +#define TPM_TCGSIM_MAX_BUFFER		4096 /* max req/resp buffer size */
>> +
>> +/**
>> + * struct tpm_req - generic request header for single word command
>> + *
>> + * @cmd:	The command to send
>> + */
>> +struct tpm_req {
>> +	u32 cmd;
>> +} __packed;
>> +
>> +/**
>> + * struct tpm_resp - generic response header
>> + *
>> + * @size:	The response size (zero if nothing follows)
>> + *
>> + * Note: most TCG Simulator commands simply return zero here with no indication
>> + * of success or failure.
>> + */
>> +struct tpm_resp {
>> +	u32 size;
>> +} __packed;
>> +
>> +/**
>> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND request
>> + *
>> + * @hdr:	The request header whit the command (must be TPM_SEND_COMMAND)
>> + * @locality:	The locality
>> + * @inbuf_size:	The size of the input buffer following
>> + * @inbuf:	A buffer of size inbuf_size
>> + *
>> + * Note that TCG Simulator expects @inbuf_size to be equal to the size of the
>> + * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
>> + * returned.
>> + */
>> +struct tpm_send_cmd_req {
>> +	struct tpm_req hdr;
>> +	u8 locality;
>> +	u32 inbuf_size;
>> +	u8 inbuf[];
>> +} __packed;
>> +
>> +/**
>> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND response
>> + *
>> + * @hdr:	The response header whit the following size
>> + * @outbuf:	A buffer of size hdr.size
>> + */
>> +struct tpm_send_cmd_resp {
>> +	struct tpm_resp hdr;
>> +	u8 outbuf[];
>> +} __packed;
>> +
>> +/**
>> + * tpm_tcgsim_fill_send_cmd() - fill a struct tpm_send_cmd_req to be sent to the
>> + * TCG Simulator.
>> + * @req: The struct tpm_send_cmd_req to fill
>> + * @locality: The locality
>> + * @buf: The buffer from where to copy the payload of the command
>> + * @len: The size of the buffer
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +static inline int
>> +tpm_tcgsim_fill_send_cmd(struct tpm_send_cmd_req *req, u8 locality,
>> +			 const u8 *buf, size_t len)
>> +{
>> +	if (len > TPM_TCGSIM_MAX_BUFFER - sizeof(*req))
>> +		return -EINVAL;
>> +
>> +	req->hdr.cmd = TPM_SEND_COMMAND;
>> +	req->locality = locality;
>> +	req->inbuf_size = len;
>> +
>> +	memcpy(req->inbuf, buf, len);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * tpm_tcgsim_parse_send_cmd() - Parse a struct tpm_send_cmd_resp received from
>> + * the TCG Simulator
>> + * @resp: The struct tpm_send_cmd_resp to parse
>> + * @buf: The buffer where to copy the response
>> + * @len: The size of the buffer
>> + *
>> + * Return: buffer size filled with the response on success, negative error
>> + * code on failure.
>> + */
>> +static inline int
>> +tpm_tcgsim_parse_send_cmd(const struct tpm_send_cmd_resp *resp, u8 *buf,
>> +			  size_t len)
>> +{
>> +	if (len < resp->hdr.size)
>> +		return -E2BIG;
>> +
>> +	if (resp->hdr.size > TPM_TCGSIM_MAX_BUFFER - sizeof(*resp))
>> +		return -EINVAL;  // Invalid response from the platform TPM
>> +
>> +	memcpy(buf, resp->outbuf, resp->hdr.size);
>> +
>> +	return resp->hdr.size;
>> +}
>> +
>> +#endif /* _TPM_TCGSIM_H_ */
>> --
>> 2.48.1
>>
>
>This commit got me lost tbh.

Now I understand why you got lost, my bad!
I checked further and these structures seem to be specific to the vTPM 
protocol defined by AMD SVSM specification and independent of TCG TPM 
(unless reusing some definitions like TPM_SEND_COMMAND).

At this point I think it is best to remove this header (or move in 
x86/sev) and move this rewrap to x86/sev to avoid confusion.

I'll do in v3, sorry for the confusion.

Stefano


