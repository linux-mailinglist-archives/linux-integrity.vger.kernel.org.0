Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF2230C2D
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgG1OOS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 10:14:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47082 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgG1OOS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 10:14:18 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 50F4120B4908;
        Tue, 28 Jul 2020 07:14:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50F4120B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595945657;
        bh=TdiXmpRni8ubU9ZDCDtSAAikTrjb8aB1OWY4V4JuSWY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Evf1Ur3ATOtpFVAItqhYZ14GV7dEE7G0F8scuvuWY+5YXZid01YBRNk2ADH4dmMxu
         MzpX0tGWkm375WpScdzy6AkFVS+xpwbJwwNwYVykTP3DSzpCzRVc3V587YZxWplxwU
         El9Q8CuUBJizQUwxUGDf2TmNl07aAb69+70sBYck=
Subject: Re: [PATCH 2/2] ima: Fail rule parsing when asymmetric key
 measurement isn't supportable
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
 <20200727140831.64251-3-tyhicks@linux.microsoft.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b9dc379d-0529-692e-9b7d-dce5ad893eb7@linux.microsoft.com>
Date:   Tue, 28 Jul 2020 07:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727140831.64251-3-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/27/20 7:08 AM, Tyler Hicks wrote:
> Measuring keys is currently only supported for asymmetric keys. In the
> future, this might change.
> 
> For now, the "func=KEY_CHECK" and "keyrings=" options are only
> appropriate when CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled. Make
> this clear at policy load so that IMA policy authors don't assume that
> these policy language constructs are supported.
> 
> Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
> Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
> Suggested-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_policy.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index c328cfa0fc49..05f012fd3dca 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1233,7 +1233,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   				entry->func = POLICY_CHECK;
>   			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
>   				entry->func = KEXEC_CMDLINE;
> -			else if (strcmp(args[0].from, "KEY_CHECK") == 0)
> +			else if (IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) &&
> +				 strcmp(args[0].from, "KEY_CHECK") == 0)
>   				entry->func = KEY_CHECK;
>   			else
>   				result = -EINVAL;
> @@ -1290,7 +1291,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>   		case Opt_keyrings:
>   			ima_log_string(ab, "keyrings", args[0].from);
>   
> -			if (entry->keyrings) {
> +			if (!IS_ENABLED(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) ||
> +			    entry->keyrings) {
>   				result = -EINVAL;
>   				break;
>   			}
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

