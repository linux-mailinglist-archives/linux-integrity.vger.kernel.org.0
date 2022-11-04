Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5400B61A070
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 20:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKDTA7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKDTA5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 15:00:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E95986F
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 12:00:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k22so5289963pfd.3
        for <linux-integrity@vger.kernel.org>; Fri, 04 Nov 2022 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jhteGoCfhnRu6lO56jCIvAOnYVZ3wVFwNqjWZiWhdE=;
        b=L2WinIR13ZQtNbMb0Qv5sE/qDaoCOqJ2+uqCKDxqXG7TTCGXBj9xQF94e8Gle8k5SY
         g1qAEqMRKv15fHhSCbxOiblgAjdwH4fVPbfsT5Qvuv/OrN7lpdF6q6swf4xHkyFNStjX
         19dGIVUo9ohirNQvWYmFxlFDgUAh3FOie2iWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jhteGoCfhnRu6lO56jCIvAOnYVZ3wVFwNqjWZiWhdE=;
        b=z45pUsfpux1ctFPIYcn3QG3cI38ulRl6z2NzErhFGdVP1JUAaGs/kyVkH13Zuk7qr5
         1e+BWgbFcFamxQOYOCjWB/A0J/WuWgC/mkXEezpAlmT+AvDC2JIhfoPzf7EmJClTVzAP
         qFcwh8mU6cH9KXnyOxFp67d5cNdgMWAN2lZd3eKT5nyJougDy5ujCtaWFA0SqE+Vmtv3
         n7vpdDTRfQ4P590l0925R0PG0TqMJg+yrG0mNc/jqFihVvignDp0zrJs2+jYTbsK/w83
         N9VTX1svINJ6ANrKvSeWOhYkgVMUxny/EQTG8fKtMOJQbiESyQarPUCX1qdntKH9HTpQ
         C+zQ==
X-Gm-Message-State: ACrzQf0X139mJbVlHvPTdy+Ueeb6P0qHiQppOjzYbntnCmU7EOnxL/U1
        YPo9szJtZuyF5Cb3E/zELm4rrA==
X-Google-Smtp-Source: AMsMyM7LJpMMZ+JYQKPCMmo7xp54Qu0quGeHYZP5TMa7jKCXeIDtus2F8YhNZQ2OsbyceaOK6er8sQ==
X-Received: by 2002:a65:56c4:0:b0:458:85e:9e65 with SMTP id w4-20020a6556c4000000b00458085e9e65mr32502538pgs.358.1667588453958;
        Fri, 04 Nov 2022 12:00:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f20-20020a623814000000b0056232682a7esm3108223pfa.2.2022.11.04.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:00:53 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:00:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 10/11] PM: hibernate: Verify the digest encryption key
