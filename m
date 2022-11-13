Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE266272D4
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 23:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiKMWN2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 17:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMWN1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 17:13:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5182993;
        Sun, 13 Nov 2022 14:13:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E075860C0A;
        Sun, 13 Nov 2022 22:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A110C433D6;
        Sun, 13 Nov 2022 22:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668377602;
        bh=U2ikFT6APnNMIjqmwVyd0zK7pPxr9s3HsJ5ryDClCZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sa508lT3frr4RDqVpbXRhF0rZhhOCKgRoIwGz0c5TFPEjyqwT7RVUb7+gQ8KC3H+v
         hBOBKeCj0VFPv/HvwF+ASUxsDFjLJtTTzg+gr+0AultOmcMECBR8L6E/G+0Pa5g31z
         Pn46Lh+Z6aL9KsK8la+0fi7T6etk1d6jl18gMFVGTgNxmMt+odueFN80jh0/TxB8xW
         U48ZUddUVrKuq8UZyFnuHE0fBAmryLm6uiZFg0I7m6t3pDW1c5gFyLc3SR+LM04Y2P
         2GUEvg44W3ZQSXjFzn4TOiM0KuAMj5JvaZEtBZSAjecTfu2CxeAKbAQPH27hr11DjZ
         dRfsS1NK8ERog==
Date:   Sun, 13 Nov 2022 14:13:19 -0800
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
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 06/11] security: keys: trusted: Verify creation data
Message-ID: <Y3Fr//gNYls25Ug3@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.6.I6cdb522cb5ea28fcd1e35b4cd92cbd067f99269a@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:31PM -0800, Evan Green wrote:
> security: keys: trusted: Verify creation data
>
> If a loaded key contains creation data, ask the TPM to verify that
> creation data. This allows users like encrypted hibernate to know that
> the loaded and parsed creation data has not been tampered with.

I don't understand what the purpose of this is.

I thought that the way to "seal" a key to a TPM PCR is to include the PCR in the
"policy".

Are you doing that too?  What is the purpose of using the "creation data"?

> +	/* Auth */
> +	tpm_buf_append_u32(&buf, 9);
> +	tpm_buf_append_u32(&buf, TPM2_RS_PW);
> +	tpm_buf_append_u16(&buf, 0);
> +	tpm_buf_append_u8(&buf, 0);
> +	tpm_buf_append_u16(&buf, 0);

This is struct tpm2_null_auth_area, so this is another place that could take
advantage of a new helper function to append it.

> +	/* Creation data hash */
> +	if (payload->creation_hash_len < 2) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	tpm_buf_append_u16(&buf, payload->creation_hash_len - 2);
> +	tpm_buf_append(&buf, payload->creation_hash + 2,
> +		       payload->creation_hash_len - 2);

So the first two bytes of creation_hash are a redundant length field that needs
to be ignored here?  Perhaps tpm2_key_encode() shouldn't include that redundant
length field?

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

This is another instance of the bug where a positive TPM2_RC_* code is being
returned from a function that is supposed to return a negative errno value.

- Eric
