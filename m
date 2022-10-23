Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7E609639
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJWUki (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 16:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJWUkh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 16:40:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6185725A;
        Sun, 23 Oct 2022 13:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A89F7CE0F28;
        Sun, 23 Oct 2022 20:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CFAC433D6;
        Sun, 23 Oct 2022 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666557633;
        bh=Ase1ag2VU+E3ra79YOHGkuWXSUct//S7LLw1x5dUijM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnHvq8de4KkBrnnTJdp9P2IDrjbDwbEd3xG0OaJ+yOJJyUmQxzjxJjnM6zZg78pne
         Wl4L9nSgr1YLIGiAlxa2+tvFxHTxhOouHyQg+ATgDD4L6AkIQ3TMRQVmglEaARtEpP
         xPVBk4VEgE1Hq4AqCj41vda0tmK6g9FlXKpxx7vWMh3LJ7wzvzHWDlFyhAwcXWY0ay
         8omPGhay4Fnw3cVp69nsW7btriy5i8K1pZMEEJjYI69NAhOR/AKVmvqL+qz6pkRNtg
         l9nDcFiwnyaIe9zK2u2wBNuFABv83xMOqtIOabZAop0NLc0SWfI044UeFXoh/pNenO
         l32+MbekzUSBA==
Date:   Sun, 23 Oct 2022 23:40:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: encrypted: fix key instantiation with
 user-provided data
Message-ID: <Y1WmuVilSzjtm5i8@kernel.org>
References: <20221019164526.B70DF1C59@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019164526.B70DF1C59@mail.steuer-voss.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 19, 2022 at 06:38:20PM +0200, Nikolaus Voss wrote:
> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with
> user-provided decrypted data") added key instantiation with user
> provided decrypted data.  The user data is hex-ascii-encoded but was
> just memcpy'ed to the binary buffer. Fix this to use hex2bin instead.
> 
> Old keys created from user provided decrypted data saved with "keyctl
> pipe" are still valid, however if the key is recreated from decrypted
> data the old key must be converted to the correct format. This can be
> done with a small shell script, e.g.:
> 
> BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c32)
> keyctl add user masterkey "$(cat masterkey.bin)" @u
> keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u
> 
> However, NEWKEY is still broken: If for BROKENKEY 32 bytes were
> specified, a brute force attacker knowing the key properties would only
> need to try at most 2^(16*8) keys, as if the key was only 16 bytes long.
> 
> The security issue is a result of the combination of limiting the input
> range to hex-ascii and using memcpy() instead of hex2bin(). It could
> have been fixed either by allowing binary input or using hex2bin() (and
> doubling the ascii input key length). This patch implements the latter.
> 
> The corresponding test for the Linux Test Project ltp has also been
> fixed (see link below).
> 
> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> Cc: stable@kernel.org
> Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> ---
> Changes
> =======
> v6: - fix checkpatch warnings
> v5: - explain security issue in commit message, add Reviewd-by
> v4: - change "Link:" address
> v3: - use generated random key in example, reformat commit message
> v2: - clarify commit message, add example to recover old/broken keys
>     - improve example in Documentation/security/keys/trusted-encrypted.rst
>     - add link to ltp patch
> 
>  Documentation/security/keys/trusted-encrypted.rst | 3 ++-
>  security/keys/encrypted-keys/encrypted.c          | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 0bfb4c339748..9bc9db8ec651 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -350,7 +350,8 @@ Load an encrypted key "evm" from saved blob::
>  
>  Instantiate an encrypted key "evm" using user-provided decrypted data::
>  
> -    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted_data.blob`" @u
> +    $ evmkey=$(dd if=/dev/urandom bs=1 count=32 | xxd -c32 -p)
> +    $ keyctl add encrypted evm "new default user:kmk 32 $evmkey" @u
>      794890253
>  
>      $ keyctl print 794890253
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index e05cfc2e49ae..1e313982af02 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -627,7 +627,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  			pr_err("encrypted key: instantiation of keys using provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is set to false\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> -		if (strlen(decrypted_data) != decrypted_datalen) {
> +		if (strlen(decrypted_data) != decrypted_datalen * 2) {
>  			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> @@ -791,8 +791,8 @@ static int encrypted_init(struct encrypted_key_payload *epayload,
>  		ret = encrypted_key_decrypt(epayload, format, hex_encoded_iv);
>  	} else if (decrypted_data) {
>  		get_random_bytes(epayload->iv, ivsize);
> -		memcpy(epayload->decrypted_data, decrypted_data,
> -				   epayload->decrypted_datalen);
> +		ret = hex2bin(epayload->decrypted_data, decrypted_data,
> +			      epayload->decrypted_datalen);
>  	} else {
>  		get_random_bytes(epayload->iv, ivsize);
>  		get_random_bytes(epayload->decrypted_data, epayload->decrypted_datalen);
> -- 
> 2.34.1
> 

Did you check that this passes "checkpatch.pl --strict"?

Your earlier version did not.

BR, Jarkko
