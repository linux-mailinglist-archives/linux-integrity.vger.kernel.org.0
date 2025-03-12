Return-Path: <linux-integrity+bounces-5251-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD9A5DBE5
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 12:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FFC3B3BB2
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6023AE64;
	Wed, 12 Mar 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDz8v92P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB023237C
	for <linux-integrity@vger.kernel.org>; Wed, 12 Mar 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780071; cv=none; b=GdWTADxi3/oQppM8ifBDqbdzYQoc/ZFAmx2kGH5PBVkH61NGQOmm3rmSCOawOor/nTU+2ccuYg4TiXkrVU7ltkW7BuHmwc2wuOnbSbiC3xorqWZEMRhb+Q7QjvbCusQvk7NuVNHQqpu7s3vkXoTpJEE/qNi6h4znn/AwSdLaBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780071; c=relaxed/simple;
	bh=X5t1MXEx3Ri3qf8vGAqhZ06ZCh7vspadQpZMzTBv6YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inmtr2IoRYR7gVCZ1XaumyLnYCWRX47H2O092qN4aoQ5rrBLDFlcH/HN+5nPr/v79KELGFA40uDuG8RFtBFjhis7LbSCJuHKBJcGicbt8oggxI8DUFrdoLtB5aQNbnK7NjAgVuQTSBZ1zR4m0L1pQGCVMrhfWhPmBXgkqs4cydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDz8v92P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741780068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmCcwhncm33zmtKRef3o88MIfofDnFACWeQE9MPkbx4=;
	b=dDz8v92PUpwlY8/k/sW+lbJ6b+ZXL8iqqluzvjWy8RURYSVWPd2NoSrZWWEwerMtSqdMNS
	zL5I/WxrNEzgyr6sTx39qN1FbdRKn3Ud/SlgmZofyDwLPSl3A7mCJEcOh9zB5bi7bBd5Wm
	Iag/S3S/c0RU5XyVy8mab/Aq9XQW1JY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-bVC-jaDmP9ugoTMiKhhPQQ-1; Wed, 12 Mar 2025 07:47:47 -0400
X-MC-Unique: bVC-jaDmP9ugoTMiKhhPQQ-1
X-Mimecast-MFC-AGG-ID: bVC-jaDmP9ugoTMiKhhPQQ_1741780066
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so46484965e9.3
        for <linux-integrity@vger.kernel.org>; Wed, 12 Mar 2025 04:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780066; x=1742384866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmCcwhncm33zmtKRef3o88MIfofDnFACWeQE9MPkbx4=;
        b=iAXC5Df3f3VCc2CYMchC/60fVhJnz5/v+CtrSSFxzxMY5OIc5h8H49Wwk1KDuHSAM6
         nAyh0/6gbaoY9nN61WsWTJxBgOIUeqIV2CBtcrV0+KMJLE+D4TpkM6Y4QjNrcCmzAIYH
         oV9Ij2VJMkVHdNaIxGnTC1fZHwKFVu7DK2fviuowD+kNG6NqeHVHmuk2QTsqESyJVJti
         pvhoBa1cgqW+61aJp7XSfy1TvIPV/5I7izMCcZP6wDqg93sbcNhRCIdjVxNT/myRnCQ3
         Bg3pblp0st1BP8Lt2A+R2J3TF6IbTNkIaOJyubhHyTDQH05vxqhCYZzJ+4Bm703tZrZW
         1v9g==
X-Forwarded-Encrypted: i=1; AJvYcCWETVj9aekQFzpP3fAnDEakJbM8xdY5wXRMZQ7ggTDojfAe37nuTIvuYhkTh7wL/IdzjefsQdc1dD4WyrZDuwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUFs3+x5+iZpfE2zDavWFLiI6GP02RYpBj7SXOvuziDWoSEDK
	NAyz75+gEg1suipfrIwsuoGF63Lcn4rHQ92fvJktXLBRaKKZXnaRnSD3K0Ux8Vjgd/cUZRzWxwB
	WBXkp2gjGtwcXzMtabGawmjhtzgwBZK8oYYWuUFOXXKq6OglcxKSGg8rQ55ZbDFlUJwvcV9vl4A
	==
