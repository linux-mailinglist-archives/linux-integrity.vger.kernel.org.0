Return-Path: <linux-integrity+bounces-6915-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A93B34F32
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 00:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534EA2A02B5
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69D027A129;
	Mon, 25 Aug 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIGRC61a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD001C84C7;
	Mon, 25 Aug 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162158; cv=none; b=ZjycIY7hYEM/78KB3Iw8DmbLILGlF9IdqqN60xnsoUoaqonpmwRW9HByNn1HnPeM82kHZ6zoRoApR9g+DDbUi44wrYKzD6tlS/ubTa/u4XsYLj6EsL+SD+aFSaAydgReGoF+te9UYD7/SnMId4tMFB4+x3di34qhkaeqJZHeunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162158; c=relaxed/simple;
	bh=OGSJXbBpZ+ZLlbeCJT9NuHPlX2y0kjeKy0z8kAeaXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igtch/xWNAEnjRbds/AqVyXYstYxvJjB9p38rfup/9hQ6URm1hmeRBPMjxHLSW67h7ku524HfM7HM/y+h1XA8tcdyUH2irTkiuUms8PGtI29rWpjtd0N0NqOhdxE+fjV+HB3paU8690uodwq3qetEoCp/seBkI/hY/oF98kgmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIGRC61a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D97C4CEED;
	Mon, 25 Aug 2025 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756162158;
	bh=OGSJXbBpZ+ZLlbeCJT9NuHPlX2y0kjeKy0z8kAeaXiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIGRC61a03P8KfgzGTrFjiViteR7bee4vuBehx1ojAUE8dETV491IgxebmqFaUp/4
	 CkRroKn1ULr/z+DdKwChERBwMQDv/XOUVrTz5Xots30UVZAcZbzaRdbfqQbXIEoC89
	 eZPDWWVpN9DnMMpVaaw/plRsBf69IgJRa0sC3xoO0D4zIEsgPBy85i+i85FTkAALhK
	 gmQVizgilETpDpOFbvqX/GEMwzwGsrXfT6dqxAhhDIZo1AlyJJB3yKDWwScRDpM3Yk
	 Chgep6Y+L7aBQ+pddvsmfrCWqaFZ3745fJZsbYFa58bV1NegmOld+Dpxkx6VmilLi9
	 EXroFnDzpBFUA==
Date: Tue, 26 Aug 2025 01:49:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: Add idle support for the Arm FF-A start method
Message-ID: <aKzoaWeJOh5W0M6J@kernel.org>
References: <20250825205943.1225599-1-stuart.yoder@arm.com>
 <aKzcaaXGQyLfDPrf@kernel.org>
 <9227d35b-40d6-4faf-910d-ee7de9bbc094@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9227d35b-40d6-4faf-910d-ee7de9bbc094@arm.com>

On Mon, Aug 25, 2025 at 05:19:34PM -0500, Stuart Yoder wrote:
> 
> 
> On 8/25/25 4:58 PM, Jarkko Sakkinen wrote:
> > On Mon, Aug 25, 2025 at 03:59:43PM -0500, Stuart Yoder wrote:
> > > According to the CRB over FF-A specification [1], a TPM that implements
> > > the ABI must comply with the TCG PTP specification. This requires support
> > > for the Idle and Ready states.
> > > 
> > > This patch implements CRB control area requests for goIdle and
> > > cmdReady on FF-A based TPMs.
> > > 
> > > The FF-A message used to notify the TPM of CRB updates includes a
> > > locality parameter, which provides a hint to the TPM about which
> > > locality modified the CRB.  This patch adds a locality parameter
> > > to __crb_go_idle() and __crb_cmd_ready() to support this.
> > > 
> > > [1] https://developer.arm.com/documentation/den0138/latest/
> > > 
> > > Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> > 
> > Perhaps a dummy question but is this "QEMU testable"? I know how
> > to bind swtpm to QEMU and make it appear as CRB device on x86-64.
> > 
> > I don't see much testing happening with these ARM CRB patches,
> > and if that works in the first palce  I could probably add
> > a new board target to my BR2_EXTERNAL [1].
> > 
> > I can of course do "negative testing' i.e. that these don't
> > break x86 ;-)
> 
> Unfortunately this is not currently testable on QEMU.  We are using
> the Arm FVP [1], which is also a machine emulator, with the firmware
> stack and an fTPM running in TrustZone.  The firmware, fTPM, etc are
> not all publicly available yet, but everything is based on open
> source projects and the intent is that all the components needed do
> test this on FVP will be available at some point.
> 
> There is nothing fundamental that would prevent this from running
> on QEMU, but just a fair amount of integration and possibly firmware
> work.

OK, it's cool and the patch looks totally fine and I can
"hallucinate it" so:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> 
> [1] https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Arm%20Architecture%20FVPs
> 
> Thanks,
> Stuart

BR, Jarkko

