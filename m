Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD87280F9
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjFHNQZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjFHNQZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 09:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1736126B2
        for <linux-integrity@vger.kernel.org>; Thu,  8 Jun 2023 06:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9379B61272
        for <linux-integrity@vger.kernel.org>; Thu,  8 Jun 2023 13:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7D8C433EF;
        Thu,  8 Jun 2023 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686230183;
        bh=FvlFmDL5KCFEx9RvnVpnGFUOv20bbkmDzfuLyHmyB74=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=O32Exwy5L6D1wCaregDWkVfkcIieWz/F539ZmalzqXD2OlkpaOHkKLhbUs/uu1ntM
         4UMzjKV+ChnS/yGysMukc7xH/wxjVkeRjjgLHS2UHPm85UJFKJxoNVaTOVn8ibHr+5
         S0APT8iSF+LXtnrZMjqGxCqECpwHR/6Jccnwbko54Cn2euX5NraD3fz/FTGZAdartT
         kFNLKQGs3MWp2+SOjiSw51SdAbG3waqkhx6W4gACUeGDpb5noEmuzDUmBr/jxI4QKj
         Nv9oZi61lx7fNdRq4HUiGPsGyp9PQ3eQGHlu3OFLJZSvZYNpnnEZnCnIVqmhA3i0S2
         K06GRvzSXB0NQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Jun 2023 16:16:18 +0300
Message-Id: <CT7APLUB2CWF.1ZGTUWOTPQGQH@suppilovahvero>
Cc:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Russell Currey" <ruscur@russell.cc>,
        "Nageswara R Sastry" <rnsastry@linux.ibm.com>,
        "George Wilson" <gcwilson@linux.ibm.com>, <stable@vger.kenrnel.org>
Subject: Re: [PATCH v2] security/integrity: fix pointer to ESL data and its
 size on pseries
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "linux-integrity" <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230608120444.382527-1-nayna@linux.ibm.com>
In-Reply-To: <20230608120444.382527-1-nayna@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 8, 2023 at 3:04 PM EEST, Nayna Jain wrote:
> On PowerVM guest, variable data is prefixed with 8 bytes of timestamp.
> Extract ESL by stripping off the timestamp before passing to ESL parser.
>
> Fixes: 4b3e71e9a34c ("integrity/powerpc: Support loading keys from PLPKS"=
)
> Cc: stable@vger.kenrnel.org # v6.3
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
> Changelog:
> v2: Fixed feedback from Jarkko
>       * added CC to stable
>       * moved *data declaration to same line as *db,*dbx
>     Renamed extract_data() macro to extract_esl() for clarity
>  .../integrity/platform_certs/load_powerpc.c   | 40 ++++++++++++-------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/=
integrity/platform_certs/load_powerpc.c
> index b9de70b90826..170789dc63d2 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -15,6 +15,9 @@
>  #include "keyring_handler.h"
>  #include "../integrity.h"
> =20
> +#define extract_esl(db, data, size, offset)	\
> +	do { db =3D data + offset; size =3D size - offset; } while (0)
> +
>  /*
>   * Get a certificate list blob from the named secure variable.
>   *
> @@ -55,8 +58,9 @@ static __init void *get_cert_list(u8 *key, unsigned lon=
g keylen, u64 *size)
>   */
>  static int __init load_powerpc_certs(void)
>  {
> -	void *db =3D NULL, *dbx =3D NULL;
> -	u64 dbsize =3D 0, dbxsize =3D 0;
> +	void *db =3D NULL, *dbx =3D NULL, *data =3D NULL;
> +	u64 dsize =3D 0;
> +	u64 offset =3D 0;
>  	int rc =3D 0;
>  	ssize_t len;
>  	char buf[32];
> @@ -74,38 +78,46 @@ static int __init load_powerpc_certs(void)
>  		return -ENODEV;
>  	}
> =20
> +	if (strcmp("ibm,plpks-sb-v1", buf) =3D=3D 0)
> +		/* PLPKS authenticated variables ESL data is prefixed with 8 bytes of =
timestamp */
> +		offset =3D 8;
> +
>  	/*
>  	 * Get db, and dbx. They might not exist, so it isn't an error if we
>  	 * can't get them.
>  	 */
> -	db =3D get_cert_list("db", 3, &dbsize);
> -	if (!db) {
> +	data =3D get_cert_list("db", 3, &dsize);
> +	if (!data) {
>  		pr_info("Couldn't get db list from firmware\n");
> -	} else if (IS_ERR(db)) {
> -		rc =3D PTR_ERR(db);
> +	} else if (IS_ERR(data)) {
> +		rc =3D PTR_ERR(data);
>  		pr_err("Error reading db from firmware: %d\n", rc);
>  		return rc;
>  	} else {
> -		rc =3D parse_efi_signature_list("powerpc:db", db, dbsize,
> +		extract_esl(db, data, dsize, offset);
> +
> +		rc =3D parse_efi_signature_list("powerpc:db", db, dsize,
>  					      get_handler_for_db);
>  		if (rc)
>  			pr_err("Couldn't parse db signatures: %d\n", rc);
> -		kfree(db);
> +		kfree(data);
>  	}
> =20
> -	dbx =3D get_cert_list("dbx", 4,  &dbxsize);
> -	if (!dbx) {
> +	data =3D get_cert_list("dbx", 4,  &dsize);
> +	if (!data) {
>  		pr_info("Couldn't get dbx list from firmware\n");
> -	} else if (IS_ERR(dbx)) {
> -		rc =3D PTR_ERR(dbx);
> +	} else if (IS_ERR(data)) {
> +		rc =3D PTR_ERR(data);
>  		pr_err("Error reading dbx from firmware: %d\n", rc);
>  		return rc;
>  	} else {
> -		rc =3D parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
> +		extract_esl(dbx, data, dsize, offset);
> +
> +		rc =3D parse_efi_signature_list("powerpc:dbx", dbx, dsize,
>  					      get_handler_for_dbx);
>  		if (rc)
>  			pr_err("Couldn't parse dbx signatures: %d\n", rc);
> -		kfree(dbx);
> +		kfree(data);
>  	}
> =20
>  	return rc;
> --=20
> 2.31.1

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
