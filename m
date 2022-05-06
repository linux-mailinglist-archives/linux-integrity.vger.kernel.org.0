Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0951E02E
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 22:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443017AbiEFUiy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiEFUix (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 16:38:53 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A30196D4E2
        for <linux-integrity@vger.kernel.org>; Fri,  6 May 2022 13:35:08 -0700 (PDT)
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3DBDB20EB6CD;
        Fri,  6 May 2022 13:35:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DBDB20EB6CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651869308;
        bh=tMd02Z5BKulKE+kWGr4119bPTz47dltWY97r8KflyzI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TlfgJd7xBh65q+REQtKDLpR+LR3p3jEfkt4BYyzWyZ1yPCuIGEoxhQLbeSTG8yKAJ
         xhWUW45v3dKwNWPD/l6lTdGVEFuDKpVFSvFTXZ71phuyzIEVCIYynjUuS8fVnBvmoS
         rJgn3yqEiEj3W5sdrdRjFMRuRp/dM+ZgwItNslq0=
Message-ID: <b4c21ae2-3980-c7ca-7719-7477d0acaa72@linux.microsoft.com>
Date:   Fri, 6 May 2022 13:35:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 2/3] dm verity: add support for IMA target update
 event
Content-Language: en-US
To:     Thore Sommer <public@thson.de>, dm-devel@redhat.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org
References: <20220106203436.281629-1-public@thson.de>
 <20220106203436.281629-3-public@thson.de>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
In-Reply-To: <20220106203436.281629-3-public@thson.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thore,

On 1/6/2022 12:34 PM, Thore Sommer wrote:
> On first corruption the verity targets triggers a dm_target_update event.
> This allows other systems to check using IMA if the state of the device is
> still trustworthy via remote attestation.
In the patch description please state the existing problem (or, 
limitation in the existing implementation) and then describe how the 
proposed change addresses the issue.

> 
> Signed-off-by: Thore Sommer <public@thson.de>
> ---
>   drivers/md/dm-verity-target.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 80133aae0db3..09696e25bf1c 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -16,6 +16,7 @@
>   #include "dm-verity.h"
>   #include "dm-verity-fec.h"
>   #include "dm-verity-verify-sig.h"
> +#include "dm-ima.h"
>   #include <linux/module.h>
>   #include <linux/reboot.h>
>   #include <linux/scatterlist.h>
> @@ -218,10 +219,15 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
>   	char *envp[] = { verity_env, NULL };
>   	const char *type_str = "";
>   	struct mapped_device *md = dm_table_get_md(v->ti->table);
> +	int old_hash_failed = v->hash_failed;
>   
>   	/* Corruption should be visible in device status in all modes */
>   	v->hash_failed = 1;
>   
> +	/* Only remeasure on first failure */
> +	if (!old_hash_failed)
> +		dm_ima_measure_on_target_update(v->ti);
It is not obvious to me why the call to measure on target update is not 
done here immediately. Updating the comment to explain the logic would help.

thanks,
  -lakshmi

> +
>   	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
>   		goto out;
>   
