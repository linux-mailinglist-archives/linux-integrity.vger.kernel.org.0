Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842D611D2EC
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 17:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfLLQ6G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 11:58:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53712 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfLLQ6G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 11:58:06 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 88B0C20B7187;
        Thu, 12 Dec 2019 08:58:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88B0C20B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576169885;
        bh=ySLNS1REyfh370oZ6WsELyIxjhx8R3R3aifd3RFR2iA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ze9D4wHVjxSbbIKVNQ7i1ptu12wo4YtsTs/a2pItCcfOpI1vN00BlrdiJQlsDmMeX
         BaEvYRG7w5IfwWj4jTijgMve5BKKur6XeNWn0FfbqFeu37gPGafT7BhdeVBDzRaFft
         87r8dCPjuiaNA0IvEuVsdgXg+BP4hJWjbG8uqEGA=
Subject: Re: [PATCH v11 0/6] KEYS: Measure keys when they are created or
 updated
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191211164707.4698-1-nramas@linux.microsoft.com>
 <1576160916.4579.151.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1f34f41a-f43d-0397-aed0-e43aab87ac42@linux.microsoft.com>
Date:   Thu, 12 Dec 2019 08:58:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576160916.4579.151.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/12/19 6:28 AM, Mimi Zohar wrote:

> Hi Lakshmi,
> 
> On Wed, 2019-12-11 at 08:47 -0800, Lakshmi Ramasubramanian wrote:
>> Keys created or updated in the system are currently not measured.
>> Therefore an attestation service, for instance, would not be able to
>> attest whether or not the trusted keys keyring(s), for instance, contain
>> only known good (trusted) keys.
>>
>> IMA measures system files, command line arguments passed to kexec,
>> boot aggregate, etc. It can be used to measure keys as well.
>> But there is no mechanism available in the kernel for IMA to
>> know when a key is created or updated.
>>
>> This change aims to address measuring keys created or updated
>> in the system.
> 
> Thank you!  This patch set is now queued in the next-integrity-testing
> branch of https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
> integrity.git/.
> 
> Mimi
> 

Thanks Mimi.

  -lakshmi
