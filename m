Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC1211C3
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 03:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfEQB3c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 21:29:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60864 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfEQB3c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 21:29:32 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 51CAE20110AD;
        Thu, 16 May 2019 18:29:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
 <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <9c944ba6-f520-96e1-3631-1e21bbc4c327@linux.microsoft.com>
Date:   Thu, 16 May 2019 18:29:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <750fdb9f-fc9b-24bf-42c3-32156ecdc16f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/16/19 7:34 AM, Ken Goldman wrote:

>> But outside the client machine this key id is not sufficient to
>> uniquely determine which key the signature corresponds to.
> 
> Why is this not sufficient?
> 
> In my implementation, I create a lookup table at the attestation service 
> that maps the 4-byte IMA log key identifier to the signing public key.
> 
> Are you concerned about collisions?  Something else?

Yes - the concern is collision.

The "Subject Key Identifier" (SKI) for no two certificate can be the 
same. But since we are using only the last 4 bytes of the SKI it can 
collide. That's mainly the reason I want to log the entire public key.

> 
> Are you suggesting that the client supply the verification public key 
> and that the verifier trust it?  Wouldn't that make the log self signed?
> 
> How would the verifier determine that the key from the IMA log is valid 
> / trusted / not revoked from the log itself?

IMA log is backed by the TPM. So if the public key is added to the IMA 
log the attestation service can validate the key information.
I am not sure if that answers your question.

> 
> A minor question here.
> 
> Are you proposing that the IMA log contain a single ima-sigkey entry per 
> public key followed by ima-sig entries?
> 
> Or are you proposing that ima-sig be replaced by ima-sigkey, and that 
> each event would contain both the signature and the public key?
> 
> If the latter, this could add 25M to a server's 100K log.  Would that 
> increase in size concern anyone?  Could it be a concern on the other 
> end, an IoT device with limited memory?

Mimi had raised the same concern. I will update my implementation to 
include the certification information in the IMA log only once per key - 
when that key is added to the IMA or Platform keyring.

Thanks,
  -lakshmi

