Return-Path: <linux-integrity+bounces-5733-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDFA8337E
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AF44474F3
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA292185A0;
	Wed,  9 Apr 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0YtUiZX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CA2116F1;
	Wed,  9 Apr 2025 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744234811; cv=none; b=KVPmPByfJcXU6SWfYRQkgRl78TshkFDG/2GhLHTXs/dxl/zYJW+xG3J7AdTulguJ7b5fB5ttrYiZc0vmO9JiJkIwVD4mkNsNVciPxtWffdUCTM25KR9a6/v5zZvGcKqHG3bBXtDrgZ/S1fbC8SM5kCfn9XGJ3A4xiJERWa1c02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744234811; c=relaxed/simple;
	bh=YADciA5GqP3hwAy68KhXvLolxELThzRD3hrVqiuqbCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEZrce0gx+NNNmHJMN3hh9QPq+Eo4mt0VyfI01m7DVHeck+0fAdfyfcDQdBKZ5rzIYiyZTwa1BrkNdR1OuQpi3127Uhg2Q/X+4qm6fIatCG3HyDG9nI/5XR4tZN+/ezFGjliOBFHI0Bk5YKdlOIlJ3RdyyuuWSuhhhyOwTZTtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0YtUiZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD62C4CEE2;
	Wed,  9 Apr 2025 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744234809;
	bh=YADciA5GqP3hwAy68KhXvLolxELThzRD3hrVqiuqbCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0YtUiZXLdDLzdqPXcrdx6pYF0iEfZTpxDB3Y9/JJXerA9EolrWHWQzCnZdf56jW5
	 j1CytVLUoVNTvIWfKh4m8iQFrlou2MaZ0f5ccbBQdRLuMuyI5ehYyL2JrQFlx7kOKB
	 Q5DhOXT0excYPon767bZxiiFDqHANNERNHhsCcBCjuSaKuWGKD6sKhwYHh0u+bPUza
	 H4qDkY31diS69wYoH74Plk6qUoPIhPd/IrSjmwjA5dVWYEWy9LyaWACUUouQ7R9GJn
	 bfd3K5Nkunl64izjMu9ZPY2l1eJseUINBmDIjE7rM55ysQy0yj9FBCmUb43ZQYLIze
	 6MmGHRBgbE0xw==
Date: Wed, 9 Apr 2025 14:40:06 -0700
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
Subject: Re: [RFC PATCH 05/29] lsm: replace the name field with a pointer to
 the lsm_id struct
Message-ID: <202504091439.802F674E@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-36-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:50PM -0400, Paul Moore wrote:
> Reduce the duplication between the lsm_id struct and the DEFINE_LSM()
> definition by linking the lsm_id struct directly into the individual
> LSM's DEFINE_LSM() instance.
> 
> Linking the lsm_id into the LSM definition also allows us to simplify
> the security_add_hooks() function by removing the code which populates
> the lsm_idlist[] array and moving it into the normal LSM startup code
> where the LSM list is parsed and the individual LSMs are enabled,
> making for a cleaner implementation with less overhead at boot.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Love it! Much cleaner.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

