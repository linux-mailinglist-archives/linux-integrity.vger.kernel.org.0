Return-Path: <linux-integrity+bounces-3802-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB7699C1A1
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 09:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2308C1F21CDB
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A014A629;
	Mon, 14 Oct 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="MjihJLQ7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F714A615
	for <linux-integrity@vger.kernel.org>; Mon, 14 Oct 2024 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891606; cv=none; b=M12XAdGFOmuTHpopHl7LJQmbs5TKh/aka9MCfVClcV+SQz9ibg7ZaMtjM+BBTb2qnz99EJjRbTH917LTQfD+10A7xdFEF4aUTfO7K/NNs5Cyy55e2A5DFydXo7tp1SqvAlT3KtkXjRZZalGUA8ZhS4LxWvTr5T7FIQNjBDHMGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891606; c=relaxed/simple;
	bh=0ONNd/EutDTP9Itu+LrZh1WTLUTA4HIYQ4CmxGnKeEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/Ms4Ly9unq4o6VNCYjI3qNAY9KO2LOBZQN4gsYikuy0cV5Nseu54JNdI2gRMlyaLEZAY6pAaWtxKy+t3Ce7UkPPembxLZJt2Ej8Q4BnxlIYPR+nEAFDmCgCXAnMKgThC4pdohl3Eclj+CZU0NW/VKCWtNkiHdFmNzVakWyReVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=MjihJLQ7; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRpzJ4rxpz6bW;
	Mon, 14 Oct 2024 09:39:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728891596;
	bh=IK21ziFHzeZTWewfpsK1ouln6YyY8LRReKv9clTkIaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjihJLQ7ZELqcL/G/6u3K+i36UXfZ4tGFKcErgGdZmintyw0hzKJDN1KBSwjxEY22
	 tuqaaFGJ1p9oOkqQRv2T1BPWhR5ARSffT78kVukyLG0h2AW+h6+dyIbLXadW4iuYzw
	 XQXfFasFeo2Y6UcTuWQ8sHMu0Ev3sW8kffRMZHr8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRpzH4DLDzKsD;
	Mon, 14 Oct 2024 09:39:55 +0200 (CEST)
Date: Mon, 14 Oct 2024 09:39:52 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v20 1/6] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20241014.ke5eeKoo6doh@digikod.net>
References: <20241011184422.977903-1-mic@digikod.net>
 <20241011184422.977903-2-mic@digikod.net>
 <20241013030416.GA1056921@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241013030416.GA1056921@mail.hallyn.com>
X-Infomaniak-Routing: alpha

On Sat, Oct 12, 2024 at 10:04:16PM -0500, Serge E. Hallyn wrote:
> On Fri, Oct 11, 2024 at 08:44:17PM +0200, Mickaël Salaün wrote:
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> 
> Apologies for both bikeshedding and missing earlier discussions.
> 
> But AT_CHECK sounds quite generic.  How about AT_EXEC_CHECK, or
> AT_CHECK_EXEC_CREDS?  (I would suggest just AT_CHECK_CREDS since
> it's for use in execveat(2), but as it's an AT_ flag, it's
> probably worth being more precise).

As Amir pointed out, we need at least to use the AT_EXECVE_CHECK_
prefix, and I agree with the AT_EXECVE_CHECK name because it's about
checking the whole execve request, not sepcifically a "creds" part.

