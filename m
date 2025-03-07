Return-Path: <linux-integrity+bounces-5176-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B9A56C3E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DC07A42BA
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7817583;
	Fri,  7 Mar 2025 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+yau+pq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4C21D002
	for <linux-integrity@vger.kernel.org>; Fri,  7 Mar 2025 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361843; cv=none; b=siywOV1HkQKRO7IaiUEKHwp/J+rqI8qqdx+LYl7sMyjmOQ9KvBa/ABH6tIa2bxaiy+oO0MlCsRnwrwWD8e00d+nmpHJtKDuorDJEcAtXC9G+grX4qsHrAvbOEFfGXTRBLOt/zh/TGdD/RP84h5dooBE/RGEUZO6RbML00cF45e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361843; c=relaxed/simple;
	bh=WZMUU+0do32vIB4ayqbki3un77HmpR/Tr9pMARBVFEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdVGGmSUki1oFw5AKKP3sz01Z0Eze3W1MFSb6s7e++6/UzY5f7eZQlXzp7y1/L06VnCUCu1mfdvq4Z35icPN0/ZKtQohJj9z94CK3k6XmlnHtsvvWIjIvP3Yio7WXJ3ETSc9KH6GmvDP1d+djOEqwQInF51sfOjxnwJEpj6KLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+yau+pq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741361841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqwct7Qo/RvM8L19VRfmymsuLYi1f8S6Qn9ogdk5ZAQ=;
	b=C+yau+pqRN7KKOFqCA3uso1nmipeWLdk42LvSuK6oR/BxO8fh3jODVKlae0vRtcKkGIuoX
	vn/7V7uvM0zDJcp0eR/brUdFrkGXcHz0M0uFLDPG2ZZ8RnTkbkziFSCg50uDYczkFfgDNk
	ZxHAYcm2NRRfP+1Sk7tHBL3XZdWzKR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-fUlsupDDNROKDNnht5dDxg-1; Fri, 07 Mar 2025 10:37:19 -0500
X-MC-Unique: fUlsupDDNROKDNnht5dDxg-1
X-Mimecast-MFC-AGG-ID: fUlsupDDNROKDNnht5dDxg_1741361838
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394c489babso9626265e9.1
        for <linux-integrity@vger.kernel.org>; Fri, 07 Mar 2025 07:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361838; x=1741966638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqwct7Qo/RvM8L19VRfmymsuLYi1f8S6Qn9ogdk5ZAQ=;
        b=MXczM3/LggldZiD4K0UlgWcx1KAGriUipAJh8fR6OVQv2FIUGO/OlkcV0jKNeIl5Ys
         9ferQ/UBa1We4Ajqtu6AmuJoVd9aqfcXVQNNPViP/r8Bh9Gen63D+k3+SFHSdz+FW0P5
         PFp69cowsI4d5/NT5M6qovdvUrfDn7mseQNWY8ZqnxS6Ha4i60EeOstXTFfErtMZ3ixK
         M8XY7Xj8bhztjaXBtIh5N9ANtIdJd7S+PV4g3MHScBAl7eZafl0/tRaN4hckdHas3aGa
         oVg7SjtwFw5UKBnq3/Zg4JtvA/KLhNqXdbiFx5FBqMiO4fykpan4rBoKkWpWxp1jyHCc
         zS4w==
X-Forwarded-Encrypted: i=1; AJvYcCVtNdADc2MJ2CSLiuHIJ0usyk8GeJQWvqdKM6MYP8uv8pC68fc5TO5pksbc8Ww3TvI4rBmTqkWbSAoWhpE7BV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3IrwVADIL9PFrITqdLQ7s8IbV8Ttn/a8MTIOwp8Krjjo8L7s
	NADv2OraRtRwDTQyr495hDHRczP5YV0m2d6ADF9lzgJmIiOVqaelrdPtYla0ee7TfmJWoR/5Dm+
	ZuGB7+rn5q6Fl2VGWRq8jcE7QEMkLH3KpjOuhNn4lyIvOpDmGrJ1bIO4TjyuLt9YiKw==
