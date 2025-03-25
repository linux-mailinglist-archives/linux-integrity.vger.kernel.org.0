Return-Path: <linux-integrity+bounces-5421-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D1A70806
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 18:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A53188AFB7
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258D25F783;
	Tue, 25 Mar 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkVK9ilw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49F26139A
	for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923261; cv=none; b=jr4Lvvl0NmWyIfgePkdUKfp8itPkDiJ/Ex3JlTCy1MMMCKfRBVtFhQtK3QUvdVkiNjTEWnOv9Y4Z0rH9CPyswUNHNzCSbEGKnU+bzNSB5CsSWm+6tjmiYPGZ2G31C1FsXIXmwy6DewLc50cIUtxIAVoOUP+8DzdDd6oK0GyvfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923261; c=relaxed/simple;
	bh=XR1tVytbIphJs05val9V5bAdzBLdjUKyNgfVx4GEvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJZ4MpKsOE5tIHPgSfRk+Sin3ozwXPyCK3FvdpTymzziseTmgCs0fnxFqf9/ghxlshxDHkDjGWm4oG4U+jVTYvPfR97JC7VEJ52taHBNu8t7fnJYtTdZmTWNpTx585aMZSjVJ5pGjmbSCwXkjb+At8rwjj+txjMQBM61H80RU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkVK9ilw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXrcQRGT+YymoQu8Nq/Sa3GMytku7iNudqsRUZDUqH8=;
	b=QkVK9ilwjvYPUKL43wE41y3eT+1BS5vgB/BfBOfOzyoiYeX7IwxhY+E5XrTZRo3UKJMT+J
	OA9JzJNnBBXUQRm6r1mdYLdCjuE6QH2dONsTAxEq1nNg5qFUrb1heGXhSIrt03BP/3oDYb
	gND2mFErtO14GYu/NGRqYT9pMDkVxJM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Zljsf-33NfSK9u4JQP0M0g-1; Tue, 25 Mar 2025 13:20:55 -0400
X-MC-Unique: Zljsf-33NfSK9u4JQP0M0g-1
X-Mimecast-MFC-AGG-ID: Zljsf-33NfSK9u4JQP0M0g_1742923255
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so26274715e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 25 Mar 2025 10:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742923254; x=1743528054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXrcQRGT+YymoQu8Nq/Sa3GMytku7iNudqsRUZDUqH8=;
        b=ZFF7ag0Ws2nq5V+5Gg1wGwWxJCYihMKdj7+MjOuNZQkRELI7qg51HZUbLd9nLgWSnp
         +qJOWvkC+NIyYtz3CkTY781y8IGj2I5g9skqVRRjflnPU8+HyweZEuxm//vcYJhVYyKN
         7KpHrAVIbxEB9VfSspEMQ5Lnagz6X1qrvtHy/v6FdWXnOxsBnrQsYH5P4Yo+BMsO2RxG
         hIzZqWKjFrCJU3tMSjw6dq4H41e3MnIb1aS0ycSv8CZCeb/tXM5eyXGKjV1hrN1U99VZ
         srUh2EYA+DWGKgWqG+Pr8+7oRVRQxNBNgOT7eI/TpoHFVOGWKE6hnJhw/el6wprHNrnM
         duHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXuWDKa3nXpSOTdmVHpvjsOUi9rFJCV+k7IBBKc6c7pFh/2mFidh0vPpYLizIg8TNJfMNS3f5xRxbTTeh3qaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYg40zVIuR4XxnZPggVWc35zRYwy0bA3P64NGlj+SPE1VJ/4o
	FZmAlTyUv0QkwcOC465LMBUcjt6t4xz4MNM2x2Ttubs1lp9jZxcjG+N8s9ZpJIDUmAPN4VCdIwC
	EeXPRyQpaSgSm+ipz6L2MaGkf0rnFD3VwKphStTzRaktWfhifTymjnKCXcz/NG5yJ/g==
