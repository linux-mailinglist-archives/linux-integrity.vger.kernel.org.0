Return-Path: <linux-integrity+bounces-7216-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08493B8F61F
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8355189FF7A
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624EF2F9992;
	Mon, 22 Sep 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE/gGc9f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D62F7AC2
	for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758527941; cv=none; b=IyuEQqlOOjJNn0iXwd2ljhqBFhw9m0NEGdlm8I69LPbZGjPT9NKRGdlj1aG43MwNnrR1XZlfz5Nlc3FdCJfWOM2BYehIp8EbrzsPq8t+mN1LfdUOyF5nw/IikfIaYcDJNVWLCCuEXZlZWFp0PENalV9CWb2MO83ozTWbIkPdfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758527941; c=relaxed/simple;
	bh=RPLNulL/r1ylv0eKUGZC0lH7XyKc8D+Rtu5BpXYM9TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi1+h8C1LGRsVqnbv1GkxHYk8FIDa9zerb4uXN9LtiB2B5mTKWVdniezWeW/QBCtrYJM2Glk4pI48Ijhl0Wzf61/VOEIJsJ/0g5pU6PgTke5fiUSLLYQUi+3NRpi98TxYPzpc8lMV9s7cAMVj7rTuaQmaq2ACC4A6PHdCvhlK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OE/gGc9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758527938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PxrdOx4EB3kHQYnOmI6oNM1Rpe8WnbLIdR6BsCbOTz8=;
	b=OE/gGc9ftrLBYoAjQChpGSWlhqEeL80Y6HMKfvH3K+GGz5K6Z+ROG+ZKOUnLAIXEyinyZP
	i/SqNfIFd4jo47a1GGN0ulMVzlN9tLcuPqGvlheEsyUdAORsM8JUb4viFJG49Z7W2qmgIo
	dkSCivT//K1QA+EScPwLSgcicx4eahU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-3c4yl4IrMeqQOFtLvgJlkg-1; Mon, 22 Sep 2025 03:58:57 -0400
X-MC-Unique: 3c4yl4IrMeqQOFtLvgJlkg-1
X-Mimecast-MFC-AGG-ID: 3c4yl4IrMeqQOFtLvgJlkg_1758527936
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee1365964cso3204774f8f.2
        for <linux-integrity@vger.kernel.org>; Mon, 22 Sep 2025 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758527936; x=1759132736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxrdOx4EB3kHQYnOmI6oNM1Rpe8WnbLIdR6BsCbOTz8=;
        b=p9l9CixBGee6yYChyc6KlHWw8I+l8qXxHh/B66HetVQboFBRkmZKn1rKDd/SIqyuGl
         hKYDm2ZGVQp9o6zXLdnqw4c5AGb/N3oKLr4EJmY1VpMbT0IVCIpCND0QY+RlYloVUgGS
         IcwjCcTWjnyPpj07Yzz684u+orCtp+AqYIbFj2qRt6mzo7b4Ms5vSwezQOCFscKDb9GD
         ibXDIe8zBGQ6TSlCu6LUgQzHvgM6QvoUtbe98enNVL9kjPmf1H/BFoyoCq6d9vs4ZMJh
         uts82jlf5a/p//nLn2lHndUYrYgutFX4cj8Wem6WgFzI2YmXP1BDl4v5aKlGn97mgQy5
         L9Hg==
X-Gm-Message-State: AOJu0YxdjsJrkR+lSPhGxbngE0zKWXPE5VNiESeTXroV2kuNfAyefWmt
	1Y8+PX4iXdpzizyIE89RnAr7YRcdX4vhHUiam0meYZ2LwnObUZqBa4NJzcGOt8P3Teqlum+RwRZ
	KNZgTLQZQJaRFFfbf2ud+i+FmoX2It8qiUMfit0DL+xPH/tJo174w4gY3mVRnp3PLRaRyzQ==
