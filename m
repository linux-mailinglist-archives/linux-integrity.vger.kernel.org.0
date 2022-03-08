Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B344D1377
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Mar 2022 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiCHJen (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Mar 2022 04:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCHJem (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Mar 2022 04:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A84131D;
        Tue,  8 Mar 2022 01:33:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C98B3613EA;
        Tue,  8 Mar 2022 09:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C68C340EC;
        Tue,  8 Mar 2022 09:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646732022;
        bh=KGNINKpwfme0ioYvCFXI97pXN8eXLL+5zUi6gZH62EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCKp5kebWxQkqmPGeS4Xfu/XlBlKW/CIp1uPmG5QEL5TsNgACHDzmthUMciPCwbih
         HX6Vl7HF355FxbwuIS3Mg6qcgxpqgS0aMKravSk7Q2MQ8W+RcIyHUb1Y0aAZcH4S43
         KvqTZWIJ7f3hJ1jJdxgL4OxDNvGj3D8tUqujbvG04NCY61s0D5IQ10GnL1CV2wy2JX
         9c7zMiz3BXgw8Uw1zWvteze8kzKbGBC/Ndb654S2einb7Icuceehx3+gl0Qn6mwI50
         V/2iqt/jdn4KSY4MotjWJ3S2awGrTLVHDfZfAmhWDRWrtAYSNwIBtwwmhTqDUEPZfN
         xs8Krh4uJsg1A==
Date:   Tue, 8 Mar 2022 11:33:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v10 3/3] integrity: support including firmware
 ".platform" keys at build time
Message-ID: <Yiciza4e1hf4MPTd@iki.fi>
References: <20220306205100.651878-1-nayna@linux.ibm.com>
 <20220306205100.651878-4-nayna@linux.ibm.com>
 <YiX/NHETfqLT8ZAz@iki.fi>
 <42243a19b5882ddff9d20b37d1566553b745a717.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42243a19b5882ddff9d20b37d1566553b745a717.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 07, 2022 at 05:03:09PM -0500, Mimi Zohar wrote:
> [Cc'ing  Masahiro Yamada]
> 
> On Mon, 2022-03-07 at 14:48 +0200, Jarkko Sakkinen wrote:
> > On Sun, Mar 06, 2022 at 03:51:00PM -0500, Nayna Jain wrote:
> > > Allow firmware keys to be embedded in the Linux kernel and loaded onto
> > > the ".platform" keyring on boot.
> > > 
> > > The firmware keys can be specified in a file as a list of PEM encoded
> > > certificates using new config INTEGRITY_PLATFORM_KEYS. The certificates
> > > are embedded in the image by converting the PEM-formatted certificates
> > > into DER(binary) and generating
> > > security/integrity/platform_certs/platform_certificate_list file at
> > > build time. On boot, the embedded certs from the image are loaded onto
> > > the ".platform" keyring at late_initcall(), ensuring the platform keyring
> > > exists before loading the keys.
> > > 
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > > ---
> > >  security/integrity/Kconfig                    | 10 ++++++++
> > >  security/integrity/Makefile                   | 15 +++++++++++-
> > >  security/integrity/integrity.h                |  3 +++
> > >  .../integrity/platform_certs/platform_cert.S  | 23 +++++++++++++++++++
> > >  .../platform_certs/platform_keyring.c         | 23 +++++++++++++++++++
> > >  5 files changed, 73 insertions(+), 1 deletion(-)
> > >  create mode 100644 security/integrity/platform_certs/platform_cert.S
> > > 
> > > diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> > > index 599429f99f99..77b2c22c0e1b 100644
> > > --- a/security/integrity/Kconfig
> > > +++ b/security/integrity/Kconfig
> > > @@ -62,6 +62,16 @@ config INTEGRITY_PLATFORM_KEYRING
> > >           provided by the platform for verifying the kexec'ed kerned image
> > >           and, possibly, the initramfs signature.
> > >  
> > > +config INTEGRITY_PLATFORM_KEYS
> > > +        string "Builtin X.509 keys for .platform keyring"
> > > +        depends on KEYS
> > > +        depends on ASYMMETRIC_KEY_TYPE
> > > +        depends on INTEGRITY_PLATFORM_KEYRING
> > > +        help
> > > +          If set, this option should be the filename of a PEM-formatted file
> > > +          containing X.509 certificates to be loaded onto the ".platform"
> > > +          keyring.
> > > +
> > >  config INTEGRITY_MACHINE_KEYRING
> > >  	bool "Provide a keyring to which Machine Owner Keys may be added"
> > >  	depends on SECONDARY_TRUSTED_KEYRING
> > > diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> > > index d0ffe37dc1d6..65bd93301a3a 100644
> > > --- a/security/integrity/Makefile
> > > +++ b/security/integrity/Makefile
> > > @@ -3,13 +3,17 @@
> > >  # Makefile for caching inode integrity data (iint)
> > >  #
> > >  
> > > +quiet_cmd_extract_certs  = CERT  $@
> > > +      cmd_extract_certs  = certs/extract-cert $(2) $@
> > > +
> > >  obj-$(CONFIG_INTEGRITY) += integrity.o
> > >  
> > >  integrity-y := iint.o
> > >  integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
> > >  integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
> > >  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
> > > -integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
> > > +integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o \
> > > +						  platform_certs/platform_cert.o
> > >  integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
> > >  integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
> > >  				      platform_certs/load_uefi.o \
> > > @@ -20,3 +24,12 @@ integrity-$(CONFIG_LOAD_PPC_KEYS) += platform_certs/efi_parser.o \
> > >                                       platform_certs/keyring_handler.o
> > >  obj-$(CONFIG_IMA)			+= ima/
> > >  obj-$(CONFIG_EVM)			+= evm/
> > > +
> > > +$(obj)/platform_certs/platform_cert.o: $(obj)/platform_certs/platform_certificate_list
> > > +
> > > +targets += platform_certificate_list
> > > +
> > > +$(obj)/platform_certs/platform_certificate_list: $(CONFIG_INTEGRITY_PLATFORM_KEYS) certs/extract-cert FORCE
> > > +	$(call if_changed,extract_certs,$(if $(CONFIG_INTEGRITY_PLATFORM_KEYS),$<,""))
> > > +
> > > +clean-files := platform_certs/platform_certificate_list
> > > diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> > > index 76e9a9515f99..219da29fecf7 100644
> > > --- a/security/integrity/integrity.h
> > > +++ b/security/integrity/integrity.h
> > > @@ -282,6 +282,9 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
> > >  #endif
> > >  
> > >  #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +extern __initconst const u8 platform_certificate_list[];
> > > +extern __initconst const unsigned long platform_certificate_list_size;
> > > +
> > >  void __init add_to_platform_keyring(const char *source, const void *data,
> > >  				    size_t len);
> > >  #else
> > > diff --git a/security/integrity/platform_certs/platform_cert.S b/security/integrity/platform_certs/platform_cert.S
> > > new file mode 100644
> > > index 000000000000..20bccce5dc5a
> > > --- /dev/null
> > > +++ b/security/integrity/platform_certs/platform_cert.S
> > > @@ -0,0 +1,23 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#include <linux/export.h>
> > > +#include <linux/init.h>
> > > +
> > > +	__INITRODATA
> > > +
> > > +	.align 8
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +	.globl platform_certificate_list
> > > +platform_certificate_list:
> > > +__cert_list_start:
> > > +	.incbin "security/integrity/platform_certs/platform_certificate_list"
> > > +__cert_list_end:
> > > +#endif
> > > +
> > > +	.align 8
> > > +	.globl platform_certificate_list_size
> > > +platform_certificate_list_size:
> > > +#ifdef CONFIG_64BIT
> > > +	.quad __cert_list_end - __cert_list_start
> > > +#else
> > > +	.long __cert_list_end - __cert_list_start
> > > +#endif
> > > diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
> > > index bcafd7387729..c2368912fd1b 100644
> > > --- a/security/integrity/platform_certs/platform_keyring.c
> > > +++ b/security/integrity/platform_certs/platform_keyring.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/cred.h>
> > >  #include <linux/err.h>
> > >  #include <linux/slab.h>
> > > +#include <keys/system_keyring.h>
> > >  #include "../integrity.h"
> > >  
> > >  /**
> > > @@ -37,6 +38,28 @@ void __init add_to_platform_keyring(const char *source, const void *data,
> > >  		pr_info("Error adding keys to platform keyring %s\n", source);
> > >  }
> > >  
> > > +static __init int load_platform_certificate_list(void)
> > > +{
> > > +	const u8 *p;
> > > +	unsigned long size;
> > > +	int rc;
> > > +	struct key *keyring;
> > > +
> > > +	p = platform_certificate_list;
> > > +	size = platform_certificate_list_size;
> > > +
> > > +	keyring = integrity_keyring_from_id(INTEGRITY_KEYRING_PLATFORM);
> > > +	if (IS_ERR(keyring))
> > > +		return PTR_ERR(keyring);
> > > +
> > > +	rc = load_certificate_list(p, size, keyring);
> > > +	if (rc)
> > > +		pr_info("Error adding keys to platform keyring %d\n", rc);
> > > +
> > > +	return rc;
> > > +}
> > > +late_initcall(load_platform_certificate_list);
> > > +
> > >  /*
> > >   * Create the trusted keyrings.
> > >   */
> > > -- 
> > > 2.27.0
> > > 
> > 
> > There's zero tested-by's for this, i.e. cannot be applied before someone
> > has tested this. Mimi, do not mean to be rude, but I don't frankly
> > understand why you ask to pick a patch set that is *untested*.
> > So I generated a self-signed certificate:
> > 
> > openssl req -x509 -out localhost.crt -keyout localhost.key \
> >   -newkey rsa:2048 -nodes -sha256 \
> >   -subj '/CN=localhost' -extensions EXT -config <( \
> >    printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
> > 
> > (by courtesy of letsencrypt: https://letsencrypt.org/docs/certificates-for-localhost/)
> > 
> > openssl x509 -in localhost.crt -out localhost.pem -outform PEM
> > 
> > And starting with tinyconfig I added minimal options to enable this
> > feature. The config is attached.
> > 
> > The end result is:
> > 
> > make[2]: *** No rule to make target 'certs/extract-cert', needed by 'security/integrity/platform_certs/platform_certificate_list'.  Stop.
> > make[1]: *** [scripts/Makefile.build:550: security/integrity] Error 2
> > make: *** [Makefile:1831: security] Error 2
> 
> I've reviewed and tested this patch set each time it was posted last
> fall/winter.  Recent changes were limited to the cover letter and patch
> description.  Only recently was "extract_cert" moved to the certs/
> directory and not built automatically.  The commit message says the
> move was because it wasn't being used outside the certs directory. 
> Refer to commit 340a02535ee7 ("certs: move scripts/extract-cert to
> certs/").
> 
> Masahiro Yamada would you be ok with reverting the move?
> 
> thanks,
> 
> Mimi

OK, so I can add your tested-by? It was missing, that's where the
concern came from.

BR, Jarkko
