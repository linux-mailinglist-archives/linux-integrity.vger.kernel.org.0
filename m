Return-Path: <linux-integrity+bounces-5479-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05473A734E8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320FF1706F4
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115C20E6FA;
	Thu, 27 Mar 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvhflBgm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50B42AA1
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086654; cv=none; b=tWJ5pY9j0OwxYfnl3bbkUDXl7Ll5g0sNe5vpMN0EVkVWPsvxMgqs300VdVuZjfCDL0sgtpPjWXRXpQWWVb9vpr0R1AoARU5ggr7t9+hK+BpmmxxV+OYF/OrjbDO5++nXU5Tf0Mf1m2cBKy5WVgADZsT84h20RpBMIu+a/I+3GJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086654; c=relaxed/simple;
	bh=d6Xu/BFgeGgDcdBzwEk9PB3O7pJ7ObaENjEtuHbA6+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqYFAoc/tZblP/p0Z486KA2H1G7Ci/86GlLFlHzxASjszkP6z8JcoMQQIK5DTHcSgkGb28xN6Hafeg2T8BPQhhGMTyR536j+Z8eOgPkyzKuPuVROmzKn0iikcLa1T36fCHeEaF5eZLWVLaS+nhFE0EUJUEvv4EHBz4lACSYFF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvhflBgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743086650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBTG0JGuxf9FkDoZXb2Ow+D+IbpvxoiKR3EeWRclaFo=;
	b=WvhflBgmbNsIfvJbqhpFMqdr94jGaP6aezGh/EyPVDYBwCDH0xIi4vDLDpyEqRaSWHARE9
	V9ucknj5A5Dd8b98GyXkD/wEaFbWyCKwaurOKSH4s5NI/whxdDXn8lGIyhFDxIZyLRVDtN
	QRzzpWC3UyhlNSM97BarBu/1TPBOG6c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-DaI-QlPLNf6dQbnh0iqqdQ-1; Thu, 27 Mar 2025 10:44:09 -0400
X-MC-Unique: DaI-QlPLNf6dQbnh0iqqdQ-1
X-Mimecast-MFC-AGG-ID: DaI-QlPLNf6dQbnh0iqqdQ_1743086648
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so5257005e9.0
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 07:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743086648; x=1743691448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBTG0JGuxf9FkDoZXb2Ow+D+IbpvxoiKR3EeWRclaFo=;
        b=OE5iruWR7oBU9rv0E+rUaVgW8pKpK+z2seWds+CDk6Vd0I4EuDp1/3nvpsgdCjObtZ
         SbfkennjfVRHskEB0E5ypxsA4Guv1qVt+1ZgkxkptokU9drlgZPPohFFzGi+xEyhNtwC
         VjDlCKec+KM+ITf17mLE7HfFCOJIy47b3nnBXGqQTQPzzN2ZONj3MYGuUUiTwacKdW8w
         QtS71dSD/cUMtY2AoVd20MUp+m3XEev+F48dQUCAj0LraVvqWY6KqwsxlpFtSZcakh5p
         AiQUL1MAKsdtxDLI1odQLigr3WFp+JwrCaYL2oQvk2JyelEtEwK+u748cJUWJaJZY2nw
         dfaA==
X-Forwarded-Encrypted: i=1; AJvYcCWBjnSMavBvoV/Tr/mXubrYIL4LEVgVj96b8IZ//MaZ7/W9pj4CagQQ0+cfZYPKjpKy0RpoADX3bg6wu4LZKU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4PjsQqLIGRd9V4SIBMx2SHH381UA1MTWRKZtRdrb9miDgVpzg
	wrMOsZt5OP5LCg4a58yrYkA15y0JVbhVvsKpGDnzUlY4enEpQ6AdZB6QZ90IPLm4HbCAljPc6vN
	wtiuuseuXZ2inOYTHpZ347GQyj3TwziD9tsfAP6J4yhvEOX+I1RCyq2oU+L5mNtos8g==
X-Gm-Gg: ASbGncuDJTgexk57eOCt5pGOmu95Ty3f64ZOT9hJAcMZxgQsTk0XvJ5ahaReCgED23q
	DiVPDTQdIyimIDBAlZuwA2GC8MomBsir+dt3Pax4b4kwi09u4go+0tTsKARh9LxhVzzzeEKqloZ
	wBIhP2eB4YcP9b/PNbEi6cwQmbJFN0dO6j+A8xdv4vVAgAQjrLe22feOZnWG1auSe5T/iejuH7y
	7D3BCYnDv86i0Q8caqGs4hoi94Kjl2kaKcqtFO+HoX2fu3uG1d62ygs4Hb1shkCsD0/vnppk9pq
	GaO7t5Hy5m42BTpWZkDEA1ahjvbOmCiTYeFxrpwadRrrsk4+Xj7raO9IkRauZIv3
X-Received: by 2002:a05:600c:138a:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-43d84f60ce1mr42280505e9.5.1743086648297;
        Thu, 27 Mar 2025 07:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfDYAxxsKTCw2DsFd7FNQsrLddXHo43pipbWePZvF/j/lq0gWQWkRDJ6Cjwx/DH6qCARj+Ug==
