Return-Path: <linux-integrity+bounces-5742-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6CAA834AA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290774428A7
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C2B21B185;
	Wed,  9 Apr 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuuHm7Fm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92ED19ADA4;
	Wed,  9 Apr 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242010; cv=none; b=uDKWChsuCwwhHHUlp1srBBdcyKZRJSFdUKRui4+tafQeTO1mhGd6nSjuYNKBVla6/B5/9EULTAwru4beaSB60R7fnHa9fUybrXiA8zxwxs0qnr3m+8KEEZxlWdeIDCFRxL8TyfqyEIljrNz4dvqJkuPFUrdgvqcbdbIbuVLwxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242010; c=relaxed/simple;
	bh=KPPetVqruaeg/vGvu4gxDKwhc2bpjHK4Dim3u9kuobg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6d3X3XD+euYkLvCStVvqBD5bIgHSQ3xnpkBwaEZt/v9bKC8yj5o+AO0KkL200AQ2Y4O9AT56PLrVqrXAX4leUwzYkMDMs54DFnkQV/lXE5doZ5cICtOKH6hLU3qclrcMVP7ULz9Q3SS2OJnzQ/AGy3ffJ/cCSXDtO/duVoPHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuuHm7Fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B22C4AF0B;
	Wed,  9 Apr 2025 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242009;
	bh=KPPetVqruaeg/vGvu4gxDKwhc2bpjHK4Dim3u9kuobg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuuHm7FmpnvV68LCd7yLPCWgPy6mmdSkR0CqWzCzOko6LMCXDafPjQBB011pfEo1Q
	 n6RICeSApdkMAfJMmOpBtUumVhhFTORd7AN+QiZIJ0Okn5GEZ3fd0ZRLprQQjOOFOr
	 9mWfFnQzdx8+2EHlOsn9u+y6mwl3mk8u06kerPUf3pdgkiuBFn+bq248ewicGO4nU8
	 Hg/9ifHHl7AcEfouvgsmtuEnrfcT6/JYC20Ls2i3W8nY4BioPAOYBZq3gvtXqj2wtq
	 bHJ9mc6hhCp6QKRqFNUhy+SbR0b5yEJAFwL7HkOz9+dpnrDnOzCixitnxErR2odtE9
	 nTYeRLpXoNC1A==
Date: Wed, 9 Apr 2025 16:40:06 -0700
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
Subject: Re: [RFC PATCH 19/29] ipe: move initcalls to the LSM framework
Message-ID: <202504091640.0E5816304@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-50-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-50-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:04PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

