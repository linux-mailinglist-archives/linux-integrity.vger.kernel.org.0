Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952F420C4D8
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jun 2020 01:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgF0XjK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jun 2020 19:39:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36064 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgF0XjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jun 2020 19:39:10 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28DCF20B4901;
        Sat, 27 Jun 2020 16:39:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28DCF20B4901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593301149;
        bh=FoeYr1KfVsguPVO0JjpdXIr6pshrcYnStx+NK/LsnLQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qio5u1atOxueAiYQLGxnFoV7By1w9HFe9LHu7X0HqDSBKXops4uev3NIL/ATUnMHD
         bkiFLMiXDktck330u5v/IMJGNRR71ZFlsad9HzU62kXJxLMOoyTUpIw0hqk3k4AD1h
         Uhg0UT5/C2vB+u0k+4QVeqivjexV4S7MTyWXcrBU=
Subject: Re: [PATCH v2 06/11] ima: Fail rule parsing when the KEY_CHECK hook
 is combined with an invalid cond
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-7-tyhicks@linux.microsoft.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8eb0035d-f326-0299-aa4c-27d3db2deb2a@linux.microsoft.com>
Date:   Sat, 27 Jun 2020 16:39:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626223900.253615-7-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/26/20 3:38 PM, Tyler Hicks wrote:
> The KEY_CHECK function only supports the uid, pcr, and keyrings
> conditionals. Make this clear at policy load so that IMA policy authors
> don't assume that other conditionals are supported.
> 
> Fixes: 5808611cccb2 ("IMA: Add KEY_CHECK func to measure keys")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
> 
> * v2
>    - No change
> 
>   security/integrity/ima/ima_policy.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 676d5557af1a..f9b1bdb897da 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1018,6 +1018,13 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>   			if (entry->action & ~(MEASURE | DONT_MEASURE))
>   				return false;
>   
> +			if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> +					     IMA_KEYRINGS))
> +				return false;
> +
> +			if (ima_rule_contains_lsm_cond(entry))
> +				return false;
> +
>   			break;
>   		default:
>   			return false;
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

