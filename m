Return-Path: <linux-integrity+bounces-7495-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03222BECEA5
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 13:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D18FA4E9A92
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29DC1A0BE0;
	Sat, 18 Oct 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW2IQCE1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D61643B;
	Sat, 18 Oct 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786937; cv=none; b=RNcmWvCMiH05PeS0Zg6RZzDkGj4K1HlHuUrQqXPIVVDub9RvsVNVvi5cdFpRIR6ZrIALOfWCsghvnUWfHuen7CfVwzLQfOxIk0wmZqnXMDTht5MgveXriecjA7tZYvnPdKsyc+YN02Kt9/fsHOghoNvlBZ+vbH9x5loTDDATYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786937; c=relaxed/simple;
	bh=UQxc6ViLFlVFF78U6caoncGViFhdBPvdRP4aRqaYZZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggJPur7x7nWxJty5dzrBLjm6cwiB+ML88bYqJvflJYCXKdFDxBSPsrleOpq2xx/hq7RSE9utB+heFWccfdLm2cD533NabLd8uvT4+u4+dXwmTtivCHXtAWjidqapTN84YrpYGM5l5WRx5wPVBUqw9vhD2ZNBr5amQSfXg9Tm22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW2IQCE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08E7C4CEF8;
	Sat, 18 Oct 2025 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786937;
	bh=UQxc6ViLFlVFF78U6caoncGViFhdBPvdRP4aRqaYZZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gW2IQCE17ZSMXILNO0KY9j3ov9YF7prSlKeEn16guhf3rqqXtyCWZ4W8k679RbtNd
	 NInj34dATy561e2LzlHipBX3CNhB9q1jL7G73wgm3R/rKsQHW0iArdWgokS5EuXqp3
	 3GmKch5gEsINE4T9Ej3XnUacQpJKddWPnmVTGgy5Z/2u3H53T7a/ZMf8V/QnbHcN9C
	 iNl5bkFeE9S0ZXFN6FyZ26u+lWKk3zSvKVJbnRl8qLEe/dzwcc/xE6Y4p3ccjBDLV2
	 JsdgR2AeRQA7KSJeyvuJsULrFDQivDqmGpqQdN0CxCpqk4//yde9910eqE5QoTngpX
	 whhl0mfguxtWg==
Date: Sat, 18 Oct 2025 14:28:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Add idle support for the Arm FF-A start method
Message-ID: <aPN59bwcUrieMACf@kernel.org>
References: <20250825205943.1225599-1-stuart.yoder@arm.com>
 <aKzcaaXGQyLfDPrf@kernel.org>
 <9227d35b-40d6-4faf-910d-ee7de9bbc094@arm.com>
 <aKzoaWeJOh5W0M6J@kernel.org>
 <91d8e71a-7013-43d7-9d04-9a191fed50e9@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d8e71a-7013-43d7-9d04-9a191fed50e9@arm.com>

On Wed, Oct 15, 2025 at 05:22:53PM -0500, Stuart Yoder wrote:
> 
> 
> On 8/25/25 5:49 PM, Jarkko Sakkinen wrote:
> > On Mon, Aug 25, 2025 at 05:19:34PM -0500, Stuart Yoder wrote:
> > > 
> > > 
> > > On 8/25/25 4:58 PM, Jarkko Sakkinen wrote:
> > > > On Mon, Aug 25, 2025 at 03:59:43PM -0500, Stuart Yoder wrote:
> > > > > According to the CRB over FF-A specification [1], a TPM that implements
> > > > > the ABI must comply with the TCG PTP specification. This requires support
> > > > > for the Idle and Ready states.
> > > > > 
> > > > > This patch implements CRB control area requests for goIdle and
> > > > > cmdReady on FF-A based TPMs.
> > > > > 
> > > > > The FF-A message used to notify the TPM of CRB updates includes a
> > > > > locality parameter, which provides a hint to the TPM about which
> > > > > locality modified the CRB.  This patch adds a locality parameter
> > > > > to __crb_go_idle() and __crb_cmd_ready() to support this.
> > > > > 
> > > > > [1] https://developer.arm.com/documentation/den0138/latest/
> > > > > 
> > > > > Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> > > > 
> > > > Perhaps a dummy question but is this "QEMU testable"? I know how
> > > > to bind swtpm to QEMU and make it appear as CRB device on x86-64.
> > > > 
> > > > I don't see much testing happening with these ARM CRB patches,
> > > > and if that works in the first palce  I could probably add
> > > > a new board target to my BR2_EXTERNAL [1].
> > > > 
> > > > I can of course do "negative testing' i.e. that these don't
> > > > break x86 ;-)
> > > 
> > > Unfortunately this is not currently testable on QEMU.  We are using
> > > the Arm FVP [1], which is also a machine emulator, with the firmware
> > > stack and an fTPM running in TrustZone.  The firmware, fTPM, etc are
> > > not all publicly available yet, but everything is based on open
> > > source projects and the intent is that all the components needed do
> > > test this on FVP will be available at some point.
> > > 
> > > There is nothing fundamental that would prevent this from running
> > > on QEMU, but just a fair amount of integration and possibly firmware
> > > work.
> > 
> > OK, it's cool and the patch looks totally fine and I can
> > "hallucinate it" so:
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Hi Jarkko,
> 
> It looks like this patch did not make it into 6.18.  I wanted to make
> sure it didn't get lost.  Will it be queued up for 6.19?

Totally my fault, sorry. There was a bit shuffling with TCG_TPM2_HMAC and
some other things, and this one slipped over :-/

Since it is non-intrusive despite not a bug fix,  I think I can put out
-rc2 pull request to Linus, and see if he sees this acceptable.

> 
> Thanks,
> Stuart

BR, Jarkko

