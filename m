Return-Path: <linux-integrity+bounces-5201-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBACA593F7
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6822B167DF8
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B1225403;
	Mon, 10 Mar 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioKTIbWe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9501A314B
	for <linux-integrity@vger.kernel.org>; Mon, 10 Mar 2025 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608813; cv=none; b=JjfvPCl+G4xlBLCGLOoo2edari/LWl0VjNnAe/cy/yY77WU4PDM/x/a50R/xYiuKK/c3Iq1slh+RqhPo+TK95yQ8hO3FjepiVcFOPOhVQr1GqI1aDaradhSB01upn8Ivfs6oA58LmUfb/7oo/hbto088DnIvoY5IOQd+ymeWuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608813; c=relaxed/simple;
	bh=XUQ74N8CFAQMmZBMklSCKl3+y2dbF8sPEjzdYlp1I3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxtdKTti+SxwZkgfoGK95+VC+bxowACwhr4Zqtpw3oYmolqVM4+IN7tSua7X16xaHxjJhv02m9WU9Z1F9ZTddkaf9QArbQ4rlUfWceczhpC2rNictX8H2qN5JfzOo/zVrk3ZpmK0htxnRWRq5IIFfb+0dVMs9Srhk2L6JVvlWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioKTIbWe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741608810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGViJXCclzx/2EWYRBSu51fQCiFZyNMwoJLCZOnspZQ=;
	b=ioKTIbWeDV7ILNC7taHRoE56/mfJC8YtNPK/U1pe3xcPwhCaPe1lnXiDrFdbGl1XzXIeuF
	Aw/6hTTZgJpqJIeLsCkRherZGvEZYz46++UdXG8/Pudw4eDsF/l/3schczuUXGsbU+ieEb
	zrgHEvx4c9FnaZmeRcRn4kwMGpLzgGs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-GABZxYhiNtOEB7Rrmbd1Fg-1; Mon, 10 Mar 2025 08:13:29 -0400
X-MC-Unique: GABZxYhiNtOEB7Rrmbd1Fg-1
X-Mimecast-MFC-AGG-ID: GABZxYhiNtOEB7Rrmbd1Fg_1741608808
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39149cbc77dso603503f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 10 Mar 2025 05:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741608808; x=1742213608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGViJXCclzx/2EWYRBSu51fQCiFZyNMwoJLCZOnspZQ=;
        b=cuvuIZPGF4ZHZgtEXNPDls0W2xOJgjUiVht6d1Xg27J2tl07TSNNSWoIYUvWitBBXb
         G+hUDZGWJFEroGGbe1udbDWSFww/R8hvNqdplqIYXzu/41xhVU63UNHbrRjfa6mqYwd4
         CiuewCxWCCdOy65iKz0hZf5eigIuH8kr9jQkQDUZIR8CgC8XAyLCsOEY/xtvxcbaMZrB
         JMANdy8kUPLhZkMhkTURyaXHyVFSOa589J8FJ5UbOoQMHX0Bvise26wSPaKXkgix0yVC
         aaOxgqohz0bQcCfla0IrT7d3A5dwPVwyK89gtkS7CaQJeZOlhZsCPXMuWElC0kJ7agQ/
         eVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ouGpeWIc7JMb0uiF9o2xYffWxE2w8HM0ie74H3u65w5zcvLvJkmTx5lgUm5BB9TGiqF+jVI9ZbLm1mjXvZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9SWSEgLhQLXx0CGTRM9gC+FUtXdUzjbmtxTjCA+gehQCmAY4
	xOa8zTGwbBSfbBG3ViSdiGfUGJrzL9VTpwWTxltcyPb+ukikJ9dOE11vCCPCYMD1RIE2OQzabt+
	R0NiW8eGYPU6lVG7mF5GNhfY0KTImZ55Kd1zwnwDhnbq5qsJ+nfBJXGLQZ7/hYyiKkw==
X-Gm-Gg: ASbGncsBtQ2wAhFdUsfTmIshER/y+a9Hy8akrWC5r2nIMESzo5ZRhO0U53ATdMyuAYd
	OKiEOOd9ET9A5Cpm8KWUE3GCzzUJ49hC6zLydvKaO149qtx+jHILfHDpbkwkVOAuQXRrZENqTxJ
	g4pXepOAHgeV/zGIW+HdEFlLWrFgMPWIR1TDl4A+3RtPpGgLEPFfUeRTAUxYWy2GHBgF19ndsZr
	X/yRU7hiCoX/+rIzMpEdpmZLg7veUD/Z0oko7T71jMppoT6SdCWEZHMk8BE1u3acPnW0wadJqcr
	ja6k76yi0gNbS4j4yKiR+LM8yD6Svohyl1iaaRbHxQ5TRfkeITlsRfH/s8x8Twmq
X-Received: by 2002:a5d:6d0c:0:b0:390:de33:b0ef with SMTP id ffacd0b85a97d-39132d7084emr11040361f8f.30.1741608807846;
        Mon, 10 Mar 2025 05:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrpAzNy6sSH4YOG1+5l942/ORd7aa1SNvDl7U7GiW1x9GoWjA6Xlf8uANpk8LgTiYslFPSmg==
X-Received: by 2002:a5d:6d0c:0:b0:390:de33:b0ef with SMTP id ffacd0b85a97d-39132d7084emr11040296f8f.30.1741608807285;
        Mon, 10 Mar 2025 05:13:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103035sm14450166f8f.88.2025.03.10.05.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:13:26 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:13:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 1/6] x86/sev: add SVSM call macros for the vTPM
 protocol
Message-ID: <5zulxqr6l4xivnbdgal6nyz5c6x2mtqbkvhfx565tu6gmxxrgq@wpklze3745wn>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-2-sgarzare@redhat.com>
 <20250310110834.GEZ87IMgB_I86-3u3l@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250310110834.GEZ87IMgB_I86-3u3l@fat_crate.local>

On Mon, Mar 10, 2025 at 12:08:34PM +0100, Borislav Petkov wrote:
>On Fri, Feb 28, 2025 at 06:07:15PM +0100, Stefano Garzarella wrote:
>> Add macros for SVSM_VTPM_QUERY and SVSM_VTPM_CMD calls as defined
>> in the "Secure VM Service Module for SEV-SNP Guests"
>> Publication # 58019 Revision: 1.00
>>
>> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>
>Those URLs are unstable - simply naming the document properly in the commit
>message so that a search engine can find it is enough.

Ack, I'll do it all over the place in this series (commit descriptions, 
code comment blocks, etc.).

>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  arch/x86/include/asm/sev.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>> index 1581246491b5..f6ebf4492606 100644
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
>> --
>
>Merge this patch with the patch where those are used - no need for a separate
>patch.

Yeah, it is left over from v1 when I had added this patch over James' 
patches, but now I agree that it no longer makes sense since I have 
reworked almost every patch in this series. I'm going to incorporate 
them!

Thanks,
Stefano


