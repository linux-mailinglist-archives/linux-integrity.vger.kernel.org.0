Return-Path: <linux-integrity+bounces-4305-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C99E5DA4
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 18:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE8B165B28
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108D226EC9;
	Thu,  5 Dec 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FZXEghZN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5549B225796;
	Thu,  5 Dec 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420914; cv=none; b=UqEV0n7fg9AJvRYy72r/iYpgd63hoGOuNVXTAHVDCWNcMObPEOXmA7ubwBLdcfHTWBfwk0p0rha1+15PyPjSJCNpJTC0UqDTlfr8jZ7Vkq7yA/JtH2QCjXR767bcFvLV1HFvfQFoKSiADQ0I6fHJNn8VR/GwaRDaTgy0rT6qEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420914; c=relaxed/simple;
	bh=91fE6MXNHvHfTG8mh42aiRrYkN/U3yVGkH6W8pDMPgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvog0xULo013BtzV1N7eYoWAx5Ro2ypqWjyvl6EyIVscKmIN/dqJ8lw4RvhomJdo5e9UIE5Q+Je0E42J6NXlVp3lCHZ9vif88FXNES3wlIZahzCsfCunD4tKByz+cQuvzp09FEj8PJT6YBu8JmSFFk8eUq0bv9UcRFfK7cK8Fz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FZXEghZN; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y421P2SvXzsD9;
	Thu,  5 Dec 2024 18:48:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1733420905;
	bh=hi8ArFvU5BqDG4ro/0Wsd51wN4Jn9lVCsIY7xuWXd78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZXEghZNBtryfZ3By/HdncgyfMjMG6/IaRrt2aBigqjpfhCNpFUd6XYRogo64//U5
	 eJf58QkPnXAFRQyM9ddrm1fZlwvD0JGAUPqJiD1Htq5+dY2jtQaTdOg30X2zv7/z8h
	 +mwr1hKKufgXPBvsjArOPk5itV9+b7tcdWmXjwKA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y421H5gBtzG4R;
	Thu,  5 Dec 2024 18:48:19 +0100 (CET)
Date: Thu, 5 Dec 2024 18:48:17 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v22 0/8] Script execution control (was O_MAYEXEC)
Message-ID: <20241205.ohw5cohsee8A@digikod.net>
References: <20241205160925.230119-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205160925.230119-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Thu, Dec 05, 2024 at 05:09:17PM +0100, Mickaël Salaün wrote:
> Hi,
> 
> The goal of this patch series is to be able to ensure that direct file
> execution (e.g. ./script.sh) and indirect file execution (e.g. sh
> script.sh) lead to the same result, especially from a security point of
> view.
> 
> The main changes from the previous version are the IMA patch to properly
> log access check requests with audit, removal of audit change, an
> extended documentation for tailored distros, a rebase on v6.13-rc1, and
> some minor cosmetic changes.
> 
> The current status is summarized in this article:
> https://lwn.net/Articles/982085/
> I also gave a talk at LPC last month:
> https://lpc.events/event/18/contributions/1692/
> And here is a proof of concept for Python (for now, for the previous
> version: v19): https://github.com/zooba/spython/pull/12
> 
> Kees, would you like to take this series in your tree?

> 
> Previous versions
> -----------------
> 

v21: https://lore.kernel.org/r/20241112191858.162021-1-mic@digikod.net

> v20: https://lore.kernel.org/r/20241011184422.977903-1-mic@digikod.net
> v19: https://lore.kernel.org/r/20240704190137.696169-1-mic@digikod.net
> v18: https://lore.kernel.org/r/20220104155024.48023-1-mic@digikod.net
> v17: https://lore.kernel.org/r/20211115185304.198460-1-mic@digikod.net
> v16: https://lore.kernel.org/r/20211110190626.257017-1-mic@digikod.net
> v15: https://lore.kernel.org/r/20211012192410.2356090-1-mic@digikod.net
> v14: https://lore.kernel.org/r/20211008104840.1733385-1-mic@digikod.net
> v13: https://lore.kernel.org/r/20211007182321.872075-1-mic@digikod.net
> v12: https://lore.kernel.org/r/20201203173118.379271-1-mic@digikod.net
> v11: https://lore.kernel.org/r/20201019164932.1430614-1-mic@digikod.net
> v10: https://lore.kernel.org/r/20200924153228.387737-1-mic@digikod.net
> v9: https://lore.kernel.org/r/20200910164612.114215-1-mic@digikod.net
> v8: https://lore.kernel.org/r/20200908075956.1069018-1-mic@digikod.net
> v7: https://lore.kernel.org/r/20200723171227.446711-1-mic@digikod.net
> v6: https://lore.kernel.org/r/20200714181638.45751-1-mic@digikod.net
> v5: https://lore.kernel.org/r/20200505153156.925111-1-mic@digikod.net
> v4: https://lore.kernel.org/r/20200430132320.699508-1-mic@digikod.net
> v3: https://lore.kernel.org/r/20200428175129.634352-1-mic@digikod.net
> v2: https://lore.kernel.org/r/20190906152455.22757-1-mic@digikod.net
> v1: https://lore.kernel.org/r/20181212081712.32347-1-mic@digikod.net

