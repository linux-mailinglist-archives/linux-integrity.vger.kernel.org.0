Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3532B15976C
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgBKRzd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 12:55:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34764 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgBKRzd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 12:55:33 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4AD2720B9C02;
        Tue, 11 Feb 2020 09:55:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AD2720B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581443732;
        bh=jTcITenpXHSnmImZ8E5vHwH3lah2WsA2T1BJ91KGgrU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HibhsXf5OrUMOz1CzVK1T6iq16BhKIV6o5zZHr07rm1XcflomsHLlt8Tw6i8qzjz3
         Fo/X1mWWGu8YpSEZpAi4UGgrp7yy1tLejNWSBaWxu/cbqI/K8oD/UW+UW+54FI4EeK
         sk49DLW5KDc3LwqaNMpSuA0VMk63iFU3UuJYIA6s=
Subject: Re: [PATCH v2 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Joe Perches <joe@perches.com>, zohar@linux.ibm.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
 <225b88ac1abcb293bf9d55ca53009015b1baa81c.camel@perches.com>
 <cde01d57-99d0-34f7-41dd-5eb5a24b5037@linux.microsoft.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <871e3f6c-5d0e-d099-8d76-5ac835992568@linux.microsoft.com>
Date:   Tue, 11 Feb 2020 09:55:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cde01d57-99d0-34f7-41dd-5eb5a24b5037@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Joe,

On 2020-02-11 9:36 a.m., Lakshmi Ramasubramanian wrote:
> On 2/10/20 7:09 PM, Joe Perches wrote:
> 
> Hi Joe,
> 
>> Series seems sensible, thanks Tushar.
>>
>> Next time you might choose to use
>>
>>     git format-patch --cover-letter
>>
>> and write in the 0/n cover letter what the point
>> of the patch series is.
>>
> 
> I was the one who suggested that we may not need a cover letter and 
> instead provide the details in the patch description. We can include the 
> cover letter in the next update.
> 
> thanks,
>   -lakshmi
> 
I will include the cover letter in the next update.

Thanks,
Tushar
