Return-Path: <linux-integrity+bounces-7425-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A89BD1C2F
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Oct 2025 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFEB73A5975
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Oct 2025 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42476296BA8;
	Mon, 13 Oct 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YODe4cti"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2F2566;
	Mon, 13 Oct 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340138; cv=none; b=DlUADpvfL2Z0jdzTis47FM8xFy0EgmNiqEDEmskFIxACJwjPo7InLKHwy2cNEBaQKNFq7MeJKEUuwa3KRkQ3uZ9H2zA1wLTwY4lM1PHQGiEnDu6Xr+/Hm1wF0EFgu6Jw4aIeHR9pegpiyVBdlySrlQnuEgpaS8tYouTksjxFfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340138; c=relaxed/simple;
	bh=G2x5sg9A9w1B3YbjixDZET8wQw7wwwOLYYyFNWZCQ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyOMJl6Adp85cEDG7w7tDL8syTmLwvoADRPE3whfCxvtl0rAgNZ+QlawujlVh/S5yx0eR8yFn4ZKlPfaq4mteGSNUiGnIF6CE6Kf94ZdVUw1GWJqmHdurFGNUb+dD/F/h8SZRdJS8QYewn6cMjN8pQI/M+R9cFjDLBCXCnC/MPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YODe4cti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7C2C4CEE7;
	Mon, 13 Oct 2025 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760340137;
	bh=G2x5sg9A9w1B3YbjixDZET8wQw7wwwOLYYyFNWZCQ6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YODe4ctiyAHqifa+d1bqWl6u2Wn0+80JlnSbABnz245cARDAUJcEsh5rQnkDd/1Wq
	 do6MUm3uucJztudtqdqOcpZuquwhNeVR9O1C7SfjCeMM/qaLw/T6Vrw6Kp9m2owhrl
	 c36QxzuW1zh3A0Zg5ySk1a1cGWg/BJmGKhJChyrqesr/vt6LEVG1GrTNO8cOK33EBt
	 TP9RolxpPrmkV00rHFFsqSwHOwga2hPZ6J8MLGINjuOU8Tx2XbFri7V8bz74Nof60s
	 yWLfndXmPzheRWFNjks3p6geBpHNyMmmNWav+gL4h4RRwnk/K0vwwVvI/8Bw27fRgC
	 dyUdV3+Lulj8Q==
Date: Mon, 13 Oct 2025 10:22:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Replace deprecated strncpy in
 ecryptfs_fill_auth_tok
Message-ID: <aOyopfvzg9HNPB4k@kernel.org>
References: <20251010161340.458707-2-thorsten.blum@linux.dev>
 <202510101543.80A1D4E3@keescook>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510101543.80A1D4E3@keescook>

On Fri, Oct 10, 2025 at 03:48:48PM -0700, Kees Cook wrote:
> On Fri, Oct 10, 2025 at 06:13:41PM +0200, Thorsten Blum wrote:
> > strncpy() is deprecated for NUL-terminated destination buffers; use
> > strscpy_pad() instead to retain the zero-padding behavior of strncpy().
> > 
> > strscpy_pad() automatically determines the size of the fixed-length
> > destination buffer via sizeof() when the optional size argument is
> > omitted, making an explicit size unnecessary.
> 
> I would explicitly say that the old code was NUL terminating the buffer
> due to it being "ECRYPTFS_PASSWORD_SIG_SIZE + 1" sized with strncpy
> left to fill ECRYPTFS_PASSWORD_SIG_SIZE. And then you have to answer the
> question, "how was this initialized?" and trace it back to:
> 
>         epayload = kzalloc(sizeof(*epayload) + payload_datalen +
>                            datablob_len + HASH_SIZE + 1, GFP_KERNEL);
> 
> so the final byte was always being zeroed there, but now we're
> explicitly zeroing it (good). So there _is_ a functional change (we're
> writing 1 more byte here now), but it's more robust that way. There is
> no expected _logical_ change, though, yes.

Thanks for the remarks.

Thorsten, would you mind posting +1 with the commit message changes,
and reviewed-by tags (from me and Kees).

> 
> > 
> > In encrypted_init(), the source string 'key_desc' is validated by
> > valid_ecryptfs_desc() before calling ecryptfs_fill_auth_tok(), and is
> > therefore NUL-terminated and satisfies the __must_be_cstr() requirement
> > of strscpy_pad().
> > 
> > No functional changes.

[just as reminder: removing this sentence was my earlier remark]

> > 
> > Link: https://github.com/KSPP/linux/issues/90
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> With "ECRYPTFS_PASSWORD_SIG_SIZE + 1" and tracing of the destination
> buffer initialization added to the commit log:
> 
> Reviewed-by: Kees Cook <kees@kernel.org>
> 
> -Kees
> 
> -- 
> Kees Cook

BR, Jarkko

