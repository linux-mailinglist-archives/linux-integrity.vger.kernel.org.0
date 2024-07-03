Return-Path: <linux-integrity+bounces-2991-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D6926962
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 22:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A19B26C26
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA53186E32;
	Wed,  3 Jul 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S/IWTZMS";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S/IWTZMS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29213DBB1;
	Wed,  3 Jul 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037477; cv=none; b=aHcuVxFxFrg7qSPkGdoekuKjH3pKfQ1QHjl8CN3n6a+bkZLjRBXtQPVgMot8PcZrakKD1Wo5kgNTxyMN42/gR/mQ7srqCy9yYWfuPxuaz/klIQko8oRAw+LQs9Ee4n1vs1cWIjKEyK5if0H6Wgp4CbypPL+B881yT6oCHpWUYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037477; c=relaxed/simple;
	bh=SQpiK44TEPrFruykt3kBmYo9BZX1HZl2Svyj+QKUNEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2SYkt/R9te9r1hr6V1zv0KaGMwwVg14XPTnQQj5Og1tiOkBSBIccpCjxg3Bv5h6tdsFfJMDMnmJSzIJKHNbVEskCIZOGoMgvp39zti/tx6+EmbBHRR0UOpp7Ti8MqFO5xUasll/DP8Vivo30Hz4nx6d3FRYDvlXmnThRGLaM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=S/IWTZMS; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=S/IWTZMS; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720037474;
	bh=SQpiK44TEPrFruykt3kBmYo9BZX1HZl2Svyj+QKUNEE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=S/IWTZMSUy7AlGM8LAvIJ1znS98TFW8MYgZ+lnih8uqo+wvwlsXGtJxDon0o3Qgx4
	 mraPuBhnou3LjQkTluGrNKL0R41q0hQtjFKLD36bLTby1x+giv/y7E744381INRMqh
	 GvJGEDsMIkq99Ge+BOq0I+rE6peXevvzcQDowb5E=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 64A7F1286C78;
	Wed, 03 Jul 2024 16:11:14 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 4ndU80lSrPBQ; Wed,  3 Jul 2024 16:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1720037474;
	bh=SQpiK44TEPrFruykt3kBmYo9BZX1HZl2Svyj+QKUNEE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=S/IWTZMSUy7AlGM8LAvIJ1znS98TFW8MYgZ+lnih8uqo+wvwlsXGtJxDon0o3Qgx4
	 mraPuBhnou3LjQkTluGrNKL0R41q0hQtjFKLD36bLTby1x+giv/y7E744381INRMqh
	 GvJGEDsMIkq99Ge+BOq0I+rE6peXevvzcQDowb5E=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C1EE3128607E;
	Wed, 03 Jul 2024 16:11:12 -0400 (EDT)
Message-ID: <922603265d61011dbb23f18a04525ae973b83ffd.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/3] tpm: Address !chip->auth in tpm_buf_append_name()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds
	 <torvalds@linux-foundation.org>, stable@vger.kernel.org, Stefan Berger
	 <stefanb@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe
	 <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, David Howells
	 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel
	 <ardb@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Date: Wed, 03 Jul 2024 16:11:10 -0400
In-Reply-To: <20240703182453.1580888-3-jarkko@kernel.org>
References: <20240703182453.1580888-1-jarkko@kernel.org>
	 <20240703182453.1580888-3-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-07-03 at 21:24 +0300, Jarkko Sakkinen wrote:
[...]
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 21a67dc9efe8..2844fea4a12a 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -211,8 +211,8 @@ struct tpm_chip {
>         u8 null_key_name[TPM2_NAME_SIZE];
>         u8 null_ec_key_x[EC_PT_SZ];
>         u8 null_ec_key_y[EC_PT_SZ];
> -       struct tpm2_auth *auth;
>  #endif
> +       struct tpm2_auth *auth;
>  };

Since auth should only be present if CONFIG_TCG_TPM2_HMAC this is
clearly an undesirable thing to do.  I think you did it because in a
later patch you want to collapse the hmac sessions to use a single
routine, but you can make that check with the preprocessor __and
function defined in kconfig.h:

if (__and(IS_ENABLED(CONFIG_TCG_TPM2_HMAC), chip->auth))

Which will become 0 if the config is not enabled and chip->auth if it
is, thus eliminating the code in the former case while not causing the
compiler to complain about chip->auth not being defined even if it's
under the config parameter.

James


