Return-Path: <linux-integrity+bounces-2414-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E428C5E3A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 02:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D96C2826ED
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 00:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAE1E491;
	Wed, 15 May 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnX3SWAP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E114293;
	Wed, 15 May 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715731225; cv=none; b=P24KLDQX7MNpXnypgNhLApQIpBg2VMl+AHLm7MVnFgXT6mtlsrrAGCuzgHTm9+PxBb3lixFDHM8cTnhIk21eNq16f/VZZ/0ckeD9Cjnz2VVs4tcGXArrm1XoRPBlAxSMdygGRFG/lnzgJTZO+OhOzawVGHDtmAES8HEjoMuvbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715731225; c=relaxed/simple;
	bh=n99Bql3gIIzuLFoZdV/TGsEOQMKJhGqv7H0JLXS0xew=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G+pr0691QBwUHxBJLweyorz2rZrC/+6mQdD+j9BUjoFC2J0bLFO7te1C+RLzBMo1PKw0wQuGDL0iYL9qMBIoykO3MfRRrEelp3J49TGJzfT8lfgdmfSVotIei9JDn0PN+KASjQd+4RGZvQWDm+QLPMns+3Rm6SGtxcp41yySxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnX3SWAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CBDC2BD10;
	Wed, 15 May 2024 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715731224;
	bh=n99Bql3gIIzuLFoZdV/TGsEOQMKJhGqv7H0JLXS0xew=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=AnX3SWAP1Ne73UHmgXZTV/afLAPSwGkDNp6kB61zZE+pwif2Sx4t0auwqM6QhLuVy
	 ikKZq5icIvinn/wCvD22B0iotNfkoq9RMhX+JvwbGKoeUHUjjq2h86KX1EZE7E2vhm
	 8BJY0WfDz9IQBVQ5LR/CcM+4/5H+mmHC7bml1DFVSMjl4DHxhD/5y+hAEqimNk60qF
	 /y035kEW5xsgOcCwLNpn/HLgb5OZ1b/g//VADxbuKnQVcqFb3R/JcO5TOygIn5eTlp
	 iL7btC0DbUIhNtYciA5N9Y6FDXSX0DbApLSwf4M8iMiS7PLOlgYonUNUzBxiQMf4v0
	 OPptqFewaXf7g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 May 2024 03:00:20 +0300
Message-Id: <D19RYHHHEZXS.2QI6ZNR60X0A5@kernel.org>
Cc: <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 2/2] KEYS: implement derived keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Ignat Korchagin"
 <ignat@cloudflare.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503221634.44274-1-ignat@cloudflare.com>
 <20240503221634.44274-3-ignat@cloudflare.com>
 <D19QW70177QG.2YC9XL0FT7VME@kernel.org>
 <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>
In-Reply-To: <D19RM0OV7YUW.1ZEI72XQUREMQ@kernel.org>

On Wed May 15, 2024 at 2:44 AM EEST, Jarkko Sakkinen wrote:
> >
> > What is "key length"? Please refer the exact attribute.
> >
> > >
> > > User id is mixed, so different users get different keys even when exe=
cuting the
> >
> > First of all it would be more clear to just s/User id/UID/
> >
> > And make obvious whether we are talking about ruid or euid and how
> > this interacts with GIDs.
> >
> > I'll look at the code change next round if the commit message starts
> > making any sense.
>
> Right and neither UIDs and GIDs are applicable for key derivation for
> quite obvious reasons. So NAK for that too.
>
> You can make them point out unlimited different identities...

Please drop the whole stateless system argument from the next patch
set version. It looks to me that only it has been considered and we
don't even have definition what it is. I think it only distorts
and confuses and is totally app specific in the end of the day.

This looks more like a tool for identity theft than a key in its
current state. This could never ever exist in a "stateful system"
and this mainline code base so would be quite irresponsible to ever
take this.

There's only one attribute I'm aware that you could ever possibly
use for key derivation: mm_struct->exe_file.

BR, Jarkko

