Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236C6F3E71
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjEBHhr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 May 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjEBHhq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 03:37:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F35E7A;
        Tue,  2 May 2023 00:37:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D93DD1F8AA;
        Tue,  2 May 2023 07:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683013063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UP0knNuNYeninJvTCEolg7Kd5UorRlQp22Xzd4OurrE=;
        b=HYsRW5YJrHtin5rxLym6IX7TQfNmt+ofIXngnSUH2HI/PH7EF3pPA4NejxVeCpO0TV5uxM
        uTLlB0Pk9mOl5778ZeLfWMGGwmr4U1JQ8z8+9DWS7UcUNTqDSmxxj6luIK+UZT5FlGMikX
        qAx+IK5DQFKGYa2EFlcM5q40/xLfY9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683013063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UP0knNuNYeninJvTCEolg7Kd5UorRlQp22Xzd4OurrE=;
        b=E+/bBYduJz2HMnu1+Ot/b/gxOhTN20LHHN5X6QJD1JeaiTriwlwNG+3qMhA249doCPSgcp
        3LpCyLh3TLGgbaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3A86139C3;
        Tue,  2 May 2023 07:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e+QwL8e9UGSIFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 02 May 2023 07:37:43 +0000
Message-ID: <6b03aaf5-2017-a0c9-9c84-c8ee2aa4ba0e@suse.cz>
Date:   Tue, 2 May 2023 09:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/2] Fix TPM 1.2 resume
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20230502011558.10743-1-jarkko@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230502011558.10743-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/2/23 03:15, Jarkko Sakkinen wrote:
> During TPM 1.2 resume, the first PCR read operation used inside
> tpm1_do_selftest() fails. Fix the bugs preventing resume from working.

Thanks for fixing this, unfortunately I can no longer test the fix as I've
got a new laptop since when I was hitting the bug on the older one.

Vlastimil

> v2:
> * Added Jerry's reviewed-by's.
> * Rebased to 865fdb08197e ("Merge tag 'input-for-v6.4-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input").
> * Mirrored patches to linux-next.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Link: https://lore.kernel.org/linux-integrity/CS6UJMSTVA4L.FRQ5VL1I1EF4@suppilovahvero/T/#m236d62184229cc035605143fde10933bcde60065
> Jarkko Sakkinen (2):
>   tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
>   tpm: Prevent hwrng from activating during resume
> 
>  drivers/char/tpm/tpm-chip.c      |  4 +++
>  drivers/char/tpm/tpm-interface.c | 10 ++++++++
>  drivers/char/tpm/tpm_tis_core.c  | 43 ++++++++++++++------------------
>  include/linux/tpm.h              |  1 +
>  4 files changed, 34 insertions(+), 24 deletions(-)
> 

