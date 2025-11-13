Return-Path: <linux-integrity+bounces-7619-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5548C55A0B
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Nov 2025 05:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE8343310
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Nov 2025 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326829D281;
	Thu, 13 Nov 2025 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGzsAt+Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j8m3MUhF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5762C1586
	for <linux-integrity@vger.kernel.org>; Thu, 13 Nov 2025 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007021; cv=none; b=nllLgdGLoijS7qskZeyL8qn0cVVKWY5gMeBFQ4barRXQEgalimK1WSJpHDR3xgs9HAt8zM4SqUwEcLyZ1CrPFCl2oD8uT5fm4rY7vtTiTZDlLa/DoOAL5wKNoKiOF02qZik31hX0GoBnQGUvU+BOKcZUlVGULJQNIajxSGTCpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007021; c=relaxed/simple;
	bh=zdLHuuMTe46EsyhV/bM1eTvKdfpTyHz80agisPFVCuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQMYgWTT7eWRjaErgSDPBJPcP/I0Hju+L74aW0PF3lwLfPUB7iNPWZKuCLc8qBB6Ekto9/enuciqqVen8L66gpbrdqPwlblinUXxz1j+dAnBWodyYJp7OK+vH55Z1jBb9Muh7Ha8YGRXjB9fdZ8bk4lD3ch0inXXoZ0Xm5W/vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGzsAt+Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j8m3MUhF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763007018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZIBY6eCn23Q+siVmn68NakRPUJnSr/kT+giBlXwV0A=;
	b=DGzsAt+Q4yb3i0rO0RXWY4BUYGVjwBAcZlvW4Ba3+hC3NVM6v17+kb8g4q3J/I45eFQ75O
	RW1q28UHMYz3iQmMmKWaUHrb7+6p6bslSCoofDTLY96X/gWm+AWJZxqPcW+qcqrGoC23Gm
	2JgX+Ij2Y5gl/OK0ixOp2RAEAkBoCvE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-gU-fGBfEOcyOdIbX-7azdw-1; Wed, 12 Nov 2025 23:10:11 -0500
X-MC-Unique: gU-fGBfEOcyOdIbX-7azdw-1
X-Mimecast-MFC-AGG-ID: gU-fGBfEOcyOdIbX-7azdw_1763007011
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bc349a8a3easo331064a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 12 Nov 2025 20:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763007011; x=1763611811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZIBY6eCn23Q+siVmn68NakRPUJnSr/kT+giBlXwV0A=;
        b=j8m3MUhFP4VoIKntrt2otGgVvRIN7lcPhhSQI6q46Bv8xC6CCKnuIXLS1UWTvHlY9P
         IY/RumUpFc1lsKlmspqYc0MG4rM9FC5KioukykMX7/GltaAYhwF6AMye0ecgSMsPoA2P
         X7yPGe2DBAS+UcN0tQ61URojhc+9CbKK0IuUZi8ROVmvcm6yIAhKbP3Us76mc/x21g60
         9534qZ51EMNdiBsLi+2dVuOABzrHttorjVOdJzIkD2oPiXhgY7tLA47tfGwTXjgC1q+b
         9DS98kacBwGwM9Qg/gWDAhWe4eyl/4EySY2Eso1zZ5QDQCgJFwIYpusliDmPnagQ9CIB
         ogbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007011; x=1763611811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZIBY6eCn23Q+siVmn68NakRPUJnSr/kT+giBlXwV0A=;
        b=jUuzDtmm68GRpIkFpi2kteedUjScYppfU+f1/aE/CWF5yoN+zUYuVhZ6v8BOPoXBcs
         Ov4xyWBhJI3BgNRWKBGEtUFpIz/95NbTnuF+DPS6vaRXoG+5esBW4fcLDRplSsjvP8a2
         /O9Zx6AqTEPd+PZ2mPkYfdEvBGla1RsQ0dRm62MLNSggVbiA3I+en1IBuJUsmYbD6TRF
         ktEOja4kD8rjhn470lTNzZeAY9B3EamA3LbFPdVoZgPqKBGqFAKfOhP4RNdQQdWfMfGi
         j9rM1FFsWRYBHP2RI1eNnSqrY2hxi4PeJ07Ib5jDRNzU+j7LAiVNE0G76R6nt8b0w8PK
         raUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJeXkcmBUEhQELZIki3X+nxDxlUq07Ba9lNmxLdbzraAPuU43Vxiu6NjN5eMdOdjtKmeUAla/z0uAVtYQKu1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jzOlhEkB1UFgqJUT+1lDd7GQmQJ4wMlGcgKqDCFXs0QfaYEY
	/vU5YQyZPmQwSVB70+zFdgUOHPrhCiI0wniPe2Eo8QitM3nlTBx9wxkVk/EzZSq3sIDvimhYfe/
	p/gAcleMJSyTLhDED0uF+IUzaZ6CVFWaKOOZZijhfMwJDcR2ThorPPUQ/RpWGa6nk1WbPuQ==
X-Gm-Gg: ASbGncs7iH1LgV3XZZASQZkXLRkS4N1J6lfd99wMDz762FDVRUeI9wJPSIOc56dvAJr
	JSZAo7kcofRFV03ylhB4PBDvOruBKW6enhQWTSo4HyZuP+sI3wd7gNo/yI9akE7l+gqi+NcNOSY
	Gb03bpjyYqCFCojoTMV6Urut3lPVYV8DiL5wFXH5qSrr2ND9y50P1QQRAeMqIHRKsc/H3XXNU5i
	UpiWQ0aQxSQ9K318ZkiblLZdxMYDHKck+t58V52LCsdMEm5zqJTfNF+VX19QQZ/gMVjqfyyYnXR
	t3RUfS4OwiH+RDC6ZiJ6QX+L24cBZVW6q/CSbPYiNu6GIbwvuz6dkBOtyVwqwFJw7Q==
