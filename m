Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4377EB77
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbjHPVLK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346446AbjHPVLG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 17:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B5F1B2;
        Wed, 16 Aug 2023 14:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3581B63A7D;
        Wed, 16 Aug 2023 21:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A09C433C8;
        Wed, 16 Aug 2023 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692220263;
        bh=mBsAzyfxfhI/6EYaCFRgUdv5YuaozjadXjfhd+MaaSI=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=Ovzvuj+D9ctGsAP6bh1Ya8cTeakvufD8PfcHUdiQM9DjwZ1dbouG7/GXgkH1z7aUi
         GBZhF16GS1/vuSA3oY5oud2t8U0XeD1VxEDKjYa/Rdd6hJS+OG4x5F9G9g41IiqheO
         hJmipQ7acAY74tbN0GcrAkdfQCVmEulOFFHxSSABEkkP9IF2fFHlkEX6tWwQvBrWea
         zyFjUbJX68JCB0Pv1pQhWCRVVPO+UDUfCfq3Xm5bq/+bsg4AwDlW+oFBzrDql1cvH2
         Y4e2WhqloA7EVZqdYBMNeIEx3KfhmsyG86Sodh15QHeTqAGt3tau0rXtq6vYo5tg5P
         JAqxOUVnRSnzw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Aug 2023 00:11:00 +0300
Message-Id: <CUUA0NGX7OT4.2TRQP2BRSVXRZ@suppilovahvero>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        <inux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] integrity: PowerVM support for loading third
 party code signing keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
 <20230815112722.1591829-7-nayna@linux.ibm.com>
 <CUU9A4V7EREZ.2CPPYURBAGN95@suppilovahvero>
 <cedb2c8f7c9d3f22f5e3d570c039bfcf59cc5a6e.camel@linux.ibm.com>
In-Reply-To: <cedb2c8f7c9d3f22f5e3d570c039bfcf59cc5a6e.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Aug 17, 2023 at 12:06 AM EEST, Mimi Zohar wrote:
> On Wed, 2023-08-16 at 23:36 +0300, Jarkko Sakkinen wrote:
> > On Tue Aug 15, 2023 at 2:27 PM EEST, Nayna Jain wrote:
> > > On secure boot enabled PowerVM LPAR, third party code signing keys ar=
e
> > > needed during early boot to verify signed third party modules. These
> > > third party keys are stored in moduledb object in the Platform
> > > KeyStore (PKS).
> > >
> > > Load third party code signing keys onto .secondary_trusted_keys keyri=
ng.
> > >
> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > > ---
> > >  certs/system_keyring.c                        | 30 +++++++++++++++++=
++
> > >  include/keys/system_keyring.h                 |  4 +++
> > >  .../platform_certs/keyring_handler.c          |  8 +++++
> > >  .../platform_certs/keyring_handler.h          |  5 ++++
> > >  .../integrity/platform_certs/load_powerpc.c   | 17 +++++++++++
> > >  5 files changed, 64 insertions(+)
> > >
> > > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > > index b348e0898d34..33841c91f12c 100644
> > > --- a/certs/system_keyring.c
> > > +++ b/certs/system_keyring.c
> > > @@ -152,6 +152,36 @@ static __init struct key_restriction *get_builti=
n_and_secondary_restriction(void
> > > =20
> > >  	return restriction;
> > >  }
> > > +
> > > +/**
> > > + * add_to_secondary_keyring - Add to secondary keyring.
> > > + * @source: Source of key
> > > + * @data: The blob holding the key
> > > + * @len: The length of the data blob
> > > + *
> > > + * Add a key to the secondary keyring. The key must be vouched for b=
y a key in the builtin,
> > > + * machine or secondary keyring itself.
> > > + */
> > > +void __init add_to_secondary_keyring(const char *source, const void =
*data, size_t len)
> > > +{
> > > +	key_ref_t key;
> > > +	key_perm_t perm;
> > > +
> > > +	perm =3D (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
> > > +
> > > +	key =3D key_create_or_update(make_key_ref(secondary_trusted_keys, 1=
),
> > > +				   "asymmetric",
> > > +				   NULL, data, len, perm,
> > > +				   KEY_ALLOC_NOT_IN_QUOTA);
> > > +	if (IS_ERR(key)) {
> > > +		pr_err("Problem loading X.509 certificate from %s to secondary key=
ring %ld\n",
> > > +		       source, PTR_ERR(key));
> > > +		return;
> > > +	}
> > > +
> > > +	pr_notice("Loaded X.509 cert '%s'\n", key_ref_to_ptr(key)->descript=
ion);
> > > +	key_ref_put(key);
> > > +}
> > >  #endif
> > >  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> > >  void __init set_machine_trusted_keys(struct key *keyring)
> > > diff --git a/include/keys/system_keyring.h b/include/keys/system_keyr=
ing.h
> > > index 7e2583208820..8365adf842ef 100644
> > > --- a/include/keys/system_keyring.h
> > > +++ b/include/keys/system_keyring.h
> > > @@ -50,9 +50,13 @@ int restrict_link_by_digsig_builtin_and_secondary(=
struct key *keyring,
> > >  						  const struct key_type *type,
> > >  						  const union key_payload *payload,
> > >  						  struct key *restriction_key);
> > > +void __init add_to_secondary_keyring(const char *source, const void =
*data, size_t len);
> > >  #else
> > >  #define restrict_link_by_builtin_and_secondary_trusted restrict_link=
_by_builtin_trusted
> > >  #define restrict_link_by_digsig_builtin_and_secondary restrict_link_=
by_digsig_builtin
> > > +static inline void __init add_to_secondary_keyring(const char *sourc=
e, const void *data, size_t len)
> > > +{
> > > +}
> > >  #endif
> > > =20
> > >  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> > > diff --git a/security/integrity/platform_certs/keyring_handler.c b/se=
curity/integrity/platform_certs/keyring_handler.c
> > > index 586027b9a3f5..13ea17207902 100644
> > > --- a/security/integrity/platform_certs/keyring_handler.c
> > > +++ b/security/integrity/platform_certs/keyring_handler.c
> > > @@ -78,6 +78,14 @@ __init efi_element_handler_t get_handler_for_ca_ke=
ys(const efi_guid_t *sig_type)
> > >  	return NULL;
> > >  }
> > > =20
> > > +__init efi_element_handler_t get_handler_for_code_signing_keys(const=
 efi_guid_t *sig_type)
