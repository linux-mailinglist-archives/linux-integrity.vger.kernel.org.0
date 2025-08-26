Return-Path: <linux-integrity+bounces-6919-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C4AB3571E
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 10:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5166A189EDEA
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C1A2F9C3D;
	Tue, 26 Aug 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="OK3Ewd5w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83B2857E9;
	Tue, 26 Aug 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197313; cv=none; b=aEZbg+14VYW2+IW9iSD5MM3ig9uHYzuJCm68DTpQQUe/tSFQIzUEwGI8u4aQGh3AI8aQg3b9V6boX+R82cT8rgOuSwqURPcJHq8vTBl6cmxBK4xU7/GVp9tYwd9f16DqfzhbLallVUE4UITX+Eird9H6eeyrtlQnoNh4iX3L3v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197313; c=relaxed/simple;
	bh=Z/LB1M/2VX7KqJrgprVj6tKUWP9E0EA908mu2BjbDTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdHBTKUpV6TUeghab8dU4SjZhM+EuvZXHhrF0mPqS8ZcXw9Wx0mv/QghLX/IiExCNMLjO6ipjwAOsw7mje4CiwiVyh5MnM/FYjAzmoNJ8xg+2/0EmEocSonnU0T3VBgYyiJBL0Tt05rYfDEK349QVwTos785gIwHvi333SoZ6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=OK3Ewd5w; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C/eQL7etAvfhe8pmbZCTySyBXYWaoKqCDA6fW77TpVI=; b=OK3Ewd5w/fEuKZMVjES/EH9cKF
	GTEXGRhREqUvtw0N5NjD7BRPRgeHipOESB8SkbYZ2EqOj2sRzGTSgMlDG69PryOMQzYugCA6nkOfQ
	pSL+u1eYfkNcxiimAdHU6cThL5Hr0hDj+BeMztWmE76LbmILFDLkpWsYhDvGnjhrPJXmPb0+7rohO
	AHppgo8LAESfR0o62xzEXWny6HX9l20ORTEl079aeCK9fQeRn/vvato/GH5CJy2FFBl6Pn3pYGntN
	6hTQZdneQ3EKSvfq0jFTTvwZxchpqFVzsuKUXZB/scbATrOB82Sh0M5adyR4c7XOSJiIoZnMAIjyU
	QrPpzORg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1uqp92-00FYom-0f;
	Tue, 26 Aug 2025 09:35:08 +0100
Date: Tue, 26 Aug 2025 09:35:08 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aK1xvMTqoq-6JyHm@earth.li>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
 <aKy5z74FE4paL7za@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aKy5z74FE4paL7za@kernel.org>

(I've seen your later mails, but I think this is the right one for me to 
respond to around what my concerns are.)

On Mon, Aug 25, 2025 at 10:30:23PM +0300, Jarkko Sakkinen wrote:
>On Mon, Aug 25, 2025 at 01:04:38PM +0100, Jonathan McDowell wrote:
>> On Sat, Aug 23, 2025 at 03:12:44PM +0300, Jarkko Sakkinen wrote:
>>
>> > My goal with tpm2_protocol is to have ACPICA alike model of imports as
>> > the crate is driven by TCG spec updates and it is very likely to be
>> > also used by TPM-RS (also via import style process).
>>
>> I'm not entirely clear on what your plan is for this / the existing TPM
>> drivers in the kernel? I assume it's to eventually remove some of the C code
>> in favour of the Rust implementation, but I'm missing exactly how that's
>> expected to work.
>
>There's no plan of doing anything at this point. This is more like doing
>early research for the following questions:
>
>1. If this comes up in form or another, what are the directions of freedom.
>2. What could be in general done in Rust that could potentially extend
>   the capabilities of e.g. /dev/tpmrm0 (which could be entirely
>   different device).
>3. There has not been any discussion from my part of removing and/or
>   repealing and replacing any of the C driver code.
>
>It's a bit odd position IMHO to not prepare for future outcomes. Even
>without kernel context, for the TPM marshalling/unmarshalling there does
>not exist decent implementation as of today in *any language*.

I'm not saying we shouldn't prepare for future outcomes. It sounds like 
you're focusing on the marshalling/unmarshalling piece with Rust, rather 
than expecting to replace the entire of drivers/char/tpm/ so that 
worries me less.

>> (Given I've spent a bunch of time this year tracking down various edge case
>> issues in the TPM code that have been causing failures in our fleet I'm
>> understandably wary of a replacement of the core code. *It* might be a
>> perfect spec implementation, but hardware rarely is.)
>
>I think this is somewhat unconstructive comment. How do you implement
>against anything if you don't follow the spec and later on fix the
>incosistencies?
>
>I have not observed high stream of marshalling and unmarshalling
>associated bugs or other issues.
>
>Also if you make obnoxious arguments like that please also underline
>how implementation A is worse at dealing possible inconsistencies
>than implementation B. Otherwise, you're only spreading FUD.

I think you're confusing my concerns with concerns others have about 
/dev/tpmrm0. I'm not overly worried about that. I suspect there might be 
some cleanups that can be done, but we use it as our resource broker and 
I don't believe it to be the root cause of any of the issues we have 
seen.

If you're focused on marshalling + unmarshalling then I don't recall 
seeing issues there. What I'm thinking of more are the workarounds for 
firmware issues, or the subtle timing bugs that have sat in the kernel 
for a number of revisions before they've been tracked down and resolved.  
I'm not intending to be obnoxious; these are not fundamental design 
issues, just code fixes that have hardened the driver over time. If we 
were talking about ripping everything out then my concern would be we'd 
have to do all this battle hardening over again, no matter what our best 
efforts. i.e. we've already done some work fixing the inconsistencies, 
let's make sure we don't lose that.

Examples of the sorts of fixes I'm thinking about:

d4640c394f23 tpm: Check for completion after timeout
2f661f71fda1 tpm: tis: Double the timeout B to 4s
1dbf74e00a5f tpm: End any active auth session before shutdown
de9e33df7762 tpm, tpm_tis: Workaround failed command reception on Infineon devices
7146dffa875c tpm, tpm_tis: Fix timeout handling when waiting for TPM status
e3aaebcbb7c6 tpm: Clean up TPM space after command failure

(I've also got another issue I'm currently trying to work through but 
I'm pretty sure it's a firmware bug and until I nail it down fully with 
a reproducible test I can't determine if there's a suitable kernel 
workaround, or it _needs_ a firmware upgrade.)

J.

-- 
Web [    101 things you can't have too much of : 22 - Friends.     ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

