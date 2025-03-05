Return-Path: <linux-integrity+bounces-5106-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC08A4F97F
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 10:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C1A16C33C
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AD201261;
	Wed,  5 Mar 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8tgdwX/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B4204090
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165488; cv=none; b=Ns8+YwnygVVBo9PylYl4Y+cFTbnhANWw8QLbOmjMyThPE2IKHyDlHEQJKzvs0VfMYroJOXSrSYEBDpXf3kt52iBy+M06ReSi7UtASfaB/Z5VC3HjqZHexL/9q9Bfgh24NE1QJ7+qfu4cuTWMvzww03bexMMVB9dRAewRxBjAAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165488; c=relaxed/simple;
	bh=AE3jTHl3RCqDhjjVKJXOh6ubweX3rBsEb/KueUuwrTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aocqGN4Rx7OYiIYuhPwmkURN6M1xts5PypRxeF/sOGizkhdHEmxoXSMJyIFNIWq5ABshE5MtjOscQXesEPrjXzu96xwkeYHS6U1Aca0frSXHo0Jg32JhCOuaJAZjsR6FagxJneISvgsgVk0SsS6Q1+0CTOBpjoHfG+jE4wfKfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8tgdwX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741165484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BEth4fIZlz8Imlyl+6R1z/6iq4I7j5kDgxxdnJQebak=;
	b=K8tgdwX/XmA5hMfS61ylKHpV1GsPogxJ8+P/D/B9fHtoVmfc6clM6+VubuFWExf8Q6M3EQ
	cRsRnRgRJbEb97UgVH4+mRB8iKGb/LoRyuK0EkJKxSvwjIhQYIjqshPnkg38SxJjQCVRnv
	4UVqT0Nm+FRAFbDhLNO+qcaL+NhTY2k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-VZpx6v4LMmagsuOekb2FAw-1; Wed, 05 Mar 2025 04:04:33 -0500
X-MC-Unique: VZpx6v4LMmagsuOekb2FAw-1
X-Mimecast-MFC-AGG-ID: VZpx6v4LMmagsuOekb2FAw_1741165472
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac21ef37e38so12982066b.3
        for <linux-integrity@vger.kernel.org>; Wed, 05 Mar 2025 01:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741165472; x=1741770272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEth4fIZlz8Imlyl+6R1z/6iq4I7j5kDgxxdnJQebak=;
        b=tAMBYRk6+6F5DaamxdMFowzAXPkJXe2cS39a9NiOkU9uodg9WbaGQ0KvILNo3un6km
         Dkv1AeaAuBlOdrxaoLJnab8mKt0Jc3T49j41Vy3ktGQkVYLeCPAwezY+JvpLKpMQHFdi
         NCis6vIO6HSxKahKPCudBIiVgn16sciL8+LmgNwl/vlYb4svahtgLDKy9Bj7FUtmhu6v
         7rHsxsHvPypDYlUsYSvyCIvKC4Wi8geiAsQeOo5KL7dWXNo8tFGYwmZ6JiPPWrkuyCZ/
         gkBlwqyTKx+gA/zZ+rttnQeli7oCgfqeW70I9SYqKB009UCcCZxyIjT45gtTr98h/Ug0
         bVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE8/JFx6V6M74yzneLlxew3pP3IsQ7DH8c5xZbRfjS/APNHrsVa3b0Qx7BMEWz+CzIk/e4B5unwlBEHSIcNFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOP1D99XN+2aQU+ZrhC8/o+in47T4zDjHCtyjlEnACMrqnK+A0
	XMYrsSI74E2sT4iiOcrVzo8GGOtDC9NNOD6+Fjl4Q1SUPLBZWK146P+wo+cpT4tcA/rXzu8uynM
	R+/McFcviF2HHrtGwNEcZqwUmobFwTXVF3cpYXlJH0z6ZN4cEXt2VVqTBg9VZa9bh8Q==
X-Gm-Gg: ASbGncuIUBFz205e2g9EiIxWjJTdC6ZizVLQ7GZULqQ06/Z+RoFqf9mB0vl/XmKiMBP
	Fa5Q/d4i+LRZSHX8qa2iIgDkqV5fsGCawl02yVjMeIduVFsLeBMtWmFeD/FZMYYLYEPvjZPeK1n
	/QX9P+H/MsHNxnZ2aENORzpQAmdHTGRA5JV8sJRL/qYCzs48X5CpGbeRZ13bN2bYHLCxJwQVlWO
	Dpah/72IXy+i3ndS5qTKLcbdRW+Ty/f5XPGp/wP1exqaFvLNqMHCYwLjYhYm9Ymh22aj6duEoxY
	KnFZtu/IgWgPL1Hpz3CY9RmHb/tOoOj1XGXKCVi82c7oQZV5GKK2b7h9opUGovHD
