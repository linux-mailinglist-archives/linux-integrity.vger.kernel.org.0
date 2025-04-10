Return-Path: <linux-integrity+bounces-5753-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2981A83C9C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 10:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE193A5808
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4221B9D9;
	Thu, 10 Apr 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR2Je7n2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74521B9FD
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272945; cv=none; b=eqBlC3qeHtH32LMCGlEkC6BQjaeXxp5O+E1fMbawIFS6NSg3UA+KptEjxX6ci6tMMLlMoaTkzcxAa67HqXfUkUZetOqzXbXAwTjL5BspRUFVecZbgIdD6Vr4WNiBUGo0ohDNftv2NL0tn9U4vX3pci+Bfu7/pWcsw0qYAyc7kDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272945; c=relaxed/simple;
	bh=mg9TTr2igANmwpfSP2Bjaog3EnCruAP6eGH7IneMLUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeZ1PA1SCaVgt/D0JPmhjMbPxzvzC7ByqcK3EzjXWUqDlVAfdFVRI7OdoRFf5yW2gXbI7GmTYTQ9+Er4b+8vYDAmN92e0DbmMghsXxnKtkX4SeLCoqXLNBk7KDOYwOQbhtVr9c16O+QV5lULqmoIVSgiXxviB6IPXSBplesajFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NR2Je7n2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744272942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWDzicHLsBgJ4w8qzf+KZj6VBuv5e32hgZSRqmxhhdU=;
	b=NR2Je7n2sKtwebk9PPMyJW29yrS/aQOzt3TmDL3Iqe+JQBjINt5tv6h3YrHQD35/uD5Lc2
	mdb9Cwo1oXQD1G/+LDMHmbcUg3tidg4QRZChkqNJw/dtldfRZPOjGeeuqsEH+KT/G31ez4
	DPm4WDqi33bTlCkHTgL4Z+gHDATPY9Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-tHZdMGckP9yhiRd0HJwakw-1; Thu, 10 Apr 2025 04:15:40 -0400
X-MC-Unique: tHZdMGckP9yhiRd0HJwakw-1
X-Mimecast-MFC-AGG-ID: tHZdMGckP9yhiRd0HJwakw_1744272940
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e623fe6aa2so557825a12.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 01:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744272940; x=1744877740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWDzicHLsBgJ4w8qzf+KZj6VBuv5e32hgZSRqmxhhdU=;
        b=UgLD4BdbfecKHgRCYhunkv7hprlxsguZeWUZboSsfhSuI7YbCURFezjnvlkGJlMTqK
         KraEA4/do4oS8hedHYApKKzHsTEQXJiXhbrKDyGVO6JZ+3MtnBFWaU1vOcpfJbtAVKzw
         B5jk0H2s71BpVeUmWoPCsyq5H4xjAIoDLfFMDL54MgKY1ub7Q7jRxqaACimaRODsIOlA
         ZkAjKTu3bCzfSAxYWPYiApDmsV4IxYPt5ReshXOTkWO9uWtsgegB/gKJbNIS08rq9ZZ6
         3RcVnB5/k5ND+YaLVfafchdKaJv6f9w3NlIOXMF7xK06D6NcuEitRmB+pPvJMiSvnqkk
         V1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWApgqbBxmikogrO7QNSY/D8Wb2ajI/lyyHDyARHlmtxl+uB2nu3Jthc/Ld+AsPT3tqhYLcozRasOSyXmoRpms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gWPiaQuB6EMjDBpuVHDIKeY3kvniIGLOknMX2qI4gTmqZEf9
	02aJ6fgUq1s9EovzJ6/UD8bDrePUBdHS4FYedeoU6lg+b6niCtivAepm91eJs0GzqYfCI2lXuLP
	Dm9+gKlCnF+Nz7xGF/f3FX2ehMyiuQ40BE6A6BV6/ufIGBUrT3QZkZhrid1KtQMzNoA==
X-Gm-Gg: ASbGnctkkFI5NXk51JQBmifxlEmyHNbCz2JYLM6BMf5B744JnDhNZ3nDKDkYyqYDl+l
	T+6EDEdj3hgJg4SrQXwqLU7M8uV0FpjIYSdPMk73yzMl2oeHfATdW5lkukinodrxH/h4wqcWVjq
	Zaz6cRB/3aHkqlBGKjpvpvwgBpO9RAdsAsDIlxkYgnvOb9MtOFxRK6KPFA5Lpls53TIBQTbXmCi
	WzKZ9mLSHPl8JYO12TQ5sZ9TSmqZtuebM8xAiCZ7xK63CNwvh2KfEJr39l7I9ivIoQZDTTnxJPx
	i9UfA4gz+EeaDkwYg6YtMzWONJP2pLwy7gtd6WmwO0B6IR31jICJZOxvOOXA
X-Received: by 2002:a17:907:e989:b0:ac3:d54:d825 with SMTP id a640c23a62f3a-acabd3d802cmr206596666b.56.1744272939754;
        Thu, 10 Apr 2025 01:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKuq1jrLQYQCt2MWuX/DTVpWgnqHWa2JwTl4MRzpVmRvMRnfirH5uXIuSine+27SzbE/Kw2Q==
X-Received: by 2002:a17:907:e989:b0:ac3:d54:d825 with SMTP id a640c23a62f3a-acabd3d802cmr206591166b.56.1744272939208;
        Thu, 10 Apr 2025 01:15:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4142sm229097166b.101.2025.04.10.01.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:15:37 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:15:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, 
	Dionna Glaze <dionnaglaze@google.com>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Message-ID: <xfwwxtkphwlkrpemprdyju6zahwh43tijdlbzivtokqtcfvvxw@a4ujdfs744tm>
References: <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
 <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
 <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
 <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>
 <20250409113154.GGZ_ZaqgfRrrMij_Zm@fat_crate.local>
 <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>
 <20250409184507.GLZ_bAM8LCPXKn9xU1@fat_crate.local>
 <bf8b7522-f34b-f7bf-11a5-5f6a223129eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf8b7522-f34b-f7bf-11a5-5f6a223129eb@amd.com>

On Wed, Apr 09, 2025 at 02:16:40PM -0500, Tom Lendacky wrote:
>On 4/9/25 13:45, Borislav Petkov wrote:
>> On Wed, Apr 09, 2025 at 11:07:49AM -0500, Tom Lendacky wrote:
>>> So the vTPM driver wouldn't change, just snp_init_platform_device():
>>>
>>> 	if (snp_vmpl && platform_device_register(&tpm_svsm_device))
>>
>> So this basically says that the SVSM is always sporting a vTPM emulation. But
>> you can build the cocont-svsm thing without it AFAICT.
>>
>> So I'm guessing Stefano's suggestion here might make more sense:
>>
>> https://lore.kernel.org/r/o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl
>>
>> considering it all...
>
>That way works for me, too.

Okay, it looks like we have an agreement! I'll apply that and send v7.

Thanks,
Stefano


