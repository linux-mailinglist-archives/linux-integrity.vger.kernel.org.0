Return-Path: <linux-integrity+bounces-7844-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594DCAB8B2
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF843300A36A
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8B145B16;
	Sun,  7 Dec 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDpSzmgz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A1171C9;
	Sun,  7 Dec 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765131458; cv=none; b=MZoOzvhInwbQWYkkhmHbcMSM6Ie9Ebe9x5PU5eK/kPuQgQwtsfENbq/Ssqw86G0dQYEL1RrAOMUSbRzA9N358hLyp4MaD5b7/wZ+BgaG/Ub6nyad1thKki+E4am96XpTD0RDMC0BwTJVOr0lXUeip0+f5nQXcgyoGZ/3tHAKczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765131458; c=relaxed/simple;
	bh=gj8mkz+stUtGYV75bwVR6MLcv+CMeJYWBmn89k9F96I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANmEU1jfR6QjvO6Ua+G9m9J82E36IttI9oTvWsL7j4/2Rs9RIA2YA38cmBLqOixnN1awlUEzUuYA6KP/TN1gQErg+A+fHA0AjU1xZ50keAo19NMzvBaWkzWjQI9e6BnmIcn3feFIMF5HMHy9tCk7IsMxeNkwj0ti8xeGqSqiJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDpSzmgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627F3C4CEFB;
	Sun,  7 Dec 2025 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765131457;
	bh=gj8mkz+stUtGYV75bwVR6MLcv+CMeJYWBmn89k9F96I=;
	h=Date:From:To:Cc:Subject:From;
	b=aDpSzmgzpIHlAfY5seh0sDenbX98hBNC7v3CfGUDkBza+pc0iy/FcuJjpffaG0uGd
	 rzhZ5OYSZz0Nhm8a0OFeh+Ta1/vY0T25FmKKybmjcR5X9n6fix2EpWEL/WjSPX1RTQ
	 vHclVbQ6vziPHA37Ywd7D+KeQOMuJK26XhnvVaKXCEFwXfi++TZv4V9US8jKWsFlaX
	 NqAsVQ6S4V4R75YQ6k8T32pNbZsExSsxTQyjqGv3ZJZK9iGp4KYKKY4tOarzL0ZwH0
	 OuJ+kFvMMugTv2QGJ47GESRJvoaeVD1/P7wQK4S22jbBi2jgpwFZLeyV/GJenwKWTJ
	 wHetre9KSGq4g==
Date: Sun, 7 Dec 2025 20:17:34 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: tpm2@lists.linux.dev
Subject: Static values for TPM 1.2 command durations
Message-ID: <aTXEvjtK-tSWSOgL@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In order to translate some of the code (or data in this case) to
Trenchboot's early boot code it needs to know have some idea of
command durations.

In the case of TPM 2.0 we have a table for this, which can be
linked easily to early boot code. 

Can be come by reasonable values for TPM 1.2 command durations
that would scale to the pre-existing hardware?

BR, Jarkko

