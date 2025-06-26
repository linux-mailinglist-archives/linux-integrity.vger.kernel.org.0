Return-Path: <linux-integrity+bounces-6559-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC254AEA76A
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 21:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C33BC910
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 19:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8442EFD8D;
	Thu, 26 Jun 2025 19:53:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2182EF675;
	Thu, 26 Jun 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967631; cv=none; b=pUIH1oi2DgPKQXd+enKbmcnvPg0MUFklcliywuQQXuFOMp43FAYBc1OrM2LWw1Mw/0OWsxWL/sQTP7VE5u1HWCrTEc2YSprPbbxTze4rUt+QKQFMFAFIFn7fORC3ayzCyd1V+VQdm9lKhhnHXYnyKqQKgNzQQLsqxYlAH5Fhvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967631; c=relaxed/simple;
	bh=ocTxTQdSlRlIX/Oz1YeVB2u+FVPPYJAajkZvda+GVWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNGAb9qEG5JKSjmll5R+IMrZ2mqWQHISCTiVXVjCkMHgWPAiJvkV0pzLoddvXMOrOL+84sZxLHto/8UhWBGWAMmH7tcSAqdu24jpunpLxKOu/FWhu0RWsx8aYWDt87u21byxV7loWV2fBzqNn36ffrEDJTumBW6U3ola1m1ezFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F3661692;
	Thu, 26 Jun 2025 12:53:31 -0700 (PDT)
Received: from bogus (unknown [10.57.50.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8DB83F66E;
	Thu, 26 Jun 2025 12:53:46 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:53:39 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <20250626-busy-hilarious-octopus-47c2fc@sudeepholla>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
 <aFvRI5OwSLLKz300@e129823.arm.com>
 <aFwrBU4H0w9AXyQM@kernel.org>
 <aFwrf1HnsilrASzX@kernel.org>
 <20250625-chital-of-infinite-proficiency-fee4dc@sudeepholla>
 <aFxuZV3lwd2Uc90g@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFxuZV3lwd2Uc90g@kernel.org>

On Thu, Jun 26, 2025 at 12:47:17AM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 25, 2025 at 08:35:33PM +0100, Sudeep Holla wrote:
> > 
> > If you are applying 1/2 too, feel free to add
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > I was initially thinking of taking it separately as there is no strict
> > build dependency. But I am fine if you can take them together.
> 
> Hmm.. Yeah, if you insist to take them, that's fine for me too.
> 

Ignore me 😄

> That said, I'm also happy to take care of them :-)
> 

Yes, please take them via your tree.

> I'll append your review.

Thanks!

-- 
Regards,
Sudeep

