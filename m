Return-Path: <linux-integrity+bounces-6588-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1BEAF6515
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFD717F2AF
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Jul 2025 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA82441A0;
	Wed,  2 Jul 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZNYA4/p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1A70805;
	Wed,  2 Jul 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495080; cv=none; b=bT1BRlu24xfSD720jtX1FgqeXhs2EIXKe74+j/ik9N9S4GduxMf5Bw0s6PlqEO1MUBTQUTs9MjVm5XhMwlAKtVIul0NFuNxJaelayJLg5SP656b/cRiJRXt7pNp/01dLVF1AcNZqONWFkGEEM8TisxUX4UN61YM2mBaWz2fPEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495080; c=relaxed/simple;
	bh=niWlz20tCdvY2IAP/jwLYa/1jI8eLqw71ef/KVXD2TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ3T6dprNMfwu4a3L83z5tfZkGNBniut1LJds2ZO8Y96aszUa+4tSV/Dfbo2zWokp2f+VJmik8k4mWIsgztf6/E102XDvWFHlK2bcJlkn4ewr1QWJph78t01wgXhGcbEuUGN0rtxwAAJt7COrXYOfRoqPYnqgMwjCBbCRb0mG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZNYA4/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54111C4CEEE;
	Wed,  2 Jul 2025 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495078;
	bh=niWlz20tCdvY2IAP/jwLYa/1jI8eLqw71ef/KVXD2TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZNYA4/pyZhk90uFI2BciJ771zPo+7ojpTqvxp6Msu0pMkRuRqAAlh4q5BzVPRYRQ
	 nXqorJBWrRTr8C78bgAJTJYugk3Dxk2/PfflxbA8IAuLZDGTghrg99+SbdAUYkEB6d
	 B9NR5EYnFhgTjGhPay11DBzViHas1e4XAlTzJX1eZy63dlnwrdK8T3oUi4U3saPbDP
	 SV5QFk/1oa/YNFJuJIMvtWsyBd4Q2wFuX85vx7Cacnb86h3uHpq2o2i+c/8N1OVFdN
	 KtfWpBYd9AqUGsM02sL0/qNqr4ZxOYVUaVLmAZg5vZZVG4j3K0b/a6qOWye2ZeZIM2
	 4iWs51C4dN70Q==
Date: Thu, 3 Jul 2025 01:24:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <aGWxozDE4-qbQqg8@kernel.org>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
 <aFvRI5OwSLLKz300@e129823.arm.com>
 <aFwrBU4H0w9AXyQM@kernel.org>
 <aFwrf1HnsilrASzX@kernel.org>
 <20250625-chital-of-infinite-proficiency-fee4dc@sudeepholla>
 <aFxuZV3lwd2Uc90g@kernel.org>
 <20250626-busy-hilarious-octopus-47c2fc@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626-busy-hilarious-octopus-47c2fc@sudeepholla>

On Thu, Jun 26, 2025 at 08:53:39PM +0100, Sudeep Holla wrote:
> On Thu, Jun 26, 2025 at 12:47:17AM +0300, Jarkko Sakkinen wrote:
> > On Wed, Jun 25, 2025 at 08:35:33PM +0100, Sudeep Holla wrote:
> > > 
> > > If you are applying 1/2 too, feel free to add
> > > 
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > 
> > > I was initially thinking of taking it separately as there is no strict
> > > build dependency. But I am fine if you can take them together.
> > 
> > Hmm.. Yeah, if you insist to take them, that's fine for me too.
> > 
> 
> Ignore me 😄
> 
> > That said, I'm also happy to take care of them :-)
> > 
> 
> Yes, please take them via your tree.
> 
> > I'll append your review.
> 
> Thanks!

OK cool, cool just syncing up :-)

> 
> -- 
> Regards,
> Sudeep

