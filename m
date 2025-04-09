Return-Path: <linux-integrity+bounces-5739-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6BDA83486
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 01:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118E47A2244
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7C21CA07;
	Wed,  9 Apr 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQbDoSDq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EA21B918;
	Wed,  9 Apr 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241353; cv=none; b=HLKOG1B1Ipb0xYJNA/Gt8JimRxypwsJRK2FBHive5AocztpGbxMjlixw8HnXKfK6GTgeLQS7PpT+AMAkbmL5gK8lP3IWvvKv2ER37Kma597S2R7T0iVPvEVQcvPMrIDGVO2L/gZAb3s/fjaI7j86J9mbVhwsEUk/FIVt04p92Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241353; c=relaxed/simple;
	bh=EhZPvyo0u2J2uKyIYhiCL8sPOLbS5opEPVEPw2q8obI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF5KhUtecLrhFrPZETjlvaM4gdkw4OcsF7n1wXXwE7xyKB5dxYWBsMkzpxglgZSjGJMJr3OUn/FZHQGaSLQ0KxR57dGt3OFv3gfuiscauhoxqHX0fpPkQklYriC8sFB4iYOqPgJbTqIw7LyQiPo0Mj+YnbtN4Sx0yGxV3odvmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQbDoSDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF0C4CEE2;
	Wed,  9 Apr 2025 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744241353;
	bh=EhZPvyo0u2J2uKyIYhiCL8sPOLbS5opEPVEPw2q8obI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQbDoSDqZFPqieEkFUMW/slIN5fF21+bfuHsCN8Qbg/0gED4VeGWDO2LzA8HLWsGR
	 7dH7pDc8Waj+wLX3yvhCga7T+9Y3Jy/41yEXrePUHG2SKuC8RldZUHFwys/IqH7Fhb
	 BJz4pd4mm+BfJW0XDqraKfhPn69Bnq9nrVOmprqtFHv23Z/C5ydprtiFuSJ/QLdLxO
	 upR2R6mKbLMbhfwMBpjTCDlkMHZRgm5RpvH8+L9IdWW29TF/VPkBWIJAwxef+OBhdO
	 u72u7gzedxf31bRostVtE0wcUt+MgKcxxSwBMgxP7TULZCWBSAVqkpUxDKV3sF0g4s
	 Kq5m/v7di82vQ==
Date: Wed, 9 Apr 2025 16:29:10 -0700
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
Subject: Re: [RFC PATCH 10/29] lsm: cleanup the LSM blob size code
Message-ID: <202504091628.33D461D2@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-41-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-41-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:49:55PM -0400, Paul Moore wrote:
> Convert the lsm_blob_size fields to unsigned integers as there is no
> current need for them to be negative, change "lsm_set_blob_size()" to
> "lsm_blob_size_update()" to better reflect reality, and perform some
> other minor cleanups to the associated code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Seems okay.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

