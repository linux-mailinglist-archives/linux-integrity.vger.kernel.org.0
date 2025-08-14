Return-Path: <linux-integrity+bounces-6815-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43792B25DC8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526053AEBFA
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A427054A;
	Thu, 14 Aug 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTH/Ukfk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57F2701D1
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157066; cv=none; b=p96U1kUq7alK8My5FFxaiFbVX94P8RVkrZ5LSzcbVyd5Z9zlEDjrmmmLuFF/Z9v3LZUC0ZJ/YgZZuA4Y8XhYSf7wc5TT7y6RcDWb9KxdgqQYmOtiyE+aXeQ0ogzn1y9QxBw/4jNXzehQ9W5FFq/34LNh36w9/zKqtzYCRNxgktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157066; c=relaxed/simple;
	bh=jbRML4EIYiAQed61m5834j//TjjH/J+5Modr5jb8T+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyB62K+FzX7BbdlGH9uQXMPEu8/MqNenoDvxeLNSsn8ef0eT51MRT8OSBvQ4D8wR/UmtYXhhkAogwDsYrXieRHW7BnSIPHAN8q58HD4kz0U/BRWadOo3Raexi0UVM+KjUu2RdZOMsv80qxVhC8BVS+13NOApqiVYlLlTNsNmo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTH/Ukfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59506C4CEF8;
	Thu, 14 Aug 2025 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755157065;
	bh=jbRML4EIYiAQed61m5834j//TjjH/J+5Modr5jb8T+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTH/UkfkEwQR/QgEDM7VWYTOGvdjqLXo8h/+XLUZJdSGK+mF9Tq5zqFjw6FIScASk
	 lpbinXau3Rj7VimO+8sLV3i+8E9hnvPmlf2WdXvtqi5TwsIyFp2s9MDlgxGmU7IvgI
	 3sYLSCMZspu3M3P0okoro6eHuhMU1KUetMr0EoKBwF195zdcO7XXHeW2jUOqOMULL0
	 D5ahQoIRprLCtB7msSaFC936ulMKdX8qKOOuN5nbFxKgSd9e8/TbffvZSP67Z1BgQr
	 1bbxzcmr7qmvRCde4Xb1n5Zgf0UFhUmyQannWaRFfXKkWE06ZY/BFuSt/Q7hat2kWR
	 c+ghgpro0/sAQ==
Date: Thu, 14 Aug 2025 10:37:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aJ2SRfn2_sGplJTx@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
 <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
 <aJtl4MOJ5hYU7mWy@kernel.org>
 <CAG+gbFfY=YZZ24dZpBtShc+4ypGJgngsz7X32XKaHZ90s3okFg@mail.gmail.com>
 <aJxDRb5KJUTc-dL9@kernel.org>
 <CAG+gbFdesyWJRBss6xBcGsKmTPZ=fro8DAFZaQTOsO-ZT1tcEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG+gbFdesyWJRBss6xBcGsKmTPZ=fro8DAFZaQTOsO-ZT1tcEg@mail.gmail.com>

On Wed, Aug 13, 2025 at 09:13:19AM -0400, Denis Aleksandrov wrote:
> Sorry about the HTML, my reply kept getting booted yesterday due
> to formatting and I wasn't sure why that was the case.
> 
> I guess it might be some automated gmail formatting.
> 
> Let me know how you would like to proceed.
> 
> Thanks again,
> Denis
> 

So I need to postpone early next week because of travelling but
I'll come back then.

BR, Jarkko

