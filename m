Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5023D57DB
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 12:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhGZKQQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 06:16:16 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:57330
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231792AbhGZKQP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 06:16:15 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 858E73F342;
        Mon, 26 Jul 2021 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627297003;
        bh=E8Bl7iWZmRi4QYo4RVKeJYrZa1hIqawSMitAIqqPS4k=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=FI5rCvpfr6YTlZdQedosfpBaL27ZxWPeTr8BwlAJAXi0KxqXAqp+c6Frkstg6ZiMb
         8hb+bAccpPc+s5gTJDunt9esZuGXnPNpKjWcNfAxEf5NHXv8nu/ECaOnTcS4wHACkL
         NrIowWZLkIWjpxY/MmuKm5OtVnlLl0sHoL6O363fgKhMMSY2S/qlNYv3VCoKN1FpoX
         kbUN9j3n0tPuxlrdVAW7PzUSVbUBButMsLSLyYgchu8ZeFk/VliCFEfKqka85u8XXJ
         fO+rqPXv1cgUhMEb08naQED90J7qQNd8lDWz4MpQJ5rpRkXPlE7556cdAmHoiIAfiN
         bPggbCtU57IJQ==
Subject: Re: [PATCH] security: keys: trusted: Fix memory leaks on allocated
 blob
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210723172121.156687-1-colin.king@canonical.com>
 <20210726085051.GG1931@kadam>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <4f200a4d-75ee-99c8-dc16-3626df7e6ff3@canonical.com>
Date:   Mon, 26 Jul 2021 11:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726085051.GG1931@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 26/07/2021 09:50, Dan Carpenter wrote:
> On Fri, Jul 23, 2021 at 06:21:21PM +0100, Colin King wrote:
>> @@ -441,6 +449,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>>  		rc = -EPERM;
>>  
>>  	return rc;
>> +
>> +err:
>> +	kfree(blob);
> 
> This needs to be:
> 
> 	if (blob != payload->blob)
> 		kfree(blob);

Good spot! Thanks Dan.

> 
> Otherwise it leads to a use after free.
> 
>> +	return rc;
>>  }
> 
> How this is allocated is pretty scary looking!

it is kinda mind bending.

Colin

> 
> security/keys/trusted-keys/trusted_tpm2.c
>     96  static int tpm2_key_decode(struct trusted_key_payload *payload,
>     97                             struct trusted_key_options *options,
>     98                             u8 **buf)
>     99  {
>    100          int ret;
>    101          struct tpm2_key_context ctx;
>    102          u8 *blob;
>    103  
>    104          memset(&ctx, 0, sizeof(ctx));
>    105  
>    106          ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
>    107                                 payload->blob_len);
>    108          if (ret < 0)
>    109                  return ret;
> 
> Old form?
> 
>    110  
>    111          if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
>    112                  return -EINVAL;
> 
> It's really scary to me that if the lengths are too large for kmalloc()
> then we just use "payload->blob".
> 
>    113  
>    114          blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> 
> blob is allocated here.
> 
>    115          if (!blob)
>    116                  return -ENOMEM;
>    117  
>    118          *buf = blob;
>    119          options->keyhandle = ctx.parent;
>    120  
>    121          memcpy(blob, ctx.priv, ctx.priv_len);
>    122          blob += ctx.priv_len;
>    123  
>    124          memcpy(blob, ctx.pub, ctx.pub_len);
>    125  
>    126          return 0;
>    127  }
> 
> [ snip ]
> 
>    371          u32 attrs;
>    372  
>    373          rc = tpm2_key_decode(payload, options, &blob);
>    374          if (rc) {
>    375                  /* old form */
>    376                  blob = payload->blob;
>                         ^^^^^^^^^^^^^^^^^^^^
> 
>    377                  payload->old_format = 1;
>    378          }
>    379  
> 
> regards,
> dan carpenter
> 

