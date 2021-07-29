Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0F3DAA3C
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhG2Rcr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 13:32:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37028 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2Rcr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 13:32:47 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9239E2043BBF;
        Thu, 29 Jul 2021 10:32:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9239E2043BBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627579963;
        bh=iJFvBbMdy08c6uGZ6Ve0hR8LzwIkWSCaUxXA8Rl3J1Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KH6y2TABH59YBCfOb2IA2NyLk2vHp5x4LE0EpLBf56aJJYdjneECv9iG2qJKisIlP
         9kJMStj3XOdPRNdH2+IsWt7dq9Y4Y4KYxc2kBJi5ob/wQ10LecO8GeKu7U7qmRvVHK
         mhBI2Jz4t8ak2xZrAxediJSHffU3DEy+5ofBVUAg=
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using
 IMA
To:     Thore Sommer <public@thson.de>
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
References: <a30c8208-f255-d0f0-0bfb-c037367e638c@linux.microsoft.com>
 <20210728171402.1120181-1-public@thson.de>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <51402c7b-eeab-9dd5-a78f-05e501f578e3@linux.microsoft.com>
Date:   Thu, 29 Jul 2021 10:32:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728171402.1120181-1-public@thson.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/28/21 10:14 AM, Thore Sommer wrote:
> Hi Tushar,
> 
>> Most likely this is because you haven't set CONFIG_IMA_DISABLE_HTABLE=y.
> Yes, that was the case.
> 
> With CONFIG_IMA_DISABLE_HTABLE=y the behavior is as expected. Now a new
> measurement is created if I create the same device twice.
> 
> Regards,
> Thore
> 
Thanks for confirming Thore. :)

Regards,
Tushar
