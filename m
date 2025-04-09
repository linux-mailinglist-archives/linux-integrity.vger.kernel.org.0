Return-Path: <linux-integrity+bounces-5736-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F916A83455
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A93B324D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 22:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575721CC54;
	Wed,  9 Apr 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYsVpDQk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB56218E92;
	Wed,  9 Apr 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744239606; cv=none; b=pp4JoOIWJc5uhLwC06bbJSFza5LGGfp9PXAmXHnA6vpgL3ifosqo9t3n1OeC5uwDcPiYtPCiNKYbukvyUjnHv3zwYkvezNzcmKG9ZQkEmzQYyrNgzRcgjKy+baAzWOtiNiy/I2zlhZRI1tBcj5km/6VMHMHsiNPhgBBO9EPUg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744239606; c=relaxed/simple;
	bh=NJZCLG/Hj9K/G2MOiCmO1/wGLd+pyeOAStJ7MXlbhnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE9xpKBaUk0Zn2tq5NGJBPRJ/Iab+pPHfarmNWWByX90PYTcVHQ7xgHa01W30MFbVV11A2zQLN/IkaHHmQlVsW0/EfsbpAdx/ehOJTG3R53GwLWN2VGM9E261DgJDX/cYGLupK7HHmzflyW8V436uTEzPWxIwruvVKAcaG3ppag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYsVpDQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD6C4CEE2;
	Wed,  9 Apr 2025 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744239606;
	bh=NJZCLG/Hj9K/G2MOiCmO1/wGLd+pyeOAStJ7MXlbhnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYsVpDQkBfuwauiNmymaerdtUVfOjiYJSAlxnc15tw5fyJDzQbU0hwdNvY7hlBRj4
	 nxe/T+x0qlD7nvyhaQATQbeImqtzVcVMxk5cNF9kVW/5OYdDUJJMK32VmfoisJm51Z
	 +edF0JZ8AhuFSl+Q3lU3eP91xh0368v1rDcBywCiauWdkOWGNf4vmv8dYcPE6Van89
	 o3+8ojc3pjbyEscgIQDkXX0f4dTMaStPc9gh4tvMl8Xd3rbCmb46Je0jx6hhbxzmdY
	 /Jj5CQcb0raku+sZtXpaeQeHb55hIYfxEcnmy5ESN0580F7r8QbektAsYjVxpfZtNs
	 zTbRU1Aobx+DQ==
Date: Wed, 9 Apr 2025 16:00:03 -0700
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
Subject: Re: [RFC PATCH 06/29] lsm: cleanup and normalize the LSM order
 symbols naming
Message-ID: <202504091559.E3096E661@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-37-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-37-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:51PM -0400, Paul Moore wrote:
> One part of a larger effort to cleanup the LSM framework initialization
> code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sure, seems fine. With a commit log listed what was renamed (and what
noun/adjective/verb ordering was chosen):

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

