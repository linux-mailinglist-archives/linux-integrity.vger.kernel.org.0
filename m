Return-Path: <linux-integrity+bounces-5310-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D952CA671E0
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 11:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48FB3B04BA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D37EAC6;
	Tue, 18 Mar 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWkVQ712"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33472080C9
	for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295327; cv=none; b=E1XvyOfpvRS6QIvX6Z5o5I7kcTyCozSxjsi1mURPhqA7mrKMNaRY7oQ6gL73VouiluLfV3RxwIl1/zZzYEdNAh2NkeETGCdQqV9cL8OEj9uUsdk+0Ud4DpMriZCUWlbtzdm3/BklleqyQ/ufZR6TcJUHgEoo+fsnBI5UNtH5g6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295327; c=relaxed/simple;
	bh=mFjQbMbXmrzrA9/oqDco2SadbOJD1AxZiZTUK+/CQGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d42vDo7mARi3Zo/LwkIfHFzCjYzJeGJQPz6JW8BCGegoSCJFHgWPKUVSjU27vuvPd1uFktaocSQCCW2XyQGlc/bWQq4+/JyfhUrqCieUzE8iJ366YpJIYVWFdGQdJY8pe7eSftMTB9w+pkwPA9enkTKtQNAZjw5ZIWv6cgmsFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWkVQ712; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742295324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHPKRiD5IvPCz4tWY3lFXAHK+T/t5ZDvSNwr48IWoBc=;
	b=GWkVQ712ILoOVcCCfB9uw2S3tZLcTf0mcRCLnoBESkad+QPTTzFsfyTDDiIH+K/Y7gVziQ
	vYueWIiOMEcb1bh/LUYUy/JpkxdFaGB4jYFuDM/hGDjADoRLJ7mt9YTgN0Q+DIAb8wgJER
	WKBiU5yQodfv8TBbt66D7SqeNnQBgqM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680--5f8kZiqNFGc7ByHHmel6A-1; Tue, 18 Mar 2025 06:55:23 -0400
X-MC-Unique: -5f8kZiqNFGc7ByHHmel6A-1
X-Mimecast-MFC-AGG-ID: -5f8kZiqNFGc7ByHHmel6A_1742295322
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d22c304adso13736495e9.0
        for <linux-integrity@vger.kernel.org>; Tue, 18 Mar 2025 03:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295322; x=1742900122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHPKRiD5IvPCz4tWY3lFXAHK+T/t5ZDvSNwr48IWoBc=;
        b=EtIgsuCBn7KGsG0Npvc8PM0tF/Av8ctB6+o3DLpBKS41jvKGvhAue6PTEFZKzMwnkQ
         IQttGeDZDvxtC5pEu7NImWbdhPot2C/2+088+KvQhdlkdATcya/lXTsTlJ9K/CPIvfhL
         qHEtlazn2iYPRrxtgrV1WxFygVHQST8YfuBMkBBZy3JNIXPPG/E6MYET8PS50k2Qg8cp
         upGJeQWagLjVFh7lN2Brk4B4m49rziKtaFBtP/abId4ivreNssBY11Gn6ocvlcSkwcKJ
         lodHXpkRAwbGxb1Ach+v6LPjWfKvQxvm1WD1gDy2fkVy0j5T7Z2aGHYcp+wYbOhgTkD1
         5b3g==
X-Forwarded-Encrypted: i=1; AJvYcCUZJt66cu0uvdh5OVIAkD5BAIQ5gII7dHjKinE6U5p0W2mcEJzgmwdk7rJ0bo1ZTtl02MCr5zjngGzcTBqX4Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRMeL/6tAD497ic2ZNMIrYax1/RJjaI1MicYjTbYxExZcG7E6
	KGaBJJyrVNZ+ZqzPwnaMUYZ2jpw156dW6DKp9+2gBtQroT/FLpd/nCM7xdxP0CCfBDJAfngdo1C
	mCrT7Gn0VhkOcBdq50EiAGseAvCUxc0Hjqtz+diZvxy6lrk9W+kwohwmRYld1HUvOyE7RB2Imeg
	==
