Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E341101E1
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 17:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLCQJD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 11:09:03 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54174 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfLCQJC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 11:09:02 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id AFB6B20B7185;
        Tue,  3 Dec 2019 08:09:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFB6B20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575389341;
        bh=cA2NvMvX1jL063jiAdOXXSP1Gwaopiy2VeenLg73h9E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j0N/i9Wx4wwKdNtHrm2WiqBSSaRnzd0P4Nju3IvAxxS1CcFNHA3MS/3Q3Os/4QHLJ
         2VDp4boCAXWBWDXj/bLxU3qp2OP7YXQDEMkLUN4VO6HVwQAK0bZLSdCq2QjyWVbTG9
         gjmLXK0hvdRzNV5jLvVrMYJiEbObjEC6RYJyjR5o=
Subject: Re: [PATCH v0 2/2] IMA: Call queue functions to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
 <20191127025212.3077-3-nramas@linux.microsoft.com>
 <1575331353.4793.471.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <e89dcb1c-c463-919a-aabb-e285d884a914@linux.microsoft.com>
Date:   Tue, 3 Dec 2019 08:09:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575331353.4793.471.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for reviewing the changes Mimi. I'll address your comments in the 
next update.

> 
> Overwriting the initial policy is highly recommended, but not everyone
> defines a custom policy.  Should there be a time limit or some other
> criteria before deleting the key measurement queue?
> 
> Mimi

For the above, I feel checking for the presence of custom policy, if 
that is possible, would be a more deterministic approach compared to 
having a time limit.

On my machine, systemd loads the custom IMA policy from 
/etc/ima/ima-policy if that file is present. Is this the recommended way 
to configure custom IMA policy? If yes, can the IMA initialization 
function check for the presence of the above file?

Another way to address this issue is to define a new CONFIG parameter to 
determine whether or not to support deferred processing of keys. If this 
config is chosen, custom IMA policy must be defined.

Least preferred option would be to leave the queued keys as is if custom 
policy is not defined - at the cost of, maybe, a non-trivial amount of 
kernel memory consumed.

If detection of custom policy is not possible, then define a timer to 
drain the key measurement queue.

Please let me know which approach you think is optimal.

thanks,
  -lakshmi

