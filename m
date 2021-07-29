Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691463DABD2
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhG2TYX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 15:24:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50836 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG2TYW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 15:24:22 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 191172048040;
        Thu, 29 Jul 2021 12:24:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 191172048040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627586659;
        bh=BmmwATUSw2oS5v373O164GXBqThODcC3h1xkHNpXUaA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WXD1EzP+OBO6haTQAfQmDONWh6ShXS0UsvhrEYcjyMy6sqNKIHnmASsz22O5/K/CF
         3sM4oqcJj7Cyy4oh/vOGmvxPBK30mWA1CfZzbSfCDlSeDvW6emau7du9OU4fTu7EH6
         4bWt94G8MmW02o/s+jWSU7kz2405qzjbXZ3M/W1w=
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using
 IMA
To:     Thore Sommer <public@thson.de>
Cc:     agk@redhat.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com,
        snitzer@redhat.com, zohar@linux.ibm.com
References: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
 <20210727101802.779067-1-public@thson.de>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <f73308f3-485f-46cb-0f20-6619edb541e6@linux.microsoft.com>
Date:   Thu, 29 Jul 2021 12:24:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727101802.779067-1-public@thson.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thore,
Replying to a few questions which were not already answered by me/Alasdair.


On 7/27/21 3:18 AM, Thore Sommer wrote:

> There is no way to verify if the root hash was verified against a signature. We
> have "root_hash_sig_key_desc SIGNATURE_DESCRIPTION" in the dm table.
> "SIGNATURE_DESCRIPTION" itself is not really useful because it seems that we
> cannot map it back to the certificate that was used for verification but the
> presence of "root_hash_sig_key_desc" might be enough in combination with
> measuring the keyring.

Thanks for the suggestion Thore.
I can update the verity_status() to measure if v->signature_key_desc is 
set.

Something like:
DMEMIT("signature_key_desc_present=%c,", v->signature_key_desc ? 'y' :
'n');

Alasdair, Mike,
Can you tell if this is needed and/or sufficient?
If it is needed, should we log the full string  v->signature_key_desc?
I am concerned about logging the full string as it is an unbounded
buffer (a char*) coming from UM. And at the same time, not sure if just
logging the presence is sufficient. Thoughts?

Thore,
Please note – even if we measure signature_key_desc (full string or just
its presence): in order to use it with the keyrings, the IMA policy also
needs to be set to measure key rings (using “measure func=KEY_CHECK
...”). It is independent from measuring the device mapper data (which is
measured when the policy is set to “measure func=CRITICAL_DATA
label=device-mapper ...”).

Therefore measuring keyrings together (i.e. in the same IMA log) with DM
data  is not always guaranteed, since it is dictated by how the IMA
policy is configured.

Just FYI.

> For remote attestation services it would be nice if we have clear indicator from
> what component the "ima-buf" entry was generated. Prefixing all "n-ng" field
> entries with something like "dm_" would make it easier for us to add different
> validators for different measurements that use the "ima-buf" template. The
> keyring measurements already use "ima-buf" and using some kind of naming scheme
> to easily differentiate the entries would be nice.
The event names typically come from kernel components that are doing the
measurement of critical data. So any duplicates should be caught in the
upstream review of the kernel patch.

But thanks for the suggestion. I will prefix the event names in this 
patch series with “dm_” to indicate they are related to device mapper.

Thanks,
Tushar
> Regards,
> Thore
> 
