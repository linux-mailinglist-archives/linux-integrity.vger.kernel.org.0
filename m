Return-Path: <linux-integrity+bounces-4835-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6CA37AD1
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 06:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BC0188CEFA
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 05:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3714D2B7;
	Mon, 17 Feb 2025 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhA4uC29"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBA33997;
	Mon, 17 Feb 2025 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769461; cv=none; b=oITcc+ahJoo30kMn7quw9mhG+aIwaixxx53yJLi3O21j8TTOu9UUJL6hrFu+xzcW4adKOzeKcqDcKTzEZopC7kTlFoU/d7yGfxWkutb8oN+C61Q1exA0VciNo0+P+Zg0KwjEQw0HkzKMiBmKhjPfDqM8JJKDofXNveZT8rOdZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769461; c=relaxed/simple;
	bh=NxHshVEGtai8izhnlNmmjHiPQb35e6Sbsgg4tw41tWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4Uhscj80jduh/HrQSGbQzuB3bLNFl9g8iZmK4hHmjR9y+O/rx2XCXwvMCwJ2O/rhuddbqwZtMTc/9g15cfuc65lehQs02KO1+ckRZu2Xd70x77YQaIKEmhQjfq+HXfC3uCr9NnZwHO1Q7cNBU/zg0+5wbkdRCnrGKqaQSNrVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhA4uC29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF55C4CED1;
	Mon, 17 Feb 2025 05:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739769461;
	bh=NxHshVEGtai8izhnlNmmjHiPQb35e6Sbsgg4tw41tWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhA4uC2991BXSMwh8z19VigmniGO2bbIQ+zZYKiksm65/U26bGd2+vADAFKYfHSu2
	 pP7jOqSOfaNj3kL6Za1qT4BdYW0dBhZoVx0mmIdgZDt8T7FHMtEYYVzOOVm4XD5qBE
	 J4Asfa5zE+G8UOWKvthfVBpJ05+MvENrctLmsHsoTRVxnYjkJ0AztILi/mUuTPfEUo
	 R0FcjRKh2rCBewxxPCuy1h/myLI7WpKEThWV9sinMe8oDx+wgq8UXSBReXsjhjrHak
	 ffeeGGVuhorRY4GRCLPJLSX3sbC2dK/7XRFeH5IuNKynkCsXi/itX7NIlyp8mpyvFr
	 o8f5TUF75QN7w==
Date: Mon, 17 Feb 2025 10:47:33 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, linux-integrity@vger.kernel.org,
	jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] Add support for the TPM FF-A start method
Message-ID: <Z7LGbZsOh_w-HRY2@sumit-X1>
References: <20250210232227.97761-1-stuart.yoder@arm.com>
 <CAFA6WYM7K4_toy5_n1arW4po4SOX0R9624rCgO=_MvcMeySwUA@mail.gmail.com>
 <4bb3cefa-b843-45ca-82c5-d96b13454baa@arm.com>
 <CAFA6WYM3UA9+TE8L2U5Qd8FZfaGZnbba=QzWU7fEu3LKQVm-tw@mail.gmail.com>
 <fdaa9a58-790f-4839-8db7-1b9a81eb8edf@arm.com>
 <CAFA6WYM0ANqc--ScYtJFRjOsCCjzO3NX46=F5V=rza_6Q-Q96g@mail.gmail.com>
 <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e142afd2-38ec-4640-b9be-cb414bccc807@arm.com>

