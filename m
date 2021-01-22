Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBAF300AB6
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jan 2021 19:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbhAVSGi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 13:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:55972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbhAVSGc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 13:06:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F92223A6A;
        Fri, 22 Jan 2021 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611338751;
        bh=RWAadgTE3OBkC/7CFKgrnVcdGooeNarn5qiZczZ3+Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TL6jaYn0mzvupgHkDmXIqa9iuhcFq3T13YmqLldcmDGL5osB8mbti6TlMo6wa6g9D
         3PwJeNrHZRo+CBeWBC2PapF/ydLffUl/MD68ct0FA+iuKHUjdT1jDBuvfiKtldc3o0
         vWdBYyCfAhGX7c8wmTKL3svn0q/lSp3y8CrdM2gGWQVKDwwATfhZ+dFt8xF9YTrKsR
         0ChufAze2E5dUsJUdp4L8LHGvDzddpkCeT6k/B/gpqpBVI/eNAEx5AsDztIUJW4egA
         OEjlE27f5bOY925CQ3oAI2NpMaWhplSzaTGJvy/suIKQlKmPD+E4GcHOfy0TBvAs30
         3opMQxT7vie+Q==
Date:   Fri, 22 Jan 2021 20:05:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, kernel@pengutronix.de,
        Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 2/2] dm crypt: support using trusted keys
Message-ID: <YAsT/N8CHHNTZcj3@kernel.org>
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
 <20210122084321.24012-2-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210122084321.24012-2-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 22, 2021 at 09:43:21AM +0100, Ahmad Fatoum wrote:
> Commit 27f5411a718c ("dm crypt: support using encrypted keys") extended
> dm-crypt to allow use of "encrypted" keys along with "user" and "logon".
> 
> Along the same lines, teach dm-crypt to support "trusted" keys as well.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---

Is it possible to test run this with tmpfs? Would be a good test
target for Sumit's ARM-TEE trusted keys patches.

https://lore.kernel.org/linux-integrity/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/

/Jarkko

> Unsure on whether target_type::version is something authors increment or
> maintainers fix up. I can respin if needed.
> 
> Cc: Jan Lübbe <jlu@pengutronix.de>
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  .../admin-guide/device-mapper/dm-crypt.rst    |  2 +-
>  drivers/md/Kconfig                            |  1 +
>  drivers/md/dm-crypt.c                         | 23 ++++++++++++++++++-
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
> index 1a6753b76dbb..aa2d04d95df6 100644
> --- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
> +++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
> @@ -67,7 +67,7 @@ Parameters::
>      the value passed in <key_size>.
>  
>  <key_type>
> -    Either 'logon', 'user' or 'encrypted' kernel key type.
> +    Either 'logon', 'user', 'encrypted' or 'trusted' kernel key type.
>  
>  <key_description>
>      The kernel keyring key description crypt target should look for
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 9e44c09f6410..f2014385d48b 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -270,6 +270,7 @@ config DM_CRYPT
>  	tristate "Crypt target support"
>  	depends on BLK_DEV_DM
>  	depends on (ENCRYPTED_KEYS || ENCRYPTED_KEYS=n)
> +	depends on (TRUSTED_KEYS || TRUSTED_KEYS=n)
>  	select CRYPTO
>  	select CRYPTO_CBC
>  	select CRYPTO_ESSIV
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 7eeb9248eda5..6c7c687e546c 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -37,6 +37,7 @@
>  #include <linux/key-type.h>
>  #include <keys/user-type.h>
>  #include <keys/encrypted-type.h>
> +#include <keys/trusted-type.h>
>  
>  #include <linux/device-mapper.h>
>  
> @@ -2452,6 +2453,22 @@ static int set_key_encrypted(struct crypt_config *cc, struct key *key)
>  	return 0;
>  }
>  
> +static int set_key_trusted(struct crypt_config *cc, struct key *key)
> +{
> +	const struct trusted_key_payload *tkp;
> +
> +	tkp = key->payload.data[0];
> +	if (!tkp)
> +		return -EKEYREVOKED;
> +
> +	if (cc->key_size != tkp->key_len)
> +		return -EINVAL;
> +
> +	memcpy(cc->key, tkp->key, cc->key_size);
> +
> +	return 0;
> +}
> +
>  static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string)
>  {
>  	char *new_key_string, *key_desc;
> @@ -2484,6 +2501,10 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
>  		   !strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
>  		type = &key_type_encrypted;
>  		set_key = set_key_encrypted;
> +	} else if (IS_ENABLED(CONFIG_TRUSTED_KEYS) &&
> +	           !strncmp(key_string, "trusted:", key_desc - key_string + 1)) {
> +		type = &key_type_trusted;
> +		set_key = set_key_trusted;
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -3555,7 +3576,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  static struct target_type crypt_target = {
>  	.name   = "crypt",
> -	.version = {1, 22, 0},
> +	.version = {1, 23, 0},
>  	.module = THIS_MODULE,
>  	.ctr    = crypt_ctr,
>  	.dtr    = crypt_dtr,
> -- 
> 2.30.0
> 
> 
