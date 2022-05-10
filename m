Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C097B521467
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 13:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiEJMBN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiEJMBG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 08:01:06 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD016689A;
        Tue, 10 May 2022 04:56:58 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeae3.dynamic.kabel-deutschland.de [95.90.234.227])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2911861E6478B;
        Tue, 10 May 2022 13:56:55 +0200 (CEST)
Message-ID: <c0daa593-5494-6d40-969b-f7ed09e87d99@molgen.mpg.de>
Date:   Tue, 10 May 2022 13:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] tpm: increase timeout for kselftests
Content-Language: en-US
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
References: <20220510111607.22984-1-johannes.holland@infineon.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220510111607.22984-1-johannes.holland@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Johannes,


Thank you for your patch.

Am 10.05.22 um 13:16 schrieb Johannes Holland:


Should you resend, maybe be more specific in the commit message summary. 
Maybe:

Double timeout for kselftests to 10 min

> Due to CreatePrimary commands which need to create RSA keys of
> increasing size, the timeout value need to be raised, as well.

need*s*?

> Default is 300s.

Mention 600 ms somewhere?

> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
> A timeout of anything below 600s still lead to occasional timeouts for
> me. Therefore, I propose 600s as a new value.

I’d say, this should go into the commit message. Maybe even say, what 
devices you are testing with.


Kind regards,

Paul


>   tools/testing/selftests/tpm2/settings | 2 ++
>   1 file changed, 2 insertions(+)
>   create mode 100644 tools/testing/selftests/tpm2/settings
> 
> diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
> new file mode 100644
> index 000000000000..919bc3803f03
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/settings
> @@ -0,0 +1,2 @@
> +timeout=600
> +
