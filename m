Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6957E20C4E0
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jun 2020 01:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgF0Xts (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jun 2020 19:49:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39490 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgF0Xts (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jun 2020 19:49:48 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4CC9020B4901;
        Sat, 27 Jun 2020 16:49:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CC9020B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593301787;
        bh=1+BfB0kaqs85yBKZRHGZmmaia9PwxbpWHcmeSuerz4o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o+b6i4CJMLl8qkkQu/vzSl9WvZbpDzY9sX8aGMyC/vIXaBduJ1uuA2f5b+MKpMAzr
         23I+TpBaHMraAkBhcRT8P5TVtkq8mvhlR6FLab5LMzXdoYJIEpHv4cHVjHGtGCOtVX
         zPQebNGXbjFTyRxDoFhvEWPBFRecP5Fn9So7WzCU=
Subject: Re: [PATCH v2 09/11] ima: Move validation of the keyrings conditional
 into ima_validate_rule()
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-10-tyhicks@linux.microsoft.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0e7012e7-e1df-466d-9d51-a691f779570a@linux.microsoft.com>
Date:   Sat, 27 Jun 2020 16:49:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626223900.253615-10-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/26/20 3:38 PM, Tyler Hicks wrote:

> Use ima_validate_rule() to ensure that the combination of a hook
> function and the keyrings conditional is valid and that the keyrings
> conditional is not specified without an explicit KEY_CHECK func
> conditional. This is a code cleanup and has no user-facing change.

In addition to checking for func=KEY_CHECK and the keyrings conditional, 
the patch also validates the flags for other IMA hooks (such as 
KEXEC_KERNEL_CHECK, POLICY_CHECK, etc.) Would be good to mention that in 
the patch description.

  -lakshmi

> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
> 
> * v2
>    - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
>      IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
>      present in the rule entry flags for non-buffer hook functions.
> 
>   security/integrity/ima/ima_policy.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 8cdca2399d59..43d49ad958fb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   		case KEXEC_KERNEL_CHECK:
>   		case KEXEC_INITRAMFS_CHECK:
>   		case POLICY_CHECK:
> +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> +					     IMA_PERMIT_DIRECTIO |
> +					     IMA_MODSIG_ALLOWED |
> +					     IMA_CHECK_BLACKLIST))
> +				return false;
> +
>   			break;
>   		case KEXEC_CMDLINE:
>   			if (entry->action & ~(MEASURE | DONT_MEASURE))
> @@ -1027,7 +1036,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   		default:
>   			return false;
>   		}
> -	}
> +	} else if (entry->flags & IMA_KEYRINGS)
> +		return false;
>   
>   	return true;
>   }
> @@ -1209,7 +1219,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   			keyrings_len = strlen(args[0].from) + 1;
>   
>   			if ((entry->keyrings) ||
> -			    (entry->func != KEY_CHECK) ||
>   			    (keyrings_len < 2)) {
>   				result = -EINVAL;
>   				break;
> 

