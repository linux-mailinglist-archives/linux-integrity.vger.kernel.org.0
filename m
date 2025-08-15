Return-Path: <linux-integrity+bounces-6866-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1131B2856E
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5567A4D56
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAFA257859;
	Fri, 15 Aug 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw3/uWez"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683D24DD11;
	Fri, 15 Aug 2025 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280686; cv=none; b=InGDNydJ9aJ5s/BUhypmI1eZ100nkcsWtEBylr0C4dQw0k0D2AZcQ9bDeAJWel88Ne0Bsbb+6Hw1LbJ+UHhB4mTzye8C3I8x/O5j2ChcQ43RZO0YsdGnSBS5GzL0Sp8upvWY1Wb7D/V6/F5ufhVFxCQWXmuCRQtW7h5DyyYxkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280686; c=relaxed/simple;
	bh=3hVu27Zupu98kxe36FCGzKn0QhZ3NlHERGCP3SmLo70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it1arwsIE4eU+qsQUhTbcYcNZRGhEYt/YI5hR/BWfXUEdKdW4/3NPqpdeB1QDgScBPDC7qQjE+KXHq83npkZ27exDPTDK3zBq7TN43zH6Kar5/x5Ysy6QrA7Ni/Csu5GDUk4Cz0z7rNQHJEne1kWhykMsfHLGTQUx50DvCA+BZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw3/uWez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D04C4CEEB;
	Fri, 15 Aug 2025 17:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755280686;
	bh=3hVu27Zupu98kxe36FCGzKn0QhZ3NlHERGCP3SmLo70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dw3/uWezA9w7GMsE8jW9iG0jj81CHLIA3t/eK8gKQrB05AdWv3t31dqES/3vaY7Q6
	 VK+gWZbeMUItT7tWtTJD1AvVEUTr3XL6ausV3z18jiXtroAuP0NFpOv2KXLdw0nwmY
	 LqIKFATCPETCyGhueD1EnQanbWWRXC7ZJjOoI/UmvjsWYxyBhNNWdd5NNKlONeSycA
	 bfg2NjXjoUqGu5FfRqqoH+wjM9mnxm5xyKeFLd26K9YLNMF/s1m48pdpfIFlqi/w9P
	 YRMHsN4sAwT1NHNZClqklbcZ5QnIcLzQYzTw50LPbF5hN9w7tVPSsJqoJrSf1fu+FS
	 X3jmhH7vnrV/A==
Date: Fri, 15 Aug 2025 20:58:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chris Fenner <cfenn@google.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aJ91KX97WVOQ3nVk@kernel.org>
References: <20250814162252.3504279-1-cfenn@google.com>
 <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
 <aJ9fy_sO6tza9qLF@iki.fi>
 <CAMigqh2=Kmnv_rrT-gBtESSXtnMrxU=VJdrYE6_9NGhKBN+ZrA@mail.gmail.com>
 <aJ9ySGv0JZ0DiNgf@kernel.org>
 <aJ9z4OlwvFdEA2Q_@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJ9z4OlwvFdEA2Q_@kernel.org>

On Fri, Aug 15, 2025 at 08:52:35PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 15, 2025 at 08:45:48PM +0300, Jarkko Sakkinen wrote:
> > On Fri, Aug 15, 2025 at 10:06:36AM -0700, Chris Fenner wrote:
> > > On Fri, Aug 15, 2025 at 9:27 AM Jarkko Sakkinen <jarkko.sakkinen@iki.fi> wrote:
> > > 
> > > > I'll with shoot another proposal. Let's delete null primary creation
> > > > code and add a parameter 'tpm.integrity_handle', which will refers to
> > > > persistent primary handle:
> > > 
> > > I'm not yet sure I understand which handle you mean, or what you're
> > > proposing to do with it. Could you elaborate?
> > 
> > Primary key persistent handle.
> > 
> > In tpm2_start_auth_session() there's
> > 
> > 	/* salt key handle */
> > 	tpm_buf_append_u32(&buf, null_key);
> > 
> > Which would become
> > 
> > 	/* salt key handle */
> > 	tpm_buf_append_u32(&buf, integrity_handle);
> > 
> > And in beginning of exported functions from tpm2-sessions.c:
> > 
> > 	if (!integrity_handle)
> > 		return 0;
> > 
> > And delete from same file:
> > 
> > 	1. tpm2_create_*()
> > 	2. tpm2_load_null()
> > 
> > That way the feature makes sense and does not disturb the user who don't
> > want it as PCRs and random numbers will be integrity proteced agains an
> > unambiguous key that can be certified.
> 
> E.g., for example that will unquestionably harden IMA exactly for the
> same reasons why some user space software might to choose to use HMAC
> based integrity protection.
> 
> At data center, there's guards and guns but for appliences, but there
> is also the market appliances, home server products etc. They are not
> mobile but neither they are protected in the same as e.g., a data
> center is.
> 
> This is not to admit that right now the feature is no good to anyone
> but in a selected set of use cases with this modification it would
> make e.g., IMA's security *worse* than it would be with the feature
> enabled.

One product example would be "blockchain node as a box" i.e., it carries
momentary value inside. I could imagine this type of products exist or
to be created (especially given proof-of-stake blockchains).

In such product, you don't have much to measure but you wan to take all
of the security that you have to harden the protection of that small
amount of data.

BR, Jarkko

