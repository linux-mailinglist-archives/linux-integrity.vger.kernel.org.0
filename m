Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897563798BB
	for <lists+linux-integrity@lfdr.de>; Mon, 10 May 2021 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEJVFq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 May 2021 17:05:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44985 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbhEJVFq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 17:05:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 463445C004F;
        Mon, 10 May 2021 17:04:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 10 May 2021 17:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=b+B/Ao5TBLbn8YtT21sbRFDG8ts
        Ssyhgsy6rowzSCO8=; b=iFZ2Hrvxjx+zZkLTKCjSMtsUAvMgvSOiqGpIyAMCdCn
        7//m6GaTjkoIdvzqZDdIpAVkcQMlvCIAzK3yu/Dk2FMasgkr8BCV+edU6hkjXtsY
        aTf7Dw7PV3epQNz9PES8WumbNqFIVxtmvc9Q02ZbiNPTPZd19BtAKK7kGRP2PPsU
        F4r2svNX59SQu2Iz/pMrbYfjMK9yZPNcPq274JbGkjxI3bHqjigbDvO6/yIIf52v
        /HhCIMuJVBPhI3i9lgHIsLvjEeQq/GmY/MwWuRgR5PGgBt0mQ4Kt1b5ogsdPVZQZ
        s549O5y35DEHrPbz7PF92M5kxBrJMmVdkwAr9TqmiSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=b+B/Ao
        5TBLbn8YtT21sbRFDG8tsSsyhgsy6rowzSCO8=; b=Uci6YFmok17WNk7jqxrnKX
        KXS9dQeGedD0sYZJazlhh3LbN3dvi/j5QecsUh7Y+OBjHI9WmK4tjgN52D+0hWY+
        AgYvISA7Rhpq4evPc831YZz9xEUGnDt+jBPmullaHqgSZCTMA/VG9TkCgTsCKZvI
        VqvG9L4fJB2yT9+WxNib7wM2VUZ/asDy20PU5h+q60oInIk3A0CMU+U29mtEgr5O
        yWmjjPDu3i3BXHMY34lM2HPB5PS8JsCP540SnGD8RCUwZ6bKNZ0wkuQ1WOVHLQjF
        e09AH4UJW7ypLFz06pyyxl8IDj/7s10Ln7bFw/0mz3BsPHCru0caaOGiDmQJm93g
        ==
X-ME-Sender: <xms:45-ZYE1KqrRSWHuBSacsn2R2KmU8jnwNQWXkldS22XwxqRl0OKY68A>
    <xme:45-ZYPHsNHh7J5waVoc9wpH9Twbv3BYPHQsEQsnPwmUJG3Id-j_XJz9XU8VIHA9oh
    AgSOXwl2o5yPQL8oOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepvefftdettefgtddtkeeufeegtddttdeuueegkeegteffueetffejudeihefh
    kedtnecukfhppedvgedrudeiledrvddtrddvheehnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:45-ZYM7A9R5Jt2884Wp-wnpKOdJ7Twu5t9g8IG7DuYKUg3n8lu3uHA>
    <xmx:45-ZYN2Xp6CeEy5PSwod02rub18zFMmwz7RbKIuvGS54fey7QdUvGA>
    <xmx:45-ZYHH7y9uu0mR82EeCRA906xVt8_91KEgHNO1kcJaBJmKodtrzgw>
    <xmx:5J-ZYLi2w64bLuN-O1vT7gak7sK-d9Kfpx36F0KpvufnaZo_O4-JmA>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 17:04:35 -0400 (EDT)
Date:   Mon, 10 May 2021 17:04:33 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/1] trusted-keys: match tpm_get_ops on all return
 paths
Message-ID: <YJmf4Q0l+MTFEaEo@erythro.dev.benboeckel.internal>
References: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
 <20210429192156.770145-2-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210429192156.770145-2-list.lkml.keyrings@me.benboeckel.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 29, 2021 at 15:21:56 -0400, Ben Boeckel wrote:
> From: Ben Boeckel <mathstuf@gmail.com>
> 
> The `tpm_get_ops` call at the beginning of the function is not paired
> with a `tpm_put_ops` on this return path.
> 
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 617fabd4d913..0165da386289 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -336,9 +336,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  			rc = -EPERM;
>  	}
>  	if (blob_len < 0)
> -		return blob_len;
> -
> -	payload->blob_len = blob_len;
> +		rc = blob_len;
> +	else
> +		payload->blob_len = blob_len;
>  
>  	tpm_put_ops(chip);
>  	return rc;

Ping? Is this going to make 5.13? This fixes an issue that is in
5.13-rc1.

--Ben
