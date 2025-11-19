Return-Path: <linux-integrity+bounces-7632-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB2C6CA8E
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 04:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D83A3552AC
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4DD2D9EF8;
	Wed, 19 Nov 2025 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiQftowr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/2+LsKA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168A288C81
	for <linux-integrity@vger.kernel.org>; Wed, 19 Nov 2025 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763524529; cv=none; b=dqoRAZaD5bYDjFzkEXE8SKdNi/p9u1yScGKwk3vGA8nAosRNTwyf0eYnvv0zvw/ZEhKCzHyUg7W4w/JZNR/b+eddThcSzjOK1Kp/sSpZc5NN9o0CuuRg01lYBDFcLjVwHcAqgp3a0Ng6tn0ybM71vhvuZOEabhEh5SiC6D6gR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763524529; c=relaxed/simple;
	bh=fexWQRxO1qDL1NeW3IczgGoSbv++XLaMMQy8gWodcVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eofzcUqgNw+AE7h+xPtbqeqrUIu8wmNo2ZH2dUFLzQv0kH8hhyOLdq0ZGlY7j5Jg4pnzXCjgNcUMjlOXDkWCOoePFkbxU+QhBcb0ElwiDg1JElaBTA4uf9sKw7jhP33P3mdVApMhxNyD9/7rYacHVTj1njLTUQU6K6C/TMMouCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiQftowr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/2+LsKA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763524526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ooCsRVhcTHqfbP0l9J8al+EICyTsRGhauAL5pmZkQRo=;
	b=SiQftowrbSHvGDFE8ig5o8c4LLyof+8UiX2pYJnIG+7cbug7PdAdgb8X+XsAGVZyBa3F25
	ZYOhUEmnMjfwg2Qa03bLdObVgWU16D0jSmS/SC20ugEbqKZBOLv1nZ2lX01MuiTn22/hiL
	jSkl5t32+5Vk4BiA0x62RU4vQZtVKvA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-TXvNutnfOtqe1rt5BkN8yg-1; Tue, 18 Nov 2025 22:55:24 -0500
X-MC-Unique: TXvNutnfOtqe1rt5BkN8yg-1
X-Mimecast-MFC-AGG-ID: TXvNutnfOtqe1rt5BkN8yg_1763524524
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so15504727a91.1
        for <linux-integrity@vger.kernel.org>; Tue, 18 Nov 2025 19:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763524523; x=1764129323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooCsRVhcTHqfbP0l9J8al+EICyTsRGhauAL5pmZkQRo=;
        b=Y/2+LsKAvRQKbFNcx2rYoLBHVPrZbzyavEfMiiuwoOsEuLl+Ch2DMBUpIIkDgDh4yY
         PQu0jZLuRXIEmTZeG+1AHo24UrZZieNoBptLWKZD4T9O3Ve1TbAgFvFJyQ/YiLYhSI+N
         3w96/8bfAuxc1Fisblk4JGWQnqSNBKGo1/qQrXwLCaIYnHBhtvwy3AAQS+mxT+GXSD4A
         dR2DSWQOEeh2FvK2lUekgTz198kvaeRRbZ+0M9m/rdl5Y/GihH3bWpkpMRivb/EbsIbh
         gRrjFtoHnMU+sGFTRDYRdiQOe4qXSCU8wPfz7Dpd/heuqiQ8BQwlHFnt7jGf0+tRddrJ
         yJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763524523; x=1764129323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooCsRVhcTHqfbP0l9J8al+EICyTsRGhauAL5pmZkQRo=;
        b=F9xx3s8ynri/gv/JticuKiMF+JkU8LLj2AZ/wcwHAiL9olU3uwC05yT6VKkF+rKXQl
         JBgDDlj0r9ZX9XuOvfpAcOTjmE9ePUqSDCAyYKoWNbqLCM4V9NAJ/MG8Q/i/4zy2yT+R
         BoxnkfYDx2mZkiN4zmAj1l+fUzUSnJxefbj/Iz22c6GGNY9yHfVjLB1LOdiBGjC/RZPX
         vSZPQvnxWjt7otayxIDoQgAxV0sbLwxlQH9c6K7zB8KYsO5ZJ2d1RT5hJiqzahaltErr
         niVtAaMp5Yv8xJ/K6xWSO3COScRqa0UYOaUKk62TwnGX6NwapSqcaa4mPsS5/meLWijl
         UazA==
