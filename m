Return-Path: <linux-integrity+bounces-7423-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45ABCEB7E
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Oct 2025 00:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8654544589
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD244274B5A;
	Fri, 10 Oct 2025 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQsVZVQF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA61A9FAE;
	Fri, 10 Oct 2025 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760136529; cv=none; b=RbOcGsjulq/fJ7qc3mw96ZyEhITuIACCF8JJhi8waTlzFkYhXviU4QT8nsrGhVmlOqWv6FYDwlbX7sNgd9EBnoawrAoOWY5pHeHaFx9fR8Ohwrt/WHwaTCHbAHsTnTeqRx+RouXaoSZM92zxl7nhrDtM5hVSeoTtd1a9kWS9mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760136529; c=relaxed/simple;
	bh=NDaXxkg4WVnhjRIYtHKKMx/ePf8Uc1IZ0z3IkB9f5Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDxiR3n8onX8Jyy8sjNEAmKcduRFxZLJCZovJl8nTOLf+TPudcXW+rTcijgrmpEZ4GvPhH6/LxWFM4PFT2xhRoEKHR3w/xykKHBQ3YPtQ2ctVSkYPFUReblJP4tabu6OrKVz8VP78bATs1fp4OyMKbxOR1DbKUowoHTYRJgHHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQsVZVQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C2CC4CEF1;
	Fri, 10 Oct 2025 22:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760136529;
	bh=NDaXxkg4WVnhjRIYtHKKMx/ePf8Uc1IZ0z3IkB9f5Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQsVZVQF3BIMmkn2VPTcxeKY4FHr4qZ5GeZUkuuPmKFI+xil2tmWJydijUCDVzXAN
	 4MOQSzOg5cJcACzDDHtEuq1vgKsep7YUbBOX+EXi49+CM6/F1oh/plh251Nqlb7b26
	 BmL2alMcZdqJyfghVyP4IQMDl7JllD+whkRMDX1nnGNApJMFO904uVv8DO11Ppq7P0
	 f+/+n3UTdDEl7axHe/ABMWChXBns0F3LCAvhzaptYGv8HDjOqB3yxsGXR340PE47WA
	 NVoTb16R2NU2lzYX0Pcag5KQLAohTYSNI0bOnamfKYLnnICeqaEu33ofaeXPNg+Skl
	 dYiS/J4Ruz0Jw==
Date: Fri, 10 Oct 2025 15:48:48 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
Message-ID: <202510101543.80A1D4E3@keescook>
References: <20251010161340.458707-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010161340.458707-2-thorsten.blum@linux.dev>

On Fri, Oct 10, 2025 at 06:13:41PM +0200, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy_pad() instead to retain the zero-padding behavior of strncpy().
> 
> strscpy_pad() automatically determines the size of the fixed-length
> destination buffer via sizeof() when the optional size argument is
> omitted, making an explicit size unnecessary.

I would explicitly say that the old code was NUL terminating the buffer
due to it being "ECRYPTFS_PASSWORD_SIG_SIZE + 1" sized with strncpy
left to fill ECRYPTFS_PASSWORD_SIG_SIZE. And then you have to answer the
question, "how was this initialized?" and trace it back to:

        epayload = kzalloc(sizeof(*epayload) + payload_datalen +
                           datablob_len + HASH_SIZE + 1, GFP_KERNEL);

so the final byte was always being zeroed there, but now we're
explicitly zeroing it (good). So there _is_ a functional change (we're
writing 1 more byte here now), but it's more robust that way. There is
no expected _logical_ change, though, yes.

> 
> In encrypted_init(), the source string 'key_desc' is validated by
> valid_ecryptfs_desc() before calling ecryptfs_fill_auth_tok(), and is
> therefore NUL-terminated and satisfies the __must_be_cstr() requirement
> of strscpy_pad().
> 
> No functional changes.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

With "ECRYPTFS_PASSWORD_SIG_SIZE + 1" and tracing of the destination
buffer initialization added to the commit log:

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

