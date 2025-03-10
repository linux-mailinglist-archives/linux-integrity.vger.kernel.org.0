Return-Path: <linux-integrity+bounces-5209-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB2A596FD
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4305F164D44
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D922A1CD;
	Mon, 10 Mar 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JmVLubMK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918311CBA;
	Mon, 10 Mar 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615393; cv=none; b=sG/bZ2LRFoGuVms+jn+BRXn4LkqhaZVWbkJqgDGIdqcMjyY0GXTfXQQFqJZQg5KiujQeeCLYjwue1VGkPn/H4GTmzy1/k1xI1IF8G3BKEJ+M/URcX4GmS5BkhiIXPDEsApUFGSEvVkFOTu7t1vagMwxFKbD7SK0hB1wDgygL+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615393; c=relaxed/simple;
	bh=DNZg6T1u+Wqljc4IdZQ4tHwKPvEeIeH3U3yFZc4zZRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDdYtjPSP/3+cir3Rc/68/btQEcaBWTcqX78I3qQkrkHgg/0vt8ENaqH3Vs07ePCrmb0kIpau7S3W06ZVt0MoYjAn4iojB/HjX0NKyKUU56y9rToQTdO5nYZ46MfHu3bllJNwUC5Vm6E7QeFz1UekIHoKAG6B2lSpCW3hrDGiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JmVLubMK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F2A8140E0218;
	Mon, 10 Mar 2025 14:03:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ruCR6lNDdq6g; Mon, 10 Mar 2025 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741615386; bh=3DqIsfSi2NV60drpZnrnHzcDMlqChpv9u782Mlba+Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmVLubMKCgXiadBDfvPOuP6Pd9Oe3fYUFT3fNh8YcG+YzP0hyzJLuFonL7u+oMThs
	 SUOF/EdSw04nLX+2pn5vs19PTcRqGq+rEt63V9CjD2Rv9wdhCqb7JW7It3/05Hc808
	 ZLpX/rvw9QxNYftcU6/xKOOvTpy3EvOMyPQ5Z9hY/XXylAj+ZgW/a06yynuT+GBe9D
	 nYEM3ky/GR/UxNWI+swBiGsYhxI8yxpTjJdxie2Vt26N0qx/5X7dhLbPjazogduqHt
	 xmKlFboztJaGehwflEHv1uMZVivHDKEWrK9d+Lv2UfbkOFcc5gigdOVt/3UsxZu1rn
	 AumsBzzQRqZncW7pBbsvUQe/pZ47j26yu8vfnG1VCbnOnWCvezuRz5n+fMNYANjvX8
	 fBZaM+gfjULDvGV/jKo9lDFu9w2wZOV3zTzq/LrScskqwJ6kykr0UtIonKq4o5kQYj
	 2F8uDst0l7DrGRU3JWhz6lsOmqA0IKWvd45Gi0m2YW02ZbQV26XRH6uPxVcMhG1yHa
	 FEF/wrZw5MT0nx+k17AKNocdgtTfd8VOD938hbZ9uaA06pndEFKVbsYhXodWtnc58j
	 oKJ2siueyqgkv7eFtasBD15wsr/Z9SUopgsxo8qhi+RXv+/kJehgLYnbwHBC2GgcZ+
	 OnhjKGcWEe5sRKC9VvkXX4Cc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9BC240E0217;
	Mon, 10 Mar 2025 14:02:47 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:02:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Message-ID: <20250310140246.GKZ87xBg3gUkOwPOZX@fat_crate.local>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
 <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
 <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
 <9c1246c8-6965-b8b6-eab1-df0761a2853a@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c1246c8-6965-b8b6-eab1-df0761a2853a@amd.com>

On Mon, Mar 10, 2025 at 08:56:53AM -0500, Tom Lendacky wrote:
> It isn't needed. It's similar to "device" information/capabilities.
> Maybe pr_debug() then? But I'm also fine with not printing anything.

Yap, nothing it is then.

If the need arises, then we can debate :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

