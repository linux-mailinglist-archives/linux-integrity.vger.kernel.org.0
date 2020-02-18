Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18902162F95
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2020 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRTPP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 14:15:15 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55030 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRTPP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 14:15:15 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2B971200889D;
        Tue, 18 Feb 2020 11:15:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B971200889D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582053314;
        bh=0umdcWx5u5QC9x3/h90kpSlJ3mmjGBSlEzTLOgMKDP4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hHcew2z5jnZZ4XiNgN5xBAQtdI/ctaW9YsmDmBKp81v4etNkIvFz0H1V3Y+C8Zq8W
         DbdICo7w+Q0vAIoznAHIhhvXBwrULARcm5ajfTBM4rM91k39lfLq8Xw5XSiaRRvePe
         HOSdnJ4SJFJkpjFMOXY4mT25Ry9rN7nUgc4xf8wg=
Subject: Re: [PATCH v4 0/3] IMA: improve log messages
To:     Mimi Zohar <zohar@linux.ibm.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200215014709.3006-1-tusharsu@linux.microsoft.com>
 <1581856840.8515.168.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <3e479e25-ccf2-0e5b-3b78-3c63600245b8@linux.microsoft.com>
Date:   Tue, 18 Feb 2020 11:15:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581856840.8515.168.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-02-16 4:40 a.m., Mimi Zohar wrote:
> On Fri, 2020-02-14 at 17:47 -0800, Tushar Sugandhi wrote:
>> The log messages from IMA subsystem should be consistent for better
>> diagnosability and discoverability.
> 
> The change isn't limited to IMA.  I would change "IMA" to "integrity"
> in the Subject line and in this patch description.
> 
Will do.
>> This patch set improves the logging by removing duplicate log formatting
>> macros, adding a consistent prefix to the log messages, and adding new
>> log messages where necessary.
> 
> Much better!
> 
> thanks,
> 
> Mimi
> 
