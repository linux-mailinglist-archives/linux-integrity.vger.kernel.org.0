Return-Path: <linux-integrity+bounces-5754-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3EA83D55
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576863B0DD7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A720E005;
	Thu, 10 Apr 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq4mEubL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA820B801;
	Thu, 10 Apr 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274535; cv=none; b=PMV3UGq+gzk6WvSjYjOWq9qACi7J3gW+eSCJm9MolrHauLAG761ElJ0zzCrgYYhKooS2fPZ0fLhFlPYG00xthDA7nwhVKscKVhVH4s0RKo2jGDU2eHwziugEwI3Ov/0SIMaFFeB7MKR45i+BUdw6V6PKydpzPtYjuobzg8Sv5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274535; c=relaxed/simple;
	bh=eaLHh1x7Yl188r+cUHnieuu+ulS+no2KAZSk41ryLSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcazrKNSc18zUxWbLied5KGovvcHeQFZbcAVd3iHLGT9WicgxDvyx0m0jOflIlsQSCCKw2AeEQGTFqHwNU62mcuxTWkKPA6c8C0mwxeG7E1E28uH5OhnPXWN3/6yCRoCQkJ2JTLMY86Y4+4F8Jal+JNhRrXzC1suis9RtUXa1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq4mEubL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22403cbb47fso5263975ad.0;
        Thu, 10 Apr 2025 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744274533; x=1744879333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+d4uPjgKpIDnR13P+mL9ZfGYIBtaMP2k/aupNTCMmKQ=;
        b=fq4mEubLPerqpy4x1d0rsJl4Rh+drQwCemv+kBSJhhSF7chcEGCUWY6JlGxx0mKsKw
         c2B2Ck+diQM33ayX5+QAQcIa8PLwZD4lz70Iq3gA2QUmpQLeIpoM42FyCDCgZXlqy5t3
         CaPkPDIEidjDFjn4DeJQ4ygQZdEb17FTxAxBezcEoafkzBfzpcGoZ+YCrIRYuGxsKRoG
         dA2qH9L+MMborZpImx0c4lmWfvdgS7lhXKR3txx/bxhtyFvHx3CLYO56909jjv9iGKoR
         kn/KmaKm4RzJ8ByA0jbs2QpG/dhfOhvxlm8acPMW9Mqp7v97dkRNhXEEiyW1WGsIbijD
         BxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744274533; x=1744879333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+d4uPjgKpIDnR13P+mL9ZfGYIBtaMP2k/aupNTCMmKQ=;
        b=a15xFVuath13vQY7mmttI8W4kcIYrfPKE9U/A6Gti9PfVPlXCrXJByytF1QIJ8+TXu
         Oj3R3hnXkk5DAOjB/FjhS0vRlw1YnT+w4JBZoDtMEIyw4zxsXCkAY/uCtPgoqRFy43Ss
         vriQVu1PV7h1qmh5u9pzyZBavhoewUeGyANrcrp09UUBx7CvK0LpyPIGCI7mnhNiuHxK
         Ss/MioG+tp1NlG3lRZ1e9xmLRCOeFVtNwU5296nP5SvUYVhw80K/BPi88Vr9auTaAXMx
         RzJwkyxWKwTbmcdd0PjeUSdJQmoL0sFF+U1uBZGnjPWqH92TRAhAOWPREqXmPBv1z//f
         3voQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAPol8Jt+nz6w0/qC3/xQvNX2Uy3Ilb5WMBXhnMPtMlM7YjUKGrt9Ymofu6JRP9ai3N69HfCWS8RwSqgdt@vger.kernel.org, AJvYcCW/xo98bq6DLoc3+TGrEwqhM8rvEqlnTqJ7m0IdUC1b1FxRX39p3aCvox1uwvHA1VQNxCj8ndymWvESxVzWPyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3ADXFIEa06rDMHfBx0nihDXXhV3zBd62j0VtjWf0n/s9JCgN
	PNEbTAye/+jnkNqtIdt7Wt2fxgbNdin6feLqWweuX1ZnhKbvkdHc