> > > +{
> > > +	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) =3D=3D 0)
> > > +		return add_to_secondary_keyring;
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > >  /*
> > >   * Return the appropriate handler for particular signature list type=
s found in
> > >   * the UEFI dbx and MokListXRT tables.
> > > diff --git a/security/integrity/platform_certs/keyring_handler.h b/se=
curity/integrity/platform_certs/keyring_handler.h
> > > index 6f15bb4cc8dc..f92895cc50f6 100644
> > > --- a/security/integrity/platform_certs/keyring_handler.h
> > > +++ b/security/integrity/platform_certs/keyring_handler.h
> > > @@ -34,6 +34,11 @@ efi_element_handler_t get_handler_for_mok(const ef=
i_guid_t *sig_type);
> > >   */
> > >  efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_=
type);
> > > =20
> > > +/*
> > > + * Return the handler for particular signature list types for code s=
igning keys.
> > > + */
> > > +efi_element_handler_t get_handler_for_code_signing_keys(const efi_gu=
id_t *sig_type);
> > > +
> > >  /*
> > >   * Return the handler for particular signature list types found in t=
he dbx.
> > >   */
> > > diff --git a/security/integrity/platform_certs/load_powerpc.c b/secur=
ity/integrity/platform_certs/load_powerpc.c
> > > index 339053d9726d..c85febca3343 100644
> > > --- a/security/integrity/platform_certs/load_powerpc.c
> > > +++ b/security/integrity/platform_certs/load_powerpc.c
> > > @@ -60,6 +60,7 @@ static int __init load_powerpc_certs(void)
> > >  {
> > >  	void *db =3D NULL, *dbx =3D NULL, *data =3D NULL;
> > >  	void *trustedca;
> > > +	void *moduledb;
> > >  	u64 dsize =3D 0;
> > >  	u64 offset =3D 0;
> > >  	int rc =3D 0;
> > > @@ -137,6 +138,22 @@ static int __init load_powerpc_certs(void)
> > >  		kfree(data);
> > >  	}
> > > =20
> > > +	data =3D get_cert_list("moduledb", 9,  &dsize);
> > > +	if (!data) {
> > > +		pr_info("Couldn't get moduledb list from firmware\n");
> > > +	} else if (IS_ERR(data)) {
> > > +		rc =3D PTR_ERR(data);
> > > +		pr_err("Error reading moduledb from firmware: %d\n", rc);
> > > +	} else {
> > > +		extract_esl(moduledb, data, dsize, offset);
> > > +
> > > +		rc =3D parse_efi_signature_list("powerpc:moduledb", moduledb, dsiz=
e,
> > > +					      get_handler_for_code_signing_keys);
> > > +		if (rc)
> > > +			pr_err("Couldn't parse moduledb signatures: %d\n", rc);
> > > +		kfree(data);
> > > +	}
> > > +
> > >  	return rc;
> > >  }
> > >  late_initcall(load_powerpc_certs);
> > > --=20
> > > 2.31.1
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > I can pick this. My last PR did not went too great partly because of
> > mess with tpm_tis but now things are calmer.
>
> Glad things have settled down.  Whatever you prefer is fine.   This
> patch set needs to make it into linux-next as soon as possible.  Please
> don't forget to add Nageswara's "Tested-by" and fix mine on 4/6.
>
> --=20
> thanks,
>
> Mimi

I'll apply the full (v4) patch set tomorrow after I wake up.

BR, Jarkko
