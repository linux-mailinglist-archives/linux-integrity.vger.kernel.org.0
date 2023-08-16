Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA477EAC7
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 22:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346168AbjHPUfZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346170AbjHPUfF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 16:35:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D22702;
        Wed, 16 Aug 2023 13:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47376629A;
        Wed, 16 Aug 2023 20:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34F8C433C7;
        Wed, 16 Aug 2023 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692218103;
        bh=69CSUoHjvcbzQmLZgZvlRFMyyoRreAxWnLdId+qirRY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=jDjFdkLX6I3NRjPFe6Aud1EBeA4/6rrjpVUBWerF/7OAUcfMm13siySpO+gyEEpQH
         twV+DNqq0W3kMLbRcFHAr+ubsoR12ARBWWFw03EF1y3lbQ7RD7HjVZzFsFoQUYoFyA
         KGVe8SZL6wwYBoU5tN9sLBZ9gHwRgbPh/gpLVAld+U351D/Gf0P8/mNTiJ8b5LeMp1
         4nXlpwUD278QMAMLcXcu7imy6GvpEKYuKFy4JGt6kinx+lt9JrInxkqI3kkrguxYSr
         Wa/YAdheIFw+Ickri8dEyMaO1VmDCJi3LuX+YF0im1KTCbPgehRjYUw1oTxCdu2EIP
         IehbNMqcDguAQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 16 Aug 2023 23:34:59 +0300
Message-Id: <CUU9932NG5XO.1RU2BEN4F9FA9@suppilovahvero>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        <inux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] integrity: PowerVM support for loading CA keys
 on machine keyring
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
 <20230815112722.1591829-2-nayna@linux.ibm.com>
In-Reply-To: <20230815112722.1591829-2-nayna@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Aug 15, 2023 at 2:27 PM EEST, Nayna Jain wrote:
> Keys that derive their trust from an entity such as a security officer,
> administrator, system owner, or machine owner are said to have "imputed
> trust". CA keys with imputed trust can be loaded onto the machine keyring=
.
> The mechanism for loading these keys onto the machine keyring is platform
> dependent.
>
> Load keys stored in the variable trustedcadb onto the .machine keyring
> on PowerVM platform.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../integrity/platform_certs/keyring_handler.c  |  8 ++++++++
>  .../integrity/platform_certs/keyring_handler.h  |  5 +++++
>  .../integrity/platform_certs/load_powerpc.c     | 17 +++++++++++++++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/securi=
ty/integrity/platform_certs/keyring_handler.c
> index 8a1124e4d769..1649d047e3b8 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -69,6 +69,14 @@ __init efi_element_handler_t get_handler_for_mok(const=
 efi_guid_t *sig_type)
>  	return NULL;
>  }
> =20
> +__init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *s=
ig_type)
> +{
> +	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) =3D=3D 0)
> +		return add_to_machine_keyring;
> +
> +	return NULL;
> +}
> +
>  /*
>   * Return the appropriate handler for particular signature list types fo=
und in
>   * the UEFI dbx and MokListXRT tables.
> diff --git a/security/integrity/platform_certs/keyring_handler.h b/securi=
ty/integrity/platform_certs/keyring_handler.h
> index 212d894a8c0c..6f15bb4cc8dc 100644
> --- a/security/integrity/platform_certs/keyring_handler.h
> +++ b/security/integrity/platform_certs/keyring_handler.h
> @@ -29,6 +29,11 @@ efi_element_handler_t get_handler_for_db(const efi_gui=
d_t *sig_type);
>   */
>  efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
> =20
> +/*
> + * Return the handler for particular signature list types for CA keys.
> + */
> +efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type=
);
> +
>  /*
>   * Return the handler for particular signature list types found in the d=
bx.
>   */
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/=
integrity/platform_certs/load_powerpc.c
> index 170789dc63d2..339053d9726d 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -59,6 +59,7 @@ static __init void *get_cert_list(u8 *key, unsigned lon=
g keylen, u64 *size)
>  static int __init load_powerpc_certs(void)
>  {
>  	void *db =3D NULL, *dbx =3D NULL, *data =3D NULL;
> +	void *trustedca;
>  	u64 dsize =3D 0;
>  	u64 offset =3D 0;
>  	int rc =3D 0;
> @@ -120,6 +121,22 @@ static int __init load_powerpc_certs(void)
>  		kfree(data);
>  	}
> =20
> +	data =3D get_cert_list("trustedcadb", 12,  &dsize);
> +	if (!data) {
> +		pr_info("Couldn't get trustedcadb list from firmware\n");
> +	} else if (IS_ERR(data)) {
> +		rc =3D PTR_ERR(data);
> +		pr_err("Error reading trustedcadb from firmware: %d\n", rc);
> +	} else {
> +		extract_esl(trustedca, data, dsize, offset);
> +
> +		rc =3D parse_efi_signature_list("powerpc:trustedca", trustedca, dsize,
> +					      get_handler_for_ca_keys);
> +		if (rc)
> +			pr_err("Couldn't parse trustedcadb signatures: %d\n", rc);
> +		kfree(data);
> +	}
> +
>  	return rc;
>  }
>  late_initcall(load_powerpc_certs);
> --=20
> 2.31.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
