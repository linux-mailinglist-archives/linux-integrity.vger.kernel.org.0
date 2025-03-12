Return-Path: <linux-integrity+bounces-5250-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFCBA5DAEF
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C58218963D5
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6023E331;
	Wed, 12 Mar 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1NDS/v5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0123E329
	for <linux-integrity@vger.kernel.org>; Wed, 12 Mar 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776979; cv=none; b=Y9kcFWnlHrQvxWsdEDZx8iD23dDDpU+ZNHp/qt/Oi8Nnm7H2JJMh/NGJYy1woezSi3jSLP0RzUcQB8S2X9vN2M1XvA47knt1+xlTp6pZ8oMUxlWFS/S1wse3WAvGvzXr7U/x8cGV4/B0UoDQ8QybAJagZEWKJYPVjLQHrQ1FDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776979; c=relaxed/simple;
	bh=C9ho3y8Z4AjksfuMtwufWo5v3OhuqO4rkMnvsa73uUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGxhyOCsbXVKBeK69YF7glyrju+bpsIKaIyWW9WJ6kzJJF7HO67e0mFhi+rrQi8LBlYkdXdwVAyiGN8lIrogdLNSVKcQcWG3jd/dZlF/LOQgM02ATRvTJtWqp8w/1OsE4vhMGJkc1WnaxU5HXBxNkBeSmdyeqv18b/l7S/zxU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1NDS/v5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741776976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BMO4udXDunUhobQ7Fjp1hXfrNyFJ45K7k54QtO+Zp4s=;
	b=R1NDS/v53pHujI0DCPL+rRp/Y7hRtnJ0ihnjB+R55ufjY0RzYsv0ONqcVpEvmgGCu+Zf0/
	2yDYntI9NERjYrYJyUriwX/9a1d5u2gNznK48+J0bELq49hnkzGilJc+yQtovow42/5UZM
	ItWbloJfk0BuEtUcWzFoRzFppH4xh0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-v2vXrr6KMiuydjfj0OjTGg-1; Wed, 12 Mar 2025 06:56:15 -0400
X-MC-Unique: v2vXrr6KMiuydjfj0OjTGg-1
X-Mimecast-MFC-AGG-ID: v2vXrr6KMiuydjfj0OjTGg_1741776974
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso33687155e9.2
        for <linux-integrity@vger.kernel.org>; Wed, 12 Mar 2025 03:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776974; x=1742381774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMO4udXDunUhobQ7Fjp1hXfrNyFJ45K7k54QtO+Zp4s=;
        b=VLGyK/TwLJRaIReXpCHToSZDAoOS1XbL1oPa4ZNat0p6k5NUA7zkw/LpiBv06D1Aii
         FBTlqyeR7l8y+S097N9ijB+09PDY25e7/zJZHLsmZVuaU6e3d9ev5EQfnu4mBtE7twTx
         nrHJZxQzyWaOdxWViia8/U+ba7B7zX4+uSW28AUguwloZdaO1cjkdjrix4kiB46SvRLm
         0liDgrPQUvyBInx6tEb20VQdAp7HbjToXmB2gUa/K/kJJaDQBcg0uyiDDXyTNPxNxryn
         af8UZUajoiDTkWuibDr4/TTFP8vNZOqT+MJXCpI3oUKQfismOgHTNi10BLqVueqVQ2ao
         N6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTYVJiso3rbUHvaON4bRn73RH2udbiEP0/iLJMvubupMiuxgcbuvrljO46Xqcl/112fM+o/d1SHsgwAvxQNgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLxSO38Wcz76MZjVoXQ3KiBz3A23+p95JMPz0Tfo01e1Ku7Q9
	rr6ydEuVTLHlxUVeEpReDAc8Zhw/4FRSpZZE+UfrLkJpp/YAVgAVPuAd3NuiN30LIgbfO2/FnSl
	8WlL50ucQWCbt/lr1rlfH1/IavbtNEbEteci7CqVHl7LViZur7cQKZeQYU5m91L8+Xw==
X-Gm-Gg: ASbGncvI+ga63pUKBV5gRk5gx15OrXy+ZV/KwMAzjVUFRo+4mCM9Zl4hQo7FEjfhL2R
	mgSRcSXsowf5HId1/7lEuCnHDoBnKsvm/6pieJDyO3p4O7R0Iq/2AdjYX6rG4+54ZAcrn8RaSAS
	V22EvjRYUnBUKMKzV4fHjGWRnivlHx9BAmF1UV1A294HxBTvY4Wn5tSRC+ZB+U7IHWxckzy3DIe
	n+q93iN7RwrobOMlYcWUQsmgYPLgOrfBtoDWA4DiTFlD6SzafPFykfzjcTgzY7RP3jNkyFpR/1m
	I7mHRLLydNEP0XizaCHTH8Wy1ufdFJnAbcFLZHCEjVuwxDuCIRlioMDspLWHwJqz
X-Received: by 2002:a05:600c:5112:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-43d04e92abamr55444245e9.8.1741776973882;
        Wed, 12 Mar 2025 03:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9AMJIu9eKhF569vVgvbzoy+XnTi3xrEHJ2FOChRIcm/dKfdUJ7RQpEPKwGeSxzTGkYglWjQ==
