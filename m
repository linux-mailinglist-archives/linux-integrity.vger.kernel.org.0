Return-Path: <linux-integrity+bounces-3704-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD66986537
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEDF1C23819
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2024 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC196A357;
	Wed, 25 Sep 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhNY2DKW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC375A7B8;
	Wed, 25 Sep 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283220; cv=none; b=OXeMgu4uYsruj2KpnNePUnW6BvyieBjMjDsYn1dpWUn34ycWKUpWbdVcdXkvHm6EZtAmIMzLeo1MyEHcmERmIQ81KTsv29IN0RbEPgX5ONg+81twhXOM4Ix4HHKKEYwtLLdvtOIlqDrakwRHXJKuwmSmpog7jFliVXlQrYvTdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283220; c=relaxed/simple;
	bh=pL8xWD03FhNjqjk7gaMHI8yO4abRLTp3egqJzbLaHeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZryXn/9LAW8P+UcLZLTWeaa/MKVGI+7yZa9vm4oZ9vOXV9mLQS7slQEL+icZHxS/0+tKnEPL6g6rTuHOy0p6aOhcb0fxely6RNKnzmCLsrVhivfx6EDaSEcMtPF4/80VBcNVQHzbad4Bmp/vuPB/KzJK/dlXpSv6NpXUzuEGCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhNY2DKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC3C4CEC9;
	Wed, 25 Sep 2024 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727283220;
	bh=pL8xWD03FhNjqjk7gaMHI8yO4abRLTp3egqJzbLaHeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhNY2DKWQraTWxejG+cGNziDjkC0jXHRqp+wiY1u2rbw8foZf7nKi6sidFqxwFWfI
	 UnnewMlQFLlx2l9P1afdpS72jChBrzm+/HRW1w3UB1i5nR45TsmnAnfuxm4qLXrSrT
	 wlynyxl1yy85KXdsfERCgPYAuP8sbLGGISu44KNR4IBHH8Jszt1ImDDK8jBD3DSUlE
	 UIxzHvJiVSdUXEf3+8qP8fAR+B9LTQ47tQYWH6ePNXXsPbfGUriUrd9VeSOCLnupZW
	 s9cbELKRCtBMJVuY5s1igfdaVPgeAhOsyXkN8ukwSrtxT9nH1/+DO5x27CpD9Cwx54
	 eQSwoLYQC1iSw==
Date: Wed, 25 Sep 2024 16:53:38 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Milan Broz <gmazyland@gmail.com>, Mikulas Patocka <mpatocka@redhat.com>,
	luca.boccassi@gmail.com, dm-devel@lists.linux.dev,
	snitzer@kernel.org, serge@hallyn.com, wufan@linux.microsoft.com,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] dm verity: fallback to platform keyring also if key in
 trusted keyring is rejected
Message-ID: <20240925165338.GA3738787@google.com>
References: <20240922161753.244476-1-luca.boccassi@gmail.com>
 <6b3e0e45-5efe-3032-62b8-75dcd45c879c@redhat.com>
 <D4EMWUMBIM94.3PM88QAV6LG6B@kernel.org>
 <7c40c30a-5154-08eb-d44e-6598087c53e6@redhat.com>
 <D4EU6G0VR6WO.24IWJJQC997Y9@kernel.org>
 <20240924215910.GA1585@sol.localdomain>
 <df791a04-feae-4708-865f-193360b35fad@gmail.com>
 <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4F8UQ7EQ1AH.28Y6BJIM287S1@kernel.org>

On Wed, Sep 25, 2024 at 12:05:59PM +0300, Jarkko Sakkinen wrote:
> On Wed Sep 25, 2024 at 11:03 AM EEST, Milan Broz wrote:
> > >> Doesn't dm-verity have a maintainer?
> >
> > (This reminds me of a nice comment from Neil about "little walled
> > gardens" between MD & DM.  Apparently it applies to other subsystems
> > as well. Sorry, I couldn't resist to mention it :-)
> 
> Np, it's just that last and only time I've ever read anything about
> dm-verity was 2011 article :-)
> 
> I will rephrase question: does dm-verity have a user? ;-)
> 
> BR, Jarkko

Sorry if I was unclear.  dm-verity is widely used, including by all Android and
Chrome OS devices.  But this patch is about dm-verity's in-kernel signature
verification which is an optional sub-feature that is not widely used.  That
sub-feature is apparently difficult to test and not clearly specified, which is
why people seem to be struggling a bit with this patch.

- Eric

