Return-Path: <linux-integrity+bounces-5477-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AB0A73404
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F1717CE72
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880ED217642;
	Thu, 27 Mar 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guqHJxrH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33D217653
	for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084670; cv=none; b=ukBzqO8LiccY7h2hRTbyxYtXeTTSuW2o34rwUzVixqGU3dyiLKkP+HvcsRhdIaHt5byB3c4Gg8ipPAbKnpEWqh+K9lWjb8sIOw8JbOhsW5/hpWfm+nWtJm9S3Ik9EHiQIX+ti9XX0w55pXNwOaKuDZPWzNL3drgxYRR8g3e49BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084670; c=relaxed/simple;
	bh=B7vCfx3k3GGrVgJmcqjs9B8k5ffO9HgiTB4iz81gIcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYRy7ndXQvwjNvcucT8g6lvWAxWUv7z2zKj44wmHoPA5L0nW0yy0fVGF66jbNesTaOYJWt2j2s2VS7F1hra0AhBShg5v16F0iOeQfiqQFKUB59a+OesQ1aijxOXwMQ9CgrCbtQ5vb8qQ3TQI6tT2UshF0TemswYQfpL9KKahidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guqHJxrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743084667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hi0A6scfyHr5zE+wPaQeLFGm0aUxJknUTOgLYjwIz9w=;
	b=guqHJxrHlEtB6k1VfWFiifl+cYVqwQKQg2ia/0JJC96RwO9yhk2N2uMfQreUrMHnGKJ2/E
	4QxQamfoygLfTIn8mErgOF/sfU+G1k45B2hiDvUn6zgK/LgYowkneYG2WmxRFZdrWMo8PZ
	RMmIE92q+REgEaVbEOMcJVRYN7sUPPA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57--wvJf-7FMUW2pSLIgz7MZQ-1; Thu, 27 Mar 2025 10:11:05 -0400
X-MC-Unique: -wvJf-7FMUW2pSLIgz7MZQ-1
X-Mimecast-MFC-AGG-ID: -wvJf-7FMUW2pSLIgz7MZQ_1743084665
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so6655105e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 27 Mar 2025 07:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084665; x=1743689465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi0A6scfyHr5zE+wPaQeLFGm0aUxJknUTOgLYjwIz9w=;
        b=pBx6yY2fTfnjZQ7knX4U0GU1AJe+diC6Ho93CFYdMZ/EL9UBjyvL9UQ+yOZJOoK3rw
         7Me5hRvCHZvwU8uEG+6ZDHln32BKhNJ6tDyDVjeUZ4BPo+SIf1HBqW+KHPtce6AUbaLV
         K6/afMjkRI2JduSsszeJJRMrVmBMciib6Bp5Gewq2JyEhBKU90ZLwq8b0rpP5IysMvDE
         FobWOmAzUFpt3YLcb/YBjQLJpWXnbYSf/G7eI/tRk1OtEuaJVeuJY8lEX5ajXdoPS6NT
         +Ezc8FzVwSvPpkEo0Txsxq3fS6JMWKo2Rhbsdb6ZC79qvyHsTcI/qyPCvq8FcqZOcEMd
         t88Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn8eVJaQQ5S83mhv2WQcHfZHB1BJVfnXeEAH7Ouo9bTGu8bpplsJ3b2METk/zCmrQHfVSUqpqBxdXllDx2U9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8owDtDyElC9ewCMomU35GZtx9d9xgTRIsgA/8mTw0ygUdaK+T
	uDgMKdYIrcXa3d5Hjwk2XrK5ZqIu+IqpqIwZimJVlBWg3tS9lr7zJSHKdsQJtQOEKAsd4TVI8c1
	7EIDRxn9I686Q0jg8+7DY2qBnB9w8PuiJR4FMZoxu5qFpQxq7QavoU80S5li+JkgJWw==