On Thu, Feb 13, 2025 at 09:19:58AM -0600, Stuart Yoder wrote:
> 
> 
> On 2/12/25 11:31 PM, Sumit Garg wrote:
> > + Rob
> > 
> > On Thu, 13 Feb 2025 at 03:25, Stuart Yoder <stuart.yoder@arm.com> wrote:
> > > 
> > > 
> > > 
> > > On 2/12/25 1:39 AM, Sumit Garg wrote:
> > > > On Tue, 11 Feb 2025 at 21:39, Stuart Yoder <stuart.yoder@arm.com> wrote:
> > > > > 
> > > > > Hi Sumit,
> > > > > 
> > > > > On 2/11/25 12:45 AM, Sumit Garg wrote:
> > > > > > + Jens
> > > > > > 
> > > > > > Hi Stuart,
> > > > > > 
> > > > > > On Tue, 11 Feb 2025 at 04:52, Stuart Yoder <stuart.yoder@arm.com> wrote:
> > > > > > > 
> > > > > > > These patches add support for the CRB FF-A start method defined
> > > > > > > in the TCG ACPI specification v1.4 and the FF-A ABI defined
> > > > > > > in the Arm TPM Service CRB over FF-A (DEN0138) specification.
> > > > > > > (https://developer.arm.com/documentation/den0138/latest/)
> > > > > > 
> > > > > > Nice to have a specification standardizing interface to TPM
> > > > > > managed/implemented by the firmware. Care to add corresponding kernel
> > > > > > documentation under Documentation/security/tpm/.
> > > > > 
> > > > > Yes, I can add some documentation there.
> > > > > 
> > > > > > BTW, we already have drivers/char/tpm/tpm_ftpm_tee.c, so do you see
> > > > > > possibilities for an abstraction layer on top of communication channel
> > > > > > based on either FF-A or TEE or platform bus?
> > > > > 
> > > > > I think the CRB and OP-TEE based messaging approaches for interacting
> > > > > with a TZ-based TPM are fundamentally different and I don't see how
> > > > > to harmonize them through some abstraction.
> > > > > 
> > > > > The OP-TEE TPM protocol copies the TPM command into a temp shared memory
> > > > > buffer and sends a message to the TPM referencing that buffer.
> > > > > 
> > > > > The CRB uses a permanently shared memory carve-out that in addition
> > > > > to the command/response data has other fields for locality control,
> > > > > command control, status, TPM idle, etc. The only 'message' needed is
> > > > > something to signal 'start'.  Any OS that is FF-A aware and has a
> > > > > CRB driver can simply add a new start method, which is what this
> > > > > patch series does.
> > > > 
> > > > Okay, I see how the CRB driver is closely tied to the ACPI based
> > > > systems.
> > > 
> > > The CRB driver is currently probed based on ACPI, but it fundamentally
> > > doesn't have to be.  If there was a DT binding for CRB-based
> > > TPMs the different start methods would be defined there and the
> > > CRB driver could support that.
> > > 
> > 
> > Can't we rather enable the CRB driver itself probed based on FF-A bus
> > and rather dynamically discover the shared memory buffer via FF-A
> > instead? AFAIU, FF-A provides you with a discovery framework for
> > firmware bits.
> 
> Yes, you could do this. But, then the TPM CRB drivers in all the
> ACPI-based OSes (Linux, Windows) and hypervisors need to be
> taught this new method of discovery. Adding new start methods is
> reasonably straightforward, but changing the basic discovery
> mechanism is a much bigger change.

We will be teaching every other OS or hypervisor about FF-A
communication regardless. So it's rather about if we want to do it
properly leveraging auto discovery mechanisms supported by FF-A or not.

> 
> > But if we still want to overload ACPI or DT with the
> > discoverable firmware bits then it seems like an overkill here.
> 
> I think it would make sense to do ACPI based discovery or FF-A
> based discovery, but doing both I think would be overkill.  For
> ease of OS integration ACPI is the way to go.  And, potentially
> device tree in the future.

Encoding firmware bits in ACPI/DT can be seen as an easy upstream path
in the shorter run. But when the ACPI/DT becomes overloaded with
information that has to be passed from firmware to the OS rather than
purely describing hardware to the OS, it's ABI maintainability becomes
complex. We are already dealing with DT ABI compatibility challenges
especially the forward compatibility, so let's not make it even worse
with firmware information that can be discovered automatically.

The other benefit of auto discovery is that platform enablement becomes
really smooth. Once the firmware starts supporting a particular feature
like TPM over FF-A then the OS can discover and support it.

-Sumit

