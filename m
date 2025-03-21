Return-Path: <linux-integrity+bounces-5355-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B5A6B68D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C7E3BCE32
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D71E5B70;
	Fri, 21 Mar 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmQxIjNQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2311E7C3A
	for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547689; cv=none; b=cp/PQMJSNA4mOj/QuBaWhqPut67cNyMwxgumF0s7xno94VonzyIPfhmGL0WTpOu5m8PkSe3avkw7m8Ywjoyw9JMV33YpM1wVXB6atHDHL+zLsSchCuscuBn1E4aV6SPQUSr7sslNonALxVy8a4KFLZRbiGGmVylElUTxQy0Dx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547689; c=relaxed/simple;
	bh=sD61hq3NbhxezVFYNQMHc6yPU40zBPjZnQBfIAHwJ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpY6dOjpydKJJHoLDGfhkRMUa7FvgLJjN98SOyJfsA7BlVagpd/dZs9Ub38ne3beE/vXnbNq3MpR/wYjmpLtI3xWwAvWEYvn8lewK+eTQ43VrYOUpqctjMnSgumfBuAlcefsZre1JDWn8IKuBvNchwjoY5nCGlctYY38E4Hd+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmQxIjNQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742547686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmxTpqzZ0HZCDGZEFV/pcObjt3lzP/3kzdelw6nLCTI=;
	b=TmQxIjNQx4pwOjZ9w7DMw2UmkQd6XqxYVHBMCkmeTt+xNQv5LF6y1PZH5xp24lJxQP6sou
	iGQYGnozSgqY4Co3/Np4W5Ats+GGx6995jTYtsm/srQVFa27gfyiAPtRYsGPpsixZBHnd6
	7h5MMnafeEOzTRwpl4iA+284sMwxUT0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Q4H-ryAOOMGrxaVeDM5aWQ-1; Fri, 21 Mar 2025 05:01:24 -0400
X-MC-Unique: Q4H-ryAOOMGrxaVeDM5aWQ-1
X-Mimecast-MFC-AGG-ID: Q4H-ryAOOMGrxaVeDM5aWQ_1742547683
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3df3f1193so124810066b.2
        for <linux-integrity@vger.kernel.org>; Fri, 21 Mar 2025 02:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742547683; x=1743152483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmxTpqzZ0HZCDGZEFV/pcObjt3lzP/3kzdelw6nLCTI=;
        b=KqDTM6p39N0mKErUI0CgU7wjHKwfMn9f6fJMAmVQcv5GU51VpZINeIzRMlvmKy1nV7
         zhOgdbQ6AtPw0CNKPuy8/C8SfhOJ1y/EYN+3nAQYJKbHufHaCNRIxsiHGwi7c6/xVAAo
         gMXGkpkkN9wDZKW8OqE+burj2YdV20ks6ghA/1fcNdnAtjqC+OSg8h2gv+cQEhoN8s9O
         jCkpWJ9et2RpAu90DDE3TYuAgTqKPAztwK4A2A7c/te/bWu8AoM959k52DFa7gXWo73u
         vhVSEqKuilFJBMhWfzP/02Sd+P0hbQw+oFeR9V94t0uxBy7VtMsnX8SXNxdzZ3xYTYJ1
         8jqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/jc2FxHH1i8LfxPFOfiTb4bi9BudpDQYbeOa+XaymLLOlKnp70GcGNwhPqX+5gwdvqatzhINqB7ufK7ZT/Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8yc0etM9BRgDjPPo4XVSopUPlP7uiCwQkq/Boct7QPwAjn2T
	d8VYxe5eJitQA+nSXSUDUv5HA6gMMiWS1f6WZYJmKZPojzupfjfWiJPt/UtC/oUAMVEZO1zxE/v
	TSIDSA5UurfcRBXyNSTD1/T2VPG0m66n9ebCQoHfDCdGFMd/FTbkBR87FpahDdVwMNw==
