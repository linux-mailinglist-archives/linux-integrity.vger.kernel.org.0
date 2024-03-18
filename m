Return-Path: <linux-integrity+bounces-1783-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A687ED70
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 17:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B18B214E7
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7852F8F;
	Mon, 18 Mar 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRyWFEYO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B24537E2
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779126; cv=none; b=pzxqnrNkq2037ya6MLAGVHFce9Fo5dNa1qno2OcBr4HQORuMqK/RxWnypQSFKbfWdplmqvFfs2ZhGQn0jTvS2ECdUDyNp2yFFsFJwoPkbKriWZhkNx3kpPgJY2DFw/8QEHDDI86VpjqeDai1TVNI4t1mPlSC7eaB+O0UvKLBCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779126; c=relaxed/simple;
	bh=cQ6ynPF/ANRl8Aqj5QPN4FYwoanps0hB8lcDdRovAJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHEytpVcRSh2Ivx4QbVMk0ffL6SnL81xLcXcCdmtlB0afuTEwcOi77g/onAyCBUMgqHQs5jqbUYVQDxxfjxwVebneYNt+OcGyFc44DslOxQHXrqI2rUwl9dLwVmGJl++3nUOnGMz6PKP89zsCRY0JiJ3B9oBJMis5/ZbdpU8/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRyWFEYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7468EC433F1;
	Mon, 18 Mar 2024 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710779126;
	bh=cQ6ynPF/ANRl8Aqj5QPN4FYwoanps0hB8lcDdRovAJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRyWFEYOwMMn+JuceBLkKupKYqLa2R9KJPWkuNKtKcqTsDbzeQQlnKdFjz5UD1rk9
	 hqtztkxogQ+O9DS8ZKxiJwY55fuR414Yy1pwf0IdyYv0ZUACYomRR1ydlX36JWFDZ7
	 Q0xJOc0lMpW14cZ2TX0F5MTLGUFIYXaRnUcZhxWbg/kJ8OIpBw5uk+3URAAVGqTKlF
	 Swf3W5lPM1cWuZ656ALokeGv5xOeNetp+6oo89tn4G9agTcibgWniCwcg5InQlLB6F
	 8oKmhtMn6fr5XKhrSeKFyQj3Zkjyqaq7krk+8XT50czebL/riqayNpIalU5Wqh6PFd
	 r8kacY7/i4ruw==
Date: Mon, 18 Mar 2024 09:25:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
	Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
	Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Vitaly Chikunov <vt@altlinux.org>,
	Ken Goldman <kgold@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Bruno Meneguele <bmeneg@redhat.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	George Wilson <gcwilson@linux.ibm.com>,
	Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>,
	Frank Sorenson <sorenson@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <20240318162523.GA1185@sol.localdomain>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>

On Mon, Mar 18, 2024 at 05:07:24PM +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.
> 
> This patch includes all acks received so far.
> 
> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Vitaly Chikunov <vt@altlinux.org>
> Acked-by: Ken Goldman <kgold@linux.ibm.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Acked-by: Bruno Meneguele <bmeneg@redhat.com>
> Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: George Wilson <gcwilson@linux.ibm.com>
> Acked-by: Tergel Myanganbayar <tergelmyanganbayar2024@u.northwestern.edu>
> Acked-by: André Draszik <git@andred.net>
> Acked-by: Frank Sorenson <sorenson@redhat.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Acked-by: Eric Biggers <ebiggers@google.com>

I misread this and thought you were just trying to change the license of the
library, in which case you wouldn't need my ack.  It's worth emphasizing in the
subject line and first paragraph that you're trying to change the whole
project's license.

- Eric

