Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2795BDC05
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Sep 2022 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiITFGZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 01:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiITFGX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 01:06:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835D46D81;
        Mon, 19 Sep 2022 22:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE216B82453;
        Tue, 20 Sep 2022 05:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE9C433D7;
        Tue, 20 Sep 2022 05:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663650379;
        bh=QrqoAWdyoKqvuCY0mh/a0HFmsrJsaS+3N7uYNdSkTVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yj6TGRtyES2UyENyN5roAwj1JkSEk0NFq8/NCDsU83JW02MuftEVkWO1JLu2UN6aK
         NHCRlRpkQJBWQYW2K6UnyMmvkgmEfSgwpjt/7M8Rx57KEb2Y3bYGQmIayfoEyTokp8
         5PGKUFdB0P0fSoNMlSTGtMK8VQq4ei32xTHagXkAGlpA7o7kvDkRAdxQphjJE+nb3n
         FE4fgYFtC9GWCrArwlzQJPr13SA392QI97T9RbbQI0OW1FxHVYfPg/g823dWuZw5+/
         Crbns8zhP/PAKbVA19Tz3NewBT5EQNnZ+hBzRFXONNBxQpVz87GK4FN0NFtIuFo7Fp
         ybP6de0uVsC2A==
Date:   Tue, 20 Sep 2022 08:06:15 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with
 user-provided data
Message-ID: <YylKR1UQZGhN0+UW@kernel.org>
References: <20220919072317.E41421357@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919072317.E41421357@mail.steuer-voss.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 16, 2022 at 07:45:29AM +0200, Nikolaus Voss wrote:
> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> decrypted data") added key instantiation with user provided decrypted data.
> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> Fix this to use hex2bin instead.
> 
> Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
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

This looks wrong. What does cap decrypted_data, and why strnlen()
is not used?

>  			pr_err("encrypted key: decrypted data provided does not match decrypted data length provided\n");

Using pr_err() is probably wrong here and has different prefix
than elsewhere in the file (also most of other uses of pr_err()
are wrong apparently). Nothing bad is really happening.

And who does make any sense of that error message anyway?

For one, I don't understand it.

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


BR, Jarkko
