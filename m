Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9936B276
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 01:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfGPXjX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 19:39:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42668 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGPXjX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 19:39:23 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id B4A4320B7185;
        Tue, 16 Jul 2019 16:39:22 -0700 (PDT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
 <5b160458-b4b8-470c-0123-8ce5525c5cb0@linux.microsoft.com>
 <f6ce1524-d1ee-08b4-d7bc-f3337a804b98@linux.ibm.com>
 <c1abe7e6-5f92-2359-19d0-024af65dd8a9@linux.microsoft.com>
 <372c86da-8bc6-25a9-1a35-c9b7f35a789c@linux.microsoft.com>
 <48871b9b-ede1-f2f7-aa51-3e563e966a47@linux.microsoft.com>
 <1563299517.4539.234.camel@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <31c44150-ba2b-fafb-7ff1-e14bfc41f768@linux.microsoft.com>
Date:   Tue, 16 Jul 2019 16:39:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1563299517.4539.234.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/16/19 10:51 AM, Mimi Zohar wrote:

> On Tue, 2019-07-16 at 09:33 -0700, Lakshmi wrote:
>> Hi Ken\Mimi,
>>
>> I wanted to check again - Did Jordan and I address your concerns?
>> Do you have more questions\concerns related to this patch set?
>>
>> Please let me know.
> 
> I made my thoughts on this subject pretty clear.
> 
> Mimi
> 

Thanks Mimi.

  -lakshmi
