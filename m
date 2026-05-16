Return-Path: <linux-integrity+bounces-9585-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDQ1NBrFB2pEHwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9585-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 03:15:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F2559B37
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 03:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E770B3002910
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 01:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702E204F8B;
	Sat, 16 May 2026 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQglXOu/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1F2882C5;
	Sat, 16 May 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894101; cv=none; b=XMOSgkLXep+wBf5YSXcmbnu8RAv06O7gV3KU88A73iiWmxVgtRqrlgtBQlyOnWWTjzP5WLpnAA8LZfyb0xbz6aA83mh+Kh0a1EmBix9mXG4aQIUueGp9n2yJw9o0JD8eRR0lUapyLdaUEzcE/3JqK3USbfSYZ1xBVyi5l2Tz2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894101; c=relaxed/simple;
	bh=wj8x1Ih6zO9ihfKZ3+1a++yryGF8Y7JsouhD+vSSdIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJqGpm1VcPMbDVAYS6SS8qLtfv2ptEkQTbBd0W3PrN0aAl/5Lsi1Vw4tIeiOl2cRbDsEUfCgiakOz1FYaIw6BWfOJDj02v3bMuZRzxdkVCr6+jVz+ufkK3UBJaLBAc734/davwc3yBG3TbuY58JVVxvtN0cVMlEvOKfqX/uXwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQglXOu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2062C2BCB0;
	Sat, 16 May 2026 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778894101;
	bh=wj8x1Ih6zO9ihfKZ3+1a++yryGF8Y7JsouhD+vSSdIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQglXOu/OPSiGJ7SsspoyqFNd6qNOfb3+U0Qqsusv2/5z6aew2kFZ/G6D1mauMCxz
	 V7yzq0OFGoJwe+WxeNA293LmyX+X/MmMsK5gWmmVPUeiBrwWStAEY9eZvUBV4MKxZp
	 BfAgROfGAEEjPd0qkzgcZDQ4KIsY8Ni0Su5RucgvWySLXyj2QVojKPwrHMQl8bFJLH
	 Rjzy/0IolOAgh/FX37pGqh0l8MXWOibp7wL3GnohIfNfQrfZlMmaN5Qvye74giOrE8
	 9vlXZ3BHj+mkkonnx2zqrUqfM8XKdhCyxEx4UEkN8i8EQLaNEKumv/Q/oLU574VuG/
	 WK6b637FmX1Uw==
Date: Sat, 16 May 2026 04:14:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during
 probe
Message-ID: <agfFERWn-5b-0H24@kernel.org>
References: <2848144.mvXUDI8C0e@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2848144.mvXUDI8C0e@rafael.j.wysocki>
X-Rspamd-Queue-Id: C86F2559B37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-9585-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 06:16:23PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> tpm_crb driver.
> 
> Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
>  static int crb_acpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct acpi_device *device = ACPI_COMPANION(dev);
>  	struct acpi_table_tpm2 *buf;
> +	struct acpi_device *device;
>  	struct crb_priv *priv;
>  	struct tpm_chip *chip;
>  	struct tpm2_crb_smc *crb_smc;
> @@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
>  	u32 sm;
>  	int rc;
>  
> +	device = ACPI_COMPANION(dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	status = acpi_get_table(ACPI_SIG_TPM2, 1,
>  				(struct acpi_table_header **) &buf);
>  	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> 
> 
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

BR, Jarkko

