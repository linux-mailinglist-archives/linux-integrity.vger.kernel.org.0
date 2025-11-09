Return-Path: <linux-integrity+bounces-7608-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C6C43866
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 05:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D92B84E1A58
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 04:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F818C008;
	Sun,  9 Nov 2025 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMGe609/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6621257E;
	Sun,  9 Nov 2025 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762663305; cv=none; b=YdwU3MRiDkzFFRua+w8JDPDqt+JGViuEtprSW1yMYghuONEezNcduZZVe1wHJpKgKv5Z08lFGomFMBAHVr6kJrtmvD5bBCou5niMj8Coy17OiZJ3QrSDDVqDYNocVkV6qaA6sfqNamByZkLBt92Tx+livdW0hsHjsgtC69Zh8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762663305; c=relaxed/simple;
	bh=8BA3ep0Sc+3QErfKfSP7MZ3FIMPJu8c+m224YJKms/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKDF9UoO+7HK47T7hgp/ROpkD6qytpWA3FzaHP4XTosPTEpgWcoYHgXo6AxH904L/iPVa7kUVSMzwEKCAdHCUpTG9U7SG+4Sa6UvuN85KnuSUyhQUqbII1t+Amq+yFICHX/g+REpCxI7YlrMMUGoJh3TQPDyYRIlD8howw99XkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMGe609/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88547C19421;
	Sun,  9 Nov 2025 04:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762663304;
	bh=8BA3ep0Sc+3QErfKfSP7MZ3FIMPJu8c+m224YJKms/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMGe609/+FgNccqAnYdBDn9n8Od2mcnR3bZAwOcHyaSB2lXM3WvTTwatl4zieeNWg
	 v/zIIXMJoaX2k7VVJKwiWTj5nQT91dsJHpOhqGkmzld6mwmg9EOyYG4HcvmuFF6zlO
	 zPHzRGG+Vk9w0OMxX8nWd6sbd/1Oes9E32nYqsSTtDnF9fBABSSB8gOBLfoyeqDT4/
	 rbjPp0Vk37a2l6AQ081/IYsfwHaiy60INRyN6HP6HYlGIQYNcLFJQ22szF8FBMw2T2
	 qlDGzqyCfJYebGQ5ePRviSwD7wuRHRnkzI3VgAI5mSv5aYWzzpJIEhUhyozFKF4DnH
	 F3pk8c1OgSEIA==
Date: Sun, 9 Nov 2025 06:41:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	sudeep.holla@arm.com, Prachotan.Bathi@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_crb: add missing loc parameter to kerneldoc
Message-ID: <aRAbhXdsupKGtDIP@kernel.org>
References: <20251028020921.214189-1-stuart.yoder@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028020921.214189-1-stuart.yoder@arm.com>

On Mon, Oct 27, 2025 at 09:09:21PM -0500, Stuart Yoder wrote:
> Update the kerneldoc parameter definitions for __crb_go_idle
> and __crb_cmd_ready to include the loc parameter.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@arm.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index c75a531cfb98..0eb48429f73d 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -179,6 +179,7 @@ static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete
>   *
>   * @dev:  crb device
>   * @priv: crb private data
> + * @loc:  locality
>   *
>   * Write CRB_CTRL_REQ_GO_IDLE to TPM_CRB_CTRL_REQ
>   * The device should respond within TIMEOUT_C by clearing the bit.
> @@ -233,6 +234,7 @@ static int crb_go_idle(struct tpm_chip *chip)
>   *
>   * @dev:  crb device
>   * @priv: crb private data
> + * @loc:  locality
>   *
>   * Write CRB_CTRL_REQ_CMD_READY to TPM_CRB_CTRL_REQ
>   * and poll till the device acknowledge it by clearing the bit.
> -- 
> 2.34.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

