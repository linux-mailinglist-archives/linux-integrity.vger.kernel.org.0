Return-Path: <linux-integrity+bounces-5840-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26164A85B58
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 13:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538EE9C488E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECA2278E7D;
	Fri, 11 Apr 2025 11:09:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608191DE3C7;
	Fri, 11 Apr 2025 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369777; cv=none; b=QGrU7thuNkfzHkmhTfTPdph9bV+0j6TghsjQU8QiCuXJRotpzAUEkB0qvJk4udzlQ+GEzWYFPARG3uDxAB+O32yE8q3Vk6tEv9gdJVeZn3rqt6o+bBLcay5MvPomeLdZ/uA+lODtIxO2tUG+pBWKNJBI+lHzYx99Bh+wvwc6fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369777; c=relaxed/simple;
	bh=D+fBmBfn1P0qRfWB1WN7ViUxBwmSFwE0xeJe+RH410k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2ktoRS7D6EojG8Oov0x4J2V0AVzHuoinudyLd9zJpcTzYwMPWGgTmoT+2TRzDWZYHZcM9NM50dyxRxR3C5CTpCManJYFnf5haXx8BHcaxSO2GqrLqAsLJ92lfc3/8lYZSX8Wvo/MFJvBjaLMj/SO5ADc3p9ONtByX4ssFnM//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F19E106F;
	Fri, 11 Apr 2025 04:09:34 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB3C3F694;
	Fri, 11 Apr 2025 04:09:32 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:09:30 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, peterhuewe@gmx.de,
	jgg@ziepe.ca, stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <20250411-imaginary-indigo-mayfly-d5a400@sudeepholla>
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
> Also, are these links assured to be stable?

The latest version as used above should be stable(we got some assurance
on that by the team maintaining those)

> Could we just mention the title and version?
> 
> e.g. "TPM Service Command Response Buffer Interface Over FF-A"
>      Document version: v1.0 BET
> 

Yes that must suffice especially if you are referring to a specific version
of the spec as latest will always point to the latest version.

-- 
Regards,
Sudeep

