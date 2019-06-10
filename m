Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACEF3BA46
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jun 2019 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfFJRCg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jun 2019 13:02:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55802 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfFJRCg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jun 2019 13:02:36 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA0D320B7194;
        Mon, 10 Jun 2019 10:02:35 -0700 (PDT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
From:   Lakshmi <nramas@linux.microsoft.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
 <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
Message-ID: <9223cb39-f24e-d65f-33cc-b9ca25bce540@linux.microsoft.com>
Date:   Mon, 10 Jun 2019 10:02:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/7/19 10:15 AM, Lakshmi wrote:
> On 6/7/19 7:14 AM, Ken Goldman wrote:
> 
>>
>> Why is this important?  What is gained by measuring the keys on the
>> built-in keyring?  The IMA log already measures [a pointer to] the
>> IMA keys used for signature verification.  Why does the service care 
>> what keys were used to install the IMA keys?
> 
> By measuring the built-in keyring, the service knows whether or not the 
> key(s) in "IMA keyring" are indeed trusted or not. So while the IMA key 
> validates the file signatures on the client, the built-in key validates 
> the IMA key(s).
> 
> By knowing what keys were used to install the IMA key(s) the service 
> knows whether or not to trust the signature validation performed by IMA 
> on the client.

Hi Ken\Mimi,

Please let me know if you have more questions\concerns about this approach.

If the high level design is acceptable, please review the code changes 
and provide feedback\comments.

Thanks,
  -lakshmi