X-Gm-Gg: ASbGncsn0QUSPEPs+AtfJ1BZJBb9uKul4Iky0zRO7VGA4pH4eqt20S9wzvksKGj4pom
	DAdkG3oL1Ci6hq3MX2tPb4cHGY2tz6i+Umr9URLGuOdUVWvy9XMSJVIWwEq7XyhS3sUIwoEAYjK
	40JfEzz0otn+woAlDktovXd34r9h59qfkPAUYqPwVfv0WwXrrTTY+agwACmXVxNL4+v0TZvmK8+
	n+SucQ0Moy57MBG61RgINmqNdwCl2OiwQcTAse2GFQ6BoKYn5n0347C0nHtCN5XKvwp8UnGd4kL
	z4YK7XlBvxAXsh6ONMGQyDEwPnLSgxLm3fSXc/7rwaDbMKOGfkWn6VwUL5a4Cy80
X-Received: by 2002:a05:600c:1d03:b0:43b:cf12:2c9e with SMTP id 5b1f17b1804b1-43c601cf24amr22907585e9.1.1741361838526;
        Fri, 07 Mar 2025 07:37:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCWNbeddeZHfz4UovoxYVfEDe+cZ0Hg5a6sskYJHpSKTFtNwY3+RHZMac+Si09BWeINjSZVQ==
X-Received: by 2002:a05:600c:1d03:b0:43b:cf12:2c9e with SMTP id 5b1f17b1804b1-43c601cf24amr22907195e9.1.1741361837942;
        Fri, 07 Mar 2025 07:37:17 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b046dsm54598135e9.5.2025.03.07.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:37:17 -0800 (PST)
Date: Fri, 7 Mar 2025 16:37:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <fgxwcfm6fctdsjnzdbf3ecxss453dir3pgaqio7bzazjj5qotj@mdi6wtuzorvn>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
 <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
 <20250305190229.GC354403@ziepe.ca>
 <Z8oZLqn4p2-AWQbz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8oZLqn4p2-AWQbz@kernel.org>

On Thu, Mar 06, 2025 at 11:52:46PM +0200, Jarkko Sakkinen wrote:
>On Wed, Mar 05, 2025 at 03:02:29PM -0400, Jason Gunthorpe wrote:
>> On Wed, Mar 05, 2025 at 10:04:25AM +0100, Stefano Garzarella wrote:
>> > Jason suggested the send_recv() ops [2], which I liked, but if you prefer to
>> > avoid that, I can restore what we did in v1 and replace the
>> > TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if you
>> > think it is fine).
>>
>> I think it is a pretty notable simplification for the driver as it
>> does not need to implement send, status, req_canceled and more ops.
>>
>> Given the small LOC on the core side I'd call that simplification a
>> win..
>
>I'm sorry to disagree with you on this but adding a callback for
>one leaf driver is not what I would call "a win" :-)

IIUC in the ftpm driver (tpm_ftpm_tee.c) we could also use send_recv() 
and save a memcpy() to a temporally buffer (pvt_data->resp_buf) and also 
that 4k buffer allocated with the private data of the driver.

BTW if you agree, for now I'll do something similar of what we do in the 
ftpm driver (which would be what Jarkko recommended - status() returns 
0, .req_complete_mask = 0, .req_complete_val = 0) and we can discuss 
send_recv() in a new series where I can include changes for the ftpm 
driver too, to see whether it makes sense or not.

WDYT?

Thanks,
Stefano

>
>I mean, it's either a minor twist in
>
>1. "the framework code" which affects in a way all other leaf drivers.
>   At bare minimum it adds a tiny bit of complexity to the callback
>   interface and a tiny bit of accumulated maintenance cost.
>2. in the leaf driver
>
>So I'd really would want to keep that tiny bit of extra complexity
>localized.
>
>>
>> Jason
>
>BR, Jarkko
>


