Return-Path: <linux-integrity+bounces-9629-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HKOHmucD2rBNwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9629-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:59:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 193095AD2BE
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 01:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B9DD307C4E1
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6CF37BE65;
	Thu, 21 May 2026 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWhFksnX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F91345751;
	Thu, 21 May 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407303; cv=none; b=Wrux3On837rSNEpMEknj59VtxOhnZDwQrYrJgsWN7hyVAEaT3jFu2nbQXPlyqnjS3jw50D2gDNCwCsIXYlzMGjd+m0ZSwNEq5LEvxhdk30iieZ4t8vfH5NlYipvll+Z/F3rcIClLkDGyaqVEE2DJqCgAwu/MkpyiRD/LLmRQaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407303; c=relaxed/simple;
	bh=UlF9gJjEMVY+E/7L2Pp90ctu+/ripQkiR44EgY80wng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQzqkFFEyztFxjfcjzsIExmDjVYAlCysrbM3FSw/D1tQJYkiWR2Z5njacKjeeebzSW7dvvqxHqo+YKzizzjNa9qXMlIaLvr/MBwDXFNyGfx2Us5HrTPnsUf6ys+ApWMJKKJrApIzznHl0EyZb1gADptL0oQmPTy6xXRjkmlWKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWhFksnX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EAB811F000E9;
	Thu, 21 May 2026 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779407292;
	bh=2pEEr3fcws8uQJeACuJVg46rHNKglVXFNsZQQpv51yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iWhFksnXX48OJ53XG/uwmKMLqm13P/1J0TwbW27HAYqrnhrA/g0ZduLLQxu5/h3G0
	 vCgGOO0gzSwAv8Pv4kL3SmfFModOgC9XvABitcyR2FN1Ky46CTofALaYTCOWWSAEGm
	 JCDrG2NnToB37JzMNPhq/16OEMPkT2HYIzZcfuenhJa5ErvnqWtuhMwXwyQac5asUx
	 4Ksee/ziz4Qnu57UXabtfcDr6fREeglIf9yUorYKk7tdQGcNlaiHbqBn9pPh8cOD/W
	 uVLMT0ptzW5oJjV3rdEUgYEe/6iD+bsZdLmeSkmPNSCMA03iFaun7ii2/Veprnj3II
	 yCa4TP3uWSuOA==
Date: Fri, 22 May 2026 02:48:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jim Broadus <jbroadus@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
Message-ID: <ag-ZuEt4uXnrO8AK@kernel.org>
References: <20260519060926.103727-1-jbroadus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519060926.103727-1-jbroadus@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9629-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: 193095AD2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:09:26PM -0700, Jim Broadus wrote:
> Some TPMs fail to grant locality when requested immediately after being
> relinquished. In this case, the TPM_ACCESS_REQUEST_USE bit of the
> TPM_ACCESS register is cleared immediately without setting
> TPM_ACCESS_ACTIVE_LOCALITY.
> 
> This issue can be seen at boot since tpm_chip_start, called right
> after locality is relinquished, fails. This causes the probe to fail:
> 
> tpm_tis MSFT0101:00: probe with driver tpm_tis failed with error -1
> 
> This occurs on some older Dell Latitudes and maybe others. To work
> around this, add a "settle" boolean param to tpm_tis. When this is
> enabled, a delay is added after locality is relinquished.
> 
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>

It would be better idea first to replace priv->manufacturer_id with
priv->did_vid, and make necessary changes to sites where it is used.

Then in the if-statement compare DID/VID of the device to priv->did_vid
and apply quirk only if it matches.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  drivers/char/tpm/tpm_tis.c                      | 7 +++++++
>  drivers/char/tpm/tpm_tis_core.c                 | 3 +++
>  drivers/char/tpm/tpm_tis_core.h                 | 1 +
>  4 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..5b7111033fbb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7651,6 +7651,13 @@ Kernel parameters
>  			defined by Trusted Computing Group (TCG) see
>  			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
>  
> +	tpm_tis.settle= [HW,TPM]
> +			Format: <bool>
> +			When enabled, this adds a delay after locality is
> +			relinquished. Some TPMs will fail to grant locality if
> +			requested immediately after being relinquished. This
> +			causes the probe to fail.
> +
>  	tp_printk	[FTRACE]
>  			Have the tracepoints sent to printk as well as the
>  			tracing ring buffer. This is useful for early boot up
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 9aa230a63616..8ac0ea78570e 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -101,6 +101,10 @@ module_param(force, bool, 0444);
>  MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
>  #endif
>  
> +static bool settle;
> +module_param(settle, bool, 0444);
> +MODULE_PARM_DESC(settle, "Add settle time after relinquish");
> +
>  #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
>  static int has_hid(struct acpi_device *dev, const char *hid)
>  {
> @@ -242,6 +246,9 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  	if (itpm || is_itpm(ACPI_COMPANION(dev)))
>  		set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
>  
> +	if (settle)
> +		set_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &phy->priv.flags);
> +
>  	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
>  				 ACPI_HANDLE(dev));
>  }
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 21d79ad3b164..68be26fa5817 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -184,6 +184,9 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>  		__tpm_tis_relinquish_locality(priv, l);
>  	mutex_unlock(&priv->locality_count_mutex);
>  
> +	if (test_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &priv->flags))
> +		tpm_msleep(TPM_TIMEOUT);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 6c3aa480396b..413cac5e0f31 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -90,6 +90,7 @@ enum tpm_tis_flags {
>  	TPM_TIS_DEFAULT_CANCELLATION	= 2,
>  	TPM_TIS_IRQ_TESTED		= 3,
>  	TPM_TIS_STATUS_VALID_RETRY	= 4,
> +	TPM_TIS_SETTLE_AFTER_RELINQUISH	= 5,
>  };
>  
>  struct tpm_tis_data {
> -- 
> 2.54.0
> 

BR, Jarkko

