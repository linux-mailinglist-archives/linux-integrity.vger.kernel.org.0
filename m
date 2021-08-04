Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438ED3E099F
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhHDUvQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 16:51:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60682 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhHDUvP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 16:51:15 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8946B209DD68;
        Wed,  4 Aug 2021 13:51:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8946B209DD68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628110262;
        bh=j+Jdj14wduq+3kGM8o+waUHvvZ7RhGotGzO5WNDWr9k=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=tIyhOAkEw/1S4aRa4rjk/WvOm2oYHRnRaaUrNvJVxp1/UwWpZGSeop//Fumx26Um/
         7GIe9SVe0qU3VJ/JfxEiAXzDcznNBe1sVQBT+vGFjYOuEZlR9LZUZ5YmuHHxSS5Gvz
         YkYflrSpKwBP89MYfKsZIWnqGKdRVH6daYsRWtX4=
Subject: Re: [PATCH v6 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-5-simon.thoby@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a1cad70f-b146-988a-746f-6c64f9631848@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 13:53:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804092010.350372-5-simon.thoby@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On 8/4/2021 2:20 AM, THOBY Simon wrote:

> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   Documentation/ABI/testing/ima_policy |  6 ++-
>   security/integrity/ima/ima_policy.c  | 75 ++++++++++++++++++++++++++--
>   2 files changed, 76 insertions(+), 5 deletions(-)
> 

>   
> +static unsigned int ima_parse_appraise_hash(char *arg)
> +{
> +	unsigned int res = 0;
> +	int idx;
> +	char *token;
> +
> +	while ((token = strsep(&arg, ",")) != NULL) {
> +		idx = match_string(hash_algo_name, HASH_ALGO__LAST, token);
> +
> +		if (idx < 0) {
> +			pr_err("unknown hash algorithm \"%s\", ignoring",
> +			       token);
> +			continue;
Is it right to ignore an invalid digest algorithm given in the IMA 
policy rule? Should "invalid ima policy" error be reported instead?

Other changes look good.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> +		}
> +
> +		/* Add the hash algorithm to the 'allowed' bitfield */
> +		res |= (1U << idx);
> +	}
> +
> +	return res;
> +}
> +
>   static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   {
>   	struct audit_buffer *ab;
> @@ -1522,6 +1546,26 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   			else
>   				result = -EINVAL;
>   			break;
> +		case Opt_appraise_hash:
> +			ima_log_string(ab, "appraise_hash", args[0].from);
> +
> +			if (entry->allowed_hashes) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
> +			entry->allowed_hashes =
> +				ima_parse_appraise_hash(args[0].from);
> +
> +			/* invalid or empty list of algorithms */
> +			if (!entry->allowed_hashes) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
> +			entry->flags |= IMA_VALIDATE_HASH;
> +
> +			break;
>   		case Opt_permit_directio:
>   			entry->flags |= IMA_PERMIT_DIRECTIO;
>   			break;
> @@ -1714,6 +1758,23 @@ static void ima_show_rule_opt_list(struct seq_file *m,
>   		seq_printf(m, "%s%s", i ? "|" : "", opt_list->items[i]);
>   }
>   
> +static void ima_policy_show_appraise_hash(struct seq_file *m,
> +					  unsigned int allowed_hashes)
> +{
> +	int idx, list_size = 0;
> +
> +	for (idx = 0; idx < HASH_ALGO__LAST; idx++) {
> +		if (!(allowed_hashes & (1U << idx)))
> +			continue;
> +
> +		/* only add commas if the list contains multiple entries */
> +		if (list_size++)
> +			seq_puts(m, ",");
> +
> +		seq_puts(m, hash_algo_name[idx]);
> +	}
> +}
> +
>   int ima_policy_show(struct seq_file *m, void *v)
>   {
>   	struct ima_rule_entry *entry = v;
> @@ -1825,6 +1886,12 @@ int ima_policy_show(struct seq_file *m, void *v)
>   		seq_puts(m, " ");
>   	}
>   
> +	if (entry->flags & IMA_VALIDATE_HASH) {
> +		seq_puts(m, "appraise_hash=");
> +		ima_policy_show_appraise_hash(m, entry->allowed_hashes);
> +		seq_puts(m, " ");
> +	}
> +
>   	for (i = 0; i < MAX_LSM_RULES; i++) {
>   		if (entry->lsm[i].rule) {
>   			switch (i) {
> 
