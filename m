Return-Path: <linux-integrity+bounces-3744-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE23993B4F
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Oct 2024 01:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197331F239BA
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBEB18C351;
	Mon,  7 Oct 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx8kchcZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881618C33C
	for <linux-integrity@vger.kernel.org>; Mon,  7 Oct 2024 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344282; cv=none; b=o32D5RdvxWSLD3OB1c8h1gwuDQ9dK06Yu5jIsNyIUeA8PBWkpMA+ffQoVycWXIWKgqy5obZi6ziiKCngTLByt9bYIZ+J1yUcXjbISmIUROkt+gKwIzmx93QAs/9sNX6UKhGK1UtAT4kqenuWu1+NpnD/fFuzP5egjYOnG9j6g94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344282; c=relaxed/simple;
	bh=PJrm234T3Z8Tt8ZDGkRL7jCkzSLxVTPaKdZKXC7OwI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwlBsojo37E3XG/2swAleoMbLY+XxycJeQOfnSR6JOnjWUAMMFC3WAe2Frj9tRQ1+1fveKXw4V05X2C8xvmVghizSeD5wKXaDYMSJx8HbD/byPFkoo35f9QlrinaH8fVgskehl4kO63uM042s2OvQ6h+S7RRsIOHqqlVPxhRZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx8kchcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F450C4CEC6;
	Mon,  7 Oct 2024 23:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344281;
	bh=PJrm234T3Z8Tt8ZDGkRL7jCkzSLxVTPaKdZKXC7OwI0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zx8kchcZuzsOEY1F0U07yfyKGMfEBgKkbmoDvtcgr+EAtBSVsO3sKa8uwPlYrjd0W
	 3TBVhdzBSsn4VXCLtOkR1RkEqyontBIO4XFjQ30KbtyOo0EriM9S18yKM3mCMli1sY
	 owc/NQOSPCjZxc0lvL1Bb1qhSED1kN/vXxarWnASiCd/WitO3uMkNl4gPJzFnYtfT3
	 Wo2VLTSC4MEBFObVWW13/A6keFwpTKPw5A9DE3NgizSi4JDdzsisew1ZxsCz+atM3m
	 ml6XjiBTljT3wGQ9j4yJF+eohwrNs0oOUFmRbCDQtM84aCb6GJidZdFGGQ31OapFvW
	 7PmMwbS74A3/Q==
Message-ID: <b081d9a0d780ff6c2eecacf46367be629e5cd949.camel@kernel.org>
Subject: Re: [PATCH 2/3] char: tpm: cr50: Use generic request/relinquish
 locality ops
From: Jarkko Sakkinen <jarkko@kernel.org>
To: bernacki@chromium.org, timvp@google.com
Cc: apronin@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 jgg@ziepe.ca,  jsd@semihalf.com, linux-integrity@vger.kernel.org,
 mw@semihalf.com,  peterhuewe@gmx.de, rrangel@chromium.org
Date: Tue, 08 Oct 2024 02:37:57 +0300
In-Reply-To: <20240930115245.2906902-1-bernacki@chromium.org>
References: 
	<CANkg5ezwYT+ZsiRDW9fe1m4vyncOEDFamq0jXTxmWO37d4i3Nw@mail.gmail.com>
	 <20240930115245.2906902-1-bernacki@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 11:52 +0000, bernacki@chromium.org wrote:
> Tim,
>=20
> [...]
> > Why is it useful to return the same `loc` value that was passed in,
> > rather than just returning `0`? The caller already knows the value
> > of
> > `loc`, so they aren't being told anything new.
> >=20
> > I think this should continue to return `0` for success.
>=20
> I think Jan just followed the conventions, when he returned 'loc'
> instead of
> '0', some others request/release locality function do exactly the
> same.
>=20
> [...]
> > For each of these ` WARN_ONCE((chip->locality < 0), ...).`, can it
> > return immediately rather than attempting to continue using an
> > invalid
> > locality value? Do the following commands have a chance of
> > succeeding
> > with the invalid value?
>=20
> WARN_ONCE() macro does not remove checking of locality. If I
> understand
> the code correctly layer above should not called this function if
> request locality fails, so this code is an extra check.=20
> I can remove it in the next patchset if you want.
>=20
> Jarkko,
>=20
> Would it be possible to merge this changes. Patch 1. has already been
> merged,
> only 2 and 3 are still waiting. Do you want me to create a new
> patchset for
> these two patches?

Send a rebased version that applies. Let's check that through
then. Quick recap and some time gone, I don't see anything
extremely bad. Still acking patches that even do not apply
is not possible.

So yeah, send. If glitches are spotted in worst case this
means two rounds.

>=20
> thanks,
> greg


BR, Jarkko

