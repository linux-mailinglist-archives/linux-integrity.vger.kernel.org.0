Return-Path: <linux-integrity+bounces-2715-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7CD8D4546
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B913028375A
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 06:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7788514373A;
	Thu, 30 May 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4GcpmJv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C5DDA0;
	Thu, 30 May 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717049255; cv=none; b=EsN6BWTlBM1+RiFBoFtLWBLfVs5WXDHLsK4BjVHGL1CWOyXMjyH4MUPgQbrCKtUKsn8SS/LGU6NB5vf6bh1BGJrlGZwC1xXp7r7wCWtE2f6u7n0c6tLZZasYGaUXU1K4JvmPRFbQOCNFw9r7vlXsZQQDejBusscL+ox7Xk8tWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717049255; c=relaxed/simple;
	bh=HaYt2U+ot0lKNo1rF40NupQyMsZE36x8bEub+oPge68=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YkZDzgewZvFaMSWBw1JkmDnpSjiJEEBT/csUtkXc1h0qssRlp28LSCcaxzQdCOZc0S0JKwzhBIa/DBhJPCg1AzNB4ztek238s8ihFN/xd13JQOUwxMCZDw2ncMUfuCC8lOIoSfwZ4+OL8gYWMyq+sjYQ1P6ipjNwUgkXPsJDDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4GcpmJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DA5C2BBFC;
	Thu, 30 May 2024 06:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717049254;
	bh=HaYt2U+ot0lKNo1rF40NupQyMsZE36x8bEub+oPge68=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=X4GcpmJvZMxWDq6XgjQ+3KSTg09v76vgBVwMhHmZP4Nt66NUtlSyl3oHkCN+hw06W
	 b4itoI0WYrjUXTKQiemhkWpnGsgW8X0Q6pG9lgN55PVktBGlQwzZFGjbWM379Ios7i
	 rCw9NjP260KHm1E8qo8ucC1JdZQgRS5fc7FRCg4RHMDwwrpOIFFZUUFwjn8H3U4lvZ
	 nEm5BRe67LkkPwku7fd5GgDeFSlkhd9niY9AyXd0muMdgKwJitk23OALnKQV2/zZKT
	 2995hxrL5vWBkdAlNGEGAOIK1/VDVv4dxjSrzqE5k6RUe7TKc+mAzfnrPmQtDkKnu3
	 7zjcAmr+cMtWQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 May 2024 09:07:23 +0300
Message-Id: <D1MR5P0W2DSW.MI93JIMHBXKI@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "Fan Wu"
 <wufan@linux.microsoft.com>, <corbet@lwn.net>, <zohar@linux.ibm.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <tytso@mit.edu>,
 <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@kernel.org>,
 <mpatocka@redhat.com>, <eparis@redhat.com>, <linux-doc@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <fsverity@lists.linux.dev>, <linux-block@vger.kernel.org>,
 <dm-devel@lists.linux.dev>, <audit@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <06bb61dc838eeff63bb5f11cea6d4b53@paul-moore.com>
 <D1MQTEW77RY8.36THC7YDK7CZO@kernel.org>
 <20240530060120.GB29189@sol.localdomain>
In-Reply-To: <20240530060120.GB29189@sol.localdomain>

On Thu May 30, 2024 at 9:01 AM EEST, Eric Biggers wrote:
> On Thu, May 30, 2024 at 08:51:21AM +0300, Jarkko Sakkinen wrote:
> > On Thu May 30, 2024 at 4:44 AM EEST, Paul Moore wrote:
> > > > +	err =3D security_inode_setintegrity(inode,
> > > > +					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
> > > > +					  signature,
> > > > +					  le32_to_cpu(sig_size));
> > >
> > > I like this much better without the explicit inode cast :)
> >=20
> > Would be nice btw if that was 'ret' or 'rc' because err is such
> > a common name for exception handler alike goto-labels... Looks
> > confusing just because of that :-)
> >=20
>
> A lot of kernel code, including the rest of fs/verity/, uses the conventi=
on that
> "0 or negative errno" return values are named 'err' (and return values th=
at
> aren't necessarily an errno are named something else).  So it's fine as-i=
s.

Right, just hadn't seen such naming convention before.

BR, Jarkko

