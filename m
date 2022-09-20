Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64E95BF0D3
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 01:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiITXHB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Sep 2022 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiITXG7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Sep 2022 19:06:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91724D172
        for <linux-integrity@vger.kernel.org>; Tue, 20 Sep 2022 16:06:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so6907858pjo.2
        for <linux-integrity@vger.kernel.org>; Tue, 20 Sep 2022 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1Il+vXEJjm1aq7phj0vfcbaGwwpTXrTpoQAMWdsv1d8=;
        b=kRUhtzPB1M9EauOLIg97nWQDDVDwTUCS9iGKW+OC+3zPHmLCFU9d+Dpas25HOWvXsQ
         eqZT703MH/K7qfpkEPkV+ICAn5xFayuR4sYfECMs7k8Hb4Z9veIbVa+9mHY8Rq4s8dEZ
         ChAvWqrZVtfYjXr4Rixu3FZlRiTfzMZbltFy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1Il+vXEJjm1aq7phj0vfcbaGwwpTXrTpoQAMWdsv1d8=;
        b=H/jtyB1TehnP5Du25CKpUIBoop4KejyJ/GOi1DHP6BEUw1SNjhlv5TMIe7viJDymHG
         Qh0zZMQhkqEQbDNkkUZDgyRUXXgYGj4ykGIQaGKwKoZfCg3mg2lv7ZnuNL6hOsaKtQnn
         9b8UwJRHs1XSSzsjXgCSmpAwyT/0eSiRfYdI7ooOysizZwkGBnZTt8kpeusNDTnDoM8s
         G3Kb+4Q1zhiJtIFjOxeqY9pVwAtLVQd8Bmrs1fQCXbnUiOvpdiMbvsEGFwFHG/XeYxC0
         TADQ6Qw6xmUy/XlfmxEObvAQV6DhoQ0l0eCuCkMrmsfwOcdJuW0QJsg/g2zRxhDkHsjG
         2ADQ==
X-Gm-Message-State: ACrzQf1TJetTCg/uoXIUN8ZRFhSmycMe4IIAMHxlFUZF6b06Za6QXEhW
        din2VgCvwLTFT+/bd7ICXqx9XA==
X-Google-Smtp-Source: AMsMyM64Fv3U7GW8Dts8IPuhbHNna2shzPOd6fXDBCQkNyWdr01sGJGu0j5oI7xexyr8zbyh6H0jAg==
X-Received: by 2002:a17:903:11c3:b0:178:aec1:189c with SMTP id q3-20020a17090311c300b00178aec1189cmr1834716plh.136.1663715217348;
        Tue, 20 Sep 2022 16:06:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b00178143a728esm401040pla.275.2022.09.20.16.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 16:06:56 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:06:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, gwendal@chromium.org,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 05/10] security: keys: trusted: Verify creation data
Message-ID: <202209201605.505F96D@keescook>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.5.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823152108.v2.5.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 23, 2022 at 03:25:21PM -0700, Evan Green wrote:
> If a loaded key contains creation data, ask the TPM to verify that
> creation data. This allows users like encrypted hibernate to know that
> the loaded and parsed creation data has not been tampered with.
> 
> Partially-sourced-from: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> Source material for this change is at:
> https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/
> 
> Changes in v2:
>  - Adjust hash len by 2 due to new ASN.1 storage, and add underflow
>    check.
> 
>  include/linux/tpm.h                       |  1 +
>  security/keys/trusted-keys/trusted_tpm2.c | 77 ++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 8320cbac6f4009..438f8bc0a50582 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -224,6 +224,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_SELF_TEST	        = 0x0143,
>  	TPM2_CC_STARTUP		        = 0x0144,
>  	TPM2_CC_SHUTDOWN	        = 0x0145,
> +	TPM2_CC_CERTIFYCREATION	        = 0x014A,
>  	TPM2_CC_NV_READ                 = 0x014E,
>  	TPM2_CC_CREATE		        = 0x0153,
>  	TPM2_CC_LOAD		        = 0x0157,
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 1d1470b880ca01..f81c6578c7f783 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -691,6 +691,74 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	return rc;
>  }
>  
> +/**
> + * tpm2_certify_creation() - execute a TPM2_CertifyCreation command
> + *
> + * @chip: TPM chip to use
> + * @payload: the key data in clear and encrypted form
> + * @blob_handle: the loaded TPM handle of the key
> + *
> + * Return: 0 on success
> + *         -EINVAL on tpm error status
> + *         < 0 error from tpm_send or tpm_buf_init
> + */
> +static int tpm2_certify_creation(struct tpm_chip *chip,
> +				 struct trusted_key_payload *payload,
> +				 u32 blob_handle)
> +{
> +	struct tpm_header *head;
> +	struct tpm_buf buf;
> +	int rc;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CERTIFYCREATION);
> +	if (rc)
> +		return rc;
> +
> +	/* Use TPM_RH_NULL for signHandle */
> +	tpm_buf_append_u32(&buf, 0x40000007);
> +
> +	/* Object handle */
> +	tpm_buf_append_u32(&buf, blob_handle);
> +
> +	/* Auth */
> +	tpm_buf_append_u32(&buf, 9);
> +	tpm_buf_append_u32(&buf, TPM2_RS_PW);
> +	tpm_buf_append_u16(&buf, 0);
> +	tpm_buf_append_u8(&buf, 0);
> +	tpm_buf_append_u16(&buf, 0);
> +
> +	/* Qualifying data */
> +	tpm_buf_append_u16(&buf, 0);
> +
> +	/* Creation data hash */
> +	if (payload->creation_hash_len < 2) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	tpm_buf_append_u16(&buf, payload->creation_hash_len - 2);
> +	tpm_buf_append(&buf, payload->creation_hash + 2,
> +		       payload->creation_hash_len - 2);
> +
> +	/* signature scheme */
> +	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
> +
> +	/* creation ticket */
> +	tpm_buf_append(&buf, payload->tk, payload->tk_len);
> +
> +	rc = tpm_transmit_cmd(chip, &buf, 6, "certifying creation data");
> +	if (rc)
> +		goto out;
> +
> +	head = (struct tpm_header *)buf.data;
> +
> +	if (head->return_code != 0)
> +		rc = -EINVAL;

Do you have a reference to this TPM command spec? I have a dim memory of
some of these commands having success/failure listed separately from
other things in the reply. Is that true here? (i.e. is the return_code
only about "yes I replied" and there is a missing "but the answer is no"
check?)

> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;
> +}
> +
>  /**
>   * tpm2_unseal_trusted() - unseal the payload of a trusted key
>   *
> @@ -716,8 +784,15 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>  		goto out;
>  
>  	rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
> -	tpm2_flush_context(chip, blob_handle);
> +	if (rc)
> +		goto flush;
> +
> +	if (payload->creation_len)
> +		rc = tpm2_certify_creation(chip, payload, blob_handle);
>  
> +
> +flush:
> +	tpm2_flush_context(chip, blob_handle);
>  out:
>  	tpm_put_ops(chip);
>  
> -- 
> 2.31.0
> 

Otherwise looks good to me. :)

-- 
Kees Cook
