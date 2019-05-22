Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B078726CBD
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfEVThF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 15:37:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40032 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfEVThF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 15:37:05 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id E438020B7186;
        Wed, 22 May 2019 12:37:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        jorhand@linux.microsoft.com
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
 <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
 <9c944ba6-f520-96e1-3631-1e21bbc4c327@linux.microsoft.com>
 <0b5ae493-6564-40e9-343b-e6781c229a25@linux.ibm.com>
 <54663a75-a601-ae6c-8068-bc2c3923a948@linux.microsoft.com>
 <b1a2edc1-45c7-7a9f-7a77-e252b2f85a64@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <2bf6f51f-a55b-9f7d-0e50-25d92fc95e8b@linux.microsoft.com>
Date:   Wed, 22 May 2019 12:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b1a2edc1-45c7-7a9f-7a77-e252b2f85a64@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/22/19 11:57 AM, Ken Goldman wrote:

> 
> 1 - How is your solution - including a public key with each event - 
> related to this issue?
This a change from my earlier proposal. In the new proposal I am making 
the public key is not included with each event. The data included in 
each IMA event does not change. For instance, when IMA signature 
validation is selected (ima-sig template, for instance), each event will 
have the IMA signature (which includes the 4 Byte Key Identifier and the 
Signature)

> 2 - I don't understand how a large cloud affects scale.  Wouldn't the 
> verifier would typically be checking known machines - those of their 
> enterprise - not every machine on the cloud?
> 
> Can't we assume a typical attestation use case has a fairly locked down 
> OS with a limited number of applications.
Yes - the attestation service (verifier) will be attesting only client 
machines known to the enterprise. But such clients could be running 
different versions of the OS and the kernel modules.
We cannot assume that this would be a limited set. Therefore, 
maintaining the hash\signature of all such components, for all versions 
of the components, and re-validating that in the service is not a 
scalable solution.

Instead, we want the IMA sub-system on the clients to do the signature 
validation (As it is done today). In addition to that, the clients will 
log the public keys from keyrings such as IMA, Platform, and BuiltIn 
Trusted Keys - this will be done only once and not in each IMA event 
(This is a change from my earlier proposal).

Using this data the service will verify that the clients used only 
trusted key(s) for signature validation.

> 
> Like I said, it should be rare.  In the worst case, can't the service 
> tell by trying both keys?If the service is validating the signature again it can try all the 
keys. But we don't want to take that approach - instead we want to 
verify the keys used by the client.

> 
> I thought your solution was to change the IMA measurements, adding the 
> public key to each entry with a new template?  Did I misunderstand, or 
> do you have a new proposal?
I have a new proposal as described above. Sorry if I had confused you.


> How does this solve the collision issue?  If there are two keys with the 
> same key ID, isn't there still a collision?
Like I have said above, the client will log all the keys from the 
relevant keyrings (IMA, Platform, etc.) The service will verify that 
they are all known\trusted keys - which gives the assurance that the IMA 
signature validation done by the client was performed using trusted 
signing key(s).


> I understand how the client keyring is used in IMA to check file
> signatures, but how is that related to the attestation service?
In my new proposal, the keys in the client keyrings will be logged in 
the IMA log. The attestation service will verify that they are 
known\trusted keys.

Thanks,
  -lakshmi
