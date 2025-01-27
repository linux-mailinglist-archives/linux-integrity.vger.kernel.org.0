Return-Path: <linux-integrity+bounces-4659-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF3A1DCD0
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2025 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366AA18829C9
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558A192B65;
	Mon, 27 Jan 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6x2PF+Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFD19004B;
	Mon, 27 Jan 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006758; cv=none; b=cwrTpcVc7YvRLktFGvoHjgQWTfyzPSuUueinv+IFJoZiL1oYnsyL1cJUWRFq/s4Q2ZDMcrBL03DcuLvtTInD2N9rGQRqNjOTuKFmhXzvfeGdxWq/sMllriWv/hbnY8HrP4paaB5vRgI7NuZ970JQn5oiAfNG9ep2hYe/r1PuE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006758; c=relaxed/simple;
	bh=r+B1vjaHImKe8GpFGnri9C6St63A4B8hutBOPjIgckM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQSl3rj1jewLcyzZ2cjbJCWX+FTS/Lh+lqtL2PQ0NgQGVBvNZS8+zSSeFKPQlDJ9IWsyEjl8jGg+GFLW1LSURB9wIbIX5pl/uqndMP6P44nlVDrI08dNrS0b9fVzv16bAaXsva4kgiLN3cxTzI7znp7yrt50mZiRYZD1xbeldZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6x2PF+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6287C4CED2;
	Mon, 27 Jan 2025 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738006756;
	bh=r+B1vjaHImKe8GpFGnri9C6St63A4B8hutBOPjIgckM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6x2PF+Y6+DxtS02vYZRZhONC7nM5a8iAcBOLFNC+/k9964U7g07vOopJ5BRc1sUT
	 hAGT2N2Bf613ryUkSCSLcBUvRtjQsQxEXkX0yjxbrmY4MN0V/k3APCnYxeGjtgrq6N
	 pBUcskFY/9lia/0O0fTj+jji0rp6fik2GmhIyj9pQp0yhGqktqcO2sd6GngaSi4cGB
	 Vyq+hxxllozkw/g/AmXKceqd3Gv79CCzEyUEdAihkT/UDrnzCkpIyU86j1AWRZjRdw
	 mvvrNtlcyug7Z4SOtbS1nVk+a4HSHHB09NXZw6sFN/y4CAevdyUuJwmV766NuWL8wI
	 G554n4pBBHwAw==
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] selftests: Handle old glibc without execveat(2)
Date: Mon, 27 Jan 2025 11:39:11 -0800
Message-Id: <173800675032.246126.5189290941932361597.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115144753.311152-1-mic@digikod.net>
References: <20250115144753.311152-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Jan 2025 15:47:50 +0100, Mickaël Salaün wrote:
> Add an execveat(2) wrapper because glibc < 2.34 does not have one.  This
> fixes the check-exec tests and samples.
> 
> 

Applied to for-next/topic/execve/AT_EXECVE_CHECK, thanks!

[1/1] selftests: Handle old glibc without execveat(2)
      https://git.kernel.org/kees/c/38567b972a22

Take care,

-- 
Kees Cook