Message-ID: <202211041156.3D184961EE@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:18AM -0700, Evan Green wrote:
> We want to ensure that the key used to encrypt the digest was created by
> the kernel during hibernation. To do this we request that the TPM
> include information about the value of PCR 23 at the time of key
> creation in the sealed blob. On resume, we can make sure that the PCR
> information in the creation data blob (already certified by the TPM to
> be accurate) corresponds to the expected value. Since only
> the kernel can touch PCR 23, if an attacker generates a key themselves
> the value of PCR 23 will have been different, allowing us to reject the
> key and boot normally instead of resuming.
> 
> Co-developed-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> Matthew's original version of this patch is here:
> https://patchwork.kernel.org/project/linux-pm/patch/20210220013255.1083202-9-matthewgarrett@google.com/
> 
> I moved the TPM2_CC_CERTIFYCREATION code into a separate change in the
> trusted key code because the blob_handle was being flushed and was no
> longer valid for use in CC_CERTIFYCREATION after the key was loaded. As
> an added benefit of moving the certification into the trusted keys code,
> we can drop the other patch from the original series that squirrelled
> the blob_handle away.
> 
> Changes in v4:
>  - Local variable reordering (Jarkko)
> 
> Changes in v3:
>  - Changed funky tag to Co-developed-by (Kees). Matthew, holler if you
>    want something different.
> 
> Changes in v2:
>  - Fixed some sparse warnings
>  - Use CRYPTO_LIB_SHA256 to get rid of sha256_data() (Eric)
>  - Adjusted offsets due to new ASN.1 format, and added a creation data
>    length check.
> 
>  kernel/power/snapenc.c | 67 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/snapenc.c b/kernel/power/snapenc.c
> index 50167a37c5bf23..2f421061498246 100644
> --- a/kernel/power/snapenc.c
> +++ b/kernel/power/snapenc.c
> @@ -22,6 +22,12 @@ static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
>  		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
>  		   0x5f, 0x49}};
>  
> +/* sha256(sha256(empty_pcr | known_digest)) */
> +static const char expected_digest[] = {0x2f, 0x96, 0xf2, 0x1b, 0x70, 0xa9, 0xe8,
> +	0x42, 0x25, 0x8e, 0x66, 0x07, 0xbe, 0xbc, 0xe3, 0x1f, 0x2c, 0x84, 0x4a,
> +	0x3f, 0x85, 0x17, 0x31, 0x47, 0x9a, 0xa5, 0x53, 0xbb, 0x23, 0x0c, 0x32,
> +	0xf3};
> +
>  /* Derive a key from the kernel and user keys for data encryption. */
>  static int snapshot_use_user_key(struct snapshot_data *data)
>  {
> @@ -486,7 +492,7 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
>  static int snapshot_create_kernel_key(struct snapshot_data *data)
>  {
>  	/* Create a key sealed by the SRK. */
> -	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
> +	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
>  	const struct cred *cred = current_cred();
>  	struct tpm_digest *digests = NULL;
>  	struct key *key = NULL;
> @@ -613,6 +619,8 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
>  
>  	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";
>  	const struct cred *cred = current_cred();
> +	struct trusted_key_payload *payload;
> +	char certhash[SHA256_DIGEST_SIZE];
>  	struct tpm_digest *digests = NULL;
>  	char *blobstring = NULL;
>  	struct key *key = NULL;
> @@ -635,8 +643,10 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
>  
>  	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
>  			  GFP_KERNEL);
> -	if (!digests)
> +	if (!digests) {
> +		ret = -ENOMEM;
>  		goto out;
> +	}
>  
>  	for (i = 0; i < chip->nr_allocated_banks; i++) {
>  		digests[i].alg_id = chip->allocated_banks[i].alg_id;
> @@ -676,6 +686,59 @@ static int snapshot_load_kernel_key(struct snapshot_data *data,
>  	if (ret != 0)
>  		goto out;
>  
> +	/* Verify the creation hash matches the creation data. */
> +	payload = key->payload.data[0];
> +	if (!payload->creation || !payload->creation_hash ||
> +	    (payload->creation_len < 3) ||

Later accesses are reaching into indexes, 6, 8, 12, 14, etc. Shouldn't
this test be:

	    (payload->creation_len < 14 + SHA256_DIGEST_SIZE) ||


> +	    (payload->creation_hash_len < SHA256_DIGEST_SIZE)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	sha256(payload->creation + 2, payload->creation_len - 2, certhash);

Why +2 offset?

> +	if (memcmp(payload->creation_hash + 2, certhash, SHA256_DIGEST_SIZE) != 0) {

And if this is +2 also, shouldn't the earlier test be:

        (payload->creation_hash_len - 2 != SHA256_DIGEST_SIZE)) {

?

> +	if (be32_to_cpu(*(__be32 *)&payload->creation[2]) != 1) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (be16_to_cpu(*(__be16 *)&payload->creation[6]) != TPM_ALG_SHA256) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (*(char *)&payload->creation[8] != 3) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* PCR 23 selected */
> +	if (be32_to_cpu(*(__be32 *)&payload->creation[8]) != 0x03000080) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (be16_to_cpu(*(__be16 *)&payload->creation[12]) !=
> +	    SHA256_DIGEST_SIZE) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Verify PCR 23 contained the expected value when the key was created. */
> +	if (memcmp(&payload->creation[14], expected_digest,
> +		   SHA256_DIGEST_SIZE) != 0) {

These various literals (2, 6, 8, 3, 8, 0x03000080, 12, 14) should be
explicit #defines so their purpose/meaning is more clear.

I can guess at it, but better to avoid the guessing. :)

> +
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	data->key = key;
>  	key = NULL;
>  
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

-- 
Kees Cook
