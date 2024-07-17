Return-Path: <linux-integrity+bounces-3150-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B48933A98
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B63D1C217F3
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC8E17E90F;
	Wed, 17 Jul 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CQORCJnW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD8341C67
	for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210465; cv=none; b=HWGk0I9WbOkU4S6y3QAEx5jEQ8Ww6b+/jOH+bRWJBfxtg7oBKHGsIGwmTqgIFqwGQ8rqS6GmuRrvzzjT8ohhEJGYR8DJ3WxYKegNhN6/dncAUDEMAj68Ve/TukAdEjmZgq/p8J+qnADf5OpR27hKYN8CWBHKQrqxkpWwowbBzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210465; c=relaxed/simple;
	bh=BUgvKjy/bDgc1rPb0S+QGNTxH79dHOZQL5vWrkXMlZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SR7G7GlRAdJkRH6pMSb2W0H8cdZeAuOLSLcMBL/Q9JsrdbeqOBxOCCkzIXA2gnQ/PFNYg89BmYFXRs9jAflaWNXHcCtFf90p1tl8ZSvP140ZVgbebuvRCZBj/XR5neuSPPiwiJ7n1Y2AD/qJoorqTW03+QnuRy7G7nkwcmPmUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CQORCJnW; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPBK51MCSz12fy;
	Wed, 17 Jul 2024 12:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721210457;
	bh=at7t7jmIJKXHqGUzpxK1Wf9lPPVRXO39/lqkd8lIEAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQORCJnW9yxbTKj6mpI9aiBiMIEPVkQXXIIrp+otWT6xL5ADv7F3xuWrpM86OT8mj
	 hxlEfQUIBU/baLZgKf0q2vx1f1bXbKAEwuiDwGfKxEwyKsnS9Qmdbrtw5MgdJ14FOt
	 uuNl6eAnPl03pzjKcgwZGEmBQDmghsV46Q7k+5KU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPBK0119bzLGN;
	Wed, 17 Jul 2024 12:00:52 +0200 (CEST)
Date: Wed, 17 Jul 2024 12:00:49 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Steve Dower <steve.dower@python.org>
Cc: Jeff Xu <jeffxu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240717.AGh2shahc9ee@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
> On 17/07/2024 07:33, Jeff Xu wrote:
> > Consider those cases: I think:
> > a> relying purely on userspace for enforcement does't seem to be
> > effective,  e.g. it is trivial  to call open(), then mmap() it into
> > executable memory.
> 
> If there's a way to do this without running executable code that had to pass
> a previous execveat() check, then yeah, it's not effective (e.g. a Python
> interpreter that *doesn't* enforce execveat() is a trivial way to do it).
> 
> Once arbitrary code is running, all bets are off. So long as all arbitrary
> code is being checked itself, it's allowed to do things that would bypass
> later checks (and it's up to whoever audited it in the first place to
> prevent this by not giving it the special mark that allows it to pass the
> check).

Exactly.  As explained in the patches, one crucial prerequisite is that
the executable code is trusted, and the system must provide integrity
guarantees.  We cannot do anything without that.  This patches series is
a building block to fix a blind spot on Linux systems to be able to
fully control executability.