X-Gm-Gg: ASbGncuEmy71jadw40qDQzkRaM+PzC9dt7fBtJgD9mBpGSdi+ltHkNf/7wSLnn9xrzf
	LV5dtohvkNzHYpRFrBWzxfMuFY31VWZ53WtfLc1QN0s9Y+Vcf8r3xJdgxWHJIEMgBGtbKLAgLR8
	wPluHVtcV/tFb2gxwCbmZo6ugxyNXyiWrHf1HCrA1sPHQh1gaLtDh3ltFEaCqE/UbCHmva7UpB1
	TCwszJByh+WSOJYR7LsLgJlK9TgN0Ge3uUJKulAjCSHe1guDKjLcmaD4dcLPVbw5fXqc0hPb3r8
	gfbMqbw4kjtwDcXENyLRUtYUwfPqIp5juBWKXJ3AyqnSUd1bh44l0QEcMdJUrJv9
X-Received: by 2002:a05:600c:3146:b0:43c:fdbe:43be with SMTP id 5b1f17b1804b1-43cfdbe4692mr84324245e9.27.1741780065734;
        Wed, 12 Mar 2025 04:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxuXx5YQe6jpb0et/xycveTFCsQDpLIYQDyO8eKnK5ImWZcZaA1Nsnk4i8zat+sFwBG9k2Og==
X-Received: by 2002:a05:600c:444d:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-43cfe154379mr99858675e9.15.1741780054340;
        Wed, 12 Mar 2025 04:47:34 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103290sm20465220f8f.87.2025.03.12.04.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:47:33 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:47:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Message-ID: <irkhppcqw6gbttshmfqggjzsjcq624wk67ovjp2wynfui6prec@e6ausihrq2il>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-3-sgarzare@redhat.com>
 <Z9ALe-kPZ5o_pim7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9ALe-kPZ5o_pim7@kernel.org>

On Tue, Mar 11, 2025 at 12:07:55PM +0200, Jarkko Sakkinen wrote:
>On Tue, Mar 11, 2025 at 10:42:23AM +0100, Stefano Garzarella wrote:
>> Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by
>> the AMD SVSM spec [1].
>>
>> The vTPM protocol follows the Official TPM 2.0 Reference Implementation
>> (originally by Microsoft, now part of the TCG) simulator protocol.
>>
>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>     Publication # 58019 Revision: 1.00
>>
>> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v3:
>> - renamed header and prefix to make clear it's related to the SVSM vTPM
>>   protocol
>> - renamed fill/parse functions [Tom]
>> - removed link to the spec because those URLs are unstable [Borislav]
>> ---
>>  include/linux/svsm_vtpm.h | 141 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 141 insertions(+)
>>  create mode 100644 include/linux/svsm_vtpm.h
>>
>> diff --git a/include/linux/svsm_vtpm.h b/include/linux/svsm_vtpm.h
>> new file mode 100644
>> index 000000000000..2ce9b1cb827e
>> --- /dev/null
>> +++ b/include/linux/svsm_vtpm.h
>> @@ -0,0 +1,141 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>> + *
>> + * Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by the
>> + * AMD SVSM spec [1].
>> + *
>> + * The vTPM protocol follows the Official TPM 2.0 Reference Implementation
>> + * (originally by Microsoft, now part of the TCG) simulator protocol.
>> + *
>> + * [1] "Secure VM Service Module for SEV-SNP Guests"
>> + *     Publication # 58019 Revision: 1.00
>> + */
>> +#ifndef _SVSM_VTPM_H_
>> +#define _SVSM_VTPM_H_
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
>> +#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
>> +
>
>Across the board below data structures: I'd svsm_vtpm_ prefix them.
>The rational is quite practical: it would easier to grep them later
>on.

I see, I'll fix in v4.

>
>> +/**
>> + * struct tpm_req - generic request header for single word command
>> + *
>> + * @cmd:	The command to send
>> + */
>> +struct tpm_req {
>> +	u32 cmd;
>> +} __packed;
>
>__packed is useless here.
>
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
>
>Ditto.

Ack, for both.

>
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
>
>Useless nesting that makes this obfuscated: you can just as well put
>that single field here, i.e.
>
>	u32 cmd;

Yep, I see. I'll remove tpm_req and tpm_resp since for now we support
only TPM_SEND_COMMAND, if in the future we will support other requests
we can think of re-introduce them if needed.

