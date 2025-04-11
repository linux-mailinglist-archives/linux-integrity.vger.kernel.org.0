Return-Path: <linux-integrity+bounces-5819-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA1AA85175
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E09464E1B
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC327932A;
	Fri, 11 Apr 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcVuH8tz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4818052;
	Fri, 11 Apr 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337811; cv=none; b=VfKFQCEJnh0yHfdyIqGImIXtw15+KgeYc0dgOzd9zf9WnfrnnMkPd5J0NlC8G6AkEZQ//DkodNgU1CeDER+7O6r7lzpCr0yoq9rfkHDFi6Hb+0kfG5yeIixUuJ7xVkd7rRHXhKmaMe8Di3ISkM6WZt80CJyf8dHZE9XmNj25B2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337811; c=relaxed/simple;
	bh=bghFnB+3UiwUUhDcsJwrD1ZauxsQD1DWjP5vSKEUPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D05eWjniUL8Tjv8P1vWDSfjkWWOn9sxgI3ERLPWW4NISi9fu+34CetbdXXSLdkRXQaRN1A+hifUBcrc6WPNwSe8mEohFgCJrXuVyBT9BtP3oQQhCe1EE14STk/6F63++VRp6zF1iROmphOrNrhGM6aqoOvdmjQBn66UaU1lVwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcVuH8tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C5C4CEE3;
	Fri, 11 Apr 2025 02:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337811;
	bh=bghFnB+3UiwUUhDcsJwrD1ZauxsQD1DWjP5vSKEUPB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcVuH8tzAGlAcgjLxLqlPgzgoyWI6arOZ2GY5XNakl3NQSjvxn+5DtNR/RmcsjsVm
	 wNxqVi2rCj6Z5ksh4mzNF0HJCo4UokfMYtMAjQD7b97xf2qb5ZVsVk6jpvRHc7QlMS
	 LaDzlUXn3lCrmli6i3Ah5Kq4A5EwY7OJ8MZWHlTS5juek5Rac4BbGqrtOLMZI6ueil
	 JD3zEPx1BveDTFQTOKo1ODeKk8yoRojcdeZdV1F1IfB6BRb5OyMjzFbzNR19IZ0Eus
	 TK2bhmNJG3Q7BJfcfYPNbmmNrmbBLpTL9pyLsswHL/4pDIzCQw9JCv90mEGOXppv9l
	 IQyMWjFx1SAZw==
Date: Thu, 10 Apr 2025 19:16:48 -0700
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
Subject: Re: [RFC PATCH 27/29] lsm: consolidate all of the LSM framework
 initcalls
Message-ID: <202504101916.36D042AB50@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-58-paul@paul-moore.com>
 <202504091649.E30A1670@keescook>
 <CAHC9VhSFGfEJ1-f48hdBMgrXwCMcqxi22ze5WZz1N_yPuFdriQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSFGfEJ1-f48hdBMgrXwCMcqxi22ze5WZz1N_yPuFdriQ@mail.gmail.com>

On Thu, Apr 10, 2025 at 09:21:46PM -0400, Paul Moore wrote:
> On Wed, Apr 9, 2025 at 7:52 PM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:50:12PM -0400, Paul Moore wrote:
> > > The LSM framework itself registers a small number of initcalls, this
> > > patch converts these initcalls into the new initcall mechanism.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/inode.c    |  3 +--
> > >  security/lsm.h      |  4 ++++
> > >  security/lsm_init.c | 14 ++++++++++++--
> > >  security/min_addr.c |  5 +++--
> > >  4 files changed, 20 insertions(+), 6 deletions(-)
> 
> ...
> 
> > > @@ -503,7 +508,12 @@ early_initcall(security_initcall_early);
> > >   */
> > >  static int __init security_initcall_core(void)
> > >  {
> > > -     return lsm_initcall(core);
> > > +     int rc_sfs, rc_lsm;
> > > +
> > > +     rc_sfs = securityfs_init();
> > > +     rc_lsm = lsm_initcall(core);
> > > +
> > > +     return (rc_sfs ? rc_sfs : rc_lsm);
> > >  }
> > >  core_initcall(security_initcall_core);
> >
> > Hrm. Given these aren't really _lsm_ hooks, maybe just leave this out. I
> > worry about confusing the lsm inits with the lsm subsystem's core inits.
> 
> I'm not too concerned about that, and I do prefer it this way.

Sounds good to me. And with an eye toward trying to minimize which kinds
of init calls we have in the future, I think it'll just get cleaner over
time.

-- 
Kees Cook

