Return-Path: <linux-integrity+bounces-1745-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D587A1B2
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Mar 2024 03:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F57C284584
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Mar 2024 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0677C147;
	Wed, 13 Mar 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgQ0JuPg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474EBC133
	for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297620; cv=none; b=OKVFes8f8DCkG87KcKgTZVBf3XHhXA1f2esXJglKvY1VE5o1gCk2bFTprjV35bYrepSQ8scIsitX54dLX2CJCuf8Ig/ykdrBfwLDLm085AB3W8dxrYYfSOB30iWCFCjYm0NWnim0JmMfCRzCw7x0pZDxXXjv2BxXxwYp4DVcUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297620; c=relaxed/simple;
	bh=bT9cgD9xoMLhqt3/eDR3nr6SSI/CyX28YEwHte2GLxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4/39pXAZnmsG/0pQpfRq8FsAk+TOiXxmmcUp7GDEo24dEfgdKglABTZRYr98eJHi03wsHubZtsh9YwQfatwiqKLdRH4DJczhs+Ce0kYnEW8QpMYAE8Djxd/iBE8NnyfeUSpaCHF9dyFgbJvWCK3LFHG6x5mr7ZgZKg8xLcekAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgQ0JuPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710297618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLDKnplj27bk7XMdJMqwJSbyHYnIPFsAuwJfX8G+gAU=;
	b=KgQ0JuPgHoV0+clD26G82HuMpE4ngpdzpP0TjxxeA0awucPpCX+y1Zt2W0+a4Pk+yanpWX
	w/3kg40JJYYTmtXDzD5HkRluFZVH9Xm/ldjNB3pa4Eg3EA44qrxr+Q3TXYpmocDKiAqK/p
	Na//6sVb8nuTXjZDV09dDTfCg6w5xQs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-FQXf8_vcMI-5UiAu2P0suA-1; Tue, 12 Mar 2024 22:40:16 -0400
X-MC-Unique: FQXf8_vcMI-5UiAu2P0suA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2219ad32ab9so6099544fac.0
        for <linux-integrity@vger.kernel.org>; Tue, 12 Mar 2024 19:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710297615; x=1710902415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLDKnplj27bk7XMdJMqwJSbyHYnIPFsAuwJfX8G+gAU=;
        b=jIUbM5Pi6FNdbVD0GzkVqXn2/8h3PE+5Dc8p7MHZ5HfhsSmObB4SdrjL4eMXcS0icT
         BdBSSGZruGC7fnOmbahTkJYVTf+PL0aPm+NVPgJRLZ+eX27eFGujv8/Ta1E8epkpSbu/
         WytsV9ihvQgD2AEfvWcCVm69Tk+jyOF1YjNCVd9H1ccU5A2wplAawxmf9sFA7J80b7l0
         f2bW1O0lWr/pNvub219RBPD+YoAjtJ8weIPnIRHQuZJpWyfPbBzbMWw4oKEicvo3iEOp
         w88xEBYflF6FJUQ0DFxpY9Cnepc4+PBluNLOjxK+sEqx4zgNPlZ5ORYvj03oR+hn4Qko
         h8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUVWnuRqH02JnogN0j5HhODUOJaloVde7Naz7cPp/OT0OfgzQlOmWvWsSAlkvW1qZ9BoHf2SajyjssiPJvEWRBV2XUYz0m2gFfo+IdCs9JN
X-Gm-Message-State: AOJu0YyNdc9ZgbpGayCpehSAe4kw2xFLJBW+ei7CXNtPmIPta2KrspGE
	9050tm+jhmJxcpKXi3mTI+AYgECWe15LiAevS4hO4Ra4xQtI9UqkEaDBkvEpVNvswAh1GLJzS55
	8lD2KS/ZU8cLMwgrWB7SswX/4Mokj1e38+RaXEUaNE4bMpdDV3hzDpPpFkFnuBF7zRw==
X-Received: by 2002:a05:6358:3401:b0:17b:f4a1:b626 with SMTP id h1-20020a056358340100b0017bf4a1b626mr14909047rwd.13.1710297615381;
        Tue, 12 Mar 2024 19:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2czkJxHHK8iTWoJP2+GXQgOSzrR8EUnlqBRIqzbEfeFRiTVhU4BFfN2MY00qNUPEEuj0R+A==
X-Received: by 2002:a05:6358:3401:b0:17b:f4a1:b626 with SMTP id h1-20020a056358340100b0017bf4a1b626mr14909016rwd.13.1710297614481;
        Tue, 12 Mar 2024 19:40:14 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d12-20020a63d64c000000b005dcaa45d87esm5975622pgj.42.2024.03.12.19.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 19:40:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:37:29 +0800
From: Coiby Xu <coxu@redhat.com>
To: Maxime Ripard <mripard@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <gucfr7sxmv4hiowr6dokx7r7nf6wdiqdm577arnwe5yua5z24b@3sljt73mpjke>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
 <20240306-humongous-nuthatch-of-science-00e58b@houat>
 <a677a9cd8eda40e5529094ba2a6ad2f7c0c927fa.camel@linux.ibm.com>
 <20240306-large-lush-catfish-e75cb2@houat>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240306-large-lush-catfish-e75cb2@houat>

On Wed, Mar 06, 2024 at 01:40:01PM +0100, Maxime Ripard wrote:
>On Wed, Mar 06, 2024 at 06:55:00AM -0500, Mimi Zohar wrote:
>> On Wed, 2024-03-06 at 11:57 +0100, Maxime Ripard wrote:
>> > Hi Dmitry, Eric, James, Mimi, Paul, Serge,
>> >
>> > On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
>> > > Currently when the kernel fails to add a cert to the .machine keyring,
>> > > it will throw an error immediately in the function integrity_add_key.
>> > >
>> > > Since the kernel will try adding to the .platform keyring next or throw
>> > > an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> > > so there is no need to throw an error immediately in integrity_add_key.
>> > >
>> > > Reported-by: itrymybest80@protonmail.com
>> > > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
>> > > Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine")
>> > > Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> > Any chance this patch can be merged? This is breaking (at least) Fedora
>> > at the moment.
>>
>> https://git.kernel.org/torvalds/c/29cd507cbec282e13dcf8f38072a100af96b2bb7
>
>Oh, awesome, we missed it.

Oh, I missed the emails about Mimi's PR sent to Linus as well. Btw, I'm
curious to ask why you used the word "breaking" because I thought these KERN_ERR
errors shouldn't cause any real problem.

-- 
Best regards,
Coiby