X-Gm-Gg: ASbGncvkSKManZtvccGhQ+1A5Dt40vhEX5qIM+7RmnBS0EYypLdegR/ABTdTyJXALZX
	fDBi5To4cOIgsgP1PsTD65w3OtffJRIuGPuCt3vbCYB40TCoEFP0rtD6gmrfAKkSFiQXZngn2Oj
	wmzqQqk0ryCYRlOx45+eat91HNO26feOiChJQPKQM82T6Akh+T7iX5y0o+TSdRv3E7By1OG35P6
	5VunCOeZySe9OyAiGozwi0+3uB5fG4y0qKiBEiAoVlLoKDo+NJPTrvOkbh2RDJDanqHjTghTdNv
	pWfA8+YkTVZpLQ7wNvbjgWt15B9XKYQkQ1eLSQRSbE5joPiTciaa+G75yJzqDRFK/BnYzVHvrkV
	QD1dP/wOz9oPZMnVtcw==
X-Google-Smtp-Source: AGHT+IEeYuhxPKJdioM1LCwerEuXFkm58pHCB6lB+BBwDEBibh3mSzv4PkY6k2vRvZujF//8AFFoEA==
X-Received: by 2002:a17:903:230b:b0:215:acb3:3786 with SMTP id d9443c01a7336-22be02f77fdmr19616235ad.19.1744274532595;
        Thu, 10 Apr 2025 01:42:12 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:d266:673b:c35c:83a8? ([2409:4080:204:a537:d266:673b:c35c:83a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b29esm25111595ad.81.2025.04.10.01.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 01:42:12 -0700 (PDT)
Message-ID: <fab2bb2d-a78e-4130-a5fd-bf07430210c7@gmail.com>
Date: Thu, 10 Apr 2025 14:12:07 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] char: tpm: tpm-buf: Fix uninitialized return values in
 read helpers
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250409205536.210202-1-purvayeshi550@gmail.com>
 <Z_dh4tRIa6xxAWQ2@kernel.org>
 <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <t2ri7facyvtmt6rx6xwcjos7rgtyiln7cywl2gt4effgukeejc@f3ml4apdh4zs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/25 13:21, Stefano Garzarella wrote:
> On Thu, Apr 10, 2025 at 09:14:58AM +0300, Jarkko Sakkinen wrote:
>> On Thu, Apr 10, 2025 at 02:25:36AM +0530, Purva Yeshi wrote:
>>> Fix Smatch-detected error:
>>> drivers/char/tpm/tpm-buf.c:208 tpm_buf_read_u8() error:
>>> uninitialized symbol 'value'.
>>> drivers/char/tpm/tpm-buf.c:225 tpm_buf_read_u16() error:
>>> uninitialized symbol 'value'.
>>> drivers/char/tpm/tpm-buf.c:242 tpm_buf_read_u32() error:
>>> uninitialized symbol 'value'.
>>>
>>> Call tpm_buf_read() to populate value but do not check its return
>>> status. If the read fails, value remains uninitialized, causing
>>> undefined behavior when returned or processed.
>>>
>>> Initialize value to zero to ensure a defined return even if
>>> tpm_buf_read() fails, avoiding undefined behavior from using
>>> an uninitialized variable.
>>
>> How does tpm_buf_read() fail?
> 
> If TPM_BUF_BOUNDARY_ERROR is set (or we are setting it), we are 
> effectively returning random stack bytes to the caller.
> Could this be a problem?
> 
> If it is, maybe instead of this patch, we could set `*output` to zero in 
> the error path of tpm_buf_read(). Or return an error from tpm_buf_read() 
> so callers can return 0 or whatever they want.
> 
> Thanks,
> Stefano
> 

Hi Jarkko, Stefano,
Thank you for the review.

I've revisited the issue and updated the implementation of 
tpm_buf_read() to zero out the *output buffer in the error paths, 
instead of initializing the return value in each caller.

static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t 
count, void *output)
{
	off_t next_offset;

	/* Return silently if overflow has already happened. */
	if (buf->flags & TPM_BUF_BOUNDARY_ERROR) {
		memset(output, 0, count);
		return;
	}

	next_offset = *offset + count;
	if (next_offset > buf->length) {
		WARN(1, "tpm_buf: read out of boundary\n");
		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
		memset(output, 0, count);
		return;
	}

	memcpy(output, &buf->data[*offset], count);
	*offset = next_offset;
}

This approach ensures that output is always zeroed when the read fails, 
which avoids returning uninitialized stack values from the helper 
functions like tpm_buf_read_u8(), tpm_buf_read_u16(), and 
tpm_buf_read_u32().

Does this solution look acceptable for the next version of the patch?

Best regards,
Purva Yeshi

