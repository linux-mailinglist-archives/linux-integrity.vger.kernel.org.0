Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38C3701A8
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhD3T5O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 15:57:14 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:45389 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233671AbhD3T5L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 15:57:11 -0400
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Apr 2021 15:57:11 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 139241EAC;
        Fri, 30 Apr 2021 15:50:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 30 Apr 2021 15:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PtajBDBgytedXM7xt9/aNsUr4Q+
        i946QjqQp1VhqJa0=; b=mJJOo7rS8hXM00Wzh05jeER5Vf3Ld3NnGG9ASX9Do7n
        MTQnxS+peMdL2PAAmeXBAnOliWXZLjWbVORnHc2tZ+zdVAq+FrrjQrRghZYGMNsu
        C5jiv/W4NiHy73v+9zORRbE5bfhqAdk5uMGH7iHztDco185BwAgjLaJJCbwi4b/U
        +DRbmVu/soNpkYIzA8wVINuZJKBdidbNeTXZP9HYSSqPTSM4v7SgmCy3MMqW1r6K
        zBNCCqC0o+QorvcPBEjr4IsTgkh3AQxYBi/khA8kYojegwY2uDp47E9ITbTJAS7w
        0Af8o5u0sHR27UR4Y5ePJFGpY3WQmaLs0QrzcYlYjSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PtajBD
        BgytedXM7xt9/aNsUr4Q+i946QjqQp1VhqJa0=; b=CQw2WcmK0fpUBvOrNdkrDt
        AAWM/QVfy+qlNpPT+VPwx9PNzbCCq6ePBp+b4Q6Wl4hI/bAsqgRjZ8DFUSC9fizQ
        vhVXOsCZzuvOq9dpF0s9UpB6oo4tuMcm1jvtFdkegkhtFMwLRKeyjLkQlVsuk7Tf
        113wZGyzLKai5j5g8jRONyowqb0RWqak+oaGvlNW4fpWE42y8S3ikxlUp/cVgSi4
        DlGTd/JD3/4/Ogcf4sFEGhFVlH9jlAziHaYdXSg3v5cJhEn4s27xBB52ZCuAqtgq
        nYhZGf5ybpWEpS3ddGuvLxz4raHynVZmOj+jy7n6qQ2cndY0uVaABLoQj7PUzbmA
        ==
X-ME-Sender: <xms:fV-MYGCuNY33RtIZbJ2dAPFK-P6e3VGSCt-Qz7WlOG0ov0WXdKygwQ>
    <xme:fV-MYAib-6LePyxvkfHUzCAv0PJnkZ9MgCo72TC797hKCm5nhhNnE9_dhkA_80FKW
    cQclyz51QwWwlVkpZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepvefftdettefgtddtkeeufeegtddttdeuueegkeegteffueetffejudeihefh
    kedtnecukfhppedvgedrudeiledrvddtrddvheehnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:fV-MYJmKKkUaZ3Vg6hQeQFv6z0sonlUX9aZ6s_HkpIQ4Iqvw1acM_A>
    <xmx:fV-MYEzlkWO2rbOYKSWEGCIc0TwEtVU7W6_Fz3V-YsQKTFki7ArI7g>
    <xmx:fV-MYLStdP-ko4iAxttjv0Qh8tF8vO1MUVQH82APFsVxUDNIfv4oGw>
    <xmx:fV-MYA_xWu_ni5RFR_Vbc-9xPIpzruTB8Xs3eqDeuNBkSKU6b0r3VDOOCBo>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 30 Apr 2021 15:50:20 -0400 (EDT)
Date:   Fri, 30 Apr 2021 15:50:18 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     trix@redhat.com
Cc:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] KEYS: trusted: fix memory leak
Message-ID: <YIxfehTLhWe58sNE@erythro>
References: <20210430185810.3331311-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430185810.3331311-1-trix@redhat.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 30, 2021 at 11:58:10 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> trusted-keys/trusted_tpm1.c:496:10: warning: Potential memory leak
>   return ret;
>          ^~~
> 
> In tpm_seal() some failure handling returns directly, without
> freeing memory.
> 
> Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 469394550801..aa108bea6739 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -493,10 +493,12 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
>  
>  	ret = tpm_get_random(chip, td->nonceodd, TPM_NONCE_SIZE);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
> -	if (ret != TPM_NONCE_SIZE)
> -		return -EIO;
> +	if (ret != TPM_NONCE_SIZE) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  
>  	ordinal = htonl(TPM_ORD_SEAL);
>  	datsize = htonl(datalen);

I see this patch also submitted by Colin (Cc'd) in Message-Id:

    <20210430113724.110746-1-colin.king@canonical.com>

To my eyes, the commit message seems a bit better over there.

--Ben
