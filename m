Return-Path: <linux-integrity+bounces-3032-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FDA92944C
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7EBD282DB7
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Jul 2024 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61E113AA31;
	Sat,  6 Jul 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nZqQzXz6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29EC13AD2F
	for <linux-integrity@vger.kernel.org>; Sat,  6 Jul 2024 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277829; cv=none; b=J2llK2lh1q7HgZgMBPFo7fPMq4asZfO13fHJMiQcPZyJTi0wdrUCtKO4Y/NMEn9SP6ENukudpN9dFHwT+DvQjFB92Orfk3HE7rrkTmJOmmqCSO6Z709J0vX2OJgR9pWfMlW0wDLHFjQz2uNU+7oSZjJ+7j4MkDFprbO4eIxtdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277829; c=relaxed/simple;
	bh=JRAKfcNAHQUde9h3yWMHT6AuYZ+lQ3GrpuP+r4Let/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVxQRTErazvGnstVkEJPiUTW0aypg7KUcycI0dawv8eRT453WXHIL7QLjThMrZRyxLbyv6pOstBrI+umGprVvDd+ZRJBELrSHx9Qqr8mD5dwJwfpHTQSaKCgNBgSJhonWkWEEPvjfbIH7SVR9Aqkt+MTgBPslUdiIt3YzCUgNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nZqQzXz6; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WGYPl0wmVzRW8;
	Sat,  6 Jul 2024 16:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720277819;
	bh=JYqPlEHCURGDmGDnXirgQkSo+v4UbE8cDc1PtWenhPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZqQzXz6Sdiu2HqKbkTRFhKQ+G4+nho/IuoMDV2od3dOpgE01KJa8RHRGbeFQ4UF5
	 1UVHdOOYdNUJW0N04FGd7c+oH0seVNi5ErR0GM0NARy8O9hBOlXx9FR6QeLTA/6Q4I
	 4NDRT4xJ0OKYffb0APxKw+rOUMWlUnGqCI+gydV8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WGYPh4xsDzw8B;
	Sat,  6 Jul 2024 16:56:56 +0200 (CEST)
Date: Sat, 6 Jul 2024 16:56:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
Message-ID: <20240706.SieHeiMie8fa@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-3-mic@digikod.net>
 <202407041711.B7CD16B2@keescook>
 <20240705.IeTheequ7Ooj@digikod.net>
 <202407051425.32AF9D2@keescook>
 <D2HYFLLXVYLS.ORASE7L62L3N@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D2HYFLLXVYLS.ORASE7L62L3N@kernel.org>
X-Infomaniak-Routing: alpha

On Sat, Jul 06, 2024 at 01:22:06AM +0300, Jarkko Sakkinen wrote:
> On Sat Jul 6, 2024 at 12:44 AM EEST, Kees Cook wrote:
> > > As explained in the UAPI comments, all parent processes need to be
> > > trusted.  This meeans that their code is trusted, their seccomp filters
> > > are trusted, and that they are patched, if needed, to check file
> > > executability.
> >
> > But we have launchers that apply arbitrary seccomp policy, e.g. minijail
> > on Chrome OS, or even systemd on regular distros. In theory, this should
> > be handled via other ACLs.
> 
> Or a regular web browser? AFAIK seccomp filtering was the tool to make
> secure browser tabs in the first place.

Yes, and that't OK.  Web browsers embedded their own seccomp filters and
they are then as trusted as the browser code.

