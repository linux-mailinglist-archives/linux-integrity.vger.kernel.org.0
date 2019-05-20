Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3452E243F5
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2019 01:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfETXP3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 19:15:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37908 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfETXP3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 19:15:29 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB7B620B7192;
        Mon, 20 May 2019 16:15:28 -0700 (PDT)
From:   Lakshmi <nramas@linux.microsoft.com>
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
Message-ID: <54663a75-a601-ae6c-8068-bc2c3923a948@linux.microsoft.com>
Date:   Mon, 20 May 2019 16:15:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0b5ae493-6564-40e9-343b-e6781c229a25@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/17/19 7:41 AM, Ken Goldman wrote:

Hi Ken,

Apologize for the delay in responding.

> Since a platform typically uses only a few signing keys, 4 bytes makes 
> the chance of a collision quite small.  The collision would have to be 
> within the same log, not global.
> 
> In that worst case, the verifier would have to try two keys.  It's a
> slight performance penalty, but does anything break?

Problem Statement:
- If the attestation service has to re-validate the signature reported 
in the IMA log, the service has to maintain the hash\signature of all 
the binaries deployed on all the client nodes. This approach will not 
scale for large cloud deployments.
- Possibility of collision of "Key Ids" is non-zero
- In the service if the "Key Id" alone is used to verify using a map of
"Key Id" to "Signing Key(s)", the service cannot determine if the 
trusted signing key was indeed used by the client for signature 
validation (Due to "Key Id" collision issue or malicious signature).

Proposed Solution:
- The service receives known\trusted signing key(s) from a trusted 
source (that is different from the client machines)
- The clients measure the keys in key rings such as IMA, Platform, 
BuiltIn Trusted, etc. as early as possible in the boot sequence.
- Leave all IMA measurements the same - i.e., we don't log public keys 
in the IMA log for each file, but just use what is currently available 
in IMA.

Impact:
- The service can verify that the keyrings have only known\trusted keys.
- The service can cross check the "key id" with the key rings measured.
- The look up of keys using the key id would be simpler and faster on 
the service side.
- It can also handle collision of Key Ids.

Note that the following is a key assumption:

- Only keys signed by a key in the "BuiltIn Trusted Keyring" can be 
added to IMA\Platform keyrings.


Thanks,
  -lakshmi
