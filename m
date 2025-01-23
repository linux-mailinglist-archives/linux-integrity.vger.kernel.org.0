Return-Path: <linux-integrity+bounces-4621-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0B3A1A43C
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B91165C30
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4220F084;
	Thu, 23 Jan 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDWBMDEc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E120F070
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737635374; cv=none; b=jg2Qs+z/7tjeS5dBJocG+wb1fx2sV6Sj2eBxi/J1lQ84nMZH5pLKyVanjASR6LIFozWJExlKoOnqEX6jMSv9piTQdCeNX6A0LPDoSgCi7aFRNmWL5PTWjklX6WtqZh9ueec2XrfNT9f0gwK0gLiLu+ieICoXvkqyXXjFdGIscss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737635374; c=relaxed/simple;
	bh=+r6j3lJQGeIcKqgqjLDDgjnoCwekw7jKG881L/ELYp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzB/g5keb0pdXN/W9eeMVHYcbAu88pkB01bs21Crc9Bz2MdOkUoPpal2ZEcOM+7rWlB8k7O97xV4TVrMmVCj4f3MdQNRfBHMXVIZKtvjMDDKgme643s+R/l4ahakXCw0KyqsRJ6VydAFEAu+DASETx1o57QwoDf8gZuZ6q9CXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDWBMDEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737635371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+r6j3lJQGeIcKqgqjLDDgjnoCwekw7jKG881L/ELYp4=;
	b=SDWBMDEcZsjR5kAxhT2dtVJmugXJ7hS9UL2Ddnzv+vfRxrTVIqRvYIsZMiTx0KxSl7rIiU
	ofo/gp8ILBInGcVMiRaLS3JILfFkZ8B5K582X++MLHAhoD+xzFa//Lqvk2xn8dL18/wbSO
	uioCz+oa7KCmOC1KYtV7Ncffot9Rcz0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Nzj7jTBbOuiSn1VSwH-IAA-1; Thu, 23 Jan 2025 07:29:30 -0500
X-MC-Unique: Nzj7jTBbOuiSn1VSwH-IAA-1
X-Mimecast-MFC-AGG-ID: Nzj7jTBbOuiSn1VSwH-IAA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa67f18cb95so99599066b.1
        for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 04:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737635369; x=1738240169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r6j3lJQGeIcKqgqjLDDgjnoCwekw7jKG881L/ELYp4=;
        b=RohWtnVd7SEVEKBBw4SNJo15AX6bWzbZvO65BiqHsI0HIbdhSnjirbKFkTFTxpN/Fd
         X3+dG9hhLULFtU4kPMHyi61JyPAO/rH6AuwGdroqyHoKiERY1mNlXBqnDhJ/ZwnsMpuT
         OzulEDRZYn9drdA88YlOMVQicC8rjPXw/OUemqlT7hqkaJjIDoCCaPTeWvOflb9KKMoZ
         LXsbnxvopKPHE4Dd5VmslneBTbiyIe9Q9HzoVDAWzr5V9TtV8ca2scVMegD0YH+7bJfe
         lrQmEpFq/4O8VDeHAVA0AEoIqQcRiPC76CHaCV1lBKI8Bc5czlozY9BXY5w1dEv/WbSU
         egGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOeXgEQmg6rsUOt6dZcgRfZsojXTorN1F4TCov3QKD3aXe0+SxSH68r6HvEYapjl2D0uhSRr/83ZciqnR3wwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+ZC8CHWQHOxDw8xJQghlsHp7Arza6+ulyWmg5Rgm2MDibcNK
	kvQvKGM7p7BnxHdKg7StJg3NtSCCri4URj9+miqhYYm3lc8QWB5vmNJ9NPi22Ms0Qm1pWYfcfKF
	Iz6JNEMOoowdA/Q7X1R4JSArlegeEXuiCVsCD2ySRx+M0/hGp6Axljvsk+O2sISl3+w==
X-Gm-Gg: ASbGncu4TUQ6np/GD13iQiCi2doTg3wAgO6lXv+ZEAnddRmnc4bWJNFZaC3DM+DVT9d
	5y4A/abnXdiCY8nxxyF8gwbBAFxa5Z0Ja0gAF/wQCJMRhiXVASQchy7zsuYqMQ2kEHeLxBu9FEh
	p5UpXY8zceEutSXllA+3B+0Uzu5flpyjpJyDmjCYaejKwpkN0w6Gx97fcV1sy3CQwxexhnv64fD
	I7ayNadwAhVF04hX0cViBUqwof9cDJN0LdAfguBCOubvROtsOINuRD/LjpWVnV+cy8laXd3US3I
	mrW4KmhJuSk9RzW/mmofvSOnJGsRrHRZA8/FczcjYlRrzg==
