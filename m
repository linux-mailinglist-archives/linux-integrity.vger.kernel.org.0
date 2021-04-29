Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C0A36EFDE
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhD2TEH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 15:04:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40275 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233830AbhD2TEH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 15:04:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 450205C013B;
        Thu, 29 Apr 2021 15:03:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Apr 2021 15:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=0qAdwqSnnmXWMaIHBBgYRffE9iU
        D9R846lYUjFsFhzg=; b=llYugO1zP4dn+Ebi9q4GVu/rJ5jWHj7vbVGmWT8N5wz
        MJvnt5HNV2CP0/c2egMni3ihePnyKEI8+eXvIYW1Muwqkf6rLQXhWYmiFnaqcmp6
        9Y6VHOHu3X+MAR09bAnr8lW6aaxl4o1ajv+5orsEViRRAuGi+od5EEtpMjlxo4dd
        bbdCLAKLKh/x1YoSfk4DZ7aPI0vSCv9LFcIQ2NoUEiEd5B1+kMuPGslbOy3TjZab
        tCjWsdPirP0y6Irflsro8zZS81RW1tc4ngz6TmxajAC6GfUb062t+sE5/GfgjJNO
        DjSJ/B2OCjfcTbqarbjf889K38+Z3FV7efmnRwXaXYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0qAdwq
        SnnmXWMaIHBBgYRffE9iUD9R846lYUjFsFhzg=; b=ZwHGKGTiZBxxy179ej0jIb
        7ENvIdIJ3x/6zbYuMXl+tGT413BeQj6UWtX+p8Bgn2HItKkzdT6y7QQ8z+Nsfj12
        Ur80VOjzWcge5w74UPp+TyjaL7y5l8u5+6exhXwFbETmmfYlmRoihya9k8HZ4npU
        YdHWgOE7HuEtfR2NVN1SoLJW454smJAPCSs9ejl+80pvCnoOAbZugCyJMuDTZVRZ
        xjr3b5iBAlkDvxPepmdC+/4e+23e4xBXlBlTVOUvS7tv3MqDUX9y4s4jrd/ng4c6
        zsxC6fDe6ipNMV2+GAGQ1QlAjscM6S97/4rCG4UyYEUjcwpV/eOwtwld5OK1DA+w
        ==
X-ME-Sender: <xms:9wKLYAhJa1_JWM9TfZVbzYt09STwReBJgckaMljpGqYOciPhoh9ENw>
    <xme:9wKLYJBkoY_jFt-ibe1VxUm3JGLNO_zuRS6H1GSQFakjnVqz8H-6aNlG8pTCsjFtv
    k3uezUHWX5rrs8YEjc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepvefftdettefgtddtkeeufeegtddttdeuueegkeegteffueetffejudeihefh
    kedtnecukfhppedvgedrudeiledrvddtrddvheehnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:9wKLYIGJMbQrYqIMulg-YNQfLslFr5KV7nZjEoEX3ZvNwPPFGGijAg>
    <xmx:9wKLYBTecCDbA_46OiOCDSSaMaVNyemmlQWT2jL31tjuAOST0cYVyg>
    <xmx:9wKLYNxKSIYXvgGR8TYP5S5S6z7qRcgle4BYsTsCWwOzyu91zhwjgA>
    <xmx:-AKLYPuQbuGLAekf_BNVT9DoEokw-A2NjJAYakIZhXjA2HPv4cKbKQ>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 15:03:19 -0400 (EDT)
Date:   Thu, 29 Apr 2021 15:03:18 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] trusted-keys: match tpm_get_ops on all return paths
Message-ID: <YIsC9mT8XmIi/fbB@erythro>
References: <20210429183742.756766-1-list.lkml.keyrings@me.benboeckel.net>
 <20210429183742.756766-2-list.lkml.keyrings@me.benboeckel.net>
 <9eea988ff637af57511107c6c0941bff2aa7c6c5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9eea988ff637af57511107c6c0941bff2aa7c6c5.camel@HansenPartnership.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 29, 2021 at 11:50:50 -0700, James Bottomley wrote:
> Actually, I think this is a better fix to avoid multiple put and
> returns.
> 
> James
> 
> ---
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index d225ad140960..cbf2a932577b 100644
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

Ah, that does look better. I had first added a new label, but that
didn't seem like an improvement in readability. I grabbed this pattern
from an early return earlier in the function. But given that this is the
end (and appears to be unlikely to have more logic inserted in the
future), this seems more reasonable to me as well. Do you want me to
respin or just let it up to you at this point?

Thanks,

--Ben
