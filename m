Return-Path: <linux-integrity+bounces-6535-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18506AE905D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 23:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B184A6D6A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 21:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434FB26E154;
	Wed, 25 Jun 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/1gtSAN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102952147FB;
	Wed, 25 Jun 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887940; cv=none; b=ZLBunYhqb3qsm/nZk/Qdj/A7GWW4+S3Tawdk4XoZfJE7iDjPIjo883BmDHlB2F3FbPCovluQZsT6zmSH+V2J/5tPjvUgr16i3f9FeFyUOpK/EYpug6fxKd/0rgQQLcCQatRTNVFYTIzlRbv2aMh0ZOYSAQLROlw/4EvKA+c1gGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887940; c=relaxed/simple;
	bh=EQERAeAUqfaASSXc/IWemtefhbnElFq93zKTtOoowZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApFDoAq9vVSl38mwHO8KhquwR/8+V+mLVyoyv4GVXI+blpU8d7tkGNkqMoIZmR0iIeARHD5VVYoYvrvrR8Gh9MR64WhB6G0xZhXa3AbANxJVprqqPlv3d4JFe4Wp7wrcQdHIuiYD87mlm96UiidYBsYo8jiJXNJsNLO/b4NggUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/1gtSAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A97AC4CEEA;
	Wed, 25 Jun 2025 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750887939;
	bh=EQERAeAUqfaASSXc/IWemtefhbnElFq93zKTtOoowZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/1gtSANXZ6neo3lmDnHuVs+x4tdxRJKU0zUzMr2Ss03QRVjgwlBS6s2PfEU1bVI3
	 StWalVe1jc2muhYEAbdkbsrFdqcHRALYl59yU4p0A6EIjrxwtzQzZkx15dP7T/eMGc
	 9w/Tz9l3TTqQLtV4BWEQgX4nSuH5vrkNu4ojOo8mbBYYArGCAlY4WVNCzkxmWaDrvR
	 teNK1dHHAQrj0VGjg77Lum/svTb2ZfH/ZyhWUlxHLOi9vcKCx/YRxeXWWGtfLH5I5M
	 Fn/gSPUBw6HuTV/OPqar8nvqR3n1RAgMssYu5JuzlGc2ZdIAXfZG56199FFhNLHLB1
	 /MRV2Wo5RRAKQ==
Date: Thu, 26 Jun 2025 00:45:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Create cleanup class for tpm_buf
Message-ID: <aFxuADgb2C9DaFrh@kernel.org>
References: <20250625213757.1236570-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625213757.1236570-1-jarkko@kernel.org>

On Thu, Jun 26, 2025 at 12:37:56AM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> Define a cleanup for tpm_buf, which will caused tpm_buf_destroy()
> automatically called at the end of a function scope. This will
> significantly decrease the likelihood of memory leaks.

Oops, this did not go well.

Here's a corrected version.

"Define a cleanup class for struct tpm_buf, which will take
 the responsibility of calling tpm_buf_destroy() automatically
 when tpm_buf instance is going out of scope."

For the code change itself I noticed that I missed tpm-sysfs.c
i.e., v2 coming post the feedback for this.

BR, Jarkko

