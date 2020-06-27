Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5220C4D9
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jun 2020 01:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgF0XkZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jun 2020 19:40:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36496 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgF0XkY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jun 2020 19:40:24 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1F73D20B4901;
        Sat, 27 Jun 2020 16:40:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F73D20B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593301224;
        bh=FClStV9rjHmFcTEtnx7rPkfJzACkXLF1GC7aCZk02Ok=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dqxT0u2/Ccs5igTY5wQfqs1S99kMz8M5hsuWIfeNNEaBd0Jz7CiUYipTs2CjMYQsn
         6ZqtHfnF2/U/HNTD7oFY9chTEPbgLmBBi+OhjnOdyFVB2ZTNmTKIqQKAiT//YMlLkQ
         to6gqvsHbgf2AaZND6Roa+OXF0Kgim9T0wJQtkIA=
Subject: Re: [PATCH v2 05/11] ima: Fail rule parsing when the KEXEC_CMDLINE
 hook is combined with an invalid cond
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-6-tyhicks@linux.microsoft.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9a45adf9-545f-f302-0000-945b5736c8a6@linux.microsoft.com>
Date:   Sat, 27 Jun 2020 16:40:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626223900.253615-6-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/26/20 3:38 PM, Tyler Hicks wrote:
> The KEXEC_CMDLINE hook function only supports the pcr conditional. Make
> this clear at policy load so that IMA policy authors don't assume that
> other conditionals are supported.
> 
> Since KEXEC_CMDLINE's inception, ima_match_rules() has always returned
> true on any loaded KEXEC_CMDLINE rule without any consideration for
> other conditionals present in the rule. Make it clear that pcr is the
> only supported KEXEC_CMDLINE conditional by returning an error during
> policy load.
> 
> An example of why this is a problem can be explained with the following
> rule:
> 
>   dont_measure func=KEXEC_CMDLINE obj_type=foo_t
> 
> An IMA policy author would have assumed that rule is valid because the
> parser accepted it but the result was that measurements for all
> KEXEC_CMDLINE operations would be disabled.
> 
> Fixes: b0935123a183 ("IMA: Define a new hook to measure the kexec boot command line arguments")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> 
> * v2
>    - Added Mimi's Reviewed-by
> 
>   security/integrity/ima/ima_policy.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 166124d67774..676d5557af1a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -343,6 +343,17 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>   	return 0;
>   }
>   
> +static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_LSM_RULES; i++)
> +		if (entry->lsm[i].args_p)
> +			return true;
> +
> +	return false;
> +}
> +
>   /*
>    * The LSM policy can be reloaded, leaving the IMA LSM based rules referring
>    * to the old, stale LSM policy.  Update the IMA LSM based rules to reflect
> @@ -993,6 +1004,16 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   		case POLICY_CHECK:
>   			break;
>   		case KEXEC_CMDLINE:
> +			if (entry->action & ~(MEASURE | DONT_MEASURE))
> +				return false;
> +
> +			if (entry->flags & ~(IMA_FUNC | IMA_PCR))
> +				return false;
> +
> +			if (ima_rule_contains_lsm_cond(entry))
> +				return false;
> +
> +			break;
>   		case KEY_CHECK:
>   			if (entry->action & ~(MEASURE | DONT_MEASURE))
>   				return false;
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