X-Forwarded-Encrypted: i=1; AJvYcCWMwN37BhsA4ylN0265fZSxkiUAtGqn3pn4CoaqO7mdmK/SmWnmcy5Jp5c1iTv+jTHMKcGJTKYr6sub1H1E+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMAjPRlQyjk47bKrhMw3OMHB12moIaNDAImq+6086jSnPx1x8B
	z39WK7TEufyP75GJ9N5iVBfMnltICXmAwkK721KzdQLVVnbVRgg1HOd6OpfipExuza5x3CpczV7
	pcmxEP2NeMmzXAUHSn8XqU4M58VqK3FHvKNULKjkeoM0np4LgWioghUS6uSHjsGoNUE8kvWvTiS
	hBDCUk
X-Gm-Gg: ASbGncv/hyrobX7wd+agY/j/u/wZh1zDxFoQfmNmgq+7BCI/y/lFKDj7xXJhAKnmI6t
	8iXmLJESIM7sjsyg8TnVfO1cEcSh1p+UdbNYqRopgoV50EJKnQvY4R2mUi7FDkmpPBDHsU5ZAvB
	STd4YHM5s2LaGfSqWFY3YEw0L1O+cNOR/66GFG5N5PscuXHuVwQwLUwoJ8lyXgumKEhNaZ2Mscx
	E9hRCxLSet3ve8jzoV4tZjr0eR7tJsHZ+WeamZtBtfpPwaBYTRg8MvxOB4w5MFdR8JykXH8UIII
	uxMQZjQaiuWUPv20FHKpQGryvIh7vpdWPv+AVhWk+wXFWX0HBomFeLz58EOesqG/tDKWEhj+GcQ
	a
X-Received: by 2002:a17:90b:2e0b:b0:343:747e:2cac with SMTP id 98e67ed59e1d1-343fa761482mr20567681a91.31.1763524523263;
        Tue, 18 Nov 2025 19:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFssyPLkzi1egxM+wSUcJO1UnhvGQOb9QwQq0/MObXjomISK4Uyzbq1QhFXSSzRMUYO4Aev6Q==
X-Received: by 2002:a17:90b:2e0b:b0:343:747e:2cac with SMTP id 98e67ed59e1d1-343fa761482mr20567648a91.31.1763524522734;
        Tue, 18 Nov 2025 19:55:22 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc3760d9887sm16384031a12.28.2025.11.18.19.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:55:22 -0800 (PST)
Date: Wed, 19 Nov 2025 11:52:15 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
Message-ID: <7unk23jlwh3gy477ose6r5mvov5apxoflxmzhhpeanvrgg4ejb@h74hvym5r67s>
References: <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
 <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
 <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>
 <42qcfcxxlmwphctzvji76hy5tycfabiiv5u6zw6lgg2p3e2jwv@fp4g2y7ecf2y>
 <fca9a7b41a5e428fadfe2d7e3b004ada2763375c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fca9a7b41a5e428fadfe2d7e3b004ada2763375c.camel@linux.ibm.com>

