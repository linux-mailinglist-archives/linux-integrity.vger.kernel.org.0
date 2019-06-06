Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2854237A55
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Jun 2019 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfFFQ6K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 12:58:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41752 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFQ6K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 12:58:10 -0400
Received: from [10.200.157.26] (unknown [131.107.160.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id A702D20B7192;
        Thu,  6 Jun 2019 09:58:09 -0700 (PDT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <1559825065.4278.94.camel@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <77dd257c-f371-1349-62e8-362b5fe01c78@linux.microsoft.com>
Date:   Thu, 6 Jun 2019 09:58:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559825065.4278.94.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/6/19 5:44 AM, Mimi Zohar wrote:
> 
> Instead of measuring all the files in policy, Roberto's "digest lists"
> proposed patch set measures only "unknown" files.  Why bother with all
> those messy measurements?!

I agree. But in our use case scenario, we want the attestation service 
to know who signed the system files and leave the task of validating the 
file signature to the clients.

Essentially, in our approach we are measuring the "signer".

> In your use case scenario, will the measurement list only contain the builtin and secondary keys?
> 
> Mimi

In my implementation I am measuring the builtin keys. Since any key 
added to the secondary keyring also needs to be signed by a key in the 
builtin keyring, I feel measuring only "builtin keys" is sufficient.

But I am open to the suggestion of measuring secondary keys as well. 
Please let me know if you think that is a must.

Thanks,
  -lakshmi


