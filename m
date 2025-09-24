Return-Path: <linux-integrity+bounces-7260-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8749B98040
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 03:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199A81B2086B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 01:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B01F9EC0;
	Wed, 24 Sep 2025 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV6aPG8P"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BEC8CE;
	Wed, 24 Sep 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677828; cv=none; b=HMfmqQzbSAqEmmG+zCtJZLp+3vkBwpo1J8QyejW1odZSuPQhv84E6CKBXQiFtLa3vSx4ypZOpZDuLPBaw/GKRMGZTqg8uxlneYSHotevUlyI74JqJ9fXruJgeMwx1muKHABGrLfCPw/gIs7FjD3y2ZUw1iAE861yWdk3E5sqwYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677828; c=relaxed/simple;
	bh=hvLAB/QBp2gG4Y8hgS0uNAwylfRncGTfMDX7xOzfAIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZOgTDK4BcoOoYun2SDi+VZx4701rpGJeZKIgV+nYxQiXFKRF05tiQ7PxcTA//0e6++U2WOv6KK2I9TwrTfmopnJqzYwHoCf3Vv+rnUFTHo5iMXGZZA2G1fvFdcEQ167xH/lziqO1t3W1YQrT8LwLg+ATBkd17kBihBCdNpsfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV6aPG8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4077BC4CEF5;
	Wed, 24 Sep 2025 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758677827;
	bh=hvLAB/QBp2gG4Y8hgS0uNAwylfRncGTfMDX7xOzfAIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV6aPG8PKc2tMO/sf2ONf6XZR8R5Z+WHPJ2Q2JZ8pG3Kf5aOYxg9So/ZUWbGQQixO
	 D5MNnclwoVem2dZvhr995VWlrGwv14zjHi6lLHdsLJVDZ39dTU7B3IvHX6DviXrUeH
	 YAr0DiLcE5h37TKWzruKfz9jCys9n02ykH76vLN+FuL9/53Tk2HWZkVqQhgG4nQc2d
	 dazoBhfG0DSa0e11wukvJIeiGVDE3su7JZSVv7aCuvPE9K0Duxo3is6mGyBgl/TSec
	 ekRzRTmr2H9ifl7m29+/h+vYce9hyIOVC7d/nwdtL7itcK9SFIn5RYpp+6jQgnZRQn
	 +EMEHc9+Y/v6Q==
Date: Wed, 24 Sep 2025 04:37:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 0/3] tpm: robust stack allocations
Message-ID: <aNNLQMOm_zz-3vOG@kernel.org>
References: <20250923170744.1749132-1-jarkko@kernel.org>
 <aNNKAIbzki-a121p@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNNKAIbzki-a121p@kernel.org>

On Wed, Sep 24, 2025 at 04:31:48AM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 23, 2025 at 08:07:41PM +0300, Jarkko Sakkinen wrote:
> > 1. These are previous changes to tpm_buf, which make stack allocations
> >    much more feasible than previously.
> > 2. Migrate low-hanging fruit to use stack allocations.
> > 3. Re-orchestrate tpm_get_random().
> > 
> > Jarkko Sakkinen (3):
> >   tpm: Make TPM buffer allocations more robust
> >   tpm: Use TPM_MIN_BUF_SIZE in driver commands
> >   tpm orchestrate tpm_get_random() in the function
> 
> I'm quite soon sending v12 because I randomly noticed a resource
> over-cosumption bug. which could be theoretically triggered e.g.
> via interposing a bus or a faulty device: tpm2_get_pcr_allocation()
> does not have a hard limit for the number of PCR banks.
> 
> The fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=tpm-buf&id=3d92f14c204d09babadaa0b7c7a82c40d11696d0

[should have "ret = -E2BIG; goto out;". The reason for that bug is that
 I just rebased the patch from tip to the bottom of the series, which
 caused some merge conflicts.]

BR, Jarkko

