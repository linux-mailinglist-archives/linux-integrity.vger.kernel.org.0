Return-Path: <linux-integrity+bounces-6927-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBFB371B0
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FE77B15A3
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AC2DA74A;
	Tue, 26 Aug 2025 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="JzF5NGct"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E22746A
	for <linux-integrity@vger.kernel.org>; Tue, 26 Aug 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756230466; cv=none; b=tNR0SdmHWJ9TXL/7XkEURm20VcnqZ2ORcXap8YzAdYIIzYslRehThFEU32wauL8GLTbFbvi0dmOXK+BQThtc2SfA7TJjFWd9QTDqmf95i2wU+GrJyI+Q2EmaNks7XnFWIgu/koIFeuMe69oICRNJPCpo7XKg5p0Rae9Uo2v2Jos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756230466; c=relaxed/simple;
	bh=sFRIu8Am2jIzlH44DxKpMs4s+3Je74MeBIKW4BmL/IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLAzWaw32YQKBDB49PoxTQpgC/MuQ0/LiQVmkKGGqENJWKHVyjcSFJQxkWiB1doqx8fVwVGZr+oU5DC7EwDce7ZsosLyqnBsklO80t8ap6vPQGCQN/6DNx+OSjnJKi6R5XcxTwgvrwCP8U8WBIuTvt8R1702BOQc/07WsPdMXsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=JzF5NGct; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cBFVZ6s0YzsK9;
	Tue, 26 Aug 2025 19:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1756230454;
	bh=z/NUjKchTuxG8z+dgzPttXLaScBMzIR69Ax8SOVBUjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzF5NGctdlftcM1YJwG89Bu/YKhZpb2TC6flRXGDGvSAhwm7E9aTjbdy+MTPNR5Cf
	 wcuscZ0FG7I5fwGhBzF51K2dbWsjCtZ6LzO0l8iqWC0cfaoHkystxzh+QdA6e4M5Yo
	 5iaVkRVK9xXxIBIjDfYAAvTB0Ap23RVRVZB8hzag=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cBFVW0pJ9z4V8;
	Tue, 26 Aug 2025 19:47:31 +0200 (CEST)
Date: Tue, 26 Aug 2025 19:47:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Robert Waite <rowait@microsoft.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <20250826.iewie7Et5aiw@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
 <20250826123041.GB1603531@mit.edu>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826123041.GB1603531@mit.edu>
X-Infomaniak-Routing: alpha

On Tue, Aug 26, 2025 at 08:30:41AM -0400, Theodore Ts'o wrote:
> Is there a single, unified design and requirements document that
> describes the threat model, and what you are trying to achieve with
> AT_EXECVE_CHECK and O_DENY_WRITE?  I've been looking at the cover
> letters for AT_EXECVE_CHECK and O_DENY_WRITE, and the documentation
> that has landed for AT_EXECVE_CHECK and it really doesn't describe
> what *are* the checks that AT_EXECVE_CHECK is trying to achieve:
> 
>    "The AT_EXECVE_CHECK execveat(2) flag, and the
>    SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
>    securebits are intended for script interpreters and dynamic linkers
>    to enforce a consistent execution security policy handled by the
>    kernel."

From the documentation:

  Passing the AT_EXECVE_CHECK flag to execveat(2) only performs a check
  on a regular file and returns 0 if execution of this file would be
  allowed, ignoring the file format and then the related interpreter
  dependencies (e.g. ELF libraries, script’s shebang).

> 
> Um, what security policy?

Whether the file is allowed to be executed.  This includes file
permission, mount point option, ACL, LSM policies...

> What checks?

Executability checks?

> What is a sample exploit
> which is blocked by AT_EXECVE_CHECK?

Executing/interpreting any data: sh script.txt

> 
> And then on top of it, why can't you do these checks by modifying the
> script interpreters?

The script interpreter requires modification to use AT_EXECVE_CHECK.

There is no other way for user space to reliably check executability of
files (taking into account all enforced security
policies/configurations).

