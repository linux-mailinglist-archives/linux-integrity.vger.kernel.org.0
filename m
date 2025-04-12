Return-Path: <linux-integrity+bounces-5851-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2AA869DD
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 02:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27ED24665E7
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00015481CD;
	Sat, 12 Apr 2025 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebgzrNEr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F445038;
	Sat, 12 Apr 2025 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418377; cv=none; b=a73lU3n2xRfolDlw2dzgPRfQQZ+mDm/20t2xl+tFnK0EZGRSgHChcXBvria5c4OArXJvycRlsd+BZ8l3GcuLEk7wvfXUjD4gR0tAndTvBvxAL4Udc8fR6kU0i1/i8EIS4UPX76vk2d7R8DZJ5E7OxT3f+RmIjhV6gnZGnFde+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418377; c=relaxed/simple;
	bh=v4hJFqSMtA7kGI6ciMIuO7QHbgizDdJEu+vaps+hbho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhsXxunM3nnu5jzsn11VQUX3kETOZva4A1eSwSDZlMIUxDXj4culZkKSKcrc82RMz5k6zLcVFPvrEYupGGROg16wIssNUFuHCqiHAjAa+bPjP7mVtNjM6qIs2QOtsygR6H/tGrrksaRvbD4TXFaAozFiiVL+k8WC/NtXf5qri6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebgzrNEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C07C4CEE2;
	Sat, 12 Apr 2025 00:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744418377;
	bh=v4hJFqSMtA7kGI6ciMIuO7QHbgizDdJEu+vaps+hbho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebgzrNErqdQuct6h1OJW3Msea35Jp0RSewxKe+eM1/cEFSTjCboDizy6ry/NSmD2R
	 C1yDSk2oVekXo7/pZIMglCO3/ywsByOEXg/FHdttirWARSYCNF/NHfgA2hO8sCTVfi
	 oWc8wigWKk9Uid3cGxgiAfEFC1knMXeU1XOTBO5eSJp7CGcFT/t4LmDlkEbyX/EUpk
	 LJW5yaH8ZBhGvdYyGK7+Z2GLaixZMtqcZn7TvoERiIDFQdv51FSwbw933eaICE7HK0
	 oFTsJ7meiH0sauHAefJjbT1zSwxJZj7/8a2JKChiiztL/Afyb7Lnj6r3PEw5CmSmgk
	 hZomEkqA6jLmw==
Date: Sat, 12 Apr 2025 03:39:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z_m2RYPP_DaER2rm@kernel.org>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
 <Z_jw6z_2k0vzqyK_@kernel.org>
 <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-glittering-cerulean-scallop-ddfdaa@sudeepholla>

On Fri, Apr 11, 2025 at 11:43:24AM +0100, Sudeep Holla wrote:
> On Fri, Apr 11, 2025 at 01:37:31PM +0300, Jarkko Sakkinen wrote:
> > On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> > > For secure partition with multi service, tpm_ffa_crb can access tpm
> > > service with direct message request v2 interface according to chapter 3.3,
> > > TPM Service Command Response Buffer Interface Over FF-A specification [0].
> > > 
> > > This patch reflects this spec to access tpm service over
> > > FF-A direct message request v2 ABI.
> > > 
> > > Link: https://developer.arm.com/documentation/den0138/latest/ [0]
> > 
> > Sorry, did not notice in the first round:
> > 
> > 1. Does not have "[0]" postfix.
> > 2. Only for lore links:
> >    https://www.kernel.org/doc/html/v6.12/maintainer/configure-git.html#creating-commit-links-to-lore-kernel-org 
> > 
> 
> I was about to comment on the presence of link itself but left it to
> the maintainer. It was part of the first commit log from Stuart. If it
> is so important that it requires mention in each commit, it better me
> made part of the file itself to avoid having to mention again and again.
> Just my opinion, I leave it to the maintainers.

Sure, this does make sense to me.

> 
> -- 
> Regards,
> Sudeep

BR, Jarkko

