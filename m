Return-Path: <linux-integrity+bounces-5820-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F18A8517C
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6881A1B602B2
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6C279349;
	Fri, 11 Apr 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz62DnNd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3C27932A;
	Fri, 11 Apr 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337882; cv=none; b=DQhgcLQV4x2iET62b5t7s71T9TBnQBsG07dPy6BbnecDuljIV6FNDyF1wwEPvYRDDwiffPcaEmCWHvucaVThz6M661pMToj7ZxHHHxJah2BbTLjAaj17VlV7EVcAzH4Ft81oUpyn7M5/2eLEhRbXOSX9DA9OWk2/i43KRC2djHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337882; c=relaxed/simple;
	bh=BGecqx1mEgufHpsp8IW5Vzf7qbYBG812SzXhEL/Lbm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbqDnW2uoqJUzLM3MLbk/GY6Zy1D395zaEWeaA3PxnDz9i4WZ2BnQ+Db74Eo0izsn82POhGwJMkEb6RtzjwLBEcxDzOKAlczNt43JKVouZ0uohkG7aRMA6I+LJUqKTeITNEGHTerFUfUhJ9x6IIafBLEmcddZFgdh9qt3UGqDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz62DnNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98082C4CEDD;
	Fri, 11 Apr 2025 02:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337881;
	bh=BGecqx1mEgufHpsp8IW5Vzf7qbYBG812SzXhEL/Lbm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zz62DnNdhWI8tmzVgoFhbjYVbqSF3jCSKTz6ZXBRpbhvpRiU/RUwXmyUdGaJYnlOr
	 kBttX8YFvCxgNlayJ+RpaUQzlnYngPAHqOCkqmCn2SDb1AO5ngS/pHUANC2Mn68ur+
	 WJ2InJsIWdDPu/rZZ++12iw1/zIIJshA1Hd1AhtIn9TKMp3LUBDZHY3dM896r3qwNJ
	 pUei/mWMyA0Xh+aJGkWK8mdRk7JfM00KKJVEP9G00yieSWouER18cZ3ncCPB5kHSsF
	 X6LxeAKjhgPwUkOS+7EOpntOvU1/JmgjrxQwuNWcjRi5HFzfKtSfxD6E0T73/Lj7qi
	 Gc0mI6nguriHA==
Date: Thu, 10 Apr 2025 19:17:58 -0700
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
Subject: Re: [RFC PATCH 09/29] lsm: cleanup and normalize the LSM enabled
 functions
Message-ID: <202504101917.65ECCC47@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-40-paul@paul-moore.com>
 <202504091656.21EEF38DCA@keescook>
 <CAHC9VhT7M4GWLJ0Kx0nkCAC+kirQ0LKqBVaqps9z-0kOc77iDw@mail.gmail.com>
 <CAHC9VhRT_dBRusxjsD+mwAXG=bg7MmwA3L_3W9J3GgtoODqZWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRT_dBRusxjsD+mwAXG=bg7MmwA3L_3W9J3GgtoODqZWQ@mail.gmail.com>

On Thu, Apr 10, 2025 at 10:14:52PM -0400, Paul Moore wrote:
> On Thu, Apr 10, 2025 at 9:50 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Apr 9, 2025 at 8:11 PM Kees Cook <kees@kernel.org> wrote:
> > > On Wed, Apr 09, 2025 at 02:49:54PM -0400, Paul Moore wrote:
> 
> ...
> 
> > > The simple renamings looks fine, but would be nicer if they got split
> > > out.
> >
> > I can look into doing that, let me try the squashing first.
> 
> ... and I pulled out the enabled/disable setter/getter functions into
> their own patch.

Awesome. My future review eyes thank you! :)

-- 
Kees Cook

