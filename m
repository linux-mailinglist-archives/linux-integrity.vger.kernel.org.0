Return-Path: <linux-integrity+bounces-4685-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BEA24365
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 20:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3418E168ED1
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04CB1369BB;
	Fri, 31 Jan 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQzW2aga"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EC14C5AA
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351895; cv=none; b=sSNShPTfRwGu2w3XgdsB8lXuWCVa2EiuowBJrY7BvlKl5w814Oa17oVMCb2xJTMkl1V9EdoY3fx2KfGhwZW9vDzXYwzKe2JDiH9mz5FXCV+iSj01OnUBq5GGCnr1sIMIuYA7VVM9KkQOPdOMgA2o6txR/+4ANIrpmvo8+Kk5uPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351895; c=relaxed/simple;
	bh=f+0RwLRl5D+chZ5U8sCJt4/0g7zQTWsJ6s5SIceqa3c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LXkK0htNt6bTZxZ2B7n8t4KntRJUuchmdgME2B/eD7o4xoBc44NWX/3/j7KkogQAPqcjeyWWsxoHrS6vGn5d+cNtQer3sabngoELxK3Rm+WLiE5ViwbkZZTpsEF0bQkZ3irA+fMoLwH4Zzce8mOGVU15oiQa7DDev45Sf1UPDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQzW2aga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A520CC4CED1;
	Fri, 31 Jan 2025 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738351895;
	bh=f+0RwLRl5D+chZ5U8sCJt4/0g7zQTWsJ6s5SIceqa3c=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=kQzW2agafq50S7/SEoFhQ8pFEkNSeIIfLqR7S0fS8HvTxwULsupZRqXrLsDD0zwcn
	 5Mdw3TvAe7Wxs4mbmrqf3BiXjR5WNJuQedc8Mj9pluV8PhSYY9SEZqBZn5c0sjX3BT
	 XZCiXgk+Y7JNP/w8RjMNe3ZpwxUjONH9lkc7rd/AalpRANxsfAIkxuVfSOUckYrsGu
	 Oav7FOCW1T/mpOna6q/UvARBgtuK8doChsiBdvlZzaEruHdSZpziRDG7TpruokU8lj
	 SfsHrq0YUgO5j+3rl3PHIfj4yFs/W2MbIGL38c0zULDxl2nids2/thu7fyaDuUgkwD
	 Eb5gOQ45jZmmQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jan 2025 21:31:30 +0200
Message-Id: <D7GIBDO5KJMD.118CQO10LJ79Y@kernel.org>
To: =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "Jonathan McDowell" <noodles@earth.li>,
 <linux-integrity@vger.kernel.org>
Subject: Re: TPM operation times out (very rarely)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz> <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org> <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org> <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
 <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org> <Z50IKdYe42_n2B0b@kitsune.suse.cz>
In-Reply-To: <Z50IKdYe42_n2B0b@kitsune.suse.cz>

On Fri Jan 31, 2025 at 7:28 PM EET, Michal Such=C3=A1nek wrote:
> On Fri, Jan 31, 2025 at 07:12:06PM +0200, Jarkko Sakkinen wrote:
> > On Fri Jan 31, 2025 at 3:02 PM EET, Michal Such=C3=A1nek wrote:
> > > It looks like the timeout_b is used exclusively as the ready timeout =
*),
> > > with various sources of the value depending on chip type.
> > >
> > > Then increasing it should not cause any problem other than the kernel
> > > waiting longer when the TPM chip is really stuck.
> > >
> > > * There is one instance of use of timeout_b for TPM_STS_VALID in
> > > st33zp24_pm_resume.
> >=20
> > Possible for you to give a shot for patch and try it out for a while?
> > I'm fine with 2x, or even 4x in this case.
>
> I will see what I can do. It will definitely take a while.
>
> How would you like to multiply it?
>
> At the sime the timeout_b is assigned, or at the time it's used?
>
> Any specific patch that you have in mind?

I'll think about this a bit and send a patch with RFC tag. Might take
to late next week.

BR, Jarkko