X-Received: by 2002:a05:600c:5112:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-43d04e92abamr55443785e9.8.1741776973173;
        Wed, 12 Mar 2025 03:56:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74c6a1sm17240825e9.13.2025.03.12.03.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:56:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:56:06 +0100
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
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <2of2zhxi2c735fgvjxug2bxjfpz2zk25adf3h2ps5byau3rj3k@pgbxmpbskezi>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <Z9AIx9kFKWcHB_WK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9AIx9kFKWcHB_WK@kernel.org>

On Tue, Mar 11, 2025 at 11:56:23AM +0200, Jarkko Sakkinen wrote:
>On Tue, Mar 11, 2025 at 10:42:22AM +0100, Stefano Garzarella wrote:
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
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> v3:
>> - removed link to the spec because those URLs are unstable [Borislav]
>> - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
>>   in this one [Borislav]
>> - slimmed down snp_svsm_vtpm_probe() [Borislav]
>> - removed features check and any print related [Tom]
>> ---
>>  arch/x86/include/asm/sev.h |  7 +++++++
>>  arch/x86/coco/sev/core.c   | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index ba7999f66abe..09471d058ce5 100644
>> --- a/arch/x86/include/asm/sev.h
>> +++ b/arch/x86/include/asm/sev.h
>> @@ -384,6 +384,10 @@ struct svsm_call {
>>  #define SVSM_ATTEST_SERVICES		0
>>  #define SVSM_ATTEST_SINGLE_SERVICE	1
>>
>> +#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
>> +#define SVSM_VTPM_QUERY			0
>> +#define SVSM_VTPM_CMD			1
>> +
>>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>>
>>  extern u8 snp_vmpl;
>> @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
>>  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req,
>>  			   struct snp_guest_request_ioctl *rio);
>>
>> +bool snp_svsm_vtpm_probe(void);
>> +int snp_svsm_vtpm_send_command(u8 *buffer);
>> +
>>  void __init snp_secure_tsc_prepare(void);
>>  void __init snp_secure_tsc_init(void);
>>
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index 96c7bc698e6b..2166bdff88b7 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -2628,6 +2628,37 @@ static int snp_issue_guest_request(struct snp_guest_req *req, struct snp_req_dat
>>  	return ret;
>>  }
>>
>
>Since this is an exported symbol, it'd be a good practice document
>snp_svsm_vtpm_probe().

Yes, you are right, since the others were not documented, I had not 
added it, but I agree with you, I'll do in v4.

>
>> +bool snp_svsm_vtpm_probe(void)
>> +{
>> +	struct svsm_call call = {};
>> +
>> +	/* The vTPM device is available only if a SVSM is present */
>> +	if (!snp_vmpl)
>> +		return false;
>> +
>> +	call.caa = svsm_get_caa();
>> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>
>I supposed CAA is some kind of shared memory area for host and VM?

Not with the host, but with SVSM, which is the firmware running in the 
guest, but at a higher privilege level (VMPL) than the kernel, where, 
for example, the vTPM is emulated.

BTW, yep it is a shared memory defined by the SVSM calling convention.
 From AMD SVSM specification:

   5 Calling Convention

     Each call to the SVSM conveys data through a combination of the
     SVSM Calling Area (whose address was first configured through the
     SVSM_CAA field of the secrets page) and registers. Use of the
     Calling Area is necessary for the SVSM to detect the difference
     between a call that was issued by the guest and a spurious
     invocation by a poorly behaved host. Registers are used for all
     other parameters.
     The initially configured SVSM Calling Area is a page of memory that
     lies outside the initial SVSM memory range and has not had its VMPL
     permissions restricted in any way. The address is guaranteed to be
     aligned to a 4 KB boundary, so the remainder of the page may be used
     by the guest for memory-based parameter passing if desired.
     The contents of the Calling Area are described in the following
     table:

     Table 2: Calling Area
     Byte      Size     Name                Description
     Offset

     0x000     1 byte   SVSM_CALL_PENDING   Indicates whether a call has
                                            been requested by the guest
                                            (0=no call requested, 1=call
                                            requested).
     0x001     1 byte   SVSM_MEM_AVAILABLE  Free memory is available to
                                            be withdrawn.
     0x002     6 byte                       Reserved. The SVSM is not
                                            required to verify that
                                            these bytes are 0.

>
>> +
>> +	if (svsm_perform_call_protocol(&call))
>> +		return false;
>> +
>> +	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
>> +	return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
>> +}
>> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
>> +
>
>Ditto.

Ack.

>
>> +int snp_svsm_vtpm_send_command(u8 *buffer)
>> +{
>> +	struct svsm_call call = {};
>> +
>> +	call.caa = svsm_get_caa();
>> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
>> +	call.rcx = __pa(buffer);
>> +
>> +	return svsm_perform_call_protocol(&call);
>> +}
>> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
>> +
>>  static struct platform_device sev_guest_device = {
>>  	.name		= "sev-guest",
>>  	.id		= -1,
>> --
>> 2.48.1
>>
>
>That said, these are rather self-documenting (i.e, nice and clean).

Thanks for the review!
Stefano


