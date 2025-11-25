Return-Path: <linux-integrity+bounces-7675-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC2C85CB5
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A698D4E03F8
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE59321A421;
	Tue, 25 Nov 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke0V/g7+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45711F3BAC;
	Tue, 25 Nov 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084990; cv=none; b=N1abJHDS+mLhBn+HiOdV46bVZtH4DoSs9BsIvXYVdDb1asJ4qKOGdTTaCg+iIgwwqfcy1Q12Uk9yLEJaFhVeVsVLjRoMFa5Ew2NtBOeusKLToDbJ9BDc+8bHe71duma/PmFUVxjMUB6fbMh4Vxc6qA8ueSjI7uDkDy7WaC9fbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084990; c=relaxed/simple;
	bh=fdwtD7BLe3GMPBXoCZtZI46pE5g9Wj4xsjpXFqGOWfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4UEQ7fGPLOQmX0V+GO8jiE1ICk4lXNI7fCmEuug6Jp5vjfNV4SXOGA4/pph0nm6MJxNFXxsag/7/BYmDpgTv40o22HVY+fb89GQMvJ1VYvYYuxR11aTM9qpIIOUraSEv0K5kIZS3UGNjhTUVeegadb7no9owbriRt51NJqsQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke0V/g7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8098C4CEF1;
	Tue, 25 Nov 2025 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764084990;
	bh=fdwtD7BLe3GMPBXoCZtZI46pE5g9Wj4xsjpXFqGOWfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ke0V/g7+1XK1SuSP1qiVV6O68EGQFlbZVTYFCBkKMq8Ek/HaHuqEdvLYEoEkqJVJP
	 gylqnnN71CO6t/EGGAgSoVixA9TJSJCeCn5FCmLXjJTSHrPQnCsrQ1u/DWW8BKfDmN
	 s4OPxx2sIJd69eKJJnbekuax2N/HLfJpGIW4OFaZHn6vwvH5FH11SDjITSbguGMJif
	 vpkH/WS9r9jtmhRctYQ8YqclS86j3rxIigMqkH+g9mchO64X7jHHZnr/Wf3mO1TNTd
	 Ufn75HrjcuvKwWWbNJCqlKhsiWw0sj5afqOj3Mgbxb1g2WPpNWHYg1hTto+n7hZ+X3
	 4EXchuVzChj2A==
Date: Tue, 25 Nov 2025 17:36:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm_crb: Fix a spelling mistake
Message-ID: <aSXM-v5FirQQopOg@kernel.org>
References: <20251125023030.3023-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125023030.3023-1-chuguangqing@inspur.com>

On Tue, Nov 25, 2025 at 10:30:30AM +0800, Chu Guangqing wrote:
> The spelling of the word "requrest" is incorrect; it should be "request".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index c75a531cfb98..e094c517b96e 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -412,7 +412,7 @@ static int crb_do_acpi_start(struct tpm_chip *chip)
>  #ifdef CONFIG_ARM64
>  /*
>   * This is a TPM Command Response Buffer start method that invokes a
> - * Secure Monitor Call to requrest the firmware to execute or cancel
> + * Secure Monitor Call to request the firmware to execute or cancel
>   * a TPM 2.0 command.
>   */
>  static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
> -- 
> 2.43.7
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

