Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799DEEB424
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfJaPmw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 11:42:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55280 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfJaPmw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 11:42:52 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3DC020B7192;
        Thu, 31 Oct 2019 08:42:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3DC020B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572536571;
        bh=VEMRMLTSgqwtGYH1CLoFnXVfEwXi5+fo0FYWAu1w7Go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G2hhH/AW1SH0XWVF66twEG0I+7/S1MLgrbzWgHOt8e1t1b3nCBUej8k9gqk9zS3Vg
         E1yjfNTAspzVJF3iDIaQPJGM0OeZPp7jqrO8/3Z5p/x6/1z2cJtGOetUuYXADAYhCV
         b3KLUodKNyJfdMrxz7NHebkEWUhWZHyE0BCtRQeo=
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
To:     Mimi Zohar <zohar@linux.ibm.com>, Sasha Levin <sashal@kernel.org>
Cc:     dhowells@redhat.com, matthewgarrett@google.com,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        prsriva@linux.microsoft.com
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
 <1572523831.5028.43.camel@linux.ibm.com>
 <b83bd7ef-ce7f-e750-e30b-30d5a6469a28@linux.microsoft.com>
 <20191031152730.GQ1554@sasha-vm> <1572536253.5028.50.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a629707a-40d2-e3dd-fdf4-af2f84f47796@linux.microsoft.com>
Date:   Thu, 31 Oct 2019 08:42:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572536253.5028.50.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/31/19 8:37 AM, Mimi Zohar wrote:

>> I couldn't even apply this patch: Nayna's series (v10) doesn't apply  >> top of 5.3 to begin with, and while it does apply on mainline, 
this>> first patch wouldn't apply on top.
> Lakshmi, development is always on top of mainline.  In this case,
>   please use 5.4.0-rc3 and apply Nayna's v10 patch set.
> 
> Mimi


Thanks for the info Mimi.

I initially started with v5.4, but the kernel I built wouldn't boot on 
my machine :(

I'll update to the latest v5.4 changes and try again.

thanks,
  -lakshmi