>
>> +	u8 locality;
>> +	u32 inbuf_size;
>> +	u8 inbuf[];
>
>Why not just buf?

I can change in `buf` and `size`.

>
>> +} __packed;
>
>Since we don't care about TCG Simulator compatibility I'd expect that
>these are ordered in a way that they align nicely. E.g.

Maybe I should add in the documentation that this structure is defined
by the AMD SVSM spec.

This is where request and response for TPM_SEND_COMMAND are defined:

   8.2.1 TPM_SEND_COMMAND
     Execute a TPM command and return the results.

     For TPM_SEND_COMMAND, platform command 8, the request buffer is
     specified according to the format of the following table.

     Table 16: TPM_SEND_COMMAND Request Structure

     Byte      Size         Meaning
     Offset    (Bytes)
     0x000     4            Platform command (8)
     0x004     1            Locality (must-be-0)
     0x005     4            TPM Command size (in bytes)
     0x009     Variable     TPM Command

     The response buffer is specified according to the format of the
     following table.

     Table 17: TPM_SEND_COMMAND Response Structure

     Byte      Size         Meaning
     Offset    (Bytes)
     0x000     4            Response size (in bytes)
     0x004     Variable     Response

>
>struct svsm_vtpm_request {
>	u32 command;
>	u16 locality;
>	u16 buffer_size;
>	u8 buffer[];
>};
>
>64k should enough for any possible TPM command.
>
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
>
>Why this does not have size? Here also __packed is useless even with the
>pre-existing layout, and something like svsm_tpm_response would be a
>factor more reasonable name.

Because it's "obfuscated" as you pointed out in the request :-)
The size is in the header, but I'll fix with something like this:

struct svsm_tpm_response {
     u32 size;
     u8 outbuf[];
} __packed;

>
>> +
>> +/**
>> + * svsm_vtpm_fill_cmd_req() - fill a struct tpm_send_cmd_req to be sent to SVSM
>
>> + * @req: The struct tpm_send_cmd_req to fill
>> + * @locality: The locality
>> + * @buf: The buffer from where to copy the payload of the command
>> + * @len: The size of the buffer
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +static inline int
>> +svsm_vtpm_fill_cmd_req(struct tpm_send_cmd_req *req, u8 locality,
>> +		       const u8 *buf, size_t len)
>
>svsm_vtpm_fill_request()
>
>> +{
>> +	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
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
>> + * svsm_vtpm_parse_cmd_resp() - Parse a struct tpm_send_cmd_resp received from
>> + * SVSM
>> + * @resp: The struct tpm_send_cmd_resp to parse
>> + * @buf: The buffer where to copy the response
>> + * @len: The size of the buffer
>> + *
>> + * Return: buffer size filled with the response on success, negative error
>> + * code on failure.
>> + */
>> +static inline int
>> +svsm_vtpm_parse_cmd_resp(const struct tpm_send_cmd_resp *resp, u8 *buf,
>> +			 size_t len)
>
>svsm_vtpm_parse_response()

About the naming, I added "cmd" because in the future we can support
also other requests/responses different from TPM_SEND_COMMAND, like
TPM_SIGNAL_HASH_DATA, TPM_REMOTE_HANDSHAKE, TPM_SET_ALTERNATIVE_RESULT
as specified in the AMD SVSM spec.

For now it's true that we support only TPM_SEND_COMMAND, so I can avoid
`cmd`, but if we will need to support the other requests in the future,
we may need to differentiate them.

Would be okay to have svsm_vtpm_cmd_[request|response], 
svsm_vtpm_fill_cmd_request(), svsm_vtpm_parse_cmd_response() ?
Or do you prefer to avoid "_cmd_"?
Not a strong opinion on my side.

Thanks,
Stefano

>
>> +{
>> +	if (len < resp->hdr.size)
>> +		return -E2BIG;
>> +
>> +	if (resp->hdr.size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
>> +		return -EINVAL;  // Invalid response from the platform TPM
>> +
>> +	memcpy(buf, resp->outbuf, resp->hdr.size);
>> +
>> +	return resp->hdr.size;
>> +}
>> +
>> +#endif /* _SVSM_VTPM_H_ */
>> --
>> 2.48.1
>>
>
>BR, Jarkko
>


