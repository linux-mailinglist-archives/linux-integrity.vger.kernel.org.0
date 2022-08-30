Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F055A6287
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiH3Lzb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiH3Lza (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 07:55:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57A1706F
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 04:55:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC5431FA61;
        Tue, 30 Aug 2022 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661860526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0w04zyyubR29j+TR3h2YAgzqEx0kNpk+Uanbh+46CY=;
        b=nheycXyQIxmvRIrgvSrAu5+/t/zg9E42bPwvUCQs8B+tVXeLOmRvHy3Q/n8Y8xD5CqNBKh
        AYA02TCLYJpWqYEt7gKr8KJ022Ehb0kzXHP2qDi9mbgx4qL/MLyQFgTi0gnJ2cRbgevYRy
        NYUWMvG4FQGjWQLvYIRBMgawxrafAwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661860526;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0w04zyyubR29j+TR3h2YAgzqEx0kNpk+Uanbh+46CY=;
        b=KywwmdEV0leGlLIN9Bhu7dU9b5/8vGJnUQrTvzuGIK32s0nPZrLAl6v+/MvAPEDDXQ67V9
        qjWMyxuXHVeg3eDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 910E413ACF;
        Tue, 30 Aug 2022 11:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zvyxIa76DWNzVwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 11:55:26 +0000
Date:   Tue, 30 Aug 2022 13:55:24 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 04/11] Deprecate IMA signature version 1
Message-ID: <Yw36rCs7MhTAWFEr@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-5-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-5-zohar@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> The original IMA file signatures were based on a SHA1 hash.  Kernel
> support for other hash algorithms was subsequently upstreamed.  Deprecate
> "--rsa" support.

> Define "--enable-sigv1" option to configure signature v1 support.

LGTM, few minor comments below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

...
> +++ b/configure.ac
...

>  static int cmd_convert(struct command *cmd)
>  {
> +#if CONFIG_SIGV1
>  	char *inkey;
>  	unsigned char _pub[1024], *pub = _pub;
>  	int len, err = 0;
> @@ -1033,6 +1033,8 @@ static int cmd_convert(struct command *cmd)

>  	RSA_free(key);
>  	return err;
> +#endif
> +	return 77;
What is this this magic number? EBADFD?
Well, git grep shows many places with 77, so it's just a tip for next cleanup :).

...
>  	log_info("Importing public key %s from file %s into keyring %d\n", name, inkey, id);
> @@ -2598,7 +2605,8 @@ static void usage(void)
>  		"  -d, --imahash      make IMA hash\n"
>  		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
>  		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
> -		"      --rsa          use RSA key type and signing scheme v1\n"
> +
nit: was this blank line intentional?
> +		"      --rsa          use RSA key type and signing scheme v1 (deprecated)\n"
>  		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
>  		"                     or a pkcs11 URI\n"
>  		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
> @@ -2637,8 +2645,8 @@ static void usage(void)
>  struct command cmds[] = {
>  	{"--version", NULL, 0, ""},
>  	{"help", cmd_help, 0, "<command>"},
> -	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring.\n"},
> -	{"convert", cmd_convert, 0, "key", "convert public key into the keyring.\n"},
> +	{"import", cmd_import, 0, "[--rsa] pubkey keyring", "Import public key into the keyring. (deprecated)\n"},
> +	{"convert", cmd_convert, 0, "key", "convert public key into the keyring. (deprecated)\n"},
>  	{"sign", cmd_sign_evm, 0, "[-r] [--imahash | --imasig ] [--key key] [--pass [password] file", "Sign file metadata.\n"},
>  	{"verify", cmd_verify_evm, 0, "file", "Verify EVM signature (for debugging).\n"},
>  	{"ima_sign", cmd_sign_ima, 0, "[--sigfile] [--key key] [--pass [password] file", "Make file content signature.\n"},
...
> +++ b/src/libimaevm.c
...

> +#if CONFIG_SIGV1
>  static RSA *read_priv_key(const char *keyfile, const char *keypass)
>  {
> +	RSA *key = NULL;
nit: NULL is safe, I wonder if it is necessary (was needed before).
>  	EVP_PKEY *pkey;
> -	RSA *key;

>  	pkey = read_priv_pkey(keyfile, keypass);
>  	if (!pkey)
> @@ -1018,10 +1034,12 @@ static int get_hash_algo_v1(const char *algo)

>  	return -1;
>  }
> +#endif
