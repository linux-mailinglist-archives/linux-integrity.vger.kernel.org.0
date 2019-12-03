Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F01101EB
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 17:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfLCQNb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 11:13:31 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55776 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCQNa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 11:13:30 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0DDA520B7185;
        Tue,  3 Dec 2019 08:13:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DDA520B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575389610;
        bh=RfT3Xc5qnAruXZFI6OG30/tifx3RL/kw/rwni/UoLpU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J8r+JagaNtiAJ/mg5PGbrT5xib+SkrauLx8LbP40jwfWjRmnFEgz8OMZgb3HD81+6
         TmXPDYZHSZ2pZyZg4etmixj012r8pbu2pd+JOKF7JK8e8Av4s6t6iw2cj69+RCmJnQ
         JRO738i7TzIuBOn7ihCyN3epZqQnPo1XnCMspyEI=
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e2faf0d0-fee1-96fe-1120-c003761aa517@linux.microsoft.com>
Date:   Tue, 3 Dec 2019 08:13:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575375945.5241.16.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/3/2019 4:25 AM, Mimi Zohar wrote:

Hi Mimi,

> Hi Lakshmi,
> 
> A keyring can be created by any user with any keyring name, other than
>   ones dot prefixed, which are limited to the trusted builtin keyrings.
>   With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
> example, keys loaded onto any keyring named "foo" will be measured.
>   For files, the IMA policy may be constrained to a particular uid/gid.
>   An additional method of identifying or constraining keyring names
> needs to be defined.
> 

I agree - this is a good idea.

Do you think this can be added as a separate patch set - enhancement to 
the current one, or should this be addressed in the current set?

I was just about to send an update today that addresses your latest 
comments. Will hold it if you think the above change should be included 
now. Please let me know.

thanks,
  -lakshmi