X-Gm-Gg: ASbGncs/E4XbGu78D8vADABo6OsA+ASKT1lsCvXCQEOBKaHqOcnmzhPQasMaM/WXK5b
	ZfX8ksIQJosbWGDqLKhDRMSPz4pXLt1VENj2ZV40IUNkw0e+wiwuFXenLu8OdouUMKTdHH9kgbS
	IotnFGBW1rgQcfaZcZfB5gXCdx2M6PqkLlajkA/NUiaHsUWgExeIcXCPjHwgnOar+Az/Iwcb3Rv
	m0T2wAH4pG9VJO4SaPf1giWADd13Dgso5bv4uCIroPU+vkjymcYmuU/pk8Sqy/E6QDiNdCInEAj
	Dcagh1uhLt8EyIIinpcbXpSaibSBOHoDbXRUX0RCvxgje7CJcZGcjPm2veKQmZ1z
X-Received: by 2002:a05:600c:1e24:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43d3bcd5e6amr19520905e9.15.1742295321961;
        Tue, 18 Mar 2025 03:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvdAtLAHCC5OhzhAzDzeB18bQRy5AjBp/p9Eb8xmzJT+FhfPVJQf69XVrgDbULlTazB3e+Mw==
X-Received: by 2002:a05:600c:1e24:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43d3bcd5e6amr19520675e9.15.1742295321527;
        Tue, 18 Mar 2025 03:55:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbf901sm130094875e9.15.2025.03.18.03.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:55:20 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:55:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, 
	Sumit Garg <sumit.garg@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 2/3] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <c5tgxiza47d3md5epw32exddl3wm5pkc3ja76dkex5jwxpmcnj@c27hnr4ezido>
References: <20250311100130.42169-1-sgarzare@redhat.com>
 <20250311100130.42169-3-sgarzare@redhat.com>
 <Z9KhlSr7qG6VooeC@sumit-X1>
 <CAHUa44HEpfL8nmG6qZMYUesSJXWUraUmJE_nwFTp5L8qBaC-jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HEpfL8nmG6qZMYUesSJXWUraUmJE_nwFTp5L8qBaC-jA@mail.gmail.com>

Hi Sumit, Jens,

On Thu, Mar 13, 2025 at 01:59:19PM +0100, Jens Wiklander wrote:
>On Thu, Mar 13, 2025 at 10:13 AM Sumit Garg <sumit.garg@kernel.org> 
>wrote:
>>
>> + Jens
>>
>> Hi Stefano,
>>
>> On Tue, Mar 11, 2025 at 11:01:29AM +0100, Stefano Garzarella wrote:
>> > This driver does not support interrupts, and receiving the response is
>> > synchronous with sending the command.
>> >
>> > It used an internal buffer to cache the response when .send() is called,
>> > and then return it when .recv() is called.
>> >
>> > Let's simplify the driver by implementing the new send_recv() op, so that
>> > we can also remove the 4KB internal buffer used to cache the response.
>>
>> Looks like a nice cleanup to me but it needs to be tested. Jens, can you
>> give this patch a try?
>>
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> > Note: I don't know how to test this driver, so I just build it.
>> > If someone can test it, or tell me how to do, it will be great!
>
>Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
>

Thanks for testing this!

>Cheers,
>Jens
>
>>
>> The fTPM is now maintained as part of OP-TEE project here [1]. The
>> instructions to test it on Qemu can be found here [2] as part of CI
>> pipeline.
>>
>> [1] https://github.com/OP-TEE/optee_ftpm
>> [2] https://github.com/OP-TEE/optee_ftpm/blob/master/.github/workflows/ci.yml
>>

Thanks for the links, I'll take a look!

Stefano


