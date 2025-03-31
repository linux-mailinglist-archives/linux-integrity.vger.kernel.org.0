Return-Path: <linux-integrity+bounces-5531-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E142A76CA8
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B12B188CB3E
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388C214A90;
	Mon, 31 Mar 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDUMMWVy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A48157A5A;
	Mon, 31 Mar 2025 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743443312; cv=none; b=kAphWf0yD49Fx7vLBkc84oRkYluJ4QlptvLaYYhjj3ruRJABSiaeuCzRNojEXkd7m4OUQ1/8YlaqaHfDEbc7gXU6PElyxZudsosxyyoPFpBM7lsYGlYoTQFCJnwehWyomxxyzRUNBDK6JMkHiHYJCZDhp6imLH9U+t4Z9+GKzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743443312; c=relaxed/simple;
	bh=UAJ7sdgWjDqfKgktWG8PXeAilNlu4G4TAMpwTEgD9y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKDYcSOw8RKCnglxI6XgZyK3fjv61Q4GILlJskc76CbuXyC8aDWNfL32LGS7ga/ZjP310D66RLH72bhnFGoEZGYXB/0UZ+bau0XuLyzCzd8sNikeUateTjEEPYJ2sO8caSNQkBmbjJp/m6ZyqINTPRQFE4p+BmOXSRTQvIu+ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDUMMWVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41201C4CEE3;
	Mon, 31 Mar 2025 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743443311;
	bh=UAJ7sdgWjDqfKgktWG8PXeAilNlu4G4TAMpwTEgD9y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDUMMWVyqOui83/kSPrg94Z8JwpkYGNE5oFILMkMy+yfZRQVlEex1l/CQgR7aUnOG
	 O0lDLhzOy2lB4oYsQIGFIDanAc5vpNlylvlkpSm91QpfSkNm7prqGPqrBkfeLOiTTD
	 0nFno6uMseaztwyOzlN9Cgua2Y5mi0FSr3UGoyFurcL7GoICC71qJwt4a9NhQcvjgf
	 r750PglYMlqpYlHkXsIWh1b7fE2GvQ47GUBlUNSeL4y4aXMWQqp3GhZYchsQeT1VBN
	 QXp27aSisMv5aJvLuigw646FRKL2RNN4dgHGwH7C4fimf1zsFAX+81GUmF6Wc4vG6U
	 qs8kGrkodDVeA==
Date: Mon, 31 Mar 2025 20:48:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v2] KEYS: Add a list for unreferenced keys
Message-ID: <Z-rVa23rud62nyQN@kernel.org>
References: <20250330111649.13547-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330111649.13547-1-jarkko@kernel.org>

On Sun, Mar 30, 2025 at 02:16:49PM +0300, Jarkko Sakkinen wrote:
> Add an isolated list for unreferenced keys. This splits key deletion as
> separate phase, after the key reaper. This makes the whole process more
> rigid, as these two distinct tasks don't intervene each other.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Rename key_gc_unused_keys as key_gc_graveyard, and re-document the
>   function.
> ---
>  include/linux/key.h      |  1 -
>  security/keys/gc.c       | 27 +++++++--------------------
>  security/keys/internal.h |  1 +
>  security/keys/key.c      |  7 +++++--
>  4 files changed, 13 insertions(+), 23 deletions(-)

kernel-test-bot reported:

https://lore.kernel.org/oe-lkp/202503312252.bef52733-lkp@intel.com/

I.e., v3 is coming.

BR, Jarkko

