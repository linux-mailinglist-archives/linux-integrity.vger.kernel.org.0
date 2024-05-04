Return-Path: <linux-integrity+bounces-2336-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6678BBDF8
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09D8B21481
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2024 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2684A3E;
	Sat,  4 May 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AF7a2jdM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FFE7318A;
	Sat,  4 May 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714853604; cv=none; b=XOwf2wIoUOSvjw4wy5YMzkoX3Bkv6CiPFQ11MlfN2N0rZpVq8EbXv8iSKjSS0mLeMYYC8+pSqydZhKgrfN9+PxXesKJSg6t+kyoXr9lpM+jZRSnufsRQIruOc1VCyYUWiTHd5qhbctLotWg+hOsrojJnuYrsrWcuRx0LN6bSwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714853604; c=relaxed/simple;
	bh=fhto2uEYgU4wqeL/mix3cVjrhwG4PTmSdbCpoGKNje0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGo6C4MiNswYbj8bQgBmPxE6KlSX+Ng9hCypm3p8iOl94npK3d/rS+6xVcfHRSbKjjH9MCx/Tpd1Vvl1N5jOfpuXbi46YtXJjh5V9WU+5lMggo5vs5L0GO5IBP5ZYlw5JtTrFMaQ9KiTrGl5SajKGqLXpEnvX0bcjJ2308jkON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AF7a2jdM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79675207DBB5;
	Sat,  4 May 2024 13:13:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79675207DBB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714853596;
	bh=Xjz+ah6dGJK98fSkhXGcgKoJ+WDVAsQMdYbME8KL/v4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AF7a2jdMT93DQfcuBJJyAee3iRGHkB6sAaFzHW3xa8rmM2fr/yng8b/vuFYOI6r1C
	 mOake8mf6Ya2UDnxaN+IpyWI8rszWLoz+iix+kLcubqMjZSW2GP9OEzG1RuoPbRQBn
	 oVcqMwODzceFEk90N4os+slDEJ+rrCu+IqwzfnOM=
Message-ID: <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
Date: Sat, 4 May 2024 13:13:16 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 20/21] Documentation: add ipe documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net,
 zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu,
 ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
 eparis@redhat.com, paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deven Bowers <deven.desai@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-21-git-send-email-wufan@linux.microsoft.com>
 <ZjXsBjAFs-qp9xY4@archie.me>
Content-Language: en-CA
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <ZjXsBjAFs-qp9xY4@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/4/2024 1:04 AM, Bagas Sanjaya wrote:
> On Fri, May 03, 2024 at 03:32:30PM -0700, Fan Wu wrote:
>> +IPE does not mitigate threats arising from malicious but authorized
>> +developers (with access to a signing certificate), or compromised
>> +developer tools used by them (i.e. return-oriented programming attacks).
>> +Additionally, IPE draws hard security boundary between userspace and
>> +kernelspace. As a result, IPE does not provide any protections against a
>> +kernel level exploit, and a kernel-level exploit can disable or tamper
>> +with IPE's protections.
> 
> So how to mitigate kernel-level exploits then?
>
One possible way is to use hypervisor to protect the kernel integrity. 
https://github.com/heki-linux is one project on this direction. Perhaps 
I should also add this link to the doc.

>> +Allow only initramfs
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> <snipped>...
>> +Allow any signed and validated dm-verity volume and the initramfs
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> <snipped>...
> 
> htmldocs build reports new warnings:
> 
> Documentation/admin-guide/LSM/ipe.rst:694: WARNING: Title underline too short.
> 
> Allow any signed and validated dm-verity volume and the initramfs
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Documentation/admin-guide/LSM/ipe.rst:694: WARNING: Title underline too short.
> 
> Allow any signed and validated dm-verity volume and the initramfs
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Documentation/arch/x86/resctrl.rst:577: WARNING: Title underline too short.
> 
> I have to match these sections underline length:
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
> index 1a3bf1d8aa23f0..a47e14e024a90d 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -681,7 +681,7 @@ Allow all
>      DEFAULT action=ALLOW
>   
>   Allow only initramfs
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~
>   
>   ::
>   
> @@ -691,7 +691,7 @@ Allow only initramfs
>      op=EXECUTE boot_verified=TRUE action=ALLOW
>   
>   Allow any signed and validated dm-verity volume and the initramfs
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   ::
>   
> @@ -725,7 +725,7 @@ Allow only a specific dm-verity volume
>      op=EXECUTE dmverity_roothash=sha256:401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=ALLOW
>   
>   Allow any fs-verity file with a valid built-in signature
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   ::
>   
> @@ -735,7 +735,7 @@ Allow any fs-verity file with a valid built-in signature
>      op=EXECUTE fsverity_signature=TRUE action=ALLOW
>   
>   Allow execution of a specific fs-verity file
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   ::
>   
> 
>> +Additional Information
>> +----------------------
>> +
>> +- `Github Repository <https://github.com/microsoft/ipe>`_
>> +- Documentation/security/ipe.rst
> 
> Link title to both this admin-side and developer docs can be added for
> disambiguation (to avoid confusion on readers):
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
> index a47e14e024a90d..25b17e11559149 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -7,7 +7,8 @@ Integrity Policy Enforcement (IPE)
>   
>      This is the documentation for admins, system builders, or individuals
>      attempting to use IPE. If you're looking for more developer-focused
> -   documentation about IPE please see Documentation/security/ipe.rst
> +   documentation about IPE please see :doc:`the design docs
> +   </security/ipe>`.
>   
>   Overview
>   --------
> @@ -748,7 +749,7 @@ Additional Information
>   ----------------------
>   
>   - `Github Repository <https://github.com/microsoft/ipe>`_
> -- Documentation/security/ipe.rst
> +- :doc:`Developer and design docs for IPE </security/ipe>`
>   
>   FAQ
>   ---
> diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
> index 07e3632241285d..fd1b1a852d2165 100644
> --- a/Documentation/security/ipe.rst
> +++ b/Documentation/security/ipe.rst
> @@ -7,7 +7,7 @@ Integrity Policy Enforcement (IPE) - Kernel Documentation
>   
>      This is documentation targeted at developers, instead of administrators.
>      If you're looking for documentation on the usage of IPE, please see
> -   Documentation/admin-guide/LSM/ipe.rst
> +   `IPE admin guide </admin-guide/LSM/ipe.rst>`_.
>   
>   Historical Motivation
>   ---------------------
> 
> Thanks.
> 

My apologies for these format issues and thanks for the suggestions. I 
will fix them.
-Fan

