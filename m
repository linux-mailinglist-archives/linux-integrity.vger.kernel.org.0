Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4E3F2F7A
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhHTP3i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 11:29:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52798 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbhHTP3i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 11:29:38 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5CB8620C33CD;
        Fri, 20 Aug 2021 08:29:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5CB8620C33CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1629473340;
        bh=VXLlf/DhQtGvvxRcobxllAKr+ZZn1mRvIQDDNqxPXwQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OSAaB2JSHIS7T9QLTAevZIqpWVqJzgAj/NsjoOQpTmd8WQTuRsOyGDbcnFez1CcBE
         hmfAD2ZZlTKy15RSNB0zx7fndWqwXBGewDc+YiKMgh+x6kbwtzvyjIpzJclwln0Ycn
         HZ8dY2Qxqmj0BI6FEW3aOrMV6CNdOz14IevIbrP0=
Subject: Re: [PATCH] IMA: set a default value for unknown digsig algorithms
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com" 
        <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
References: <20210820121847.34087-1-Simon.THOBY@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <11e10cc0-922c-c5b4-e89e-89e0bf2d7991@linux.microsoft.com>
Date:   Fri, 20 Aug 2021 08:31:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820121847.34087-1-Simon.THOBY@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/20/2021 5:18 AM, THOBY Simon wrote:
> When adding new protections against writing invalid data in
> the security.ima xattr, I erroneously expected ima_get_hash_algo()
> to always return a valid 'enum hash_algo', but it turns out it trusts
> the user-supplied digital signatures and return it without any checks.
> It didn't affect process_measurement() because that function
> (indirectly) calls into ima_alloc_atfm() that fallback silently
> on the default hash algorithm, but it did affect ima_inode_setxattr
> as that new function didn't perform a bounds check.
> 
> Update ima_get_hash_algo() to always return a valid hash algorithm,
> defaulting on 'ima_hash_algo' when the user-supplied value inside
> the xattr is invalid.
> 
> This patch was successfully tested by syszbot, see
> https://syzkaller.appspot.com/bug?extid=e8bafe7b82c739eaf153.
> 
> Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
> Reported-by: syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com
> ---
>   security/integrity/ima/ima_appraise.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 8f1eb7ef041e..dbba51583e7c 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -185,7 +185,8 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>   	switch (xattr_value->type) {
>   	case EVM_IMA_XATTR_DIGSIG:
>   		sig = (typeof(sig))xattr_value;
> -		if (sig->version != 2 || xattr_len <= sizeof(*sig))
> +		if (sig->version != 2 || xattr_len <= sizeof(*sig)
> +		    || sig->hash_algo >= HASH_ALGO__LAST)
>   			return ima_hash_algo;
>   		return sig->hash_algo;
>   		break;
> 
