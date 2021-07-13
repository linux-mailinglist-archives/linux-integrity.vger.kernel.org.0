Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5563E3C7A50
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 01:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhGMXuy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jul 2021 19:50:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57152 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhGMXuy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jul 2021 19:50:54 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 91C8720B6C50;
        Tue, 13 Jul 2021 16:48:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91C8720B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626220083;
        bh=wivArcq+K53SeOwhjHoDSEx+QtV1FP+6fTkpLC9eXEw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=mNTs8b+kcVx4kU3gRIrG2qbmQkbQgY2DILi5wimXOUI+aS52pljvaOjc8Eg8zbtYX
         7Oi3Aj16woLis+JRq138GAs9eYIOMBzTWSaaY4oH1Ywg0jPBC+N6rJ42INLlINV+sV
         1xfXNra5+ZEKQXMqpyX5Mr5cPTn6vXKhXNX7SJ8E=
Subject: Re: [PATCH ima-evm-utils] Fix NULL pointer warning
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20210713192413.699857-1-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2d3e76c3-81bf-47f2-9b75-84dab19dfe69@linux.microsoft.com>
Date:   Tue, 13 Jul 2021 16:50:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713192413.699857-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/13/2021 12:24 PM, Mimi Zohar wrote:
> Static analysis reported an "invalid operation involving NULL pointer"
> warning.  Although the code properly exits the loop without ever
> using the variable, test the pointer isn't NULL before incrementing
> it.
> 
> Fixes: 80d3fda6083f ("ima-evm-utils: Check for tsspcrread in runtime")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/utils.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

> 
> diff --git a/src/utils.c b/src/utils.c
> index ce2cc285a930..fd9b4a84189f 100644
> --- a/src/utils.c
> +++ b/src/utils.c
> @@ -77,7 +77,8 @@ int get_cmd_path(const char *prog_name, char *buf, size_t buf_len)
>   		if (buf_len - size > ret && file_exist(buf))
>   			return 0;
>   
> -		start = end + 1;
> +		if (end != NULL)
> +			start = end + 1;
>   
>   	} while (end != NULL);
>   
> 
