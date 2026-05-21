Return-Path: <linux-integrity+bounces-9623-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJrNLIN8D2rLMgYAu9opvQ
	(envelope-from <linux-integrity+bounces-9623-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:43:31 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CE5AC29D
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 23:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF92B302571C
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AC6399D0C;
	Thu, 21 May 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6NMsldu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3536CDE3;
	Thu, 21 May 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779399809; cv=none; b=UfOmjlYCEXejebS7KvNHGjPg7G3x0g4MGsO1ntBJSoRmqR6jiQZdpmF8fj49xsC1VqG36sR9qO1yfygoeBKlcdPYgGtZ4tIWd0BxiRrdlonnPr8MsLNIl97H4db74GT3EXH8OFi/ZdaOtoULgft7sjH33lQ933ylCwClCfZ0Siw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779399809; c=relaxed/simple;
	bh=Zw1IrQoeEZq0rHz/dyK7SWUBW7w1v3hBpjgtUh4WrZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdWYK/9bwzsx0bxOv9xdDg3vla2BGOiaBciGh1qvAnBFQVZtB0aa8NB4wgAn1p/rXjFv2omWgfASD95GWPmfnGrWkSG1AeFC7AfJKJ/uka6TirF10R3e23yxI02xnYML78EHpSkHiYDk7b0n4KYzj0/EJRXq4VY2KzyIKSokbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6NMsldu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 067291F000E9;
	Thu, 21 May 2026 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779399807;
	bh=sAcHpEMzFo+L/3yU5vscq+A1ZKs5ukOn3xu+qJdsdQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g6NMsldub9EByQIUUeeDNudrk4bi6Lv7OOIi9FNI8OkH5GKT6o9diB2+fEZk2BOJa
	 fC4tlKrhMJ8Zq7Vj2eSXhzfVWdNhUNithCzy5avbpwnvMhD2+nPDImgx4w4+0yF7uq
	 PXp1dh4Cnj+Dxs7EHpsvLBVFUw2V0LEZ9z3ZZHI4PSx44jIrcMWkwlgoyMVQYSzzZp
	 Z+fxpdKjfN5ckwzIylO+9Vedp2rBN1yXPnWi3ZxmX2E7fbUcO+S8vPwIE9CqPgkpXI
	 FZf7/89bDKjyhBup9b2j375mBXZCSrUWA34JrzGahF31fv0rfAhS/h2IGnSduCo9Nm
	 W1BCoMx7GNJpQ==
Date: Fri, 22 May 2026 00:43:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
Message-ID: <ag98e88678TSfwxG@kernel.org>
References: <20260518134035.644762-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518134035.644762-2-u.kleine-koenig@baylibre.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,bootlin.com,tuxon.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9623-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,baylibre.com:email,cheri-alliance.org:url]
X-Rspamd-Queue-Id: 178CE5AC29D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 03:40:35PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> While touching all these arrays, unify usage of whitespace in the list
> terminator.
> 
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> the mentioned change to i2c_device_id is the following:
> 
> 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> 	index 23ff24080dfd..aebd3a5e90af 100644
> 	--- a/include/linux/mod_devicetable.h
> 	+++ b/include/linux/mod_devicetable.h
> 	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
> 
> 	 struct i2c_device_id {
> 		char name[I2C_NAME_SIZE];
> 	-	kernel_ulong_t driver_data;	/* Data private to the driver */
> 	+	union {
> 	+		/* Data private to the driver */
> 	+		kernel_ulong_t driver_data;
> 	+		const void *driver_data_ptr;
> 	+	};
> 	 };
> 
> 	 /* pci_epf */
> 
> and this requires that .driver_data is assigned via a named initializer
> for static data. This requirement isn't a bad one because named
> initializers are also much better readable than list initializers.
> 
> The union added to struct i2c_device_id enables further cleanups like:
> 
> 	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
> 	index 0123ca8157a8..dfb0b07500a7 100644
> 	--- a/drivers/regulator/ad5398.c
> 	+++ b/drivers/regulator/ad5398.c
> 	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
> 	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};
> 
> 	 static const struct i2c_device_id ad5398_id[] = {
> 	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
> 	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
> 	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
> 	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
> 	 	{ }
> 	 };
> 	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
> 	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
> 	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
> 	 	struct regulator_config config = { };
> 	 	struct ad5398_chip_info *chip;
> 	-	const struct ad5398_current_data_format *df =
> 	-	                (struct ad5398_current_data_format *)id->driver_data;
> 	+	const struct ad5398_current_data_format *df = id->driver_data;
> 
> 	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> 	 	if (!chip)
> 
> that are an improvement for readability (again!) and it keeps some
> properties of the pointers (here: being const) without having to pay
> attention for that. (I didn't find a tpm driver that benefits, so this
> is "only" a regulator driver example.)
> 
> My additional motivation for this effort is CHERI[1]. This is a hardware
> extension that uses 128 bit pointers but unsigned long is still 64 bit.
> So with CHERI you cannot store pointers in unsigned long variables.