X-Gm-Gg: ASbGncvlE2u271hKivl6xL2EmUYL3J3eo7/Py/AJZSYzTyS3diOBEVI8Uu20lg1fjPE
	DV5zubI+ejstoU2VqcXC/nEqXZypC3NBYyqBfGk+U2EYuvF4/ruqKaImr3FhMlExOBYx3FpfqJt
	hSnal/irU0wqB25CVxVNgce9UOSCyh/nn1zvEEWU+p+IqOsRkXvlDLR795W+WUJxK3RSrEchFoV
	8r38I1swk0TBoqCgXpOqqXPaAhohlWViyHc7x8p1EFmPyDiK6jwK9lJ6NcR8BY860cG85J4Khcj
	cv1MjkC91GPXFJ6owCwZyQOCuknv1H0Kvk9pXBd4HXxhRmIRm7WCDRgpLr+wwG3+
X-Received: by 2002:a05:600c:1d05:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-43d84f5f482mr38225375e9.2.1743084664702;
        Thu, 27 Mar 2025 07:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwervicR8HJyW32dDEpFNwFDZuw43Crvb82jmCEiLUmWRbpF+tRkohYrusgDBir4muwY2dA==
X-Received: by 2002:a05:600c:1d05:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-43d84f5f482mr38224505e9.2.1743084664134;
        Thu, 27 Mar 2025 07:11:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995a10sm19848348f8f.6.2025.03.27.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:11:03 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:10:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <setj52yumlcd43q5hnsfntig5mv7uxhh6n32puahkmwg75wtlc@ft3xk3vybpwn>
References: <20250324104653.138663-1-sgarzare@redhat.com>
 <20250324104653.138663-4-sgarzare@redhat.com>
 <Z-RV7T7Bwt3Auopx@kernel.org>
 <x3nkctmpbwkldm5aawfpqrw3b5lej5kxuxam7gb2w6nhgzy7kr@gd3mfnigyg6q>
 <Z-U8UxEdt9Jit9GA@kernel.org>
 <Z-U9KxQYA6vj1DZT@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z-U9KxQYA6vj1DZT@kernel.org>

On Thu, Mar 27, 2025 at 01:57:31PM +0200, Jarkko Sakkinen wrote:
>On Thu, Mar 27, 2025 at 01:53:59PM +0200, Jarkko Sakkinen wrote:
>> On Thu, Mar 27, 2025 at 11:03:07AM +0100, Stefano Garzarella wrote:
>> > On Wed, Mar 26, 2025 at 09:30:53PM +0200, Jarkko Sakkinen wrote:
>> > > On Mon, Mar 24, 2025 at 11:46:48AM +0100, Stefano Garzarella wrote:

[...]

>> > > > +
>> > > > +static struct tpm_class_ops tpm_chip_ops = {
>> > > > +	.flags = TPM_OPS_AUTO_STARTUP,
>> > > > +	.recv = tpm_svsm_recv,
>> > > > +	.send = tpm_svsm_send,
>> > > > +	.cancel = tpm_svsm_cancel,
>> > > > +	.status = tpm_svsm_status,
>> > > > +	.req_complete_mask = 0,
>> > > > +	.req_complete_val = 0,
>> > > > +	.req_canceled = tpm_svsm_req_canceled,
>> > >
>> > > If this was bundled with the patch set, this would short a lot:
>> > >
>> > > https://lore.kernel.org/linux-integrity/20250326161838.123606-1-jarkko@kernel.org/T/#u
>> > >
>> > > So maybe for v5? Including this patch does not take send_recv()
>> > > out of consideration, it is just smart thing to do in all cases.
>> > >
>> > > It would be probably easiest to roll out my patch together with
>> > > rest of the patch set.
>> >
>> > Yeah, I agree. I'll include it in this series and adapt this patch on top of
>> > it.
>>
>> Yeah, and you could simplify to goal in the other patch set: it's about
>> avoiding double-copy of a buffer.

Yep, agree!

>>
>> It's a totally legit argument that we can measure. So in the end this
>> will help out landing that too because it takes away the extra cruft
>> and streamlines the goal.
>
>... IMHO there is this unwritten law for upstreaming kernel features
>that goes something like "further the goals are from white papers,
>closer they are to mainline" ;-)

:-D I'll make a note of it!

Thanks,
Stefano


