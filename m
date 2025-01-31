Return-Path: <linux-integrity+bounces-4683-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED78A24197
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527653A70B5
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2025 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220871EB9F3;
	Fri, 31 Jan 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUGbueRP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165E1E883E
	for <linux-integrity@vger.kernel.org>; Fri, 31 Jan 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343532; cv=none; b=fRLTpwNosBUGiVW8X2U32/CZs0eBBcptfUzGBqHwTJgpjbs4NMMff2YUqKLOZJ22xdMbpY1uFDssLooKfQ7g6KdJ2hxw1zaB6RngYrjPFPL5jy6apXf1928jn5HWp2uBlSCZ+HiPIw64zEqtlb7tsgdDWFH76B4dzw/i4IKDhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343532; c=relaxed/simple;
	bh=s3wtHpO2eSWj2oi5/cWY5WGeUSyYy2LaEfiWAvkzqGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FYeSKUT1SJY77WgL3UEx7m/DsayZwAljDnL2txzhxDREsw2YsBR/q5G+DPZ81VMlLorP1t70LXsVSY8Fy+sNQDgbExwIcGAhRk6u8GpwYreWHspwsQXOZNWSTSxrYS54u9KIesllJF/5mc0SBiG+GVpJJBcvaIWQLO4Qvjl1eGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUGbueRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CB4C4CED1;
	Fri, 31 Jan 2025 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738343531;
	bh=s3wtHpO2eSWj2oi5/cWY5WGeUSyYy2LaEfiWAvkzqGI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kUGbueRPlZfltM4rUWyOXvjiEY8Q7RyzSm4AhoEa9GTwBDdeG+3g5nvpqRpOBoylW
	 BRQ/B0iErZzNAHFokRmVe49XQB52lw5OMYgCEN2IaB7Pc/4CpxOT7DhYoYBvfDGB3M
	 wgd7/hIeM8J1DA5k+o71DLvBlWZcWD2q/FHptLXfP5uZsNVMHAGRjLfiZFHItM1VYS
	 rXM2ifzZqUQPxuMfM8wZ2cgNDIzS+epWnJXh6I5rzbz/RW2W0nXn1hpXGafgBDjjAu
	 kOPbg1DWvRR7s95AlkFzEoNp3aBeI3l8r1erxF+NBNqa+5IE2QYTT1rZsA1DwaNiWL
	 P0HCGm6wLp4Mg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jan 2025 19:12:06 +0200
Message-Id: <D7GFCNGDK7S6.1X0KPPHF1TXBO@kernel.org>
Subject: Re: TPM operation times out (very rarely)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "Jonathan McDowell" <noodles@earth.li>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <Z5pI07m0Muapyu9w@kitsune.suse.cz> <Z5pRKcZKc3FUzP8Q@earth.li>
 <D7FSS837QLNR.5XOU66J6FBTU@kernel.org> <Z5yLYVBn6inIH8cG@kitsune.suse.cz>
 <D7G6P7W7AY65.257WPBC8I3HAF@kernel.org> <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>
In-Reply-To: <Z5zJ7R6vDU4h9iDk@kitsune.suse.cz>

On Fri Jan 31, 2025 at 3:02 PM EET, Michal Such=C3=A1nek wrote:
> It looks like the timeout_b is used exclusively as the ready timeout *),
> with various sources of the value depending on chip type.
>
> Then increasing it should not cause any problem other than the kernel
> waiting longer when the TPM chip is really stuck.
>
> * There is one instance of use of timeout_b for TPM_STS_VALID in
> st33zp24_pm_resume.

Possible for you to give a shot for patch and try it out for a while?
I'm fine with 2x, or even 4x in this case.

BR, Jarkko

