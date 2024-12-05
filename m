Return-Path: <linux-integrity+bounces-4293-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72009E5306
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D282878B0
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E74F1D8A10;
	Thu,  5 Dec 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1MSiodC3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE91D9A48
	for <linux-integrity@vger.kernel.org>; Thu,  5 Dec 2024 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396013; cv=none; b=PwIEB6+ubydXG44eiLzkipDqpI7cd/BvQIvQlfVTcVJATCojRuxyeCdHYOZ0uIeURtc7+JkcUrfopuvBANgedSCC1ounz9v3QJ5GkhPGeTvneO8URsOs0n/OKIyRVSnELSYK1ZcWh8AL/3ku2hRzqRhLjKeVbgV1bs3eyBg2VOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396013; c=relaxed/simple;
	bh=V7TDcfBuyky5UsKZRbY/kdI8U0JTK2PgSkZNRMtSVHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDTbXp/W3i9ObvsfxauokqWvB5vIl8bRjOi9DJFLzydxxJwbNXyyrPcuAB8UQLykFIHK1mPk6Ldl17CuO5UIdA99LMEfLpNb6zWrBO6iI0XFf41wzW5475t5QufkRzltU8KsdXuNBvnkCH2gvKKIDFTfU7Eb9263dZ267k1mazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1MSiodC3; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y3rpZ4r0CznS;
	Thu,  5 Dec 2024 11:53:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733396006;
	bh=cTdGME8xOveDjt/A541FRkracaMRa2kD7BqhDnfiQ5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1MSiodC3yO84x9ruBw8LRr0ArJoSuCIdfqGZ4KKWrBW6uX4L3hoeQqPpWoYwYiCI5
	 WUuQSLzxs8bbIGUmpy2smurAVkuSf4NEVuqCp0nabu1d7yqINrdz0Dt7V+dCD6OfnA
	 tmgo9xHpaRvxHHKsOsPkrKOlB2Vn4EOJaVmHuWQY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y3rpZ0PF3zK3H;
	Thu,  5 Dec 2024 11:53:25 +0100 (CET)
Date: Thu, 5 Dec 2024 11:53:26 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
Message-ID: <20241205.fien4aet3Jae@digikod.net>
References: <20241203233424.287880-1-zohar@linux.ibm.com>
 <c1c61f20-a4ee-437f-840b-2433345e74b6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1c61f20-a4ee-437f-840b-2433345e74b6@linux.ibm.com>
X-Infomaniak-Routing: alpha

On Wed, Dec 04, 2024 at 02:01:02PM -0500, Stefan Berger wrote:
> 
> 
> On 12/3/24 6:34 PM, Mimi Zohar wrote:
> > Like direct file execution (e.g. ./script.sh), indirect file exection
> 
> typo: execution
> 
> > (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> 
> If I understand the underlying patches correctly then 'sh script.sh' would
> be evaluated with execveat(AT_CHECK) but this requires the execute flag to
> be set. To maintain backwards compatibility  sh cannot assume that script.sh
> has the execute flag set since it doesn't need today:
> 
> $ echo 'echo hi' > foo.sh
> $ sh foo.sh
> hi
> 
> the same is true for python:
> 
> $ echo 'print("hi")' > foo.py
> $ python foo.py
> hi
> 
> I am not sure which interpreters are going to be able to take advantage of
> this or whether they will behave differently if the x bit is set versus when
> it is not set...?

This is a valid concern handled with two new securebits.  See the
related patch series and documentation:
https://lore.kernel.org/all/20241112191858.162021-3-mic@digikod.net/