X-Received: by 2002:a05:600c:138a:b0:43d:300f:fa3d with SMTP id 5b1f17b1804b1-43d84f60ce1mr42280195e9.5.1743086647808;
        Thu, 27 Mar 2025 07:44:07 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82f7b9f4sm41179575e9.34.2025.03.27.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:44:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:44:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 1/2] tpm: add send_recv() op in tpm_class_ops
Message-ID: <wwf3brf4rtdh7ciejgbjesy32ywqxw5vrpuznyee2yp4arrtmw@gspriiauxvgt>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-2-sgarzare@redhat.com>
 <Z-QxH7aDjlixl2gp@kernel.org>
 <eidmcwgppc4uobyupns4hzqz562wguapiocpyyqq67j5h26qbl@muhbnfxzqvqt>
 <Z-VMWl9UDx5ZY1qK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-VMWl9UDx5ZY1qK@kernel.org>

On Thu, Mar 27, 2025 at 03:02:32PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 27, 2025 at 10:48:17AM +0100, Stefano Garzarella wrote:
>> On Wed, Mar 26, 2025 at 06:53:51PM +0200, Jarkko Sakkinen wrote:
>> > On Thu, Mar 20, 2025 at 04:24:32PM +0100, Stefano Garzarella wrote:
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > Some devices do not support interrupts and provide a single operation
>> > > to send the command and receive the response on the same buffer.
>> > >
>> > > To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
>> > > chip's flags to get recv() to be called immediately after send() in
>> > > tpm_try_transmit(), or it needs to implement .status() to return 0,
>> > > and set both .req_complete_mask and .req_complete_val to 0.
>> > >
>> > > In order to simplify these drivers and avoid temporary buffers to be
>> >
>> > Simplification can be addressed with no callback changes:
>> >
>> > https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u
>> >
>> > I also noticed that tpm_ftpm_tee initalized req_complete_mask and
>> > req_complete_val explictly while they would be already implicitly
>> > zero.
>> >
>> > So it reduces this just a matter of getting rid off the extra
>> > buffer.
>>
>> Yep, as mentioned I think your patch should go either way. So here I can
>> rephrase and put the emphasis on the temporary buffer and the driver
>> simplification.
>
>Yes. Removing extra copy is a goal that can only make sense!
>
>>
>> >
>> > > used between the .send() and .recv() callbacks, introduce a new callback
>> > > send_recv(). If that callback is defined, it is called in
>> > > tpm_try_transmit() to send the command and receive the response on
>> > > the same buffer in a single call.
>> >
>> > I don't find anything in the commit message addressing buf_len an
>> > cmd_len (vs "just len"). Why two lengths are required?
>> >
>> > Not completely rejecting but this explanation is incomplete.
>>
>> Right.
>>
>> The same buffer is used as input and output.
>> For input, the buffer contains the command (cmd_len) but the driver can use
>> the entire buffer for output (buf_len).
>> It's basically the same as in tpm_try_transmit(), but we avoid having to
>> parse the header in each driver since we already do that in
>> tpm_try_transmit().
>>
>> In summary cmd_len = count = be32_to_cpu(header->length).
>>
>> I admit I'm not good with names, would you prefer a different name or is it
>> okay to explain it better in the commit?
>>
>> My idea is to add this:
>>
>>     `buf` is used as input and output. It contains the command
>>     (`cmd_len` bytes) as input. The driver will be able to use the
>>     entire buffer (`buf_len` bytes) for the response as output.
>>     Passing `cmd_len` is an optimization to avoid having to access the
>>     command header again in each driver and check it.
>
>This makes more sense. Maybe we could name them as buf_size and
>cmd_len to further make dead obvious the use and purpose.

Yeah, I see. I'll do!

>
>>
>> WDYT?
>
>I just want to get this done right if it is done at all, so here's
>one more suggestion:
>
>1. Add TPM_CHIP_FLAG_SYNC
>2. Update send() parameters.

So, IIUC something like this:

     int (*send) (struct tpm_chip *chip, u8 *buf, size_t cmd_len, size_t buf_size);

Where `buf_size` is ignored if the driver doesn't set TPM_CHIP_FLAG_SYNC.

Right?

>
>You don't have to do anything smart with the new parameter other than
>add it to leaf drivers.

Okay, this should answer my question :-) (I leave it just to be sure).

>It makes the first patch bit more involved but
>this way we end up keeping the callback interface as simple as it was.

Yep, I see.
And maybe I need to change something in tpm_try_transmit() because now
send() returns 0 in case of success, but after the change it might
return > 0 in case TPM_CHIP_FLAG_SYNC is set. But I will see how to
handle this.

>
>I'm also thinking that for async case do we actually need all those
>complicated masks etc. or could we simplify that side but it is
>definitely out-of-scope for this patch set (no need to worry about
>this).

I see, I can take a look later in another series.

Thanks,
Stefano


