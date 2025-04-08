Return-Path: <linux-integrity+bounces-5674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A93A811AB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4B1886A1F
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B223E34F;
	Tue,  8 Apr 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlgNlfZJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773C23E344;
	Tue,  8 Apr 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128112; cv=none; b=asEHmus3RTRoondLeZIK3aVDeFPrKvlO0ZJw6uU6gi1ngBHPOahviwAeVL6zeOzoICdZrOFsurW7xhhfBJGcSxyqq+2WB2C5k6Vir6GMX8s/tbLYh5i7Y/BRpwkK92+QvFiv1+mou2fnyf8BeK2ag4ahbA7tMAUQfhfj+cfmJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128112; c=relaxed/simple;
	bh=fzSIaOi+TnDTPZf9iJ7o18mcS68/4052jghV1Xly1b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyhVjpAQ0ZfcCdlAM0y6nPTWpU+ZrJ4Z/sUw5O/DVSerKAKDPY+v32ybBwYOr2I/eNt/nPKp4lJDjtST0gcT+5a3x90MvVGG/1bVnlNtgx22C7Y81cYcj+pLBgOHFKyaPHD3uq02UBWN8AR8tMF6nX/uVtCldu04dAllFAA5om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlgNlfZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25839C4CEE5;
	Tue,  8 Apr 2025 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744128111;
	bh=fzSIaOi+TnDTPZf9iJ7o18mcS68/4052jghV1Xly1b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlgNlfZJ/8lohUwsyRWA70QzUQKmRfkXbxgC9ORP/pTOfPOzN4j/kIGZ8tyUmtvIp
	 ZrFRL1Qw+YBjUxS7b2BGiTl9pZTN83EVZRY8dQLfEXXx70qv7t0OO0irHbj4t/1vOB
	 +4FKJQQbHZjDenWsUloQtXOrIprF6tddPHQv7Ga0/GWlfMmnpnp8bZlAb4dpss1opR
	 mR11gnYaISRpfKwGcsiL/1e+oFmd+H/vtExeeKwzHOFaaAjB/cYuC4C3T7Xv3Qe5UP
	 RvEKheTGlexTJA403d2I8qvAUSFGTCQofZ3E8k/5J0++J7On3MGkSQNxM/SAwwDFsT
	 0/XqJcUjRvzNw==
Date: Tue, 8 Apr 2025 19:01:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v8] KEYS: Add a list for unreferenced keys
Message-ID: <Z_VIaxyGoRlg3vyo@kernel.org>
References: <20250407125801.40194-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407125801.40194-1-jarkko@kernel.org>

On Mon, Apr 07, 2025 at 03:58:01PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Add an isolated list of unreferenced keys to be queued for deletion, and
> try to pin the keys in the garbage collector before processing anything.
> Skip unpinnable keys.
> 
> Use this list for blocking the reaping process during the teardown:
> 
> 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
>    list is flushed. This the very last step in `key_put()`.
> 2. `key_put()` reaches zero. This will mark key as busy for the garbage
>    collector.
> 3. `key_garbage_collector()` will try to increase refcount, which won't go
>    above zero. Whenever this happens, the key will be skipped.
> 
> Cc: stable@vger.kernel.org # v6.1+
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

This version is my master branch now:

https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

For the time being not in next.

BR, Jarkko

