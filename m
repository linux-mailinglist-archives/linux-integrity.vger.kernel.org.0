Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0832036D
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 04:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBTDHh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 22:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBTDHf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 22:07:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E2A164EE0;
        Sat, 20 Feb 2021 03:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613790414;
        bh=iy2Eb6qZ0tP3+bdv50GaJ2iR4lwzXWSbVFQ/dX331EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTv8Cl09ORuvjH8bg6lwvbZgq8V+NcvQtJrljTRSX8BNf9SfPoD1loDOxsXuVwo68
         2ogNKYE5jpSKymyDVYJxnXp3SidO4UZHvs3S0bNX/VUGAKHXjhQ67lW62Oh0jmYAvA
         ZfXKWkPpa0FGs8++d8jLO3cRNiiRuP/GvhkK+6PMDeecJuWbGUSIK65U6NjLR/i5qm
         FvV9cceEeSzF9bgxENyOqe/jhkYEd4OQHz5hhHER10lPtbiC1uTiBsefHKSF3HO70e
         ZuwvmknsnEuxfAWV4D0OvEo+mRAYW/lJsFIChF71DRefueenLWKStj4FwSqY8/mctF
         GQgP/rrFB8whA==
Date:   Sat, 20 Feb 2021 05:06:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 4/9] security: keys: trusted: Store the handle of a
 loaded key
Message-ID: <YDB8vwZ2MqQ8x1sj@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-5-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220013255.1083202-5-matthewgarrett@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:50AM +0000, Matthew Garrett wrote:
> Certain in-kernel operations using a trusted key (such as creation
> certification) require knowledge of the handle it's loaded at. Keep
> a copy of that in the payload.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

This looks good to me as well *as a code change*.

/Jarkko

> ---
>  include/keys/trusted-type.h               | 1 +
>  security/keys/trusted-keys/trusted_tpm2.c | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 020e01a99ea4..154d8a1769c3 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -21,6 +21,7 @@
>  
>  struct trusted_key_payload {
>  	struct rcu_head rcu;
> +	unsigned int blob_handle;
>  	unsigned int key_len;
>  	unsigned int blob_len;
>  	unsigned int creation_len;
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 6357a51a24e9..a3673fffd834 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -272,11 +272,13 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	}
>  
>  	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
> -	if (!rc)
> +	if (!rc) {
>  		*blob_handle = be32_to_cpup(
>  			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
> -	else
> +		payload->blob_handle = *blob_handle;
> +	} else {
>  		goto out;
> +	}
>  
>  	rc = tpm2_unpack_blob(payload);
>  out:
> -- 
> 2.30.0.617.g56c4b15f3c-goog
> 
> 
