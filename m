Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20E776D58
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 03:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHJBDX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHJBDX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 21:03:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D7F2DA;
        Wed,  9 Aug 2023 18:03:22 -0700 (PDT)
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8092920FC4EA;
        Wed,  9 Aug 2023 18:03:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8092920FC4EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691629402;
        bh=2x2EFhFJgTyCZhIinQsqkFaSlOaRo4/tPw/QPajL/BU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gx57cqg3A3QgQ3AYuhFcN7vGxDUiNdFywJNq4cRkOq5swDeWUQ/O4apEcC4wp0cQ3
         O71O/OyDQwo1KSdLtUVRF8li9nCAxD7oDTgSZyT2FTZAZlJnNW8pkueOnu3tZn/E91
         YYmU/YPLTBZsi7varAA7bynpVAUndeutc12+fVrM=
Message-ID: <e9b67fd8-3a8f-7024-5940-a093a704358e@linux.microsoft.com>
Date:   Wed, 9 Aug 2023 18:03:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
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
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
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

Thanks a lot James for looking at this proposal,
and sharing your thoughts. Really appreciate it.

On 8/1/23 14:21, James Bottomley wrote:
> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
> [...]
>> Truncating IMA log to reclaim memory is not feasible, since it makes
>> the log go out of sync with the TPM PCR quote making remote
>> attestation fail.
> This assumption isn't entirely true.  It's perfectly possible to shard
> an IMA log using two TPM2_Quote's for the beginning and end PCR values
> to validate the shard.  The IMA log could be truncated in the same way
> (replace the removed part of the log with a TPM2_Quote and AK, so the
> log still validates from the beginning quote to the end).
Here we meant just truncating IMA log is not a complete
solution in itself. As you said, we have to take additional steps
like logging TPM2_Quotes etc. Logging AK is an interesting proposal
which we didn’t consider earlier. I am not sure if embedding AK to IMA
log/snapshot is needed. If the client sends them separately with "signed
PCR quotes" + "IMA log" + snapshots, it should still serve the purpose,
right?

>
> If you use a TPM2_Quote mechanism to save the log, all you need to do
> is have the kernel generate the quote with an internal AK.  You can
> keep a record of the quote and the AK at the beginning of the truncated
> kernel log.  If the truncated entries are saved in a file shard it
> should have a beginning and end quote and a record of the AK used.
A new IMA log snapshot file (or shard as you call it) will have
the TPM2_Quote record (plus some additional metadata) at the beginning.
I don't believe it needs to be logged at the end of the snapshot (since 
it can
be computed by replaying the remaining entries in the snapshot).

See the snapshot_aggregate field in section B.5 in the original RFC mail 
[1].
> Since verifiers like Keylime are already using this beginning and end
> quote for sharded logs, it's the most natural format to feed to
> something externally for verification and it means you don't have to
> invent a new format to do the same thing.
Could you please point to the Keylime source and/or documentation
which explains the use of beginning and end quotes? We would like to
understand how the verifiers are addressing this problem currently.


[1] 
https://lore.kernel.org/all/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/#t

~Tushar
>
> Regards,
>
> James

