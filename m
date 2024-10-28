Return-Path: <linux-integrity+bounces-3923-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A49B2FF1
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 13:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B687F1C217A6
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Oct 2024 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2652F188733;
	Mon, 28 Oct 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWiBNPoO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A017C61
	for <linux-integrity@vger.kernel.org>; Mon, 28 Oct 2024 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117821; cv=none; b=uvktaC3WTxWz3MDP3nrO/fsKRcn0jy13z4iUXPFqoW86EP253ou0IqXDBwwTbKvC19AJMaWSpcsy3nMkCwW0XOn7JQ3kIahqAzi0Ix6vZmPcZ99G/pzIkclVgsmhK8uPytbG8+tJ6blZ/7EUPRYmZ/M19KA1GE9Hn0rAkMrHGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117821; c=relaxed/simple;
	bh=j0wm7E3pArq0Ysmg/OceTCBbCpn6UwS2sch5gba7R5Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pG0y/YB4LZfMPj9H6b+uxsHsIpY/j+dfNGf4+wwWfZSWjRsyYTOFG1K3DMlZOWzyHi/asu0sI5+qvv57cuK2ZNj2hwLrLSGgK7iCPy4aAa4poU4Ba/UHCgf9pU/f0Zx6sIGi1VQ39Tqk52ONVeB6uRhg6MKZ7cP+u4l3koCGUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWiBNPoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F21C4CEC3;
	Mon, 28 Oct 2024 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730117820;
	bh=j0wm7E3pArq0Ysmg/OceTCBbCpn6UwS2sch5gba7R5Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jWiBNPoONXnFWq3FNW+EC5Tll4EkFon3t4+Rxg211enLG+srugMgiZV2+DIYh182i
	 qAcmRtGItCJuz2LNFVBp8SZ2oupaz1zTztfyywSt/HLGTYMXmpak3Xl1vy2u3s6Zwr
	 GzRGdhsrb8uegCZdTTDlW6B6cBOpr2ur6oAJrTcA5j48erHG6hN7w2AlKuKjp1k5xn
	 GtqdN9KbgjmNcswr3PBxzEkDQX7MdQdAZTa9JpTE0RUQvdukCOuz3stqj96MaNmnLT
	 N7UjzTAM7xgqbWSFORoMFgjhsPUVrH482IgqnPR4uSp0eiGC7hrF0LFDZVKLOjEgdj
	 6epGlEucOanGQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Oct 2024 14:16:56 +0200
Message-Id: <D57FKWCZW87W.3GHWUBZA5F4PE@kernel.org>
Cc: <apronin@google.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
 <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, <mw@semihalf.com>,
 <peterhuewe@gmx.de>, <rrangel@chromium.org>, <timvp@google.com>
Subject: Re: [PATCH V3 0/2]  char: tpm: Adjust cr50_i2c locking mechanism
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Grzegorz Bernacki" <bernacki@chromium.org>, <jsd@semihalf.com>
X-Mailer: aerc 0.18.2
References: <20241010091559.30866-1-bernacki@google.com>
 <20241028090930.2179983-1-bernacki@google.com>
In-Reply-To: <20241028090930.2179983-1-bernacki@google.com>

On Mon Oct 28, 2024 at 11:09 AM EET, Grzegorz Bernacki wrote:
> Jarkko,
>
> Could you check if there is any additional work needed for these patches?
> Please let me if you have any more comments, which can block it from bein=
g
> merged.
>
> thanks,
> greg

I got confused because they were in the same email thread, thus I just
saw my review comments in lore. I.e. I mixed v1 comments to v3.

ERROR: Remove Gerrit Change-Id's before submitting upstream
#11:
Change-Id: Iee45ab1cbb2f4d898fbac12e9632de27f615bfba

I'll remove it and apply.

BR, Jarkko

