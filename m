Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B17611D9BA
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 23:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfLLW57 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 17:57:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40726 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfLLW57 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 17:57:59 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7F3D020B7187;
        Thu, 12 Dec 2019 14:57:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F3D020B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576191478;
        bh=IaY9QfPYlGX8LBGy1XQmQtegmcwNOQejtgEwB7A4BKM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZK2aaBtqm/DdZi7fhP+jIagujLRcrIzUhHkusgPASPWi+e45zhO4QcV4EsrQnGWgG
         cEVGInMrEE2PBMHOKGGNS/Hm6PfK2zTv6ao/pNu89hUpnw2783+PXhtB2SnSf+jXlV
         FsTlSGsPyE0ttPj7kLXTEPBqZyXR+usBEscHngN0=
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
 <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
 <1576185189.4579.165.camel@linux.ibm.com>
 <b4ff3607-076e-7b90-24d1-9a129d9ce720@linux.microsoft.com>
 <1576191258.4579.181.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <cd0d6b0c-1be4-493d-6ba7-72bd60f601cb@linux.microsoft.com>
Date:   Thu, 12 Dec 2019 14:58:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576191258.4579.181.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/12/2019 2:54 PM, Mimi Zohar wrote:

>>
>> I can also move the setting of ima_process_key flag inside the lock
>> along with the above change.
> 
> My concern is with the last sentence "Since ima_process_keys is set to
> true above, any new key will be processed immediately and not queued."
>    It's unlikely, but possible, that a second process will wait for the
> ima_keys_mutex.  Either we remove this sentence or move setting
> ima_process_keys to after taking the lock.
> 
> Mimi

Sure - i'll move the setting of ima_process_keys flag inside the lock 
and define the flag as static. Will keep the comment as is.

thanks,
  -lakshmi

