Return-Path: <linux-integrity+bounces-5852-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DCA869DE
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 02:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC651B88224
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F4502BE;
	Sat, 12 Apr 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laeuIeCZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC047F4A;
	Sat, 12 Apr 2025 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418477; cv=none; b=J2feLVZ4Hmq7RiW8QadRVNqQMuB/bw952khPcKAZUUJxMX1wYw6Bn4BsWLP8YdanQGR8ilIXxYqWVkVfwWskc3z3iwUtzhP35N1rzBa35mc0GzXWdN65fbwckz9ID4hlmgP7WmHXnOFvc1osIeA0Sl8njOzJUjUqoqL1JOXa/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418477; c=relaxed/simple;
	bh=t3orFv6PApcBMNh1cJahKRpxISvgncr/B0LU+7oD+m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc0BqoFR9qnx08r3V8MNu3AT+YHvB2YeEnF+OrEpDLIJbtLCR7KXH3lb8hmMtxxZ1fYeppWja2ncIpdfY9b+gAfXHMBJq7yKjN+U0n+diyIHCr2gQBy3BdjfLP51t0uyLAZezz51xz2mBOvGxhvvPDeMQ9p+2qS8yn7JLLv9AAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laeuIeCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CF4C4CEE2;
	Sat, 12 Apr 2025 00:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744418476;
	bh=t3orFv6PApcBMNh1cJahKRpxISvgncr/B0LU+7oD+m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laeuIeCZSbXt5kCCpGR6ZsK0aED5GKYU5mdboC46Oc+3aUNRgqR/vppEkxuw57Vie
	 icnAb4Lq+tBWfux/hsiAAsrMZqHxP8l0t8wiusYWvkUPbYsarMoYLRPoPZ1C/oFrKJ
	 DatvA1+I7Zj0GhsB0iWMbNsl4Lis9E8Chr9xjn0YFe1FOnlAtBJmQ3+2HYiZvG0aQE
	 soVhIOYnD4Jr3SAroWErF/RIqNvW0rdg12xVnAtgVNIjk0Xb3hBQOxAawzI6eLkevW
	 oIBvHSEueLLTaoNb8yhzlpIc0ke4EvV987AH2SiMj94gMevFS0Vp7pkKhpNzdnfk9x
	 WXIm0rpQy0kDw==
Date: Sat, 12 Apr 2025 03:41:12 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
	peterhuewe@gmx.de, jgg@ziepe.ca, stuart.yoder@arm.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z_m2qMpcoaoVEWxu@kernel.org>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
 <Z_jw6z_2k0vzqyK_@kernel.org>
 <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>
 <xixqxrt6anogjj25jq3774bmjoeb3jzxgtez7affpewq2cuqib@qnq6cv4g72kp>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xixqxrt6anogjj25jq3774bmjoeb3jzxgtez7affpewq2cuqib@qnq6cv4g72kp>

On Fri, Apr 11, 2025 at 01:04:32PM +0200, Stefano Garzarella wrote:
> On Fri, Apr 11, 2025 at 11:43:24AM +0100, Sudeep Holla wrote:
> > On Fri, Apr 11, 2025 at 01:37:31PM +0300, Jarkko Sakkinen wrote:
> > > On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> > > > For secure partition with multi service, tpm_ffa_crb can access tpm
> > > > service with direct message request v2 interface according to chapter 3.3,
> > > > TPM Service Command Response Buffer Interface Over FF-A specification [0].
> > > >
> > > > This patch reflects this spec to access tpm service over
> > > > FF-A direct message request v2 ABI.
> > > >
> > > > Link: https://developer.arm.com/documentation/den0138/latest/ [0]
> > > 
> > > Sorry, did not notice in the first round:
> > > 
> > > 1. Does not have "[0]" postfix.
> > > 2. Only for lore links:
> > >    https://www.kernel.org/doc/html/v6.12/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org
> > > 
> > 
> > I was about to comment on the presence of link itself but left it to
> > the maintainer. It was part of the first commit log from Stuart. If it
> > is so important that it requires mention in each commit, it better me
> > made part of the file itself to avoid having to mention again and again.
> > Just my opinion, I leave it to the maintainers.
> 
> I agree on this.
> Also, are these links assured to be stable? Could we just mention the title
> and version?

I don't actually care in the end of the day if it is valid forever as
long as it is valid for "reasonable amount of time".

> 
> e.g. "TPM Service Command Response Buffer Interface Over FF-A"
>      Document version: v1.0 BET
> 
> Thanks,
> Stefano
> 

BR, Jarkko