On Tue, Nov 18, 2025 at 07:19:50AM -0500, Mimi Zohar wrote:
>On Thu, 2025-11-13 at 12:06 +0800, Coiby Xu wrote:
>> On Fri, Nov 07, 2025 at 02:28:13PM -0500, Mimi Zohar wrote:
>> > On Thu, 2025-11-06 at 17:15 -0500, Mimi Zohar wrote:
>> > > On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
>> > > > On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>> > > > > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
>> > > > [...]
>> > > > >
>> > > > > Hi Coiby,
>> > > > >
>> > > > > Based on the conversation with Paul, there is no reason to remove the existing
>> > > > > security_kernel_post_read_file() call.
>> > > > >
>> > > > > The changes are similar to the 2nd link, but a bit different.
>> > > > > - Define a single enumeration named READING_MODULE_COMPRESSED.
>> > > > >
>> > > > > - In module/main.c add a new security_kernel_post_read_file() call immediately
>> > > > > after decompressing the kernel module.  Like a previous version of this patch,
>> > > > > call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>> > > > > based on MODULE_INIT_COMPRESSED_FILE.
>> > > > >
>> > > > > - In ima_post_read_file() defer verifying the signature when the enumeration is
>> > > > > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)
>> > > >
>> > > > Hi Mimi,
>> > > >
>> > > > Thanks for summarizing your conversation with Paul! I can confirm Paul's
>> > > > approach works
>> > > > https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul
>> > > >
>> > > > While testing the patch today, I realized there is another
>> > > > issue/challenge introduced by in-kernel module decompression. IMA
>> > > > appraisal is to verify the digest of compressed kernel module but
>> > > > currently the passed buffer is uncompressed module. When IMA uses
>> > > > uncompressed module data to calculate the digest, xattr signature
>> > > > verification will fail. If we always make IMA read the original kernel
>> > > > module data again to calculate the digest, does it look like a
>> > > > quick-and-dirty fix? If we can assume people won't load kernel module so
>> > > > often, the performance impact is negligible. Otherwise we may have to
>> > > > introduce a new LSM hook so IMA can access uncompressed and original
>> > > > module data one time.
>> > >
>> > > ima_collect_measurement() stores the file hash info in the iint and uses that
>> > > information to verify the signature as stored in the security xattr.
>> > > Decompressing the kernel module shouldn't affect the xattr signature
>> > > verification.
>> >
>> > In the case when the compressed kernel module hasn't previously been measured or
>> > appraised before loading the kernel module, we need to "collect" the file data
>> > hash on READING_MODULE_COMPRESSED, but defer appraising/measuring it.
>> >
>> > An alternative to your suggestion of re-reading the original kernel module data
>> > to calculate the digest or defining a new hook, would be to define "collect" as
>> > a new "action" and pass the kernel_read_file_id enumeration to
>> > process_measurement().  IMA_COLLECTED already exists.  Only IMA_COLLECT would
>> > need to be defined.  The new collect "action" should be limited to
>> > func=MODULE_CHECK.
>> >
>> > The downside of this alternative is that it requires a new collect rule:
>> > collect func=MODULE_CHECK mask=MAY_READ uid=0
>> > appraise func=MODULE_CHECK appraise_type=imasig|modsig
>
>As it turns out, the "collect" rule is unnecessary.  On
>READING_MODULE_COMPRESSED, process_measurement() should calculate the compressed
>file hash.  Extending the IMA measurement list and verifying the signature can
>then be differed to READING_MODULE.
>
>>
>> Thank for suggesting an alternative! I've implemented the idea in
>> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_collect
>>
>> Note besides a new collect rule, another change is needed. Currently,
>> process_measurement only accepts enum ima_hooks thus it can't tell if
>> it's READING_MODULE_COMPRESSED so to only do collect action. So I
>> create a fake MODULE_COMPRESSED_CHECK func.
>
>Correct, either extending process_measurement() with the read_idmap enum or
>defining the fake hook would work.
>
>>
>> And for the idea of re-reading the original kernel module data, it has
>> been implemented in
>> https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul
>>
>> Both branches have applied your requested three changes including
>> respecting the 80 char line limit. Additionally, I made a change to the
>> IPE LSM because of the new READING_MODULE_COMPRESSED kernel_read_file_id
>> enumerate.
>>
>> After comparing the two implementations, personally I prefer re-reading
>> the original kernel module data because the change is smaller and it's
>> more user-friendly. But if there are other reasons I don't know, I'll
>> post the patches of the new collect action approach to the mailing list.
>
>The "re-reading" option fails some of the tests.  As the "collect" rule isn't
>needed, let's stick with the first option.

Thanks for evaluating the two options! Yeah, without the "collect" rule,
the 1st option is much better as it doesn't have the issue of re-reading
the module.

-- 
Best regards,
Coiby


