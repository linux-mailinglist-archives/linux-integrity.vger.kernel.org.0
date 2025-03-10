Return-Path: <linux-integrity+bounces-5206-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7026FA596BE
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF0A168395
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC422ACF1;
	Mon, 10 Mar 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XM7YoThf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF022A4D1;
	Mon, 10 Mar 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614725; cv=none; b=a7OcjekyQWZ2mY6EwuIEeSyFAahorQoLC2X3pK7QaltuvWXBVxpjLd+PGFwpkdoAj31qT3c1q42ecutal3+ImR/UyVtk/bSAS22FZYqdbpw6Tl/0trtqgHQELDqxySfCILO9vwCS11gkbGa7CU79ZI77xvLqECvEUMDP13Dot0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614725; c=relaxed/simple;
	bh=1TJ53lJRDTMxywhBHJv4vf86bvPwz8wl/ZKsNYS3z7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIi78SUmG66Gj3jdsGwtv3iZHe+uThX8AidFEOacyVx7wMQ+bRFdx9t+WGGWA6KuYB91JXTWPmoY2jY3r1E78nMOy4C8jFHi+dsnEodvN+biYsaUjbpuOxxD12g1MS5tNvJskMRlQ22IDHqf56FDt60o7Q9qnhrqNFX64nJNb60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XM7YoThf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8825940E0219;
	Mon, 10 Mar 2025 13:52:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JIZtN1r01_MQ; Mon, 10 Mar 2025 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741614717; bh=PJPXCJ4ZG3jPjneSuXnZz7yG6y2P2lIKAdq82tpdR6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XM7YoThfORbKlY2PATOa4swN8Bj5Llw+HngLxblCZL7MDiXzNEHo5Gargue+3cjRP
	 u36WP8heRdLecPrBFVtoacQRwwCDK38c0JumZDMMc0xXHDA/K5lrNtjt6gIaQpc6ri
	 zCC46/S7Yuc0p1VIcJJWkrVATUq8CYkdaHrXBcRikJ5VJ1Tbcxlr2P4PrH45tXPtsI
	 BGLOuz0//iC5OLKyz4nd9wFSzOS3f8ycAs2WpZYVBYj9CWua7viXf2XHM/yJlThQ+Y
	 yYmosbLc3zcDid+EZpKBbKCE/xl5J81vx7AgAkzlIugQihNUNI4CVKkqoU45PqHUYw
	 nXIvXVOxIvLEqwBUjLTcR6xV1q8nfrORBfI/Xu5s/M2T8N1rKnqOPwY+AMwGkIdp91
	 XKNWTdysxRpM1JVMdgaNK2MhGBEWmia/7yw6tU8jpHQUsCzEz9krfBdM52bWP8Yk0H
	 6hLWHzoY0kC4k9IZnA7GrsGJCOyzTTvY/0N3UyOTAqzolD27qD19nQf2iUiLrX6jDh
	 Nsk0RVeCeyqRYDMC1gq9UM1meDsL/MW1lisnmdj2ATdolhEtLGpF6t4d0WPjoYTA3P
	 NsKsDfY8WqSC9nM9esQ13Dlv3OIRvBUeM42aStNB6BFTw1YUgmYxgFs4QK5eNcCGXO
	 qkN8EgTxrQO7LsM7vmICcwEQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97EF440E0214;
	Mon, 10 Mar 2025 13:51:39 +0000 (UTC)
Date: Mon, 10 Mar 2025 14:51:33 +0100
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
Message-ID: <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
 <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>

On Mon, Mar 10, 2025 at 08:27:37AM -0500, Tom Lendacky wrote:
> I don't think anything needs to be checked or printed.

Yes.

> If you want to do anything, just issue a pr_info() with the features value
> (and maybe the platform_cmds value, too). Issuing a pr_warn() here would be
> like issuing a pr_warn() for a new CPUID value that the current kernel
> doesn't know about.

I still don't get the need to print anything. Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