X-Gm-Gg: ASbGncs8HruPHCpZOxVcVzIsgoSTXKmFpGm2J3OlK0/tFNzkLu51+Kcdpgf2KIvtB2U
	CZ7x1emS2F7x6rYKSLPdJUF2Rcnc8CqMt3xg/qxioyJZm/4GkE+dbv+bZ84STX1aepLFEAVI6Ho
	Den5pyMe1pTALp2eEaoicAWQM7kgvgZCKno2OtHYM6IrC/Jsd8e7tqFwveQlFeNTmdqRCyoj6Cf
	leaEsE2xyz9O6H2EXTbU0OD2fp7bhB6pcIzFwFBTAUy6/zDS/twwXJ4H/GQ+DGWRsGdJtWEQtm2
	G6kOcm4fS/YXqgt9Rdx8QkS0yuPIwq6YyP09HvysHQ==
X-Received: by 2002:a5d:4943:0:b0:3f8:3f7a:e7e with SMTP id ffacd0b85a97d-3f83f7a1050mr3635646f8f.63.1758527935779;
        Mon, 22 Sep 2025 00:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg5E/j/J153zhcNVC1lL72SAmeutEX0IFz0drnTb2dHTudyZkYhubA99dVKR3VQmM6PJrzCQ==
X-Received: by 2002:a5d:4943:0:b0:3f8:3f7a:e7e with SMTP id ffacd0b85a97d-3f83f7a1050mr3635608f8f.63.1758527935093;
        Mon, 22 Sep 2025 00:58:55 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.126.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm18904744f8f.63.2025.09.22.00.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:58:54 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:58:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>, 
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7] tpm: Make TPM buffer allocations more robust
Message-ID: <jecgeh5dmurb6dwzbfgc3agenfsuhwyzslqcvbh3rlbtgvyqzk@ljkuaxtm5rch>
References: <20250919112448.2543343-1-jarkko@kernel.org>
 <hwsx2t2tkbos3g7k2syemxbvc6sfrsbviwm64ubcdl6ms7ljvo@toetomkhheht>
 <aM13m-CYijlu6Pf6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aM13m-CYijlu6Pf6@kernel.org>

