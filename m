Return-Path: <linux-integrity+bounces-7498-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFABEDA47
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 21:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21ED5E5328
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Oct 2025 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76504287267;
	Sat, 18 Oct 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkIg6/ll"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49514275B06;
	Sat, 18 Oct 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815393; cv=none; b=ecnnU1lfABYhqh2SRFLcXerOEOYwfI02P2mK1I5ur9T2Ds8xCuzMQ0Spjv+bJfRm8SQHuqt1ec6aZZqxdw0FfKrY5oB42ydRAH0vgunnmZcx0oumaqs2cUmNBV9JzSZ1E89aT78Z7+O51Bs9ukzgxOxpkB6zT6pqX6Cnc2O+Gqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815393; c=relaxed/simple;
	bh=okaLHNChsfatPFsextwxLTnkXUZZn0XdmVRPBuesZG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EAi0/uds8b2Opxp+bVcJmlDCUnFdDvuveGkpB+G98B3Dc3TGhonwtXB9SSN2haxxnbaCkoSTPul7gSK2sPuiJQ2gvtRB9RbsVNsEMIcjYWk0pu8nfS02jb9dDe5J/VYJ+xfcTN9BTbO0fNfdDTCz24kTaaV1DFbsPzmrVhVe4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkIg6/ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242DDC4CEF8;
	Sat, 18 Oct 2025 19:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815393;
	bh=okaLHNChsfatPFsextwxLTnkXUZZn0XdmVRPBuesZG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mkIg6/llf7adv5heJFy3Ov0LoZTOITS/Ai+fY8DmEPPOoUy6n8CS18kWj6NyD3DqH
	 JA+FbD0B0oqkYr5z64jEItRIRE8oFrD92vicS8gtqewci68ziJCJJycnf0LdS6ql8U
	 wvcTgKqyvgaqg8f+6Vs93nqzMkELz7HpNbYGGBgsZX7Z1dgQAPhQ8WNJaMoExNs5mE
	 teQ75DTGVaNOdMGTo69LqymTqkI+I/XjUqs13c11w5/+z71IAaU1fzRnl7oVqxgauA
	 Su3tbP+TchuiE0CjbyxJyncVajxKIQU5wGUQg/BK8XPuPOlTQO1RohcCmjFhKpae63
	 LbvdGSC5b0Ucw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4139EFBBA;
	Sat, 18 Oct 2025 19:22:57 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPOB9lMvnrXLf4ZD@kernel.org>
References: <aPOB9lMvnrXLf4ZD@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <aPOB9lMvnrXLf4ZD@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-rc2
X-PR-Tracked-Commit-Id: dbfdaeb381a49a7bc753d18e2876bc56a15e01cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 648937f64a09ae4a938a6793f95207d955098038
Message-Id: <176081537600.3081941.14515189649303697967.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 19:22:56 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Stuart Yoder <stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Oct 2025 15:03:35 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/648937f64a09ae4a938a6793f95207d955098038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

