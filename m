Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAE724E4D
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjFFUvs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjFFUvs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 16:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596910D5
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 13:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A4C4630F0
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 20:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51ACC433EF;
        Tue,  6 Jun 2023 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686084706;
        bh=2jeY/zYw9+efJavnBVCx0YddVH9y3b//cWixqkEFE1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMQWaUAglPJUYb3Isn/Jv/wSsc3/vgOB6BgFkPbWpmSYq+pD6zVnOG0wjKGOWGIoI
         rIE2U5t83mEQaVjUGQQYYK2QEz4nmcziyEbhTI9ntiUWTVVywfGV6YMjRcFS6e/Ncn
         fXNd+NGJ142ocdALhQSlvCm5asPafNNY8ZCEhWPeQqUMkJZdhzRbiMvB/mcmcm/tTn
         OxyhGXiaAvAs6I1FGVYMHp2rdPnWNMLCZ33bilbE3De5yW72FDpxoOjAKeweQIDxFs
         FEvYVaV6tPwxxo3gUWoayELt0/tZ1yo/LFEsxBCji1K4u5rj1IKlFoJ+a0HadV2ZAN
         IsnjRD7N5b9vg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 23:51:41 +0300
Message-Id: <CT5V56O3NZS8.1V2L3JJWRKIOE@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "linux-integrity" <linux-integrity@vger.kernel.org>
Cc:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Russell Currey" <ruscur@russell.cc>,
        "Nageswara R Sastry" <rnsastry@linux.ibm.com>,
        "George Wilson" <gcwilson@linux.ibm.com>
Subject: Re: [PATCH] security/integrity: fix pointer to ESL data and its
 size on pseries
X-Mailer: aerc 0.14.0
References: <20230606172652.198227-1-nayna@linux.ibm.com>
In-Reply-To: <20230606172652.198227-1-nayna@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jun 6, 2023 at 8:26 PM EEST, Nayna Jain wrote:
> On PowerVM guest, variable data is prefixed with 8 bytes of timestamp.
> Extract ESL by stripping off the timestamp before passing to ESL parser.
>

Cc: stable@vger.kenrnel.org # v6.3

?

> Fixes: 4b3e71e9a34c ("integrity/powerpc: Support loading keys from PLPKS"=
)
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  .../integrity/platform_certs/load_powerpc.c   | 39 ++++++++++++-------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/=
integrity/platform_certs/load_powerpc.c
> index b9de70b90826..57768cbf1fd3 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -15,6 +15,9 @@
>  #include "keyring_handler.h"
>  #include "../integrity.h"
> =20
> +#define extract_data(db, data, size, offset)	\
> +	do { db =3D data + offset; size =3D size - offset; } while (0)
> +
>  /*
>   * Get a certificate list blob from the named secure variable.
>   *
> @@ -55,8 +58,10 @@ static __init void *get_cert_list(u8 *key, unsigned lo=
ng keylen, u64 *size)
>   */
>  static int __init load_powerpc_certs(void)
>  {
> +	void *data =3D NULL;
> +	u64 dsize =3D 0;
> +	u64 offset =3D 0;
>  	void *db =3D NULL, *dbx =3D NULL;

So... what do you need db still for?

If you meant to rename 'db' to 'data', then you should not do it, since thi=
s is
a bug fix. It is zero gain, and a factor harder backport.

> -	u64 dbsize =3D 0, dbxsize =3D 0;
>  	int rc =3D 0;
>  	ssize_t len;
>  	char buf[32];
> @@ -74,38 +79,46 @@ static int __init load_powerpc_certs(void)
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
> +		extract_data(db, data, dsize, offset);
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
> +		extract_data(dbx, data, dsize, offset);
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

BR, Jarkko
