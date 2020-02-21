Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2129A168A17
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 23:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBUWpf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 17:45:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39176 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUWpf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 17:45:35 -0500
Received: from [10.137.112.97] (unknown [131.107.159.97])
        by linux.microsoft.com (Postfix) with ESMTPSA id B8DC22007690;
        Fri, 21 Feb 2020 14:45:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8DC22007690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582325134;
        bh=+utzrB5Ax7MJXfKmbSSaYDiTTJH/bmE7dr+3MikH3UU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DKjsLSUVgbMXFKegRmj0qz3+YAULMysy+Aks2z4kyILWMBLSKwP6GUXMm30/canCf
         ZIB7u2MoH5chEcojUIXZPh2s8II/nyhpvwzcdJ4rrSkFEyvvZjhXuAmAWwxEjleJ47
         fXmwsPFaeB6hpBfHdo1DfMnmCTv4BHR5X+WM8t8w=
Subject: Re: [PATCH v5 0/3] integrity: improve log messages
To:     Mimi Zohar <zohar@linux.ibm.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
 <1582240035.5121.0.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <47faa01f-7ed7-ce6b-8021-af8e5deaadcf@linux.microsoft.com>
Date:   Fri, 21 Feb 2020 14:45:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582240035.5121.0.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Mimi.

On 2020-02-20 3:07 p.m., Mimi Zohar wrote:
> On Tue, 2020-02-18 at 16:06 -0800, Tushar Sugandhi wrote:
>> The log messages from integrity subsystem should be consistent for better
>> diagnosability and discoverability.
>>
>> This patch set improves the logging by removing duplicate log formatting
>> macros, adding a consistent prefix to the log messages, and adding new
>> log messages where necessary.
> 
> Thanks!  This patch set is now queued in the next-integrity-testing branch.
> 
> Mimi
> 
