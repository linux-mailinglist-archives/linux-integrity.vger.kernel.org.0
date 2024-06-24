Return-Path: <linux-integrity+bounces-2920-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7D1914653
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AACB2849EB
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9C13049E;
	Mon, 24 Jun 2024 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="wupNwgB0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A17346C
	for <linux-integrity@vger.kernel.org>; Mon, 24 Jun 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221053; cv=none; b=uZ0WpFpOXhm0DqmZLrr8KwD23mq7QW5xWfy4DhIHB5AHItbIyUVPYE90+ZjzIis1HYbLbWBwz42f7irdy3Ptj0NK8j5G2NXhtJR3KyJexEonjc331SOJb9/w+ibULnCVcJSY6asjnEHPDKvrnmKxrI+sH2OarfgHwWmgSb2PiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221053; c=relaxed/simple;
	bh=6gbsmilc3HZ4ErPzDmaGa4+RgG7DfiDFQ47eyx88HeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqDSLRFPlIMOP5RzZdB6oUB7sIiEvvQs5e6q999c58XVJePUPYLjd1bK2kmgWRIgpHrLgsJxwZ+AUC+34tw8oB2jj6qZBeCAPUzADYLYlqd8qVDJAh0+Ljomj4HUwqOM0hQpgdN7CNRqB0HHHJ0ll2qj13/T68v+1YJrDvhnhSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=wupNwgB0; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=f+RqtYqgtJ6OjqzyEO6Nfnt86JS5z8jN3u4v28Y8neA=; b=wupNwgB0sT7t3aIRdL/UJy1u7V
	6hdG/3EAcfkjZKc7m42RlV4wdy618f6jf3IZIWczeBvArOuobbHR2jAlCZRBHwraMqEvcMHoPJczz
	htQollBkF860eadoTDv39twxxp7p9se2JSt/trXOHOJBoHtKBW9uY31nUxi4W40Fss1RRbeyvrcbI
	6VDx074yI+4DxZMWlanTzWAYYLlE6tOo7F/wvWkefM3cevbzsJkSAfkywqnL3xLr7Yf+tuy5YdxJp
	ZNo9Z0yoVFPy5hUSrFLZ3Zq8dAFzK9N3+nsfTpy95l7kibnxhym7yI7X8A5NibhwWWOxIQRdhgzPt
	XFBCBBlg==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sLfve-00BnTd-23;
	Mon, 24 Jun 2024 10:24:02 +0100
Date: Mon, 24 Jun 2024 10:24:02 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-integrity@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [ima-evm-utils][PATCH 2/3] CI/CD: Disable pkcs11 providers for
 Debian and AltLinux
Message-ID: <Znk7MpQ7ixXJygNj@earth.li>
References: <20240621005912.1365462-1-stefanb@linux.vnet.ibm.com>
 <20240621005912.1365462-3-stefanb@linux.vnet.ibm.com>
 <ZnVP1nLxm1vhc1l0@earth.li>
 <5fc85cd29bc8456bfd1cd47b6dbe38bfbaeb4907.camel@linux.ibm.com>
 <ZnVni8XlHevSIfEB@earth.li>
 <c7cace8cd944ea83bf93f8db652ead0b07611fe5.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7cace8cd944ea83bf93f8db652ead0b07611fe5.camel@linux.ibm.com>

On Fri, Jun 21, 2024 at 04:34:33PM -0400, Mimi Zohar wrote:
> On Fri, 2024-06-21 at 12:44 +0100, Jonathan McDowell wrote:
> > On Fri, Jun 21, 2024 at 06:24:38AM -0400, Mimi Zohar wrote:
> > > On Fri, 2024-06-21 at 11:03 +0100, Jonathan McDowell wrote:
> > > > On Thu, Jun 20, 2024 at 08:59:11PM -0400, Stefan Berger wrote:
> > > > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > > > 
> > > > > Disable testing provider support on Debian:latest and AltLinux:sisyphus
> > > > > since both now get stuck while running OpenSSL provider-related tests.
> > > > > This is most likely due to an update in a dependency (OpenSSL, libp11,
> > > > > softhsm,  or others).
> > > > 
> > > > This seems to disable it for both Debian stable + testing.  Is it
> > > > actually broken for both?
> > > 
> > > There is no pkcs11-provider package on stable, so the test is skipped.
> > 
> > Ah, right. I can't actually figure out what tree Stefan's patch is
> > against to try myself. https://git.code.sf.net/p/linux-ima/ima-evm-utils
> > does not have the commented out softhsm2 / pkcs11-provider apt line.
> > Where should I be looking?
> 
> Upstream should be based on the next-testing branch of 
> https://github.com/linux-integrity/ima-evm-utils.git.

Thanks, I was able to reproduce with that. There's some sort of deadlock
happening down in the softhsm2 / p11-kit-proxy layers that wasn't
immediately obvious to me. Backtrace at

https://the.earth.li/~noodles/evm-test-failure

in case it means something to someone else.

J.

-- 
Can't you see I want tenderness, you idiot?