I don't understand why any of this should be merged to be honest, and
why I should care about CHERI when reviewing mainline patches.

Clean up can be side-effect but not a purpose.

> 
> Best regards
> Uwe
> 
> [1] https://cheri-alliance.org/discover-cheri/
>     https://lwn.net/Articles/1037974/
> ---
>  drivers/char/tpm/st33zp24/i2c.c     | 4 ++--
>  drivers/char/tpm/tpm_i2c_atmel.c    | 4 ++--
>  drivers/char/tpm/tpm_i2c_infineon.c | 8 ++++----
>  drivers/char/tpm/tpm_i2c_nuvoton.c  | 6 +++---
>  drivers/char/tpm/tpm_tis_i2c.c      | 4 ++--
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index 81348487c125..74b25af5ce79 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -133,8 +133,8 @@ static void st33zp24_i2c_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id st33zp24_i2c_id[] = {
> -	{ TPM_ST33_I2C },
> -	{}
> +	{ .name = TPM_ST33_I2C },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
>  
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
> index 9fd73049821f..6891642a7f51 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -199,8 +199,8 @@ static void i2c_atmel_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id i2c_atmel_id[] = {
> -	{ I2C_DRIVER_NAME },
> -	{}
> +	{ .name = I2C_DRIVER_NAME },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, i2c_atmel_id);
>  
> diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
> index 8b7d32de0b2e..29cf2f998405 100644
> --- a/drivers/char/tpm/tpm_i2c_infineon.c
> +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> @@ -664,10 +664,10 @@ static int tpm_tis_i2c_init(struct device *dev)
>  }
>  
>  static const struct i2c_device_id tpm_tis_i2c_table[] = {
> -	{"tpm_i2c_infineon"},
> -	{"slb9635tt"},
> -	{"slb9645tt"},
> -	{},
> +	{ .name = "tpm_i2c_infineon" },
> +	{ .name = "slb9635tt" },
> +	{ .name = "slb9645tt" },
> +	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_table);
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index d44903b29929..71c59eeaccab 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -624,9 +624,9 @@ static void i2c_nuvoton_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id i2c_nuvoton_id[] = {
> -	{"tpm_i2c_nuvoton"},
> -	{"tpm2_i2c_nuvoton", .driver_data = I2C_IS_TPM2},
> -	{}
> +	{ .name = "tpm_i2c_nuvoton" },
> +	{ .name = "tpm2_i2c_nuvoton", .driver_data = I2C_IS_TPM2},
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, i2c_nuvoton_id);
>  
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> index 6cd07dd34507..21d66bfba6a8 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -375,8 +375,8 @@ static void tpm_tis_i2c_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id tpm_tis_i2c_id[] = {
> -	{ "tpm_tis_i2c" },
> -	{}
> +	{ .name = "tpm_tis_i2c" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  
> -- 
> 2.47.3
> 

BR, Jarkko

