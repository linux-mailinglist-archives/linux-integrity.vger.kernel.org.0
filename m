Return-Path: <linux-integrity+bounces-2558-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D08CC4B3
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD091C2153D
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F4856444;
	Wed, 22 May 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6R5kMkQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D01F17B;
	Wed, 22 May 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394288; cv=none; b=dnXRJdvwczvZ0+lBEqdA870po4h1AqSYS3GOPIKNKzJXvN/ANbPEaORsqhNUtGst9/Ae6RplNhx7W4b0VMS8ZmH7ffT61p3W1lvfTmYAB205pZ8BCp/sSDzplF0f11S1FcDwJY2wPlpdc6SJqirh3//ld6Rit2IbXwQvTWbepJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394288; c=relaxed/simple;
	bh=l7EGjRfKBfRmrw53XUGC/wZrWAByRXWig4B6SkEmGf4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gd98QGbqwQ7QSe46kznAYNDadGL1UQpYYldgDElCGoCbVKoUiUtSaDH9xtTRLV2+ozfnSQyP+MedLZp2iFSCdkCpnP74svW+Z6TOsofBybp6RSSvuoqnHUikj8GNdA3BDb6hPdRm2+99cRqSiwC0+u8zhXmPBVg3O5ZyqXwYbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6R5kMkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED71C2BBFC;
	Wed, 22 May 2024 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716394288;
	bh=l7EGjRfKBfRmrw53XUGC/wZrWAByRXWig4B6SkEmGf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6R5kMkQSiswrusbh5WtXMWujeSVB6+fuCe+VE/7f9IlC7/GncDlvpEIC8xnnHge/
	 MoZrdhubeOJYvkXfk+vefdHg/evft/qMQ4yrEMldcG/28MEfLQsPqu1M1XXckoRfmj
	 gGsaluwrvu6YLqBQoj3+xCwi/dMIPvFRHF306OtpSU9LUqoACTRuY2YkUjRNH1gfNu
	 29BdDO3kn9QmLtEmTJ4SwOQYxhKmhUeEHDRq+N1BzGwJg+aBiYGE0uhP8If33XuJEI
	 zg9qQxpvcfGubd+vFX7l4r7E2fFDRy2LMLwMwpK6ynxPK/fWGkzi88wXD+nLI0kLJa
	 EggLsxXQWV6bg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 19:11:23 +0300
Message-Id: <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vitor Soares" <ivitro@gmail.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
 <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
In-Reply-To: <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>

On Wed May 22, 2024 at 5:58 PM EEST, Vitor Soares wrote:
> I did run with ftrace, but need some more time to go through it.
>
> Here the step I did:
> kernel config:
>   CONFIG_FUNCTION_TRACER
>   CONFIG_FUNCTION_GRAPH_TRACER
>
> ftrace:
>   # set filters
>   echo tpm* > set_ftrace_filter
>
>   # set tracer
>   echo function_graph > current_tracer
>
>   # take the sample
>   echo 1 > tracing_on; time modprobe tpm_tis_spi; echo 0 > tracing_on
>
> regards,
> Vitor Soares

I'm now compiling distro kernel (OpenSUSE) for NUC7 with v6.10 contents.

After I have that setup, I'll develop a perf test either with perf or
bpftrace. I'll come back with the possible CONFIG_* that should be in
place in your kernel. Might take up until next week as I have some
conference stuff to prepare but I try to have stuff ready early next
week.

No need to rush with this as long as possible patches go to rc2 or rc3.
Let's do a proper analysis instead.

In the meantime you could check if you get perf and/or bpftrace to=20
your image that use to boot up your device. Preferably both but
please inform about this.

Fair enough?

BR, Jarkko

