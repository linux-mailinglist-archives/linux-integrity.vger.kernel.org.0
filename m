Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7AB62737C
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 00:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiKMXdK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 18:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiKMXdI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 18:33:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE76FDFF4;
        Sun, 13 Nov 2022 15:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 589E9B80C69;
        Sun, 13 Nov 2022 23:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D7CC433D6;
        Sun, 13 Nov 2022 23:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668382385;
        bh=mecLQ1ama1BtgpOVmxEx0SclMBV8VPMmHMH/4AGpGXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COKK39D62EscXlO7juWhkboxSvJ+wNEciP+p2Ch3P7LzN+DoCBfRqjFMyfk8TjePu
         KPbvFY00g5NyRmS9w3qduDNaw42XikWpMb/zI90/ejPTNrR6N+VViEssKIRBYmKeoP
         niu28DohHggq35Ec0FgtAbD/8FZ23VZJf8IBHKZtlEse/go/anj6ugpT59TB5n8CeX
         cxbiIazEMxs4tAVAYu539ut3hpwteY8ZLmNUCeJAtCfzpYFLQmvpAt2v6O++3w0aWc
         BxFhdvaKZunkd1f1nWkpfFkLuSS6p2+ThGe+SXL9XjBJdqwt0kQjCW2Ybi688GiM+k
         vxliqacseuzLQ==
Date:   Sun, 13 Nov 2022 15:33:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 08/11] PM: hibernate: Use TPM-backed keys to encrypt
 image
Message-ID: <Y3F+rj59Q5uzGI5i@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:33PM -0800, Evan Green wrote:
> We'll also go through the motions of having PCR23 set to a known value at
> the time of key creation and unsealing. Currently there's nothing that
> enforces the contents of PCR23 as a condition to unseal the key blob,
> that will come in a later change.

This patch doesn't really make sense without the later patch
"PM: hibernate: seal the encryption key with a PCR policy".

Maybe they should be merged into one patch?

> +/* sha256("To sleep, perchance to dream") */
> +static struct tpm_digest known_digest = { .alg_id = TPM_ALG_SHA256,
> +	.digest = {0x92, 0x78, 0x3d, 0x79, 0x2d, 0x00, 0x31, 0xb0, 0x55, 0xf9,
> +		   0x1e, 0x0d, 0xce, 0x83, 0xde, 0x1d, 0xc4, 0xc5, 0x8e, 0x8c,
> +		   0xf1, 0x22, 0x38, 0x6c, 0x33, 0xb1, 0x14, 0xb7, 0xec, 0x05,
> +		   0x5f, 0x49}};

This can be const.

> +static int snapshot_create_kernel_key(struct snapshot_data *data)
> +{
> +	/* Create a key sealed by the SRK. */
> +	char *keyinfo = "new\t32\tkeyhandle=0x81000000";
> +	const struct cred *cred = current_cred();
> +	struct tpm_digest *digests = NULL;
> +	struct key *key = NULL;
> +	struct tpm_chip *chip;
> +	int ret, i;
> +
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return -ENODEV;
> +
> +	if (!(tpm_is_tpm2(chip))) {
> +		ret = -ENODEV;
> +		goto out_dev;
> +	}

tpm_is_tpm2() can return an error value.

> +	digests = kcalloc(chip->nr_allocated_banks, sizeof(struct tpm_digest),
> +			  GFP_KERNEL);
> +	if (!digests) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < chip->nr_allocated_banks; i++) {
> +		digests[i].alg_id = chip->allocated_banks[i].alg_id;
> +		if (digests[i].alg_id == known_digest.alg_id)
> +			memcpy(&digests[i], &known_digest, sizeof(known_digest));
> +	}
> +
> +	ret = tpm_pcr_extend(chip, 23, digests);
> +	if (ret != 0)
> +		goto out;

So, PCR 23 will not actually be extended properly if there is not a SHA-256
bank?  Wouldn't it make more sense to return an error in that case?

> +static int snapshot_load_kernel_key(struct snapshot_data *data,
> +				    struct uswsusp_key_blob *blob)
> +{
> +
> +	char *keytemplate = "load\t%s\tkeyhandle=0x81000000";

Make this const.

> +	blobstring = kmalloc(blob->blob_len * 2, GFP_KERNEL);
> +	if (!blobstring) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	bin2hex(blobstring, blob->blob, blob->blob_len);
> +	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blobstring);

There's no need for bin2hex().  Just use the %*phN format specifier instead:

	const char *keytemplate = "load\t%*phN\tkeyhandle=0x81000000";

	keyinfo = kasprintf(GFP_KERNEL, keytemplate, blob->blob_len, blob->blob);

- Eric
