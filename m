Return-Path: <linux-integrity+bounces-5728-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90565A8331C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F973B23D6
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DA120299B;
	Wed,  9 Apr 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaRP77qE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCED155C97;
	Wed,  9 Apr 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233432; cv=none; b=ENiUicgmqM9cck5+7Vdz2D4xxOON5JOdBx0HCr3ucyenC1XLY1zMqmTvAFMhD7wYIjXPzA3KpP1TqqfbT8ZmTMHkKShjUQL88dHR0bDJ+Y2uFvazNPdTcGCfMrVrK4xbb6OPbDcpSbQ3Jjgo6Q+8v7pH5nN/SDlesaOdau5jQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233432; c=relaxed/simple;
	bh=II/SJWpPbgfusmP4q0AJ6ri3EfX+djTm94xylZqwpZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLhH2AA63m5ETiVHW4iw00ZsKJ8PEQqO6ISU4+u96o1CIJxoa1VHkdOzX5k1otW6JeeMSvKSHxLPzGXLGEiESeenM7YUjWP+ScZ6mR2wE2o0dzJFb5mVttEmGEG2q7xFCI+a60FcNxXA0GH6ABnEDx5ch7bJkGjwS8XZdJzZavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaRP77qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E5FC4CEE2;
	Wed,  9 Apr 2025 21:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744233432;
	bh=II/SJWpPbgfusmP4q0AJ6ri3EfX+djTm94xylZqwpZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaRP77qE3xhr3CGhT1miuendIZK43Ez3Zt1nr8VTMYEskFSql0IBlC7qwVCJa2xSL
	 8JyAsKChP+UHJIIDRWhxymRi48OzGtD9hCDCYgfV9zuKBfcKPH+OElIVtklddAwsKo
	 aVE3y9D1TmkxAt/HTHIQ84TJNkzySxko82NH5DuEVmCeK5OMO7H+aTOB4eFWf/sQK+
	 7f8egpJ5uB+CqX+lWWsn79x17/zW9J3IBeAGo5OPJML9lSQoqGKh5+CXcZ6L3bFxjh
	 MHE8y1mj7aNJerTQyC7A9UtNsLEVc3qaJe1QqGlv4f/Ctkfw5B2x4IwOIFn2EFMPDx
	 jTrl5vGo66YiQ==
Date: Wed, 9 Apr 2025 14:17:09 -0700
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
Subject: Re: [RFC PATCH 01/29] lsm: split the notifier code out into
 lsm_notifier.c
Message-ID: <202504091417.12FD658@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-32-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-32-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:46PM -0400, Paul Moore wrote:
> In an effort to decompose security/security.c somewhat to make it less
> twisted and unwieldy, pull out the LSM notifier code into a new file
> as it is fairly well self-contained.
> 
> No code changes.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Yeah, seems good.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

