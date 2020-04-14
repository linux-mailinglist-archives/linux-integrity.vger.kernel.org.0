Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537971A820D
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407317AbgDNPRX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 11:17:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53402 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405617AbgDNPRQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 11:17:16 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 350C720B4737;
        Tue, 14 Apr 2020 08:17:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 350C720B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586877435;
        bh=4Tq3FB+xGJtxT6ZUJb0cf3A21zkjTaUDbsRjLeb16W4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rONCojIm0QhclazO1zFbIqpb0Fg7wgDbsdQRc+yc8GRjqaScZWdOx870Nq7D+agOO
         rsG2DlIToXNm6Yvf6yRt46/RvdMZKpDB29hFSxGQiL2i9OJAADLibOXrKhXrehXpkM
         iG1yYDoJpXtG22gfeY00WDEciLw4dvRHjFdQQEu4=
Subject: Re: [PATCH 1/2] ima: simplify function ima_store_template
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200414114850.98622-1-tianjia.zhang@linux.alibaba.com>
 <20200414114850.98622-2-tianjia.zhang@linux.alibaba.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <36c7b81e-ac42-b34a-808b-92107ff85805@linux.microsoft.com>
Date:   Tue, 14 Apr 2020 08:17:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414114850.98622-2-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/14/20 4:48 AM, Tianjia Zhang wrote:

> The 'result' here is not necessary, remove redundant code,
> the code is more concise.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   security/integrity/ima/ima_api.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index f6bc00914aa5..9121257c9dc6 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -118,8 +118,7 @@ int ima_store_template(struct ima_template_entry *entry,
>   		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
>   	}
>   	entry->pcr = pcr;
> -	result = ima_add_template_entry(entry, violation, op, inode, filename);
> -	return result;
> +	return ima_add_template_entry(entry, violation, op, inode, filename);
>   }
>   
>   /*
> 


Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

