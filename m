Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2336EFBD
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 20:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbhD2Svq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbhD2Svj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 14:51:39 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF53C06138C;
        Thu, 29 Apr 2021 11:50:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D21C912801CA;
        Thu, 29 Apr 2021 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619722251;
        bh=VwqfuRV94ygqfXZS1UeALT+6jZdpwq29n2FhIXE8648=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=BNzknt7UULVwUspwyiap7s3ojhMPpAootk5fdqtimemuj485mf0hQsV2iusO5/XBa
         sBVnZjWmK2kh4Yd5RY6r3dGDIxujwxQecdeV8EJH8XcP691OyW+m3t/IIk5bqfQwE8
         KGhDIWhIZcAdp4R9n4QsVILWIXSk7DnQsvskDOHM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kSLeBx-fT8Hw; Thu, 29 Apr 2021 11:50:51 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4CFA3128017C;
        Thu, 29 Apr 2021 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1619722251;
        bh=VwqfuRV94ygqfXZS1UeALT+6jZdpwq29n2FhIXE8648=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=BNzknt7UULVwUspwyiap7s3ojhMPpAootk5fdqtimemuj485mf0hQsV2iusO5/XBa
         sBVnZjWmK2kh4Yd5RY6r3dGDIxujwxQecdeV8EJH8XcP691OyW+m3t/IIk5bqfQwE8
         KGhDIWhIZcAdp4R9n4QsVILWIXSk7DnQsvskDOHM=
Message-ID: <9eea988ff637af57511107c6c0941bff2aa7c6c5.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/1] trusted-keys: match tpm_get_ops on all return paths
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ben Boeckel <me@benboeckel.net>, keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 29 Apr 2021 11:50:50 -0700
In-Reply-To: <20210429183742.756766-2-list.lkml.keyrings@me.benboeckel.net>
References: <20210429183742.756766-1-list.lkml.keyrings@me.benboeckel.net>
         <20210429183742.756766-2-list.lkml.keyrings@me.benboeckel.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-04-29 at 14:37 -0400, Ben Boeckel wrote:
> From: Ben Boeckel <mathstuf@gmail.com>
> 
> The `tpm_get_ops` call at the beginning of the function is not paired
> with a `tpm_put_ops` on this return path.
> 
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key
> format for the blobs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> b/security/keys/trusted-keys/trusted_tpm2.c
> index 617fabd4d913..25c2c4d564de 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -335,8 +335,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		else
>  			rc = -EPERM;
>  	}
> -	if (blob_len < 0)
> +	if (blob_len < 0) {
> +		tpm_put_ops(chip);
>  		return blob_len;
> +	}
>  
>  	payload->blob_len = blob_len;
>  

Actually, I think this is a better fix to avoid multiple put and
returns.

James

---

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index d225ad140960..cbf2a932577b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -336,9 +336,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			rc = -EPERM;
 	}
 	if (blob_len < 0)
-		return blob_len;
-
-	payload->blob_len = blob_len;
+		rc = blob_len;
+	else
+		payload->blob_len = blob_len;
 
 	tpm_put_ops(chip);
 	return rc;

