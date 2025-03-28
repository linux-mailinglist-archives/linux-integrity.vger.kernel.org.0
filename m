Return-Path: <linux-integrity+bounces-5490-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A7A7518B
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Mar 2025 21:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F1216C020
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Mar 2025 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22211EF379;
	Fri, 28 Mar 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mURuwQa1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B951EF371;
	Fri, 28 Mar 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194448; cv=none; b=QK4u6buShyj18raneKl1r1iqCvKbikuInF4SeY1Crdqq5vyuW4dh3W7aS9NcqJPYX/FJRuc59MYv7ztjfldsP6+Isbtiu4SFo7lS75XB2WN4zriDZuK11TfnRtMPZUcKmFxInWrBvg0mKiKaqRLd29LF4ehlAPmc0WIe0/OISlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194448; c=relaxed/simple;
	bh=feL6gVMKVW/YhRQYnIgUQBZbQKnjgZjjM41BZQlaiXA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pi9yK8ERuZI3OYbhtyFsRbngRT0IDc6GBN9CcJ2JGu3JSu23XuwMgke7nANoB8vtzCipV6sqsj6slzYAjdQVyJOpOJYuTVpx9DJBb/jk8zcQAL4Ps6a95gI7G5/D7ic6Ty/wk8Um6NtXWpFtxM/nHq4LupZXsL36xjj9C4fVHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mURuwQa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691CCC4CEE9;
	Fri, 28 Mar 2025 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743194448;
	bh=feL6gVMKVW/YhRQYnIgUQBZbQKnjgZjjM41BZQlaiXA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mURuwQa1offvr3fO04zoPnsTd19cQNdKwQO+0mQVNqi7nbFvT5jPQwl9EbP4kK/Gz
	 qGVA86/Tpx3Osau8Kvoffr7ReFfeA/1lwsPY8FEquoGOoZX3TPaXRT9BsyM2cV1CUh
	 7uByytHj2DJafUNrwfbB8XTsF4e91TSkE/BgbgqfjOKRfw7kodRGyrAYfvYmoYPPrO
	 8Gs3vsdfkNYsXY794fjSEGKpk2PpalyY7JjdnxjNL+vM2kjus1kB3Y1ULgVR8V2d7H
	 TuMiLDc/tCKQlfJwiftHucToJoDuGpssD+NtGmruZkE06ylQtZAy8y3DVlLJWuP+5l
	 PegbfhhGj/6vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 25CCD380AA79;
	Fri, 28 Mar 2025 20:41:26 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: subsystem fixes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <b33c8cbb7038a65f51677e547ebcabcaebdd5305.camel@linux.ibm.com>
References: <b33c8cbb7038a65f51677e547ebcabcaebdd5305.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b33c8cbb7038a65f51677e547ebcabcaebdd5305.camel@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.15
X-PR-Tracked-Commit-Id: a414016218ca97140171aa3bb926b02e1f68c2cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2d4f473df1117e437fee125fa7e9420e19207ec
Message-Id: <174319448478.2953471.5705766506609559454.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 20:41:24 +0000
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-integrity <linux-integrity@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Mar 2025 12:54:41 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2d4f473df1117e437fee125fa7e9420e19207ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

