Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35561056C8
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKUQRM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Nov 2019 11:17:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41360 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUQRM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Nov 2019 11:17:12 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0A02320B7185;
        Thu, 21 Nov 2019 08:17:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A02320B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574353032;
        bh=0NGwDic+CWZB9bud1PRLutHtUsmXVrkpBUEVqMzsVAQ=;
        h=From:Subject:To:Cc:Date:From;
        b=A1wFisUrfB9OEk6PIKwUhzWIV9IIDSY4uoJzNDiCeJ78Leu6bD7rQxaw8Ont4njLq
         iuAfG8rn2elfBXeCX4VBLupVrYwQPMuCsUY09W3OhnctBcuGVfY2oHj8xJmIZpkcwZ
         U1dHGFiPP7t5kZLNEztfWTwSw+z1Y6E89iYVjE/E=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: IMA: Data included in the key measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     James Morris <jamorris@linuxonhyperv.com>
Message-ID: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
Date:   Thu, 21 Nov 2019 08:17:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

 >>> everything needed for verifying a signature is included in
 >>> the key measurement.

Regarding the requirement you had stated above, I would like some 
clarification.

When I started this change to measure keys through IMA, the use case we 
had in mind was enabling an attestation service, for instance, to verify 
if the client has only known good (trusted) keys - for example, in 
keyrings such as ".builtin_trusted_keys", ".ima", etc.

On the client IMA verifies the signature of system binaries using keys 
in the IMA keyring. And, if the config namely 
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled, 
only keys signed by a built-in trusted key can be added to the IMA keyring.

An attestation service can keep a list of public keys of "known good 
(trusted)" keys for various keyrings, and verify against the measurement 
data provided by the client.

To achieve the above we decided to include only the public key in the 
key measurement buffer.

I would like to know what benefit we'd get by including "everything 
needed for verifying a signature in the key measurement"?

 From testing point of view, if we have the certificate (like the .DER 
file), we can validate the key measurement data in the IMA log.

Do you see a need to include more data or the entire cert for the 
product code?

thanks,
  -lakshmi
