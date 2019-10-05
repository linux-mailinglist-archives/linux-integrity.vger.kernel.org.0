Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF7CC6D7
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Oct 2019 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJEAKN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 20:10:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60686 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJEAKN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 20:10:13 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id D4D6B20B71C6;
        Fri,  4 Oct 2019 17:10:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4D6B20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570234212;
        bh=Eu7eFGJUhL8ChQ4mjTx6uGUjkQqTb1IOoeXJFzGLPm0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gr5GtEbBW3RUqCu0mPRMhAIoxKgdJ+F+J3nCG8ZqNKbCkknN1q6ZE1kmA2bIVhT7R
         UbqBo+f62xZHfFlFFVhHq7BL/jFqkUWru4ZPQ6SvRNLWM4sPUw57IF1vfoSUDHeW93
         hbbYqf0Wrsy4N9nNfzKQEXGh9pIM/X5E+mnWXZfE=
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, Sasha Levin <sashal@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
 <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
 <1567190507.10024.134.camel@linux.ibm.com>
 <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
 <1568035881.4614.347.camel@linux.ibm.com> <20190919131851.GA8171@sasha-vm>
 <1568913178.4733.89.camel@linux.ibm.com>
 <1dfc7a83-3fcb-1356-958e-2afb7c6f1285@linux.microsoft.com>
 <1570219032.5046.101.camel@linux.ibm.com>
 <868f6b82-7b43-5e27-0738-f9d09e765c59@linux.microsoft.com>
 <1570226287.5046.114.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <382dfa7b-a5f9-01e3-0624-9ecd526557bb@linux.microsoft.com>
Date:   Fri, 4 Oct 2019 17:10:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1570226287.5046.114.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/4/19 2:58 PM, Mimi Zohar wrote:

> The measurements could be added to an IMA pending measurement
> workqueue, until the TPM is enabled, assuming there is a TPM, and then
> processed.  All of this code would be within IMA.

Good point. I will look into this.

>> I prefer gathering data on trusted keys in ima_init, but gate it by IMA
>> policy and follow the other coding guidelines you have suggested earlier
>> (similar to the approach taken for kexec_cmdline measurement).
> 
> So your intention is only to measure the initial keys added to these
> keyrings, not anything subsequently added to the secondary keyring?

I am currently measuring only the initial keys. But I think including 
the ones added subsequently is a good idea.

> Defining an LSM/IMA hook to measure keys, based on policy, seems
> cleaner and more useful.

I agree.

thanks,
  -lakshmi