X-Gm-Gg: ASbGncuapWLhDgkh80kHD6iSXJ+eYewNguDBFpMecZobSZR6b8ZEupiFnKsvTXab8gF
	tYhaG7CWaCIL3eoPfZSP8PSFdlNTQhKCZg/aBpyms+860cL8EH0fZUAR4+032W51y1/w3Lk2Oxv
	iSSdEWWTgJOxARtYPa/4RT7pKCemg0OdozJiAJVtjnxa+vHUfWMMMZJd5hucX4Gx6fHxXAybf0W
	7JdiQ6a0IxFMWrzt53oMWdsAPRkYI3J3jt+9YdeHuuX2R3L4JTbA6fV0vEj8a5M7OjShCZ7WNkl
	kBmguhIUyI8T5nZGKj2yBaCY3WcYLpkW7FdMXNJgl2OaAnMzqzP7IJu5cj7wiwhS
X-Received: by 2002:a05:600c:5488:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d50a219a4mr183356005e9.23.1742923254503;
        Tue, 25 Mar 2025 10:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCb+zv6HS9bYecqfccexaC5TWzYCJ46ME9+z1Odod48/9DY0ZMeRbh9jp1LnT9G/G4XaXh8A==
X-Received: by 2002:a05:600c:5488:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d50a219a4mr183355615e9.23.1742923253915;
        Tue, 25 Mar 2025 10:20:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9e96bsm159257455e9.25.2025.03.25.10.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:20:53 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:20:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Joerg Roedel <jroedel@suse.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <dou3uniecwqapl7kmsxa2776v6pdy7c4zdvcrdky6wz62ohyao@u3vlgaao4sb7>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-2-sgarzare@redhat.com>
 <CAAH4kHYuaQEkvftWuX+UmGDiAgV5i1uHx8=rjmhJ0Y=inQFw-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHYuaQEkvftWuX+UmGDiAgV5i1uHx8=rjmhJ0Y=inQFw-Q@mail.gmail.com>

On Tue, Mar 25, 2025 at 09:56:53AM -0700, Dionna Amalie Glaze wrote:
>On Mon, Mar 24, 2025 at 3:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add two new functions to probe and send commands to the SVSM vTPM.
>> They leverage the two calls defined by the AMD SVSM specification [1]
>> for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
>>
>> Expose these functions to be used by other modules such as a tpm
>> driver.
>>
>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>     Publication # 58019 Revision: 1.00
>>
>> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v4:
>> - added Tom's R-b
>> - added functions documentation [Jarkko]
>> - simplified TPM_SEND_COMMAND check [Tom/Jarkko]
>> v3:
>> - removed link to the spec because those URLs are unstable [Borislav]
>> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>>   in this one [Borislav]
>> - slimmed down snp_svsm_vtpm_probe() [Borislav]
>> - removed features check and any print related [Tom]
>> ---
>>  arch/x86/include/asm/sev.h |  7 +++++
>>  arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index ba7999f66abe..09471d058ce5 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -384,6 +384,10 @@ struct svsm_call {
>>  #define SVSM_ATTEST_SERVICES           0
>>  #define SVSM_ATTEST_SINGLE_SERVICE     1
>>
>> +#define SVSM_VTPM_CALL(x)              ((2ULL << 32) | (x))
>> +#define SVSM_VTPM_QUERY                        0
>> +#define SVSM_VTPM_CMD                  1
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>
>>  extern u8 snp_vmpl;
>> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>>                            struct snp_guest_request_ioctl *rio);
>>
>> +bool snp_svsm_vtpm_probe(void);
>> +int snp_svsm_vtpm_send_command(u8 *buffer);
>> +
>
>These should be defined static inline with trivial definitions in the
>#else case, yes?

For now the only user of those is the tpm_svsm driver which is build 
only if CONFIG_AMD_MEM_ENCRYPT is defined, so there should be no 
problem, but you are right, better to follow the other functions and 
define the stubs

I'll fix in v5, good catch!

Thanks,
Stefano


