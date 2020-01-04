Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59251303E5
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Jan 2020 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgADSqG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Jan 2020 13:46:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45920 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADSqF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Jan 2020 13:46:05 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25EFE2010C21;
        Sat,  4 Jan 2020 10:46:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25EFE2010C21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578163564;
        bh=3HA3xT5CMr5nCDYBy43HSWYXviiXmUGxICVBHz0Vt6M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H239N8GTI1LBoEsRRyGNtwWseiS+bkIBqB+UvopVtO4yKlF4Ic9GQmwB8Mw8EuXN5
         vxNTLFNXApgylG4xu/iCgl1dPT5fyJ9c84AssQsum2MtOue/nQQLYFdQmAR1jF79/C
         hLLDr3HDzcrsEuS/KZqSzEFYQobCcvNZPYd6plQk=
Subject: Re: [IMA] 11b771ffff:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, lkp@lists.01.org
References: <20191227142335.GE2760@shao2-debian>
 <2a831fe9-30e5-63b4-af10-a69f327f7fb7@linux.microsoft.com>
 <e30864ab-4867-fffa-bf0c-88a5a9bb6f6e@intel.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a493e36a-694c-0c21-1b89-2dae5208c1a1@linux.microsoft.com>
Date:   Sat, 4 Jan 2020 10:46:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e30864ab-4867-fffa-bf0c-88a5a9bb6f6e@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/4/2020 3:49 AM, Chen, Rong A wrote:

Hi Rong,
> 
> Hi,
> 
> Sorry for the delay, we updated the lkp-tests code and uploaded the 
> missing cgz files for this case.
> 
> Best Regards,
> Rong Chen

Thanks - I was able to execute the test and validate the fix.

  -lakshmi