On Fri, Sep 19, 2025 at 06:32:43PM +0300, Jarkko Sakkinen wrote:
>On Fri, Sep 19, 2025 at 03:35:43PM +0200, Stefano Garzarella wrote:
>> On Fri, Sep 19, 2025 at 02:24:47PM +0300, Jarkko Sakkinen wrote:
>> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>> >
>> > Drop 'tpm_buf_init', 'tpm_buf_init_sized' and 'tpm_buf_free'. Refine
>> > 'struct tpm_buf' to hold capacity in order to enable stack allocation and
>> > sizes other than page size.
>> >
>> > The updated 'struct tpm_buf' can be allocated either from stack or heap.
>> >
>> > The contract is the following:
>> >
>> > 1. 'tpm_buf_reset' and 'tpm_buf_reset_size' expect that on the first run
>> >   the passed buffer is zeroed by the caller (e.g. via memset or kzalloc).
>> > 2. The same buffer can be reused. On the second and subsequent resets the
>> >   aforementioned functions verify that 'buf_size' has the same value, and
>> >   emits warning if not.
>> >
>> > As a consequence 'struct tpm_buf' instance can be easily wrapped into
>> > managed allocation:
>> >
>> > 	struct tpm_buf *buf __free(kfree) buf = kzalloc(PAGE_SIZE,
>> > 							GFP_KERNEL);
>> >
>> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>> > ---
>> > v7:
>> > - Additional function comments and invariant was unfortunately left to
>> >  my staging area so here's the addition (does not affect functionality).
>> > v6:
>> > - Removed two empty lines as requested by Stefan:
>> >  https://lore.kernel.org/linux-integrity/be1c5bef-7c97-4173-b417-986dc90d779c@linux.ibm.com/
>> > - Add 'capacity' field as this makes easy to stretch tpm_buf into stack
>> >  allocation.
>> > v5:
>> > - I tested this version also with TPM 1.2 by booting up and checking
>> >  that sysfs attributes work.
>> > - Fixed the length check against capacity (James) with TPM_BUF_CAPACITY.
>> > - Fixed declaration style: do it at the site (Jason).
>> > - Improved commit message (Stefan).
>> > - Removed "out" label from tpm2_pcr_read() (Stefan).
>> > - Removed spurious "return rc;" from tpm2_get_pcr_allocation() (Stefan).
>> > v4:
>> > - Wrote a more a descriptive short summary and improved description.
>> > - Fixed the error in documentation: there is 4090 bytes of space left
>> >  for the payload - not 4088 bytes.
>> > - Turned tpm_buf_alloc() into inline function.
>> > v3:
>> > - Removed the cleanup class and moved on using __free(kfree) instead.
>> > - Removed `buf_size` (James).
>> > - I'm open for the idea of splitting still (Jason) but I'll hold
>> >  at least this revision just to check that my core idea here
>> >  is correct.
>> > v2:
>> > - Implement also memory allocation using the cleanup class.
>> > - Rewrote the commit message.
>> > - Implemented CLASS_TPM_BUF() helper macro.
>> > ---
>> > drivers/char/tpm/tpm-buf.c                |  68 ++----
>> > drivers/char/tpm/tpm-sysfs.c              |  19 +-
>> > drivers/char/tpm/tpm1-cmd.c               | 143 ++++++------
>> > drivers/char/tpm/tpm2-cmd.c               | 270 ++++++++++------------
>> > drivers/char/tpm/tpm2-sessions.c          | 118 +++++-----
>> > drivers/char/tpm/tpm2-space.c             |  42 ++--
>> > drivers/char/tpm/tpm_vtpm_proxy.c         |  29 +--
>> > include/linux/tpm.h                       |  17 +-
>> > security/keys/trusted-keys/trusted_tpm1.c |  40 ++--
>> > security/keys/trusted-keys/trusted_tpm2.c | 153 ++++++------
>> > 10 files changed, 390 insertions(+), 509 deletions(-)
>> >
>> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
>> > index dc882fc9fa9e..19774bc5786f 100644
>> > --- a/drivers/char/tpm/tpm-buf.c
>> > +++ b/drivers/char/tpm/tpm-buf.c
>> > @@ -7,83 +7,57 @@
>> > #include <linux/module.h>
>> > #include <linux/tpm.h>
>> >
>> > -/**
>> > - * tpm_buf_init() - Allocate and initialize a TPM command
>> > - * @buf:	A &tpm_buf
>> > - * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>> > - * @ordinal:	A command ordinal
>> > - *
>> > - * Return: 0 or -ENOMEM
>> > - */
>> > -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
>> > -{
>> > -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>> > -	if (!buf->data)
>> > -		return -ENOMEM;
>> > -
>> > -	tpm_buf_reset(buf, tag, ordinal);
>> > -	return 0;
>> > -}
>> > -EXPORT_SYMBOL_GPL(tpm_buf_init);
>> > -
>> > /**
>> >  * tpm_buf_reset() - Initialize a TPM command
>> >  * @buf:	A &tpm_buf
>> > + * @buf_size:	Size of the buffer.
>> >  * @tag:	TPM_TAG_RQU_COMMAND, TPM2_ST_NO_SESSIONS or TPM2_ST_SESSIONS
>> >  * @ordinal:	A command ordinal
>> > + *
>> > + * 1. Expects that on the first run the passed buffer is zeroed by the caller.
>> > + * 2. Old buffer can be reused. On the second and subsequent resets @buf_size is
>> > + *    verified to be equal to the previous value.
>> >  */
>> > -void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>> > +void tpm_buf_reset(struct tpm_buf *buf, u16 buf_size, u16 tag, u32 ordinal)
>> > {
>> > 	struct tpm_header *head = (struct tpm_header *)buf->data;
>> >
>> > +	WARN_ON(buf->capacity != 0 && buf_size != (buf->capacity + sizeof(*buf)));
>> > 	WARN_ON(tag != TPM_TAG_RQU_COMMAND && tag != TPM2_ST_NO_SESSIONS &&
>> > 		tag != TPM2_ST_SESSIONS && tag != 0);
>> >
>> > 	buf->flags = 0;
>> > 	buf->length = sizeof(*head);
>> > +	buf->capacity = buf_size - sizeof(*buf);
>> > +	buf->handles = 0;
>> > 	head->tag = cpu_to_be16(tag);
>> > 	head->length = cpu_to_be32(sizeof(*head));
>> > 	head->ordinal = cpu_to_be32(ordinal);
>> > -	buf->handles = 0;
>> > }
>> > EXPORT_SYMBOL_GPL(tpm_buf_reset);
>> >
>> > -/**
>> > - * tpm_buf_init_sized() - Allocate and initialize a sized (TPM2B) buffer
>> > - * @buf:	A @tpm_buf
>> > - *
>> > - * Return: 0 or -ENOMEM
>> > - */
>> > -int tpm_buf_init_sized(struct tpm_buf *buf)
>> > -{
>> > -	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>> > -	if (!buf->data)
>> > -		return -ENOMEM;
>> > -
>> > -	tpm_buf_reset_sized(buf);
>> > -	return 0;
>> > -}
>> > -EXPORT_SYMBOL_GPL(tpm_buf_init_sized);
>> > -
>> > /**
>> >  * tpm_buf_reset_sized() - Initialize a sized buffer
>> >  * @buf:	A &tpm_buf
>> > + * @buf_size:	Size of the buffer.
>> > + *
>> > + * 1. Expects that on the first run the passed buffer is zeroed by the caller.
>> > + * 2. Old buffer can be reused. On the second and subsequent resets @buf_size is
>> > + *    verified to be equal to the previous value.
>> >  */
>> > -void tpm_buf_reset_sized(struct tpm_buf *buf)
>> > +void tpm_buf_reset_sized(struct tpm_buf *buf, u16 buf_size)
>> > {
>> > +	WARN_ON(buf->capacity != 0 && buf_size != (buf->capacity + sizeof(*buf)));
>> > +
>> > 	buf->flags = TPM_BUF_TPM2B;
>> > 	buf->length = 2;
>> > +	buf->capacity = buf_size - sizeof(*buf);
>> > +	buf->handles = 0;
>> > 	buf->data[0] = 0;
>> > 	buf->data[1] = 0;
>> > }
>> > EXPORT_SYMBOL_GPL(tpm_buf_reset_sized);
>> >
>> > -void tpm_buf_destroy(struct tpm_buf *buf)
>> > -{
>> > -	free_page((unsigned long)buf->data);
>> > -}
>> > -EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>> > -
>> > /**
>> >  * tpm_buf_length() - Return the number of bytes consumed by the data
>> >  * @buf:	A &tpm_buf
>>  *
>>  * Return: The number of bytes consumed by the buffer
>>  */
>> u32 tpm_buf_length(struct tpm_buf *buf)
>> {
>> 	return buf->length;
>> }
>> EXPORT_SYMBOL_GPL(tpm_buf_length);
>>
>> Should we update the return type (u16) on this function?
>
>Yes we should. Thanks for catching this.
>
>>
>> > @@ -108,7 +82,7 @@ void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
>> > 	if (buf->flags & TPM_BUF_OVERFLOW)
>> > 		return;
>> >
>> > -	if ((buf->length + new_length) > PAGE_SIZE) {
>> > +	if ((buf->length + new_length) > buf->capacity) {
>>
>> IIUC all of these are u16, so there could be an overflow when we do
>> `buf->length + new_length` ?
>>
>> Should we cast to u32 or just change the expression in something like
>> `new_length > (buf->capacity - buf->length)`
>
>Thanks, these really appropriate comments.
>
>I think best measure here would have hard constant cap of PAGE_SIZE
>for buf_size. That's how the specs limit anyhow. I'll extend the
>invariant.

Oh I see, that makes sense, thanks :-)

Stefano


