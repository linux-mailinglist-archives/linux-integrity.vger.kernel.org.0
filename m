Return-Path: <linux-integrity+bounces-5740-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0ABA8348E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326CD3B2E81
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154021C187;
	Wed,  9 Apr 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubyQXESR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3466211472;
	Wed,  9 Apr 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241424; cv=none; b=Hei0HrndLl6Dxm29B9SZiHjA79k0c4aLtQ6e9oKaJjjmF452X7EMQhgd/A2Q4o0FZw8AmpuejmfePuQXw19uz1AA0EJwcqM4LOPDcL+nhfHLw6e+rK/jfD/UTBllc/+Xn/wTTVPXz+0S1CGvuOjT0wowNJwbHSu6yhEbDjU1TiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241424; c=relaxed/simple;
	bh=7idoA3f76Itiw68XIYy/s8ASUoYSGdwveEpWj8mY8d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moa2/tr2eeFCapAwTqs/r2yrS2WZW8j3ohxV4UudqpugrG4gbcRFxdtL4YX16FOlZMT9AEHpGYqx/SLbp3fWqND83l6rVNnVJGfrq4NA9I8nvhmhwBa/ZCQ3PsUEJIVhvNsj4kPhZL0uTUW1OyCJRzqXZrFsr+iYXgJVt1pFt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubyQXESR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347ABC4CEE2;
	Wed,  9 Apr 2025 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744241424;
	bh=7idoA3f76Itiw68XIYy/s8ASUoYSGdwveEpWj8mY8d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubyQXESR0J7gD1PtjRQW7g8azPKftypvxuTfCJBVpu1yrCqxQpSFjlPW539UQC1un
	 n6wpAskce2+dC1vmG2Lxthw4cy/ThT6KyoKT76aAsJY6Uc7aJIFz8zEsrY+oIJZNos
	 fAZrkHFb/Yt4o+AQOg9JmK7lwT/IOhpnoewiaoQYuBHX7WM6aC3qwE3sQeMx68udQp
	 YpYzwpFGrFX0f5HeHqdQ8Q+iIBKMzqEUDXNDzemRi4y+YGq5Icj7P3vjgoIlLSDjHg
	 4/O+BZeXDxkyrS4K9ROs8N6EwCi3EvlKUTzkVSHjWzg1VoPGH4INXt+Nwe5U0tr93z
	 rrRylBrBENaHA==
Date: Wed, 9 Apr 2025 16:30:21 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 11/29] lsm: cleanup initialize_lsm() and rename to
 lsm_init_single()
Message-ID: <202504091629.ADEFE53@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-42-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-42-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:56PM -0400, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Yup, better structure for "exit on fail" instead of indented normal code
flow. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

