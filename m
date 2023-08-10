Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3708E776F15
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 06:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjHJEbi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 00:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjHJEbh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 00:31:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16A311BFB;
        Wed,  9 Aug 2023 21:31:37 -0700 (PDT)
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2002820FC4EA;
        Wed,  9 Aug 2023 21:31:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2002820FC4EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691641896;
        bh=nraAPWOICvNXkZftejzgjjq0Wg6iJe2sFPMDKZdWoRg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BAjmFHtw0r59qAg2VS0JDt720MQZXxOpcR45G0eHR7t2LNeR9eNroaB+cHO0gqPd+
         8YTgwP708jbMz2PahIx238OzmSBkSKvtsZzk+R+FqtSBFfdvbuzq4SBOqtf55oBj5W
         T877ETAip+1R/gNsT0bC8I6cQ0SYHBTuy1TWXUXs=
Message-ID: <2f60bc38-6a9e-6a2d-038d-cd3daf46faf2@linux.microsoft.com>
Date:   Wed, 9 Aug 2023 21:31:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
 <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/8/23 11:26, James Bottomley wrote:
> On Tue, 2023-08-08 at 09:31 -0400, Stefan Berger wrote:
>>
>> On 8/8/23 08:35, James Bottomley wrote:
>>> On Mon, 2023-08-07 at 18:49 -0400, Stefan Berger wrote:
>>>>
>>>> On 8/1/23 17:21, James Bottomley wrote:
>>>>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>>>>> [...]
>>>>>> Truncating IMA log to reclaim memory is not feasible, since
>>>>>> it makes the log go out of sync with the TPM PCR quote making
>>>>>> remote attestation fail.
>>>>> This assumption isn't entirely true.  It's perfectly possible
>>>>> to shard an IMA log using two TPM2_Quote's for the beginning
>>>>> and end PCR values to validate the shard.  The IMA log could be
>>>>> truncated in the same way (replace the removed part of the log
>>>>> with a TPM2_Quote and AK, so the log still validates from the
>>>>> beginning quote to the end).
>>>>>
>>>>> If you use a TPM2_Quote mechanism to save the log, all you need
>>>>> to do is have the kernel generate the quote with an internal
>>>>> AK.  You can keep a record of the quote and the AK at the
>>>>> beginning of the truncated kernel log.  If the truncated
>>>>> entries are saved in a file shard it
>>>> The truncation seems dangerous to me. Maybe not all the scenarios
>>>> with an attestation client (client = reading logs and quoting)
>>>> are possible then anymore, such as starting an attestation client
>>>> only after truncation but a verifier must have witnessed the
>>>> system's PCRs and log state before the truncation occurred.
>>> That's not exactly correct.  Nothing needs to have "witnessed" the
>>> starting PCR value because the quote vouches for it (and can vouch
>>> for it after the fact).  The only thing you need to verify the
>>> quote is the attestation key and the only thing you need to do to
>>> trust the attestation key is ensure it was TPM created.  All of
>>> that can be verified after the fact as well.  The only thing that
>>> can be done to disrupt this is to destroy the TPM (or re-own it).>
>>> Remember the assumption is you *also* have the removed log shard to
>>> present.  From that the PCR state of the starting quote can be
>> Yes, the whole sequence of old logs needs to be available.
> Yes and no.  If the person relying on the logs is happy they've
> extracted all the evidentiary value from the log itself then they can
> reduce the preceding log shard to simply the PCR values that match the
> quote and discard the rest.
>
>>   IF that's the case and the logs can be stitched together seamlessly,
>> who then looks at the kernel AK quote and under what circumstances?
> For incremental attestation.  Each log shard can be verified using the
> base PCR values corresponding to the bottom quote then replayed and the
> top quote verified.  This means that logs that aren't needed anymore
> can be discarded, which, I recall, was the base reason for this
> proposal: reducing IMA memory consumption.  Although all you need to do
> is extract the shards from kernel memory to file space and free the
> kernel memory.  Since that scheme can keep all logs intact, there's no
> reason to further reduce them unless the filesystem is running out of
> space.
>
> James
Thank you James for addressing Stefan’s concerns here.
Appreciate it.


~Tushar
