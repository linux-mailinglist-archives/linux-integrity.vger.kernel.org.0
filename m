Return-Path: <linux-integrity+bounces-3935-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2EA9B5A0D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 03:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60D11F240E7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Oct 2024 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC127194C75;
	Wed, 30 Oct 2024 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXFSx6Oc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7B194AF9;
	Wed, 30 Oct 2024 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256263; cv=none; b=n88ZpS3dthuNM/Gi8IAS2oprJV1tZkzEMaKLv9eivohRC4WxWDG4h1QZsp38+EbPBiCnweUWLeytTIf4QoT7v30o3L4R91zhnDxWc+wgsk5UTr7VL6lwdX5HSNcm2/HbLKKkQHSxc/zrpSEX1JFrIMgidj87C1BsQJFYVElXTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256263; c=relaxed/simple;
	bh=DwM25zNQhr3SkGodlmeZCf/gY5xEJDmN0oxcmn2H4SE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BtrH354EioX66WuEmFRzV98MVct0ltCZcsNEj+awu4uwTUaqrikzlvCESRi8+cfM8eMZ3LNFbgoOmWgayOmFpoIKEHH9ZCU0ZH4nlcEbhBg7tOrAPZhPzyK0mdkGvd6u6YOu58Iljt3P+bwIZQC0dzxd6F9dE4zohL9VRYYIVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXFSx6Oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FD4C4CECD;
	Wed, 30 Oct 2024 02:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730256263;
	bh=DwM25zNQhr3SkGodlmeZCf/gY5xEJDmN0oxcmn2H4SE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iXFSx6Oc64Ek1ASGj1I2q5XU2vMpcsVKLO2slyOF7u8rd7QVPQtrOZYowDKzmk0Vb
	 IqfcTkmsAXNVAKzalihExnbO6AUcPGp1CV3WxTDD4JnG8bsqQTJdOGyyZitLMA6nXo
	 usyqqrB9MQVQb+jxVNHCVRkO5Kq9VeQPHzu4CwOqjlA0cdhQmHLpP1g9+fkK5yiqn6
	 oCeIa+gElXTt+t6PyrXxu2YNp2u8VfaNG2O6HOcFYOvaEGd3T5xiQE7I5hhqt2ByQy
	 06r1ZzTZE+7HL3pdvcVHKMKkL20oCKJ8toJAgFz67qs/TpEZ2bdpP45nybRR6RZ8Dr
	 4zA4HDdZHWkpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3489F380AC00;
	Wed, 30 Oct 2024 02:44:32 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <D57UNU1ZUXJS.E2RDQDB8XFKI@kernel.org>
References: <D57UNU1ZUXJS.E2RDQDB8XFKI@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <D57UNU1ZUXJS.E2RDQDB8XFKI@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc6
X-PR-Tracked-Commit-Id: df745e25098dcb2f706399c0d06dd8d1bab6b6ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5b2ee0fe863519be5e1c277d22609b048b61a2a
Message-Id: <173025627071.893735.11225393380200318536.pr-tracker-bot@kernel.org>
Date: Wed, 30 Oct 2024 02:44:30 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Oct 2024 02:06:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5b2ee0fe863519be5e1c277d22609b048b61a2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

