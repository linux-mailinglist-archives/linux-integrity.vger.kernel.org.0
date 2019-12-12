Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8814511D2E7
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 17:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfLLQ5U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 11:57:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53412 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfLLQ5U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 11:57:20 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A2E020B7187;
        Thu, 12 Dec 2019 08:57:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A2E020B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576169839;
        bh=KyhXCBWIWDVmTamDcOrKgloZXoXwUisTGR1nWRGbTBI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QBrUTU3APDiLdHcPH2ydDWvqQgRbX+Ygzi+YXIyHXv18vYYFZ2/0lJ1Yc2pmWix3M
         mEBiAdDMI8ND+FJ1BseOaac0bavJiQW4wo9uY1TOBTYmmQtWY4EKoKTWjHtlxUzucm
         A9YKTYP/yuEtRjh04PSxJVlPAe+Pd02XpMde/zHY=
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key"
 measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
 <20191211185116.2740-2-nramas@linux.microsoft.com>
 <1576138743.4579.147.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
Date:   Thu, 12 Dec 2019 08:57:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576138743.4579.147.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/12/19 12:19 AM, Mimi Zohar wrote:

>>> +	ima_process_keys = true;
>> +
>> +	INIT_LIST_HEAD(&temp_ima_keys);
>> +
>> +	mutex_lock(&ima_keys_mutex);
>> +
>> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list)
>> +		list_move_tail(&entry->list, &temp_ima_keys);
>> +
>> +	mutex_unlock(&ima_keys_mutex);
> 
> 
> The v1 comment, which explained the need for using a temporary
> keyring, is an example of an informative comment.  If you don't
> object, instead of re-posting this patch, I can insert it.
> 
> Mimi

Sure Mimi. Thanks for including the comment in the patch.

thanks,
  -lakshmi

