Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280B84A8D3
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfFRRwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 13:52:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38500 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbfFRRwP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 13:52:15 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2E76620B7194;
        Tue, 18 Jun 2019 10:52:14 -0700 (PDT)
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
 <5b160458-b4b8-470c-0123-8ce5525c5cb0@linux.microsoft.com>
 <f6ce1524-d1ee-08b4-d7bc-f3337a804b98@linux.ibm.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <c1abe7e6-5f92-2359-19d0-024af65dd8a9@linux.microsoft.com>
Date:   Tue, 18 Jun 2019 10:52:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f6ce1524-d1ee-08b4-d7bc-f3337a804b98@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/18/19 10:31 AM, Ken Goldman wrote:
> On 6/10/2019 12:57 PM, Jordan Hand wrote:
>>
>> Thought I'd jump in this conversation to see if I can clarify what I 
>> see as the value of this patch set.
>>
>> At a certain point, keeping a list of all known-good (or known-bad) 
>> hashes becomes infeasible. We could probably disagree about at what 
>> scale this happens but I think we could agree that eventually this 
>> happens (let me know if you still disagree with this assertion). So at 
>> this point you likely need to rely on a few things:
> 
> I've seen large systems with 60,000 measurements.  Even if that goes to 
> 100,000, *10 for bad measurements, and *10 for future expansion, that's 
> only 10M, or 320 mbytes.  That's pennies of disk space.

Ah, so I'm not really worried about disk space/file size. I'm worried 
about the need to update the service every time a new key is used to 
sign something.

Lets say the people who are maintaining the attestation service (Team A) 
are different from the people writing/signing the code to run on the 
client (Team B). The problem is that Team A has to take an update 
whenever a new signing key is used. And rolling leaf keys is often an 
automatic process so Team B may not even know exactly when a new leaf 
key is used. They just know its the same CA. And now as Team A, I may 
trust code as long as its signed by 1 of 10 different sources.

My concern is more that the process of keeping track of these leaf keys 
doesn't scale. This is where having a shared/static CA shines (as it 
does in other PKI infrastructures like TLS).

> 
>>
>> (1) is the file >= <known good version>. This allows you to forbid any 
>> kernel version before a vulnerability was fixed.
> 
> Perhaps, but one might also exclude a newer version, either because of a 
> regression, a certification, etc.
> 
>>
>> (2) Was it signed with a good, trusted, production key.
>>
>> You can sort of do this today by using the keyid. The issues with this 
>> are (a) collision (though the chance may be pretty remote. I don't 
>> have the crypto expertise to make an empirical call on that) and (b) 
>> you need to know all the possible signing keys in the service.
> 
> The 4 byte key id was probably a long term mistake, but can be fixed. 
> Today, a collision is remote.  Even then, just try both keys.  Nothing 
> breaks.
> 
>>
>> Again, once you cross a certain scale threshold, signing/deployment is 
>> so automated that the leaf key could change at any time, leaving your 
>> service in the dark about new keys. You could automatically add new 
>> trusted keys to the service but it depends on the service environment 
>> and how much you want to automate what the service trusts.
>>
>> So what does measuring the keyring do? It allows you to put long-lived 
>> trusted CAs in .builtin_trusted_keys. On the service if you trust the 
>> CA and you trust the running kernel to do the right thing during key 
>> enrollment, you can trust that loaded files are properly signed.
> 
> This is my gap in understanding.
> 
> Even if I somewhat trust the keys on the built-in keyring, I may not 
> trust every key on the IMA keyring.

Its a different policy than is maybe used today in IMA, but often it is 
the case that I want indirect trust. I (Party A) trust Party B. Party B 
trusts parties C, D, and E. And long as party B trusts them, then party 
A can also trust C, D, and E. It allows for a service to trust any code 
that chains to a CA, but not trust any code that doesn't, in cases where 
the service may not know the exact hashes or leaf keys it should trust.

> 
> I may trust the kernel that ran at the time the key was enrolled, but I 
> don't trust the one that's currently running until I attest.  Or, are 
> all the keys on both keyrings erased before any kernel SW update?  I 
> don't think so.

On a cold boot, the keys would be re-enrolled. I'm not sure about the 
kexec case. But as long as you carry-forward the measurement log across 
kexec, you can attest to the whole chain (this assumes TPM-based 
attestation).

And if you don't carry forward the measurements, there are some other 
server side things you can do to reconstruct the PCR state. But I think 
that's a bit out of scope for this discussion.

-Jordan