X-Received: by 2002:a17:907:6095:b0:aaf:4008:5e2d with SMTP id a640c23a62f3a-ab38ada14e0mr2416241666b.0.1737635369239;
        Thu, 23 Jan 2025 04:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBE43qw/yeaxV3tvNVhefMnK58lG2TmX6VtUAz/ujJ5n6shG4mNZw9wV3zX1YT/b7rxQG1OA==
X-Received: by 2002:a17:907:6095:b0:aaf:4008:5e2d with SMTP id a640c23a62f3a-ab38ada14e0mr2416236066b.0.1737635368506;
        Thu, 23 Jan 2025 04:29:28 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce13e2sm1067837966b.52.2025.01.23.04.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 04:29:27 -0800 (PST)
Date: Thu, 23 Jan 2025 13:29:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Jarkko Sakkinen <jarkko.sakkinen@iki.fi>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Dov Murik <dovmurik@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
Message-ID: <cfoz65txflem7xlvqupn5ltiaad3svcwum5m2kmechzss6pnjy@fwmaj2e35ohr>
References: <6rwo7tkdst227kb4pwvr54w4mfz2zw3offux7mqfupi3rgwkaz@65yklvvqw6n4>
 <CAGxU2F4YQy-otsGtGiUHDiL7PGXic2_HzWL_+GHkn+Hs_ScGpQ@mail.gmail.com>
 <D725TPWOVBUL.1DJAOZ0QL0RNH@kernel.org>
 <D725V628UV87.31SUEYVF9IUUC@kernel.org>
 <D726DAWHLOGW.3TR2LCJ936OG7@kernel.org>
 <CAAH4kHYy7=OZsHnOBiQug0Y__bNHt6i+bop0xaxQjpWQ6aQr1Q@mail.gmail.com>
 <D79CYAVX0LAZ.1MIYNOM6J7MMM@kernel.org>
 <sf5zezwsokmz7lkl7fdl5z5q6lipeqd5d4sws2hpi6pznyvdap@tjfv5p5uty7y>
 <D79FFA5JMK7J.1GD3PSB11COGC@kernel.org>
 <D79FHC9OB5WS.CCNDGUTDNG31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <D79FHC9OB5WS.CCNDGUTDNG31@kernel.org>

On Thu, Jan 23, 2025 at 01:49:34PM +0200, Jarkko Sakkinen wrote:
>On Thu Jan 23, 2025 at 1:46 PM EET, Jarkko Sakkinen wrote:
>> On Thu Jan 23, 2025 at 12:09 PM EET, Stefano Garzarella wrote:
>> > On Thu, Jan 23, 2025 at 11:50:40AM +0200, Jarkko Sakkinen wrote:
>> > >On Wed Jan 22, 2025 at 11:29 PM EET, Dionna Amalie Glaze wrote:
>> > >> I can appreciate this viewpoint. It even surfaced Microsoft's fTPM
>> > >> paper to me, which solves some interesting problems we need to solve
>> > >> in SVSM too. So thanks for that.
>> > >>
>> > >> Just to clarify, you're not asking for SVSM to implement the TIS-MMIO
>> > >> interface instead, but rather to use the fTPM stack, which could make
>> > >> SVSM calls a TEE device operation?
>> > >
>> > >I don't really know what I'm asking because this is barely even a
>> > >PoC, and I state it like this knowingly.
>> > >
>> > >You should make the argument, and the case for the solution. Then
>> > >it is my turn to comment on that scheme.
>> >
>> > I'll check if I can use fTPM, in the meantime I had started to simplify
>> > this series, avoiding the double stack and exposing some APIs from SEV
>> > to probe the vTPM and to send the commands. The final driver in
>> > drivers/char/tpm would be quite simple.
>> >
>> > But I'll try to see if reusing fTPM is a feasible way, I like the idea.
>> >
>> > >
>> > >That said, I would not give high odds for acceptance of a duplicate
>> > >TPM stack succeeding.
>> >
>> > Got it ;-)
>> >
>> > Thanks to everyone for the helpful feedbacks!
>> >
>> > I've been a bit messy these days and I'm in FOSDEM next week, so I hope
>> > not to take too long for the v2.
>>
>> Yeah, OK one thing that I want to say.
>>
>> Nail the story. What is it about what is the problem what is the
>> motivation to solve it etc. If you have all that properly written
>> up then it is easier to forgive not that well nailed code and
>> give reasonable arguments.

Yes, I completely understand your point and I admit that the cover
letter and the commits description were not very informative, I will
fix them putting more context.

>>
>> And don't rush, I have all the time in the world ;-)

;-)

>
>Here the point is that if I don't fully understand the context
>(starting explaining the obvious like what is SVSM) I might
>give some ridiculously wrong advice.
>
>Then people come back to me and start blaming me on saying
>opposite arguments. I hope you see where I'm standing here.

I see it completely!

>I neither don't want you to do useless and unproductive
>work.

Thanks for that,
Stefano