X-Received: by 2002:a17:906:794e:b0:abf:7a26:c47b with SMTP id a640c23a62f3a-ac20e152a8dmr216332066b.39.1741165472175;
        Wed, 05 Mar 2025 01:04:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGscyqZ5x+Y/FizJPiAUuTdN5MEIafB1TLPqWDWprgT1XpnNzoBuyuavmFNtXAojOn0ZOWyxA==
X-Received: by 2002:a17:906:794e:b0:abf:7a26:c47b with SMTP id a640c23a62f3a-ac20e152a8dmr216326966b.39.1741165471489;
        Wed, 05 Mar 2025 01:04:31 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf71a0e0b6sm533326666b.7.2025.03.05.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:04:30 -0800 (PST)
Date: Wed, 5 Mar 2025 10:04:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
Message-ID: <jkr5z4thb55gs2jcmtcfipgg6p7z6ikhr6etd6l3nqpf723hf7@3fns3z5cjqk4>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
 <Z8Jmps6AF_geaHUw@kernel.org>
 <3p5erujbhxw7ozdnfpmresv3dqdh2xszolv6mh4khkagoy3wit@ow5qht4keh4h>
 <0e156883acf95d31b9358831550d6d675e3ce4ff.camel@kernel.org>
 <Z8dg46Mj81Q9Z0WV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8dg46Mj81Q9Z0WV@kernel.org>

On Tue, Mar 04, 2025 at 10:21:55PM +0200, Jarkko Sakkinen wrote:
>On Tue, Mar 04, 2025 at 06:56:02PM +0200, Jarkko Sakkinen wrote:
>> On Mon, 2025-03-03 at 17:21 +0100, Stefano Garzarella wrote:
>> > On Sat, Mar 01, 2025 at 03:45:10AM +0200, Jarkko Sakkinen wrote:
>> > > On Fri, Feb 28, 2025 at 06:07:17PM +0100, Stefano Garzarella wrote:
>> > > > +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t
>> > > > buf_len,
>> > > > +			 size_t to_send);
>> > >
>> > > Please describe the meaning and purpose of to_send.
>> >
>> > Sure, I'll add in the commit description.
>>
>> It's always a command, right? So better be more concerete than
>> "to_send", e.g. "cmd_len".

Right!

>>
>> I'd do instead:
>>
>> if (!chip->send)
>> 	goto out_recv;
>>
>> And change recv into:
>>
>> int (*recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> 	    cmd_len);
>
>I think I went here over the top, and *if* we need a new callback
>putting send_recv would be fine. Only thing I'd take from this is to
>rename to_len as cmd_len.

Got it.

>
>However, I don't think there are strong enough reasons to add complexity
>to the callback interface with the basis of this single driver. You
>should deal with this internally inside the driver instead.
>
>So do something along the lines of, e.g.:
>
>1. Create dummy send() copying the command to internal
>   buffer.
>2. Create ->status() returning zero, and set req_complete_mask and
>   req_complete_val to zero.
>3. Performan transaction in recv().
>
>How you split send_recv() between send() and recv() is up to you. This
>was merely showing that we don't need send_recv() desperately.

We did something similar in v1 [1], but instead of your point 2, we just 
set `chip->flags |= TPM_CHIP_FLAG_IRQ;` in the probe() after we 
allocated the chip.

Jason suggested the send_recv() ops [2], which I liked, but if you 
prefer to avoid that, I can restore what we did in v1 and replace the 
TPM_CHIP_FLAG_IRQ hack with your point 2 (or use TPM_CHIP_FLAG_IRQ if 
you think it is fine).

@Jarkko, @Jason, I don't have a strong preference about it, so your 
choice :-)

Thanks,
Stefano

[1] https://lore.kernel.org/linux-integrity/20241210143423.101774-2-sgarzare@redhat.com/
[2] https://lore.kernel.org/linux-integrity/CAGxU2F51EoqDqi6By6eBa7qT+VT006DJ9+V-PANQ6GQrwVWt_Q@mail.gmail.com/


