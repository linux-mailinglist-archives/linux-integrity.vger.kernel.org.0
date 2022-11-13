Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E688627398
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 00:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiKMXvK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 18:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMXvJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 18:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9ABB1E2;
        Sun, 13 Nov 2022 15:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF0E160C09;
        Sun, 13 Nov 2022 23:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1385C433C1;
        Sun, 13 Nov 2022 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668383466;
        bh=KSPW+gb8KZq1GJgr/6V5CJJhPw275z9NwUUesDbF54I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNpW7+e35iFlHE5dpScwvWbXnQlNJY9W6LdE7LgXvVi5ktPjMEcclIrP4GkbAdwLK
         jqtDt/Kdje+EaKeSlAzxiZOHgbP03dZvT1BJYKLB8wHc5mcz/wvvN2UOjJBqGwsGY0
         k/z7b8fBzWAcbfcKB1Fo6XqzGTBDeYUY8Ja13M/cFPkf6nV1KW2fWdoTdGiCzPLI7V
         9N1L324DATQog2Ys42sRG5MHU59sn+d1f+2+yD+5Lni6EtTk+htdsylE3xwTpnidHS
         JYllaitr+wSN8K5mZbu2661RMniVtNWrvyDIcD7ivl5M0lD67Gn6qGotroyVHtPVav
         2ub64ZY36GTGA==
Date:   Sun, 13 Nov 2022 15:51:04 -0800
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
        "Rafael J. Wysocki" <rafael@kernel.org>, axelj <axelj@axis.com>
Subject: Re: [PATCH v5 11/11] PM: hibernate: seal the encryption key with a
 PCR policy
Message-ID: <Y3GC6M6umF+MOu1f@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.11.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.11.Ifce072ae1ef1ce39bd681fff55af13a054045d9f@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:36PM -0800, Evan Green wrote:
> +static int tpm_setup_policy(struct tpm_chip *chip, int *session_handle)
> +{
> +	struct tpm_header *head;
> +	struct tpm_buf buf;
> +	char nonce[32] = {0x00};
> +	int rc;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
> +			  TPM2_CC_START_AUTH_SESSION);
> +	if (rc)
> +		return rc;
> +
> +	/* Decrypt key */
> +	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
> +
> +	/* Auth entity */
> +	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
> +
> +	/* Nonce - blank is fine here */
> +	tpm_buf_append_u16(&buf, sizeof(nonce));
> +	tpm_buf_append(&buf, nonce, sizeof(nonce));

In general, hardcoded nonces are a huge red flag.  If it's fine here, it would
be helpful to leave a comment explaining why that is.

> +	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +	if (rc)
> +		goto out;

This is another instance of the bug where TPM2_RC_* codes are being returned
from a function that is expected to return -errno values.

> +	*session_handle = be32_to_cpu(*(__be32 *)&buf.data[10]);

get_unaligned_be32, to avoid an unaligned memory access.

> @@ -497,11 +602,16 @@ static int snapshot_setup_encryption_common(struct snapshot_data *data)
>  static int snapshot_create_kernel_key(struct snapshot_data *data)
>  {
>  	/* Create a key sealed by the SRK. */
> -	char *keyinfo = "new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000";
> +	const char *keytemplate =
> +		"new\t32\tkeyhandle=0x81000000\tcreationpcrs=0x00800000\tpolicydigest=%s";
>  	const struct cred *cred = current_cred();
>  	struct tpm_digest *digests = NULL;
> +	char policy[SHA256_DIGEST_SIZE];
> +	char *policydigest = NULL;
> +	int session_handle = -1;
>  	struct key *key = NULL;
>  	struct tpm_chip *chip;
> +	char *keyinfo = NULL;
>  	int ret, i;
>  
>  	chip = tpm_default_chip();
> @@ -534,6 +644,28 @@ static int snapshot_create_kernel_key(struct snapshot_data *data)
>  	if (ret != 0)
>  		goto out;
>  
> +	policydigest = kmalloc(SHA256_DIGEST_SIZE * 2 + 1, GFP_KERNEL);
> +	if (!policydigest) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = tpm_setup_policy(chip, &session_handle);
> +	if (ret != 0)
> +		goto out;
> +
> +	ret = tpm_policy_get_digest(chip, session_handle, policy);
> +	if (ret != 0)
> +		goto out;
> +
> +	bin2hex(policydigest, policy, SHA256_DIGEST_SIZE);
> +	policydigest[SHA256_DIGEST_SIZE * 2] = '\0';
> +	keyinfo = kasprintf(GFP_KERNEL, keytemplate, policydigest);
> +	if (!keyinfo) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

With the %*phN format specifier, there would be no need for bin2hex().

- Eric
