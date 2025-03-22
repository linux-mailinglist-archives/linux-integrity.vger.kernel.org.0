Return-Path: <linux-integrity+bounces-5382-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87DA6CC9E
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 22:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFC31892B1D
	for <lists+linux-integrity@lfdr.de>; Sat, 22 Mar 2025 21:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B511DED79;
	Sat, 22 Mar 2025 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n63KfsxJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA584522A;
	Sat, 22 Mar 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678702; cv=none; b=gpLUTCZnfyIt6lreaA3ksrXd/n55iY6WhCls8nPRxlZBifAzjVfI1qqEpM4JtoZ5NGOprE1QAVOG0vppp/OH4BaKpC0jK/ug8gNGYjlFCfvMwTdJGRG91u4KQWSC+m7vkoUZPa7MtsgzH73f0DEEFxQ7DjHSfXFJAZTp+YUdzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678702; c=relaxed/simple;
	bh=iXfQco7kSe8vhMA9nzpstt2Zcp6VqukJOUYA5gnQp/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htEAYzqREih1bU+lR/lyoYRVNQLWLaIwyTVppv6XxHFJRAQ6M9birzhh1jsjsrkh8pA0BD1mT6FoX+kn99ph9WavKI82DwoTptxbIq+Mb3NLulpgaylAAkncZBJJxgjsTA3dgWmiX23n2e+v9LF5+3Zufmjon9U5rx1XyWdqTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n63KfsxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9076C4CEDD;
	Sat, 22 Mar 2025 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742678701;
	bh=iXfQco7kSe8vhMA9nzpstt2Zcp6VqukJOUYA5gnQp/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n63KfsxJoK5AsxCVKgpH+MR7lM0aQCdxbL3zoo3tAfiFXXO8yIp6ZrP+Cmka8UzRd
	 OXX13BuQkA3pp4MwCwe2s0C6T7Bi3FQ708Kb+xc3tuREkvsgbgU0mxfzMZUmLAl/ae
	 5BJmqCLyFNoeSCpI4tGJldykmCwIFbXtxL7WRuYLPBkqnuvGhwcgtcpaQh5VQP32Kh
	 h6Sx+kav/D5ZbqpseJc40naSmAh90JfbyWfuTPqgQfbX69jPzTseONEF6buJFqhiOb
	 +rZ1ljIYrd2OEAdk2RbT+kurrb1lC0rBVEdtvaJ8Aokg9F51g2vUWwA0kX8B37eGR0
	 /vQWX/JDlArPA==
Date: Sat, 22 Mar 2025 23:24:57 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: lee joey <joeyli.kernel@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	joeyli <jlee@suse.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
Message-ID: <Z98qqSoZ-ZkVa1qv@kernel.org>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <CAGLnvc_eyLEasc4tKYnYp2c1M+YYRxaoXt2BmJ3kgAec6YTmzg@mail.gmail.com>
 <Z90l26ADmS87tu0k@gardel-login>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z90l26ADmS87tu0k@gardel-login>

On Fri, Mar 21, 2025 at 09:39:55AM +0100, Lennart Poettering wrote:
> On Fr, 21.03.25 15:13, lee joey (joeyli.kernel@gmail.com) wrote:
> 
> > Hi Lennart,
> >
> > Lennart Poettering <mzxreary@0pointer.de> 於 2025年3月20日 週四 下午8:02寫道：
> > >
> > > This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.
> > >
> > > This original commit this reverts creates a strange situation: it
> > > ensures more restrictive behaviour if SecureBoot is off then when it
> > > is on, which is the opposite of what one would expect.
> > >
> > > Typically, one would expect that if SB is off the validation of
> > > resources during the pre-kernel and kernel initialization is less
> > > restrictive, not more restrictive. But this check turned the world on
> > > its head.
> > >
> >
> > SB off means that the chain of trust is broken. Which means that all
> > mechanisms rely on SB are non-secure. Meanwhile, if the integrity of kernel
> > can be guaranteed by other mechanism (e.g. TPM), then mok should not
> > be loaded when SB off.
> 
> Why not? as you say, chain of trust is broken: the kernel itself is
> not immediately integrity protected and neither is the firmware. Hence
> filtering out keys in this case is really pointless.

The way I look at this is that unless there is an actual threat scenario
that we protect against by hiding MOK keys, then we should not hide
those keys.

Since I don't find any threat scenarios my reviewed-by holds. Pointless
checks is security by obfuscation, which is not really security.

BR, Jarkko

