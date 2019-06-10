Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7142E3BA21
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jun 2019 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfFJQ5D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jun 2019 12:57:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53800 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfFJQ5C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jun 2019 12:57:02 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6C7620B7194;
        Mon, 10 Jun 2019 09:57:01 -0700 (PDT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Ken Goldman <kgold@linux.ibm.com>,
        Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <5b160458-b4b8-470c-0123-8ce5525c5cb0@linux.microsoft.com>
Date:   Mon, 10 Jun 2019 09:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/7/19 7:14 AM, Ken Goldman wrote:
> On 6/5/2019 8:16 PM, Lakshmi wrote:
>> The kernel could be built with the config parameter
>> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY enabled.
>> If this is done only those "IMA Signer Keys" that are signed by a key in
>> the "BuiltIn Trusted Keys" or the "Secondary Trusted Keys" can be added
>> to the "IMA Keyring".
>>
>> In other words, "IMA Signer Keys" are attested by the "Trusted Keys"
>> on the client machines if the above config parameter is enabled.
>>
>> IMA will enumerate the keys in the Trusted Keys keyring, and measure
>> them in the IMA log. On file read, IMA will validate the signature of
>> the system files using "IMA Signer Key" present in "IMA Keyring".
>>
>> An attestation service would receive the "Trusted Keys" from
>> a trusted source (which is different from the client machines it is
>> attesting). The service would compare the Trusted Keys reported by
>> the client with the list of known Trusted Keys. A client would be
>> marked trusted by the service if and only if the keys reported
>> by the client are all trusted.
> 
> Why is this important?  What is gained by measuring the keys on the
> built-in keyring?  The IMA log already measures [a pointer to] the
> IMA keys used for signature verification.  Why does the service care 
> what keys were used to install the IMA keys?
> 
>> Using the above approach the attestation service will be attesting
>> the "IMA Signer" while the clients attest the IMA Signature of
>> the system files. This enables the service to attest the client
>> machines by maintaining only a list of "Trusted Keys". These keys
>> change much less frequently than "IMA Signer Keys". It also frees
>> the service from having to maintain the "Hash of System Files"
>> which would change very frequently. This approach would significantly
>> reduce the maintenance cost of the service with respect to the data used
>> for attesting clients.
> 
> I don't understand this reasoning.
> 
> To me, there is a difference between signed files and trusted files. 
> E.g., an old version may be signed, but it is no longer trusted.
> 
> In other words, the service wants to know all files that have run, not 
> just whether they are signed

Thought I'd jump in this conversation to see if I can clarify what I see 
as the value of this patch set.

At a certain point, keeping a list of all known-good (or known-bad) 
hashes becomes infeasible. We could probably disagree about at what 
scale this happens but I think we could agree that eventually this 
happens (let me know if you still disagree with this assertion). So at 
this point you likely need to rely on a few things:

(1) is the file >= <known good version>. This allows you to forbid any 
kernel version before a vulnerability was fixed.

(2) Was it signed with a good, trusted, production key.

You can sort of do this today by using the keyid. The issues with this 
are (a) collision (though the chance may be pretty remote. I don't have 
the crypto expertise to make an empirical call on that) and (b) you need 
to know all the possible signing keys in the service.

Again, once you cross a certain scale threshold, signing/deployment is 
so automated that the leaf key could change at any time, leaving your 
service in the dark about new keys. You could automatically add new 
trusted keys to the service but it depends on the service environment 
and how much you want to automate what the service trusts.

So what does measuring the keyring do? It allows you to put long-lived 
trusted CAs in .builtin_trusted_keys. On the service if you trust the CA 
and you trust the running kernel to do the right thing during key 
enrollment, you can trust that loaded files are properly signed.

> 
> Further, the service also wants to know files that were blocked from 
> running, either because of no signature, a signature with an untrusted 
> IMA key, or a bad signature.  I.e., the service needs the entire IMA 
> log, not just the keys used to install the keys used to locally verify 
> the signatures.

In UEFI measurements, the goal is usually to allow the service to decide 
what is important and what isn't. For example, UEFI measures the file 
hashes of efi binaries as well as the db (list of keys being used to 
validate efi signatures). The service is free to use one, both, or 
neither depending on its security model.

Obviously Linux is not UEFI and "they do it in UEFI" is not a design 
justification by itself, just though I'd provide that as a frame of 
reference to explain the reasoning.

> 
> While the built-in keys may change less frequently that the IMA keys, 
> both are likely to be stable.  I.e., is this proposal to provide an 
> additional security benefit, or is it to improve performance?

In my opinion the biggest benefit here is to improve manageability of 
keys. You can put trust in CAs (similar to what browsers do with SSL 
certs) and you don't need to update the service when leaf keys change, 
as they're bound to do.

-Jordan
