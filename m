Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40C5779378
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjHKPsk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjHKPs1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 11:48:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A21DF211C;
        Fri, 11 Aug 2023 08:48:26 -0700 (PDT)
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7D7F220FD0C5;
        Fri, 11 Aug 2023 08:48:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D7F220FD0C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691768906;
        bh=UKEi7WJXl5hJdjwWxrw5NDZOvUTxztWU9msXupBAioE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A6+wUIIfI7qkrBchbUMDtIOLwpRi462atJwsAdwPMskRKIouLHmAuAFQcqqhKe3sw
         IbTJPMBTNn74Wx7KMNU/BJFuXsumZex+1WQ8TVvGWSYxeC66PQXxRyC7/3THmzbYtN
         ShK5qUuuLyTQk6zoKUh8SAI5FmkRRZXid70JmORs=
Message-ID: <72e39852-1ff1-c7f6-ac7e-593e8142dbe8@linux.microsoft.com>
Date:   Fri, 11 Aug 2023 08:48:25 -0700
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
 <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
 <a522b17a536ea87a6a4c2faf95583ae3b7b74a26.camel@HansenPartnership.com>
 <5cb03349-7a32-8f74-f2a1-ff3c6247c1ef@linux.microsoft.com>
 <8ccaec30bf85cfbf4415bbafa22646a62e753840.camel@HansenPartnership.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8ccaec30bf85cfbf4415bbafa22646a62e753840.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/10/23 04:43, James Bottomley wrote:
> On Wed, 2023-08-09 at 21:43 -0700, Tushar Sugandhi wrote:
>> On 8/8/23 14:41, James Bottomley wrote:
>>> On Tue, 2023-08-08 at 16:09 -0400, Stefan Berger wrote:
> [...]
>>>>    at this point doesn't seem necessary since one presumably can
>>>> verify the log and PCR states at the end with the 'regular'
>>>> quote.
>>>   
>>> I don't understand this.  A regular quote is a signature over PCR
>>> state by an AK.  The point about saving the AK in the log for the
>>> original is that if the *kernel* truncates the log and saves it to
>>> a file, it needs to generate both the AK and the quote for the top
>>> of the file shard. That means the AK/EK binding is unverified, but
>>> can be verified by loading the AK and running the usual tests,
>>> which can only be done if you have the loadable AK, which is why
>>> you need it as part of the log saving proposal.
>>   
>> I had this question about the usability of AK/EK in this
>> context. Although AK/EK + PCR quote is needed to verify the snapshot
>> shards / IMA logs are not tampered with, I am still not sure why
>> AK/EK needs to be part of the shard/IMA log. The client sending AK/EK
>> to attestation service separately would still serve the purpose,
>> right?
> 
> Well, the EK doesn't need to be part of the log: it's just a permanent
> part of the TPM identity.  To verify the log, you need access to the
> TPM that was used to create it, so that's the point at which you get
> the EK.
> 
Agreed. EK is part of TPM identity. But to verify the log,
you don’t need to have physical access to the TPM. You need to have
access to just public part of EK and AK/AIK certs (TPM on the system
would sign the quote using the private AK).
I believe you already know this, just stating for the sake of
completing the conversation. :)
> An AK is simply a TPM generated signing key (meaning the private part
> of the key is secured by the TPM and known to no-one else).  In the
> literature a TPM generated signing key doesn't become an Attestation
> Key until it's been verified using an EK property (either a certify for
> a signing EK or a make/activate credential round trip for the more
> usual encryption EK.
> 
Yes. That aligns with my understanding of EK/AK in general.
Thanks for describing.

> So the proposal is for each quote that's used to verify a log shard is
> that the TPM simply generate a random signing key and use that to sign
I believe you are suggesting creating a new AK each time you
want to sign a PCR quote. It is doable in TPM 2.0, and it provides
benefits like privacy and untraceability. But it comes with it’s own
costs – cost of generating new AK each time you want to sign,
maintaining mapping of AK and it’s signed quotes, maintaining
multiple public AK certs etc.

> the quote.  You need to save the TPM form of the generated key so it
> can be loaded later and the reason for that is you can do the EK
> verification at any time after the quote was given by loading the saved
> key and running the verification protocol.  In the normal attestation
> you do the EK verification of the AK *before* the quote, but there's no
> property of the quote that depends on this precedence provided you do
> the quote with a TPM generated signing key.
Yes.

> 
> The underlying point is that the usual way an EK verifies an AK
> requires a remote observer, which the kernel won't have, so the kernel
Agreed.

> must do all its stuff locally (generate key, get quote) and then at
I believe the Kernel doesn’t have to generate key while
taking the snapshot. In the current proposal, Kernel can simply get
the (unsigned) PCR quote and log it in IMA log as part of the
snapshot_aggregate event. We don’t need to sign the quote while
logging it in the IMA log as snapshot_aggregate. And the act of
logging that event in IMA log extends the PCR bank. Sometime later,
when a remote observer wants to validate the log – it can do it by
comparing against the PCR quote that was signed at that point.

> some point later the system can become remote connected and prove to
> whatever external entity that the log shard is valid.  So we have to
> have all the components necessary for that proof: the log shard, the
> quote and the TPM form of the AK.
> 
>> For instance, PCR quotes will be signed by AK. So as long as the
>> verifier trusts the AK/EK,
> 
> Right, but if you're sharding a log, the kernel doesn't know if a
> verifier has been in contact yet.  The point of the protocol above is
> to make that not matter.  The verifier can contact the system after the
> log has been saved and the verification will still work.
> 
The Kernel doesn’t need to know. And it still doesn’t matter.
The benefit of our approach is the PCR values that represent the
previous snapshot(shard) is now logged in the IMA log as
snapshot_aggregate, and the PCRs are extended again as part of
logging that event in IMA log.

>>   it can verify the quotes are not tampered with.
>> Replaying IMA log/snapshot can produce the PCR quotes which can be
>> matched with signed PCR quotes. If they match, then the verifier can
>> conclude that the IMA log is not tampered with. So AK doesn't need to
>> be part of the log/snapshot.
> 
> Only if the system is currently in contact with the verifier and the
> verifier has created the AK.  That may not have happened.
> 
Hope my above explanation addresses this point.

>> BTW, in this proposal, kernel is truncating the log and passing the
>> truncated buffer to UM.  UM client need to save it to the disk
>> location of it's choice.
> 
> Yes, but I was assuming tampering with or discarding the log file would
> be treated in exactly the same way as an in-kernel IMA log tamper.
> 
Hope my above explanation addresses this point.

~Tushar

> James
