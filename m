Return-Path: <linux-integrity+bounces-5809-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADDBA84F9D
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 00:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AF04C0E4A
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273B20F063;
	Thu, 10 Apr 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/BH+ZWr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120720E00C;
	Thu, 10 Apr 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323930; cv=none; b=D2DA8Iq7TJZEbYlvVTCX3vX9qnIf7xmFsYQVo+aB73b6TlSr9SCla7JEYJZeKtFGHPmyf6oGDIRLN8KhYDFPndnFfauBetOGGNqWaPgg9z9Yx85BkoCjLLAPhZhaGgxKnyOp7RTfke6pVzQsrCejJjurjmp8Nu/ZQuzP6+YVfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323930; c=relaxed/simple;
	bh=R3CAUSstVPeamgcofh9+rsIG9AUP6GVwcPBXA/zhxIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+lXezDcBGQjHSFvpMOTpXRQJ8q5mSKea1OIpsZfzmxaXrPJcjbVZrYL2tTI/vd4aa8+sXffbm7ywF7Mr7cQFBoS6P2GLwbG/hHQKx8wwokUpxcIMjAT8784LFGHIypaevFZWd9Z5f1LmqkOcbo7R+C4k5ksAhDg8XBNVwvwxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/BH+ZWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B3BC4CEDD;
	Thu, 10 Apr 2025 22:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744323930;
	bh=R3CAUSstVPeamgcofh9+rsIG9AUP6GVwcPBXA/zhxIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/BH+ZWraLCqLk2X7IGGNS3TC13FrqDgxG9qpkNmxwdLNzEiX6JNde8gMPo1zHQB3
	 OIrkQmq7G3eJSv2LNTHV4ORoLpuhb+U++7q+i9vx9chQ5SujD+tLpblPH2vbFrhChX
	 VITCzYIFaB/dfj784qA35uBWS0pKfaWs6ca+6Axwyr1tLH64w/c5rhHk5IIK5fZnB4
	 GbtC4TjiPdBTKViJuSw9qgsbwrgPKoYwKBoMJgf8WKjFB+ehw1ym22/5f8ZYr1EGyY
	 WE54TAzhjvL1vgDyQBZP7UK3+9ddJgmFr2sJGMyprW1tVimVKI569iaxOZYO8J+IBy
	 hNXXMSX5DlfEQ==
Date: Thu, 10 Apr 2025 15:25:26 -0700
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
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
Message-ID: <202504101524.827B6FE55@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-38-paul@paul-moore.com>
 <202504091603.107B41F4@keescook>
 <CAHC9VhT+yr=Pf=sSpFAO7RbAGejRgQhKPDLppCeOmydfhds5qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT+yr=Pf=sSpFAO7RbAGejRgQhKPDLppCeOmydfhds5qQ@mail.gmail.com>

On Thu, Apr 10, 2025 at 06:04:38PM -0400, Paul Moore wrote:
> On Wed, Apr 9, 2025 at 7:06 PM Kees Cook <kees@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 02:49:52PM -0400, Paul Moore wrote:
> 
> ...
> 
> > > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > > index edf2f4140eaa..981ddb20f48e 100644
> > > --- a/security/lsm_init.c
> > > +++ b/security/lsm_init.c
> > > @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
> > >  static __initdata const char *lsm_order_legacy;
> > >
> > >  /* Ordered list of LSMs to initialize. */
> > > -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> > >  static __initdata struct lsm_info *lsm_exclusive;
> > > +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> >
> > I don't care either way, but why re-order these? Just local reverse
> > xmas-tree?
> 
> Sure?
> 
> Honestly can't say for certain, at this point in the development
> process I had somewhat resigned myself to having a mess of a patchset
> so I figured this was an opportunity to make it look "nice" (er?) in
> my mind, and I suppose at that point that looked better to me ... ?

Understood. I think I ordered the original way because I was hopefully
we'd remove "exclusive" soon, and it felt better to remove it from the
end of a list of variables. *shrug* yay code vibes

-- 
Kees Cook

