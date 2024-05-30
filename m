Return-Path: <linux-integrity+bounces-2712-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB98D44F0
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 07:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0498B2836FB
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 05:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA12381C8;
	Thu, 30 May 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhXGdTib"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27A847A;
	Thu, 30 May 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048292; cv=none; b=pbDzCRkCjpZZhCH3yyp1aZLzV4SsJRp5ygtnvBTAF3HZJsJyTDziwKxBVvGWalwDBSDmhHu5J4TQcyClwTocR5rdrX2N570H1r0rtGAL/cvGxLcvcuLO9mgvOAtfkL9kuk8LQXb7QaR4ZlqlfcMEw3HiDooE9bD8LHRKdF1q+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048292; c=relaxed/simple;
	bh=RE4inK9HYK9j9DUP4tuPAf2yjJTVUeaHvDhqFSuDHW8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hnVdpPxNznb8f8DI0SxBWbUTLpDtB7oG+G7fFjxDHe1CElSNIQOSbzllsRhrJWtvm3nMrOfQ7H+TdHdqrQARtG/vgpUuAZP+yqmb0WgrGTVOlGfZcxZuzaKwsEa1p+XhSFdyINyjUvU+fcbTcwIgodW9uM4Iykr3VoENPO571gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhXGdTib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E86AC2BBFC;
	Thu, 30 May 2024 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717048291;
	bh=RE4inK9HYK9j9DUP4tuPAf2yjJTVUeaHvDhqFSuDHW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhXGdTib12y9KsK2WUfE+QIvMiSUn4rTn07uYaUvBm18G3IehM/EALLRk9j6TzTg3
	 z3LZ+UlCmORNsbmPD5eoPDhdG6DONJybPzYLzg1M/4io7sUS9FC0jGMWADAlguMxL1
	 4k0IFOzLCjJFfCysKuCRnkLU1R6rYX+ciz4lX4lp0FIgDjwJGnR8R+t7G2STE8KJFu
	 gVKMYhvoNjR2/83IGvkF/JuvgOnrLhHspFjB163EUonxrV4kSrC4v+nqwRVtnoVxYg
	 vAIJNfD7Jtlfx3sS7g7PizG7ZlerW+IGXHZvjXUr6saTSiAwuXyp88rNdnCfgTbiNc
	 KUBiw3sJlVrmA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 08:51:21 +0300
Message-Id: <D1MQTEW77RY8.36THC7YDK7CZO@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>, "Fan Wu"
 <wufan@linux.microsoft.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <ebiggers@kernel.org>, <axboe@kernel.dk>, <agk@redhat.com>,
 <snitzer@kernel.org>, <mpatocka@redhat.com>, <eparis@redhat.com>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
X-Mailer: aerc 0.17.0
References: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <06bb61dc838eeff63bb5f11cea6d4b53@paul-moore.com>
In-Reply-To: <06bb61dc838eeff63bb5f11cea6d4b53@paul-moore.com>

On Thu May 30, 2024 at 4:44 AM EEST, Paul Moore wrote:
> > +	err =3D security_inode_setintegrity(inode,
> > +					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
> > +					  signature,
> > +					  le32_to_cpu(sig_size));
>
> I like this much better without the explicit inode cast :)

Would be nice btw if that was 'ret' or 'rc' because err is such
a common name for exception handler alike goto-labels... Looks
confusing just because of that :-)

BR, Jarkko

