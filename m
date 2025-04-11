Return-Path: <linux-integrity+bounces-5817-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C8A8516F
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 04:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDA97AFC10
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8526FA76;
	Fri, 11 Apr 2025 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQ3+HfQ3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372D18052;
	Fri, 11 Apr 2025 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337734; cv=none; b=EEyBrhSK0eyaqa5j0dQ3bmlYxdzZiXg9TL/KseL/fdtJHJpcrP/Yq8PUcsLBfYjqqqHPzZ8AJRfWsoQfAvjqZ0q1qoWEbiBP3rzEaT4Xv9BFAPWP3MNLbR3Omlg8IUEOJ0o23LW5AHHGq5caWh/mkbD5rZSssedJ+uRoj1xkdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337734; c=relaxed/simple;
	bh=Q81vzCLD2na6hGY9543l1oTGYd0RgK1YOobU435O0Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfOdNeaijH/3mMuge74gCpw4S+dZmoEzKf76Fd3N3GKqtkb/N1sMyxxUrJM4Y+3QdONcCqxl84mcDwATyQAnTeQMzgtaxEi+LBkctfFlCNQW5rRbkRfpmqpyEl9QsOQs77VJr3ZP/zqXlQwRs85U/EJvSC5jI32U4kzM/BEhuk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQ3+HfQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07606C4CEDD;
	Fri, 11 Apr 2025 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337734;
	bh=Q81vzCLD2na6hGY9543l1oTGYd0RgK1YOobU435O0Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQ3+HfQ35TtgQjSR0KSA1a0kI49RQM4NInVatUJjNifswKUMA17c0xCld9BrQRorN
	 uIorLslyjGK7I8E7H5rqB25kTAk28rrDHHpBbvtKqO7SVWBDA6uhXK5XjiKgTvGcA1
	 +8DOXB34XwESxnOoH7YStVzJlFSdbfhthsxBX7CD6BJhzuEj5UVtXTZbVnwMwrEM8X
	 C4MKxCxiAvT5zZ8ap40VngsAgPlkhetSrzbPh8ic0vylxZdO/H1WRGPaHCVs7JufCD
	 q8UrYcU2B5vznukiikeiKgD7xB3QBYMCIekG684Chb5EeVjxUUZm88xl4SD6quswHJ
	 +P7o1P4coeRSw==
Date: Thu, 10 Apr 2025 19:15:31 -0700
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
Subject: Re: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some
 cleanup
Message-ID: <202504101913.8F3B5D1@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-39-paul@paul-moore.com>
 <202504091607.0A394D5EF@keescook>
 <CAHC9VhS4nB2xV-zw+=eN2MYaetvCkParammXn1fPGsm-wuHtTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS4nB2xV-zw+=eN2MYaetvCkParammXn1fPGsm-wuHtTw@mail.gmail.com>

On Thu, Apr 10, 2025 at 06:47:12PM -0400, Paul Moore wrote:
> On Wed, Apr 9, 2025 at 7:13 PM Kees Cook <kees@kernel.org> wrote:
> > Better yet, do this whole thing in a initcall after LSMs are loaded, and
> > both can gain __ro_after_init...
> 
> I *really* disliked all the stuff we were having to do during boot,
> and all the redundant global state we were keeping around.  I'll go
> ahead and cache the lsm_read() result local to the function but that's
> probably all I'm going to accept at this point in time.

Oh, for sure. I love that all that can get thrown away. I mean literally
copy/paste what you have in lsm_read() and stick it immediately before
the "lsms are done loading" notifier. Then it only needs to be done
once, it's impossible to race, etc.

-- 
Kees Cook

