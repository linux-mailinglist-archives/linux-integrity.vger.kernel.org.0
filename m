Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F923BDE08
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 21:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGFTac (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 15:30:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42450 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGFTac (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 15:30:32 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5BA5B20B7188;
        Tue,  6 Jul 2021 12:27:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BA5B20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625599673;
        bh=ryjydfJPAKvDWqmnuLYjXsYmMMZaDBUiObj4MocZElo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bl/TCf9udxXUZhstiHlaeRDUFCZ+x9yZkTseKahwkqNkCPu9eTn70a9zS2+PfqBe5
         ZPoxQQLbJfnkr0fVeWG91ywfhnkWdkWbalTRWq2OanCt2MCm/6Sdu2IWO5e52bV/6L
         9IRgfMuZoPYkOZKjok7EtGaffZzRWZJixbKIwDCY=
Subject: Re: [PATCH] ima: Support euid keyword for buffer measurement
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210705115650.3373599-1-roberto.sassu@huawei.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2996f5ae-d76f-5fc9-bf90-857d4fc6644a@linux.microsoft.com>
Date:   Tue, 6 Jul 2021 12:29:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705115650.3373599-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/5/2021 4:56 AM, Roberto Sassu wrote:

Hi Roberto,

> This patch makes the 'euid' keyword available for buffer measurement rules,
> in the same way as for other rules. Currently, there is only support for
> the 'uid' keyword.
> 
> With this change, buffer measurement (or non-measurement) can depend also
> on the process effective UID.

Who (kernel component) will be using this?

Maybe you could make this change as part of the patch set in which the 
above "euid" support will be used.

thanks,
  -lakshmi

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   security/integrity/ima/ima_policy.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fd5d46e511f1..fdaa030fb04b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -480,6 +480,16 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
>   	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
>   		return false;
>   
> +	if (rule->flags & IMA_EUID) {
> +		if (has_capability_noaudit(current, CAP_SETUID)) {
> +			if (!rule->uid_op(cred->euid, rule->uid)
> +			    && !rule->uid_op(cred->suid, rule->uid)
> +			    && !rule->uid_op(cred->uid, rule->uid))
> +				return false;
> +		} else if (!rule->uid_op(cred->euid, rule->uid))
> +			return false;
> +	}
> +
>   	switch (rule->func) {
>   	case KEY_CHECK:
>   		if (!rule->keyrings)
> @@ -1153,7 +1163,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   		if (entry->action & ~(MEASURE | DONT_MEASURE))
>   			return false;
>   
> -		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> +		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_EUID | IMA_PCR |
>   				     IMA_LABEL))
>   			return false;
>   
> 
