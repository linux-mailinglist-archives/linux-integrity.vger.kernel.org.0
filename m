Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3633234FF
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhBXBK7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:10:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhBXA7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 19:59:02 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 859B920B6C40;
        Tue, 23 Feb 2021 16:25:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 859B920B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614126353;
        bh=FBzAz65Z+tjf5xUyNSGfsapmSUwxRby0EKUI4F/Icq4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gMYHFHRdlNxuwLh0OL9xKtuVUafjHfUJe9SqVYHn6ZLI/0d3LQeBEjThvWoA495Yv
         G4N9z/w4AuA/mcewG9yOFzCzu6gZFUK9CrhxrMf4O9vLCfjUuxUWcmnof+htO1QLOo
         lce5tuPJA83TRN/U1zD1HnbBoRhtyg6vbPTld1B4=
Subject: Re: [PATCH v3] IMA: support for duplicate measurement records
To:     Petr Vorel <pvorel@suse.cz>
Cc:     zohar@linux.ibm.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210219010045.5509-1-tusharsu@linux.microsoft.com>
 <YDWbWimf+tO5YvAc@pevik>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <12b62c3c-e2f7-b551-c79a-a0336ceec5d6@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 16:25:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDWbWimf+tO5YvAc@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Petr,

On 2021-02-23 4:18 p.m., Petr Vorel wrote:
> Hi Tushar,
> 
>> Change Log v3:
>>   - Incorporated feedback from Mimi on v2.
>>   - Updated patch title and description to make it generic.
>>   - Changed config description word 'data' to 'records'.
>>   - Tested use cases for boot param "ima_policy=tcb".
> 
> LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 

Thank you taking a look at the patch, and the 'Reviewed-by' tag.
~Tushar

> Kind regards,
> Petr
> 
