Return-Path: <linux-integrity+bounces-6173-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B1AB21B6
	for <lists+linux-integrity@lfdr.de>; Sat, 10 May 2025 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B381175845
	for <lists+linux-integrity@lfdr.de>; Sat, 10 May 2025 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750951E3790;
	Sat, 10 May 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRm0JemU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE96125;
	Sat, 10 May 2025 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746863084; cv=none; b=dvxemJYYdHql5tIsuHpTd0TrADLnQ/+snF2RrkdMH+9M3aMeEdlSBf9O6zchKhdlpQDNS9JtipW5TKCH9HutN0ZLw+Hq9Jso8hyLeqrnQJfHJ3hrOyCUEK/2F3c7V5NYFvIv54Hlw1lciMF+YuY6KhWBY1rQf0vdZE8b5D9oTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746863084; c=relaxed/simple;
	bh=bE/SOpoChEP71E9o00tKei1ZQQ2RQ/5dOoWOaqj9An8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP/OBrYFdDG1ixLd2ut2PewqpAiTsRsRFnkpFGq1Pv904SFd3uG4T5Vv0QXn/E5lhLCaOg854qb/ZDB9gehWxylG5zAQ+BePa6hYAA0ha2/OwzLsK2H/6GwDH3fq5E5Jp9fHW91jA+DufrcfGVw94uJQcyC59f+BEPbelRxotJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRm0JemU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA1C4CEE2;
	Sat, 10 May 2025 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746863083;
	bh=bE/SOpoChEP71E9o00tKei1ZQQ2RQ/5dOoWOaqj9An8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRm0JemUldpe+AgpDLQ5gUzWpGiNST07Xb7zIxeqwnu7jsSZr1yS4/lz4mfza2rln
	 G7AyXvCic3ERDJlHJMfN3/S7aWRxrb7rmLDTtta01a79D3ACZLBzNl2+Zd4CVFHMqs
	 quMc08ZsU6wqlDsG6c5lHSD5KEpOOdNF1h70gGSb4W8qvFDaK7kw0dKtNwzqtYeQgU
	 zmm/Yxvof1Ps+yJAHT7+PbjkbgIV7njlN6hU0BumHXRHQ8/Aw16DO7Lf8ciKRklKi3
	 JDoafNUlWi1+P/wswBxr6C1sL3xDClwUVa6Rsq0Wk/bcrQXS2SN5ixpLivo249eC2O
	 Ja0cRETdRmAjw==
Date: Sat, 10 May 2025 10:44:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, Peter Huewe <peterhuewe@gmx.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-integrity@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 1/4] tpm: add buf_size parameter in the .send callback
Message-ID: <aB8D5syofPSqjzns@kernel.org>
References: <20250509085713.76851-1-sgarzare@redhat.com>
 <20250509085713.76851-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509085713.76851-2-sgarzare@redhat.com>

On Fri, May 09, 2025 at 10:57:10AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add a new `buf_size` parameter to the `.send` callback in `tpm_class_ops`.
> This parameter will allow drivers to differentiate between the actual
> command length to send and the total buffer size. Currently `buf_now` is
> not used, but it will be used to implement devices with synchronous send()
> to send the command and receive the response on the same buffer.
> 
> Also rename the previous parameter `len` to `cmd_len` in the declaration
> to make it clear that it contains the length in bytes of the command
> stored in the buffer. The semantics don't change and it can be used as
> before by drivers. This is an optimization since the drivers could get it
> from the header, but let's avoid duplicating code.
> 
> While we are here, resolve a checkpatch warning:
>   WARNING: Unnecessary space before function pointer arguments
>   #66: FILE: include/linux/tpm.h:90:
>   +	int (*send) (struct tpm_chip *chip, u8 *buf, size_t cmd_len,
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
> - rework the commit description [Jarkko]
> ---
>  include/linux/tpm.h                  | 3 ++-
>  drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
>  drivers/char/tpm/tpm-interface.c     | 2 +-
>  drivers/char/tpm/tpm_atmel.c         | 3 ++-
>  drivers/char/tpm/tpm_crb.c           | 2 +-
>  drivers/char/tpm/tpm_ftpm_tee.c      | 4 +++-
>  drivers/char/tpm/tpm_i2c_atmel.c     | 3 ++-
>  drivers/char/tpm/tpm_i2c_infineon.c  | 3 ++-
>  drivers/char/tpm/tpm_i2c_nuvoton.c   | 3 ++-
>  drivers/char/tpm/tpm_ibmvtpm.c       | 6 ++++--
>  drivers/char/tpm/tpm_infineon.c      | 3 ++-
>  drivers/char/tpm/tpm_nsc.c           | 3 ++-
>  drivers/char/tpm/tpm_svsm.c          | 3 ++-
>  drivers/char/tpm/tpm_tis_core.c      | 3 ++-
>  drivers/char/tpm/tpm_tis_i2c_cr50.c  | 6 ++++--
>  drivers/char/tpm/tpm_vtpm_proxy.c    | 4 +++-
>  drivers/char/tpm/xen-tpmfront.c      | 3 ++-
>  17 files changed, 37 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 9ac9768cc8f7..7ac390ec89ce 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -87,7 +87,8 @@ struct tpm_class_ops {
>  	const u8 req_complete_val;
>  	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
>  	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
> -	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
> +	int (*send)(struct tpm_chip *chip, u8 *buf, size_t cmd_len,
> +		    size_t buf_size);

I'm sorry but now that I look at this, just for the sake of consistency:

	int (*send)(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
		    size_t cmd_len);

I.e. match the order and parameter names from tpm_try_transmit().

BR, Jarkko