X-Gm-Gg: ASbGncuuWTGzxpbhfEDfViytRuvsZALLfIjwh0jccwQgewM1asnauFmPGniO/1pi6LV
	QqKdxlH1PM8rhMNa86P4MLia7QlzBve7p//Z4zKbca6lRbPiajn31RYTVO952zhxiRF27i07+1l
	bHrB3YJy8+ZOqfZLOr54gBCQ1RI+uSHUxCqpDHy3ri7Q823ojWo858B4sgLk2Ak2DFZQKmjnZQO
	9ITmxS54NsMuHrKJrT8KY3J3GyDKfyaGVHTDmekiWOIId3F1gOMOPSjOnEYGWmJ4zsZhD7k6UcC
	PgjTIY2UhoaTnvAMGWVnVGLIkPrBVdYPvdDEkLOZxLWRPZqknLxepqko4aaoz7Pc
X-Received: by 2002:a17:907:971e:b0:ac2:622f:39c1 with SMTP id a640c23a62f3a-ac3f20f3e88mr195018966b.22.1742547683320;
        Fri, 21 Mar 2025 02:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWCLFs66okYwfxdtv5GcgcdWwR8ZJt//AkHzaDeJko0ra/kue35fF/YS12dNXFy2WPXsVuiQ==
X-Received: by 2002:a17:907:971e:b0:ac2:622f:39c1 with SMTP id a640c23a62f3a-ac3f20f3e88mr195011766b.22.1742547682576;
        Fri, 21 Mar 2025 02:01:22 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50edsm114444066b.52.2025.03.21.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:01:21 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:01:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 1/4] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <rspkz663fg7i7jomvg5ehv3ldr6ayehttb7vgwwzsfsxafzb5y@uhqcadvsmw6f>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-2-sgarzare@redhat.com>
 <d7e5a1d2-5fcc-bf7f-a67d-7871a1627c98@amd.com>
 <Z9glWp6U6vyEmKQa@kernel.org>
 <7kuhiyy7gj4py323g5n2vy3ddlg666zwhtx3mjcklebgtlstdc@xgdyeecifwei>
 <Z9wuLVeP726Cssqp@kernel.org>
 <20250320171619.GOZ9xNY4W54avW2a-u@fat_crate.local>
 <Z9xQw8QpRKk26G6R@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z9xQw8QpRKk26G6R@kernel.org>

On Thu, Mar 20, 2025 at 07:30:43PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 20, 2025 at 06:16:19PM +0100, Borislav Petkov wrote:
>> On Thu, Mar 20, 2025 at 05:03:09PM +0200, Jarkko Sakkinen wrote:
>> > > I can do that, I slightly prefer BIT_ULL() macro, but I don't have a strong
>> > > opinion on my side.
>> > > @Borislav since you suggested it, WDYT?
>> >
>> > Either goes for me. Sorry for nitpicking that :-) The first comment
>> > stil applies.
>>
>> Bit 8 is a lot better than 0x100.
>>
>> Let's give a better example:
>>
>> 0x0000000008000000
>>
>> or
>>
>> BIT_ULL(27)
>>
>> :-)
>
>Sure, I'm fine with using BIT_ULL() :-)

Yeah, we all agree :-)

>
>>
>> While I'm here: I'm guessing I'll route patches 1 and 4 through tip once
>> they're ready to go and give Jarkko an immutable branch he can base the other
>> two ontop.
>>
>> Agreed?
>
>Works for me.

Just a note, patch 2 adds `include/linux/svsm_vtpm.h`, that file is 
basically a translation of the AMD SVSM specification into structures 
and functions used to communicate with SVSM in the way it is defined by 
the specification.

I realized that the file does not fall under any section of MAINTAINERS.
How do you suggest we proceed?

Should we create an SVSM section to maintain it, including the TPM 
driver and future other drivers,etc.?

Or include it in other sections? Which one in this case?

I'm willing to help both as a sub-maintainer and reviewer of course, but 
I would like your advice.

Thanks,
Stefano


