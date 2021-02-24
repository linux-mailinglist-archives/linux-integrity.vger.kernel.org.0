Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1CF323555
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhBXBaj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:30:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57420 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhBXB1z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 20:27:55 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 130C820B6C40;
        Tue, 23 Feb 2021 17:27:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 130C820B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614130030;
        bh=Rz63EwxifwahcHu97kiZNA7TJSJhj6rDo7xRcgKSU6Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qv2FeUuhYmYuQPt+lv1wBRqQnBQxG6jAql2QdtlhPOUK2XgZq2aywyq/6pcjG1cVn
         4cVv3VbqgOAL5dVB5PdiRQeV10qSOElARxjcKPfsPP4siH0baObrhobD/vOBUdodb9
         XH0dMqbTPQRmSbftsMUolQpTla5Ka+GyVlI/kbfw=
Subject: Re: [PATCH v3 0/2] IMA: Add test for dm-crypt measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com
References: <20210223225930.27095-1-pvorel@suse.cz>
 <0a25f4b7ed53566b13211d5aeea18e7f13f12bd7.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <e8232b66-8081-090e-4e26-0e1d2544e752@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 17:27:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0a25f4b7ed53566b13211d5aeea18e7f13f12bd7.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On 2021-02-23 4:43 p.m., Mimi Zohar wrote:
> Hi Petr,
> 
> On Tue, 2021-02-23 at 23:59 +0100, Petr Vorel wrote:
>> Hi!
>>
>> I updated Tushar's patchset to speedup things.
>>
Thank you. :)

>> Changes v2->v3
>> * rename function s/check_ima_ascii_log_for_policy/test_policy_measurement/
>> * move tst_res TPASS/TFAIL into test_policy_measurement()
>> * drop template=ima-buf (see Lakshmi's patch [1] and discussion about
>>    it, it will be removed from ima_keys.sh as well)
Makes sense.

>> * moved ima_dm_crypt.sh specific changes to second commit
>> * further API and style related cleanup
>>
>> Could you please check this patchset?
I reviewed the patchset.
Patch 1 looks ok. (generalize key measurement tests)
Patch 2 won't work as is, since the dm kernel code is not upstreamed
yet. (see my comments below for more context)

> 
> I'm not sure about the status of the associated IMA dm-crypt kernel
> patch set.  It hasn't even been reviewed, definitely not upstreamed.
>   I would hold off on upstreaming the associated ltp test.
> 
That is correct.

The device mapper measurement work is being revisited - to cover aspects
like more DM targets (not just dm-crypt), better memory management, more
relevant attributes from the DM targets, other corner cases etc.

Therefore, even though the first patch of the series "generalize key
measurement tests", would be useful for other tests; I will have to
revisit the second patch, "dm-crypt measurements", to address the
DM side changes I mentioned above.

To summarize,
  - you may upstream the first patch (generalizing the key
    measurements). It would be useful for us while writing more tests in
    this space.

  - but please hold off upstreaming the second patch (dm-crypt test)
    as Mimi has suggested.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
