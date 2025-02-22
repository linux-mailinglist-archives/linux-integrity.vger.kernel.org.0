Return-Path: <linux-integrity+bounces-4974-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC7DA40987
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Feb 2025 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F8E703D35
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Feb 2025 15:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F09219DF61;
	Sat, 22 Feb 2025 15:39:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F593224;
	Sat, 22 Feb 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238781; cv=none; b=jU33IQb4vRRUsulngWPzGgWAnUp4nGtG0gISI8fSiLY3QA2tpxSTS2lgq+TKM9Mi/E1GoGPYbyPQCcNednPt+nQ8baJbsmIwUCAGHxei09JLm3V1fGQ2ppvuGqaJtfsyORsGJbjN2cX+9yyDFH2GT3lSH28vu8CpZWhZUMfOab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238781; c=relaxed/simple;
	bh=7IKYFO/1To/SFLqEc4c9Ck4qc3cN4itGbMN5/EgAeaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/DP0OVnhZ/rT6IrJu8QwkwoAYgE0HGhSiCSKMoLs/YsHLl32idZ6kdvkBQ6HPt5bIs+KWAttkJxWWWvMxfZjFMmz6g7pqPud1Rncfgn0ZDl6UkYOaD2OdOxkLaKYdUN1HNauVhZXiNtYRsjdLisNDTy5c7BZod0F4YvpW2UhS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63D6A152B;
	Sat, 22 Feb 2025 07:39:48 -0800 (PST)
Received: from bogus (unknown [10.57.37.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07CC23F59E;
	Sat, 22 Feb 2025 07:39:27 -0800 (PST)
Date: Sat, 22 Feb 2025 15:39:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Sumit Garg <sumit.garg@linaro.org>,
	linux-integrity@vger.kernel.org, jarkko@kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
Message-ID: <20250222153924.wrjqmaowvcmdlojd@bogus>
References: <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
 <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
 <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com>
 <Z7LGbZsOh_w-HRY2@sumit-X1>
 <5dae96fa-0e54-4274-bcc6-1c20fe846f60@arm.com>
 <Z7iDuwLDA2rFPZK6@sumit-X1>
 <Z7iHaWPyq3KDG7J2@bogus>
 <79dd35d4-147b-4b12-8ce8-1909428d75bd@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79dd35d4-147b-4b12-8ce8-1909428d75bd@arm.com>

On Fri, Feb 21, 2025 at 12:29:03PM -0600, Stuart Yoder wrote:
>
>
> On 2/21/25 8:02 AM, Sudeep Holla wrote:
> > Hi Sumit,
> >
> > On Fri, Feb 21, 2025 at 07:16:35PM +0530, Sumit Garg wrote:
> > > On Mon, Feb 17, 2025 at 10:56:58AM -0600, Stuart Yoder wrote:
> > > >
> > > > I don't see how changing TPM discovery to be via FF-A directly
> > > > would improve maintainability.
> > >
> > > You are considering ACPI at this point but when people want to use this
> > > TPM over FF-A on a platform using DT then it will require corresponding
> > > DT bindings. After that each platform has to enable TPM over FF-A in
> > > their corresponding ACPI/DT. All that won't be needed with auto
> > > discovery over FF-A.
>
> Yes, we would need a new DT binding.
>

Not sure how that would look like, so I will hold off my comments on this
topic. But we really should strive towards auto-discovery as much as possible.

> > I hear you and completely agree. However, someone thought it was a good idea
> > to align with other start methods and duplicate information in the TCG ACPI
> > specification. This is definitely a bad idea, as it may contradict the
> > firmware. All we needed was a simple flag to indicate whether FF-A is the
> > start method.
>
> Do you mean a flag exposed via ACPI?  If you do FF-A based discovery you
> don't even need that.  Everything could be determined via an FF-A
> interface.
>
> > It sounds like a classic case of misalignment between specification authors
> > and practical implementation needs. Instead of a simple flag to indicate FF-A
> > as the start method, duplicating information in the TCG ACPI specification
> > seems unnecessary and potentially problematic—especially if it risks
> > conflicting with firmware behavior.
>
> There is a lot of history, but I think it was simply that ACPI
> advertisement of an FF-A based TPM seemed like the approach
> with the least friction. And Linux is not the only target OS.
>

I guess so. I understand sometimes we need to consider multiple target OS.

> > Anyway, I can't comment on how we ended up here, but this seems to be the reality.
>
> I don't think we are locked into ACPI (or DT) only discovery.
> It's possible that with a modest delta on top of this patch series
> that the tpm_crb driver could also probe based on FF-A.
>
> The CRB over FF-A spec (DEN0138) could be extended in a backwards
> compatible way to expose additional info like the base address of the
> CRB.
>

Ideally, we should manage with dynamic buffers. But I do understand the
reasons why we may need static curve outs. I prefer the ffa client driver
take care of that without needing to build FF-A bindings just for that.

I will wait and see how all these shape up (soon ?)

--
Regards,
Sudeep

