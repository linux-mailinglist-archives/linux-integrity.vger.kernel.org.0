Return-Path: <linux-integrity+bounces-5729-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79862A8332F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9594B189F41D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D881E32D6;
	Wed,  9 Apr 2025 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGhNrFav"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9014213E61;
	Wed,  9 Apr 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233534; cv=none; b=azhj9VTSQ15OsxN5YDYamr/WXeEuebLrnAJbxHbmGalu8AXb9Me1iaIegz6qOxQ7/6xBUWqnB+b1Az67n8OC1Qn1K5A24X/27xupIL1fSmLgF2YQq49H7QnAmR4CSAl2RsPmTRgQIfL+2HDTp4JcKZ9V9KMhjqKHaR6FiwzF8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233534; c=relaxed/simple;
	bh=M6iy4diyJT076GqlBwftOTckvGiaQjkzTsokCyM20Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBHwnmKoHyEaMpUJGIXcHyHbe82rw135XfX47wIL7BBB0aEyln4Hv6tKHflMxU0M8wgreTrQdeJiz+JIEvoQYDtV7cHty2H58qGDqcb1xdUHkKFF1tlCFCzSZKJQ7k9z+LwHY97Y/VELOUrqvoKVGfwBr1BdB07C6/H8Y7WZ0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGhNrFav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A238C4CEE2;
	Wed,  9 Apr 2025 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744233533;
	bh=M6iy4diyJT076GqlBwftOTckvGiaQjkzTsokCyM20Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGhNrFavP0kfJFbXvfdZ+APPjXLOvm5t5N2E6Arz0w4qZoWbK8NGYpIoNkJ5nyYHq
	 uUgHZNx+nf9psSMGdDsQXHdTzxbjgfqrU+q7m3xQP1EMXvRNY9/zwBoAhmPHnUDTOi
	 dMJqw5/IUtVZzK2DE9YJ22piDp4NIyIgh1bHj1v180p7Ybx43kzZnEdBH2we5H5gYc
	 IFTSJIDK2cMPSwO4n+ep/Wx8veFurwxhUd3/BqY3e10cv/5RKKnTmVIMrWq+a3piGi
	 qY2T3whcGiJYD7zal8ExlbcwfR5LCr0HT99VVVg4NigKxGbtPGozhg6UbJCFRTslXS
	 Gws9YjoGJGNRA==
Date: Wed, 9 Apr 2025 14:18:50 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 02/29] lsm: split the init code out into lsm_init.c
Message-ID: <202504091417.0C851C35A@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-33-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-33-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:47PM -0400, Paul Moore wrote:
> Continue to pull code out of security/security.c to help improve
> readability by pulling all of the LSM framework initialization
> code out into a new file.
> 
> No code changes.

No behavioral changes, but this allows for the section arrays to avoid
being exposed in a common header. I think the reorganization it worth it
for this alone! :)

> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

