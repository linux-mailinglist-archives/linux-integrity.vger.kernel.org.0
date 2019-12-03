Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF911204F
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 00:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLCXg7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 18:36:59 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43348 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfLCXg7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 18:36:59 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8BAC120B7185;
        Tue,  3 Dec 2019 15:36:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8BAC120B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575416218;
        bh=lumjR+WsAH17zIElti4at56HiP3oZKr0jeW3mqpgrHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=de947gFnmNyOixr7N1TMZYsinoGV2xsUKN/WwfHNuRjXgU61OunOF3SifgKSmF89G
         bRi33LhmfBFfM/IFU2Yu66gQvpR3cgchy6aY4zm9ohJ6QAoEEtnJ4fz2nu5HSPCeTw
         tz7djkOq501rwSmZC9Tc6rKg2AJjuDbXf14n6PTs=
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
 <20191127015654.3744-6-nramas@linux.microsoft.com>
 <1575375945.5241.16.camel@linux.ibm.com>
 <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
 <1575403616.5241.76.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com>
Date:   Tue, 3 Dec 2019 15:37:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575403616.5241.76.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/3/2019 12:06 PM, Mimi Zohar wrote:

> Suppose both root and uid 1000 define a keyring named "foo".  The
> current "keyrings=foo" will measure all keys added to either keyring
> named "foo".  There needs to be a way to limit measuring keys to a
> particular keyring named "foo".
> 
> Mimi

Thanks for clarifying.

Suppose two different non-root users create keyring with the same name 
"foo" and, say, both are measured, how would we know which keyring 
measurement belongs to which user?

Wouldn't it be sufficient to include only keyrings created by "root" 
(UID value 0) in the key measurement? This will include all the builtin 
trusted keyrings (such as .builtin_trusted_keys, 
.secondary_trusted_keys, .ima, .evm, etc.).

What would be the use case for including keyrings created by non-root 
users in key measurement?

Also, since the UID for non-root users can be any integer value (greater 
than 0), can an an administrator craft a generic IMA policy that would 
be applicable to all clients in an enterprise?

thanks,
  -lakshmi


