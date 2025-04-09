Return-Path: <linux-integrity+bounces-5746-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6EA834C2
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D719E4705
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655AE21CC7D;
	Wed,  9 Apr 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZXcXeGI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BFA21CC7C;
	Wed,  9 Apr 2025 23:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242278; cv=none; b=qHWjUh6GRXg3sxuVndrvwVAF6UsrOFazFB9D+ZF0Twn78RtxeZf3rwxAvY1Zo8Mz5j+J5vQhmSXBcTvAE2NHliFS3oNClzJ/xi8B+IOvpn/9mAnLtMbt53VyM/wBH39MqnHVjThU8KfxQIyi7U5wyRk6IYbwkkpkBr8dhxb69Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242278; c=relaxed/simple;
	bh=Mi6Lz+232Ax1E0orF7QIVfnmQymN6Lpxdl/wmXwetyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDG5G4v0G+sGBstvr2AJbO8/A0PIZJmlmbSrQuijNBYv/cLEm2Q8wO9oe5WVdylrIuq4OYXc0fPHDQx1CWZnGDb4mDFGZq3yec/zMmuwUZeuGqpaEpr3h5eNsNPu9Rg8hd5iCDPD6nqwlEm+lIJjXQTgaL7PyXQyh4ZkSPav19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZXcXeGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F359DC4CEE2;
	Wed,  9 Apr 2025 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242278;
	bh=Mi6Lz+232Ax1E0orF7QIVfnmQymN6Lpxdl/wmXwetyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZXcXeGIWke2BflRJ+ELUqAPYMUKVM5htCTt5GvKVC/o4AGVOKCiwt/huA98dqgTE
	 BaRYQyIjKd0BWvcZIceXFdtIlM5ZQKQ2MFYEE5flB0e8tTLkxurkgM84ZwtYQkzC7B
	 xP6kLF1/NOThQrh6m6e/m5rqOaowViuiI29M/ehUjiG8lO0gyyGGVEPAwc7mGgmUcL
	 HKmN5ixCb/csgdArYH4bMdpanPi2YHckIalHGfxJzpyI4jCJL8Gz57Z6qm1BkDY2bV
	 SCsEaNp2Tn1O7fEVwyEJ3G4CKFs0T7ivHOlNxvjRe0ICzFv9wvK4bgyZQUVv8LKExI
	 2iU3j1hTu39+A==
Date: Wed, 9 Apr 2025 16:44:35 -0700
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
Subject: Re: [RFC PATCH 23/29] apparmor: move initcalls to the LSM framework
Message-ID: <202504091644.81276A2B3@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-54-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-54-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:08PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

