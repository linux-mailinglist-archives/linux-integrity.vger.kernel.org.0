Return-Path: <linux-integrity+bounces-3894-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 494AF9A9EAD
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Oct 2024 11:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D601C24030
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Oct 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623C157487;
	Tue, 22 Oct 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZybO5NF0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2212D75C;
	Tue, 22 Oct 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589903; cv=none; b=mQ7qIAPV6OF3uAPn9bDod7A7sccjUvC/CynJYJMJG3u/2OM7uy2/DvlZQIpB1zdrpoN1hOIO0y1Xxj2OHRh7l0ow6TmWeZuQfdqdrAsoOKK3hvCcA+Wwf0CRbiP9KDMPWyp4vH4x1kLv2WnTu5cxDHFreM5YL+qpuCc9uvXg33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589903; c=relaxed/simple;
	bh=rtPElCoyK4VHoVpAFxPy2kWEIKq6zLf57q1FMR6qYZo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ts+Sms4sHuswICAzrDiZZV99MjKgmLhVfJZgS2eUpDspw1CvmTnfK12jMFhNpniXCTwo8/gg+7gBmHxfcggObLjpq6eLuTtTe2JtYu+Bpt/R+jc/9Qc02n4aHLGl8Uy7wg0wSp7/tCpwxcC1aDHwctHZohKQjb96vRWGwssjFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZybO5NF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535BAC4CEC3;
	Tue, 22 Oct 2024 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729589902;
	bh=rtPElCoyK4VHoVpAFxPy2kWEIKq6zLf57q1FMR6qYZo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZybO5NF0Kc/iWb2juyhLGO4bdKoA/4UzzBl+F7iBEiRiQvJsTTAsL89fu7yWfVbcr
	 +po8kiF/8suzSRTgAjyppPL4WMogKzx5U4R10Q2YEaE2SL6P/dkNB2ariGM/4IznD/
	 PHdfLM56jDv5KT+p4zRrA07PLyX9S5jmmD/xNDGlAIYxlNtzHQaFwmyKRSh2FfoNCX
	 A6IRV/pzUCZV/iFLAXaaZWbuBXDW1Esj5LBbpKSVk+GdLmkon3mH3bn1mIYquWqz5Y
	 3Z361vXSnzBgwFJ7vyJe+yg+AgO3hxFhiCE6dY50XgcKwn7ETkc47eYtGMww69qmfA
	 kIW3B7dmvdEKQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Oct 2024 12:38:18 +0300
Message-Id: <D528G66RF7H4.238HD3WNOPXHP@kernel.org>
Cc: <mikeseohyungjin@gmail.com>
Subject: Re: [Bug 219383] New: System reboot on S3 sleep/wakeup test
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Borislav Petkov" <bp@alien8.de>, <bugzilla-daemon@kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, "lkml" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <bug-219383-6385@https.bugzilla.kernel.org/>
 <20241021160202.GGZxZ6-gCNNKUtTRse@fat_crate.local>
In-Reply-To: <20241021160202.GGZxZ6-gCNNKUtTRse@fat_crate.local>

On Mon Oct 21, 2024 at 7:02 PM EEST, Borislav Petkov wrote:
> Looks like TPM. CCing the proper people.

Thanks for forwarding this to me.

My fixes for an issue with TPM bus encryption and AMD boot time have
been stuck for a while (over a month) [1].

They've also tested by the reporter [2] but seems to be hard to get any
reviewed-by's for this, which is weird given how dead obvious the
changes are.

There's already a decent plan for overhaul of that functionality [3]
so looking into to the new issue you forwarded would make a lot of
sense to me while at it.

BR, Jarkko

[1] https://lore.kernel.org/linux-integrity/20241021053921.33274-1-jarkko@k=
ernel.org/T/#t
[2] https://lore.kernel.org/linux-integrity/CALSz7m3SXE3v-yB=3D_E3Xf5zCDv6b=
AYhjb+KHrnZ6J14ay2q9sw@mail.gmail.com/
[3] https://chaos.social/@gromit/113345582873908273

