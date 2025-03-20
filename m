Return-Path: <linux-integrity+bounces-5335-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438BFA6A4C9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BECB7B17D8
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3710221549;
	Thu, 20 Mar 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhC4gia5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2A21D5BF
	for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469530; cv=none; b=jrxTXEFTeKhKcGdPJpbs2EvYv7C2YGPtsdsX2ExlT7WvqVy9FoKJNG+GbZZJldhiqPFa6xRuY+6Nr5lG30h5/wDCQXDue462m2+HrOxkWmorDYj6CVHZt2wo5YAdaI2JiQGfJrB0khbPkgi4o9TeHiZHWik7oi3jZMnvvXpi2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469530; c=relaxed/simple;
	bh=0FdnkXQluRsPObUmbyXPh2pDGWDzoaM0MsbjAFVybsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewdHnnmBwROY+2LTp+EyfoJOLTwYkUokbDI/V6KgAbScBccj81rI+UAcPJ/TySwa9Vm0CiPwv4f5pyMUBuo41R50U1gIJNZHdWRnHRa+4U4Rjhyojged3bOtcnxvaBxuEM/qSqOP649TA+seNFa0Oy+KT37Bflnp/O7ENymDzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhC4gia5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742469528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlhLlOmKjiRqXZDEYP/oB3y/fV4BzL5SuKNYZXi0IDU=;
	b=LhC4gia5O/tkJKMheRz3VBIhpjLRMDwOLWKockOvRz1QoSpF8dOeyH4ON604L6G/gWOIc1
	q95T6wFnEDA6BiGNMFXJyHGKIxXrtEmfOI8nbJ11JW2JdZxYIL0zoLvpGsKSAtbJe0Jyth
	lBH69VG6ZBOUY4afWlYZtnMpmkG4PgA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-RRqjb3brNFiimW0kLHNYVA-1; Thu, 20 Mar 2025 07:18:44 -0400
X-MC-Unique: RRqjb3brNFiimW0kLHNYVA-1
X-Mimecast-MFC-AGG-ID: RRqjb3brNFiimW0kLHNYVA_1742469524
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3914608e90eso415993f8f.2
        for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469523; x=1743074323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlhLlOmKjiRqXZDEYP/oB3y/fV4BzL5SuKNYZXi0IDU=;
        b=X314wy4dtpgojseUdLlyNbf5meDzOT4uhQigVY1F3rrWkmkNt0htCIpBj8E1vjp5Qi
         phrN1AvPZCtQh1tZ/qSExnRMBWUYbRN+GJH1WVjviEmqs925ZaJoga++rf0gAfeooq/4
         u+z0JLtxJLke1/cWz6+a7HYAcskDl2MAo4ly504JRf/n1V4Z3VR4ZAMlGih9pCsRL6aJ
         7wUDi6FAcApo0sMw3DWTD5t1ObfDVOQK4/53dNLGO8FG1ZZkMgiYYBfOOhkCJSoj3Co/
         vDYlhazBwfIVgvP4gHPmozU94ZE5djSjp2rErhMndUCXO+TAzB1HNoAbpM4qmjeGGm53
         Ocaw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Kt6wBQ9KjxbY7JlBIE4rG0NXVliJqAMK7XS1xBRDxVUdUKjqUtBJVD1yBHe8xzKXKdjs4Boy/WKcjdhzMIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6f+mJzVq82uST1cy1dxnVTgqw8Xc5xzDmVLnsonDYztM+JDai
	qYOFGdOFWGG7YdEwrX6eRdlD85Vvq1jNo1OYiPYNEPStOVXc1mFefEMvAFbVdR8Xu1XkBuEXuS/
	442Vc3irex+E9beMUo2DbnXTn2pIaTclvAG1Ua77jbpX/Kn4XF4b4++e5uTi8JrMOvQ==
X-Gm-Gg: ASbGncuH4LXTTA7w6CO9pPP38e3BP+Olm36lfLsRuABweZpESXAwCiCGZ3AIVgYlxZc
	S7MA9v/YohvtMcch4PqiwCRoRYEKslFp5p3+5SDmOHIaC63iwC0EuBIeqOU1NnUj4lfhqVZNZtj
	Zt8I9MEsJb6NUmuTwsepJo2S8VLsyI3trs/Vf+mM2AE+228UjCkeep63kn36vGY+c09whTIWuSK
	BcjZgQIejnJLwNi5DNX7h61cJDJdQcGAKsGEF9enE1NT4WOazqbyHgzkSv7JdSS0h1j9naK7A3I
	zJLI51PTFOwrwphERcCIE8ewBiC3RVuhW0REjgZzyXLthghpMmXbT5jJYh8LF8LN
X-Received: by 2002:a05:6000:4107:b0:391:255a:748b with SMTP id ffacd0b85a97d-39973afaef3mr7410053f8f.39.1742469523532;
        Thu, 20 Mar 2025 04:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI5mpKp1YJg5aoVvk5ggv41pOHlIt28ldIzkOLJLMe/dkF2SkzzL//q6jSa4e5CHMy+shCrg==
X-Received: by 2002:a05:6000:4107:b0:391:255a:748b with SMTP id ffacd0b85a97d-39973afaef3mr7409991f8f.39.1742469522991;
        Thu, 20 Mar 2025 04:18:42 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm23916885f8f.70.2025.03.20.04.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:18:42 -0700 (PDT)
Date: Thu, 20 Mar 2025 12:18:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-integrity@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>, 
	linux-coco@lists.linux.dev, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <imld77cuc6e4kyd5an5oeerfseit3l4enrbpazne2ybo34srik@ejqwayyod2mv>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
 <Z9gm9iWhk5Zs2NvI@kernel.org>
 <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
 <1262fa5b-0822-b8d4-26c5-426ffa4e0265@amd.com>
 <qne5fm44dhkbnwc6ldgff76ljt7ecd3cvtf3b3lhos56yyx2ez@qbcv45zbxlhp>
 <20250319234422.GG126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319234422.GG126678@ziepe.ca>

On Wed, Mar 19, 2025 at 08:44:22PM -0300, Jason Gunthorpe wrote:
>On Tue, Mar 18, 2025 at 05:18:53PM +0100, Stefano Garzarella wrote:
>
>> I see, thanks for the clarification!
>> I saw that with devm_get_free_pages() I can easily allocate a
>> resource-managed page, so I'll do that in v4.
>
>As a general note you should just use kmalloc these days, even for
>PAGE_SIZE. It is efficient and OK.

Thanks for sharing!

I think I'll stay with devm_get_free_pages() just because if it's
page aligned (with kmalloc I'm not sure if I have a way to ensure it), 
it can be a bitter faster for SVSM to map/unmap it on every command.

>
>Having a struct that is PAGE_SIZE+1 is not efficient and will waste
>a page of memory. That should be avoided ..

Got it, I will definitely split the buffer allocation from the priv.

Thanks,
Stefano