X-Received: by 2002:a17:903:4b04:b0:298:529b:8956 with SMTP id d9443c01a7336-298529b8bd1mr54723675ad.56.1763007010485;
        Wed, 12 Nov 2025 20:10:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWDwN+5E+tsPmc61Ky6R88DQMezRVeNlZMFO+j6cmwW//kMzz/cF3f2/ywvf8oGJ38G1y9PQ==
X-Received: by 2002:a17:903:4b04:b0:298:529b:8956 with SMTP id d9443c01a7336-298529b8bd1mr54723255ad.56.1763007009881;
        Wed, 12 Nov 2025 20:10:09 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm8193665ad.7.2025.11.12.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:10:09 -0800 (PST)
Date: Thu, 13 Nov 2025 12:06:02 +0800
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
Message-ID: <42qcfcxxlmwphctzvji76hy5tycfabiiv5u6zw6lgg2p3e2jwv@fp4g2y7ecf2y>
References: <20250928030358.3873311-1-coxu@redhat.com>
 <20251031074016.1975356-1-coxu@redhat.com>
 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
 <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
 <d24wnmefebnheerigmh6ts5yskkutz726l6a2f6g5s3s5fhhrv@osaactobwb5g>
 <b9eb78105115a00731b3677a5f3a39d5dde4d2ec.camel@linux.ibm.com>
 <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0dfec96bf98b1c18d51bf40f4329c3ede48a9f32.camel@linux.ibm.com>

On Fri, Nov 07, 2025 at 02:28:13PM -0500, Mimi Zohar wrote:
>On Thu, 2025-11-06 at 17:15 -0500, Mimi Zohar wrote:
>> On Thu, 2025-11-06 at 21:29 +0800, Coiby Xu wrote:
>> > On Wed, Nov 05, 2025 at 03:47:25PM -0500, Mimi Zohar wrote:
>> > > On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
>> > [...]
>> > >
>> > > Hi Coiby,
>> > >
>> > > Based on the conversation with Paul, there is no reason to remove the existing
>> > > security_kernel_post_read_file() call.
>> > >
>> > > The changes are similar to the 2nd link, but a bit different.
>> > > - Define a single enumeration named READING_MODULE_COMPRESSED.
>> > >
>> > > - In module/main.c add a new security_kernel_post_read_file() call immediately
>> > > after decompressing the kernel module.  Like a previous version of this patch,
>> > > call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRESSED
>> > > based on MODULE_INIT_COMPRESSED_FILE.
>> > >
>> > > - In ima_post_read_file() defer verifying the signature when the enumeration is
>> > > READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_module.)
>> >
>> > Hi Mimi,
>> >
>> > Thanks for summarizing your conversation with Paul! I can confirm Paul's
>> > approach works
>> > https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul
>> >
>> > While testing the patch today, I realized there is another
>> > issue/challenge introduced by in-kernel module decompression. IMA
>> > appraisal is to verify the digest of compressed kernel module but
>> > currently the passed buffer is uncompressed module. When IMA uses
>> > uncompressed module data to calculate the digest, xattr signature
>> > verification will fail. If we always make IMA read the original kernel
>> > module data again to calculate the digest, does it look like a
>> > quick-and-dirty fix? If we can assume people won't load kernel module so
>> > often, the performance impact is negligible. Otherwise we may have to
>> > introduce a new LSM hook so IMA can access uncompressed and original
>> > module data one time.
>>
>> ima_collect_measurement() stores the file hash info in the iint and uses that
>> information to verify the signature as stored in the security xattr.
>> Decompressing the kernel module shouldn't affect the xattr signature
>> verification.
>
>In the case when the compressed kernel module hasn't previously been measured or
>appraised before loading the kernel module, we need to "collect" the file data
>hash on READING_MODULE_COMPRESSED, but defer appraising/measuring it.
>
>An alternative to your suggestion of re-reading the original kernel module data
>to calculate the digest or defining a new hook, would be to define "collect" as
>a new "action" and pass the kernel_read_file_id enumeration to
>process_measurement().  IMA_COLLECTED already exists.  Only IMA_COLLECT would
>need to be defined.  The new collect "action" should be limited to
>func=MODULE_CHECK.
>
>The downside of this alternative is that it requires a new collect rule:
>collect func=MODULE_CHECK mask=MAY_READ uid=0
>appraise func=MODULE_CHECK appraise_type=imasig|modsig

Thank for suggesting an alternative! I've implemented the idea in
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_collect

Note besides a new collect rule, another change is needed. Currently,
process_measurement only accepts enum ima_hooks thus it can't tell if
it's READING_MODULE_COMPRESSED so to only do collect action. So I
create a fake MODULE_COMPRESSED_CHECK func.

And for the idea of re-reading the original kernel module data, it has
been implemented in 
https://github.com/coiby/linux/tree/in_kernel_decompression_ima_no_lsm_hook_paul

Both branches have applied your requested three changes including
respecting the 80 char line limit. Additionally, I made a change to the
IPE LSM because of the new READING_MODULE_COMPRESSED kernel_read_file_id
enumerate.

After comparing the two implementations, personally I prefer re-reading
the original kernel module data because the change is smaller and it's
more user-friendly. But if there are other reasons I don't know, I'll
post the patches of the new collect action approach to the mailing list.


-- 
Best regards,
Coiby


