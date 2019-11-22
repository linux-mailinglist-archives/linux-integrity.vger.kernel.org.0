Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2700C105E14
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2019 02:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKVBPJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Nov 2019 20:15:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34442 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBPJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Nov 2019 20:15:09 -0500
Received: from [10.137.112.108] (unknown [131.107.159.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3152420B7185;
        Thu, 21 Nov 2019 17:15:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3152420B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574385308;
        bh=I4K9ilz7bmmc8BfuFFbPUeIZ58hQzBCf1gLHUYEwODo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RNZpjKeftP0A+le/ieSGcUhoYf3riMJlaaobYjn+DgMw3nR7slj2wl6dqpRBKhQtZ
         6ql6vbz5lFBs+qNJ+m/NXKlW1BZd+kS5z4mmnPtqeMMdktqb2hOD9ybaV5PcSTsT+q
         zwrjs1fit+huHJ+3vtKaog0tgE8BNGs6jZak8BsE=
Subject: Re: IMA: Data included in the key measurement
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Cc:     James Morris <jamorris@linuxonhyperv.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
 <1574354333.3277.27.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
Date:   Thu, 21 Nov 2019 17:15:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574354333.3277.27.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/21/19 8:38 AM, James Bottomley wrote:

Hi James,

> You're making the assumption that the public key and the certificate
> are isomorphic.  That's only true if you trust the issuer (which you
> obviously do, since it's you [microsoft]) but nothing in X.509 prevents
> the issuer from issuing multiple certificates with the same public key
> and different properties.  Even in your use case, I would think
> attesting to whether the certificate had expired or not would be
> useful.

I agree attesting the x509 certificate and not just the public key is 
the right approach. But in the kernel the certificate is not stored - 
only the key extracted from the certificate is stored (please correct me 
if I am wrong).

When IMA, for instance, verifies the file signature only the public key 
(the data in "struct public_key") of the corresponding IMA key is used - 
the certificate is not used.

In my key measurement implementation, IMA hook is called when 
key_create_or_update() function has successfully added\updated a key in 
a keyring. At that point, I do not have the corresponding x509 certificate.

Please let me know if the kernel indeed stores the x509 certificate also 
and it can be queried when the corresponding key is added to a keyring. 
I'll make the changes to measure the x509 cert instead of just the 
public key.

Thank you.

  -lakshmi

