Return-Path: <linux-integrity+bounces-5050-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1EBA4CA05
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DD31880103
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D41A92E;
	Mon,  3 Mar 2025 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNcqsATA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCF13CA97
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023046; cv=none; b=Lucthx2KOYhqeZKZ8OigFECSxPqNK7Y4vZWI4wFSdN2UJylU64t6KaiIshh8qyKhDIzlM930lhk19EAf7zdakqM2SPhxX7hbMDqIjQLmsKJZK5c1mcAPZOAcFheynGCPH7jMLpfm8hmhbgUQe6z5CdyZddPp7HCcbDkx2o6C18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023046; c=relaxed/simple;
	bh=zCLifRE0KoQawzB/TcyJYbwoK84uaqCSQwdfN6x2BcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA8K1OlVIrou9dBeHXKcQgmADdqmwzNXFHYSEXRVp5pNG9FeSNTXTQN4NDK0CWbi5X+eCvTS5lKc3Eq9G0aAF0MviMEevUhqMP1LxcnHzDfyM7AEB4eKIyUHpMGLoiKaBY6LvRVvcpuNzw2gkrLNCkmUYwpYzQ140y6OSQCItwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNcqsATA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741023043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qK6V1d4F8/3GYYMbFs+Mb6fZwFXqDTRxwVUEODfRNfg=;
	b=SNcqsATA208DOBkhZVaous9NmIfM1l6OJXGtT4ixwC/GopxqdfUUtzqGZq3hu1D8AVlpV2
	tLIDdQN28Yxep4lCQz+exm2W32XMk3/VW0sfNXo3VcoWcJuHCxtTbW/Mg5DcqFMQ7nMTLX
	MgvJLJnFcP6HnGdWuiFHFbkWv5R2BKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-MYhE2b-3NVespJ-wFCj5XA-1; Mon, 03 Mar 2025 12:30:32 -0500
X-MC-Unique: MYhE2b-3NVespJ-wFCj5XA-1
X-Mimecast-MFC-AGG-ID: MYhE2b-3NVespJ-wFCj5XA_1741023031
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so21065845e9.3
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 09:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023031; x=1741627831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK6V1d4F8/3GYYMbFs+Mb6fZwFXqDTRxwVUEODfRNfg=;
        b=gqVRQaBq+DjmzOTG+TbqKqZ15D22LnuQtIX41D6z6kL+Zx5GrEgOFQ77gnt/tA3mGH
         d25bzyIt6wF3sfuzqswiW8mpNQQKfdJ9+31uuUCfhF2QouBuzqDIG3MNvXC9gIN/kQvr
         sDJav3zCBlue81N93ioe/iA6qHx86YuDiGF5vhIekLPvFNtwnSyHB3uymm1Udlk9ipUy
         nB3IRJ+ikzGOAFTdTeSDFLHZeaxPhQbiruImBeneqOKr3O0Kir6PpN6h57pyooos6pst
         GYDkmXDa5ORoRn4mX7leLbQrrB0Tip2LlKdB4uU27To+xq5YxC6snz6duls5BcktKfE5
         4kkw==
X-Forwarded-Encrypted: i=1; AJvYcCVTmVb7M8tIvd8+kR2USbChFBAZaSK8LONVT/SL+bu285dhlN72WknTwLnHazhRy5nW3m0xqvhCeW0HxNZOKco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38DNQ/BvxczbT9vHtGiFAaO1Jr8fxWOUhEFdRFGUij/bZDzsv
	QNwj24sV7rxqZxDct2TgBROYXEhy1A0jW5jgT1wZAuxQ5Es/oZfqjIxHAG1yqHJmADaMuniRlW9
	1Qxo/hCr2ZBmyKP5Pxs/nfrwxQiN0OZNCT+KzmGe2vLN/hO7KTjaXoszfwX/FK2+FWw==
X-Gm-Gg: ASbGnctbnwijvIwXXDZyBufNSJl412UWfA6CHF/xVIY3hLqaX8Pn/mw0Zho2W2zwNjn
	E6l7TY140SyBd+iOet9yvPs1Fdcx6IUWnwxJC2+4aPCn7drk1FoKek2MhsN8ISG2WDoXfbRCmag
	w2D0sguJdg9v3RbHvPsPio1U4D4/H67gMuEbZfOUm4k+GJLlVJMS5z4KrWvsbkxwgBfxHucu2Ui
	bbUAYYSHvM/wxL4a8UOPwsERbv1EuyrkpfjmKwkyPQ/5kpooalBiUvXBsFhWoOiDYCmNv4rkYBP
	9AmJxPteyWb5AlUkXdMNsRoQezUNAgbaaeHBUn46Pqx9NQMW8ovxd0MeaUe7OiVW
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr101788025e9.21.1741023031549;
        Mon, 03 Mar 2025 09:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQsnNiGGEYqX44soHY1inSfp9Dy8FQXmQyAL1i5ej8GJiYTvczodK99UyEHKUMhAfUCjVl7A==
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr101787525e9.21.1741023030939;
        Mon, 03 Mar 2025 09:30:30 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba539466sm204364905e9.18.2025.03.03.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:30:30 -0800 (PST)
Date: Mon, 3 Mar 2025 18:30:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
Message-ID: <jmo7t55vnwlszauoje2o427re3omdnaaqk2cbhynksb225isig@blymmqrezzo7>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-5-sgarzare@redhat.com>
 <d50d9d6e-10e4-23e8-a584-df28a1c41e86@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d50d9d6e-10e4-23e8-a584-df28a1c41e86@amd.com>

On Mon, Mar 03, 2025 at 08:28:45AM -0600, Tom Lendacky wrote:
>On 2/28/25 11:07, Stefano Garzarella wrote:
>> This is primarily designed to support an enlightened driver for the
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
>
>This is a confusing name... would tpm_tcgsim_parse_cmd_resp() be a
>better name?

Ack, and we can rename also the other in tpm_tcgsim_fill_cmd_req().

Thanks,
Stefano


