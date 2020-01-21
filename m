Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974E8144601
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jan 2020 21:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgAUUiq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jan 2020 15:38:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39004 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUUiq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 15:38:46 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id E32BA2008819;
        Tue, 21 Jan 2020 12:38:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E32BA2008819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579639126;
        bh=39hRDfcQoedGytqRqIp/6T1ZCaQPsUpXvrhCIte/taw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eZhJmakmz0bsFphuCLNYJ7RtxE+ijV4PfcNO94/c7nk1lWIBY5xF+b+pGNIz8ANta
         ZVVcFf3bdyrBRSdA1LQwXQhOcjlcEK2yaPIC0BmcNh6aTOleO0ElMu0iR9TdkmI36O
         zlgZiqHYC5tzGODOOaTLotQpBq3cUGqb0sQk/7Zw=
Subject: Re: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
References: <20200121171302.4935-1-nramas@linux.microsoft.com>
 <1579628090.3390.28.camel@HansenPartnership.com>
 <1579634035.5125.311.camel@linux.ibm.com>
 <1579636351.3390.35.camel@HansenPartnership.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ac6c559e-2d68-afcb-d316-6ac49a570831@linux.microsoft.com>
Date:   Tue, 21 Jan 2020 12:38:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579636351.3390.35.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/21/2020 11:52 AM, James Bottomley wrote:

>> - really small devices/sensors being able to queue certificates
> 
> seems like the answer to this one would be don't queue.  I realise it's
> after the submit design, but what about measuring when the key is added
> if there's a policy otherwise measure the keyring when the policy is
> added ... that way no queueing.

Without the "deferred key processing" changes, only keys added at 
runtime were measured (if policy permitted).

"deferred key processing" enabled queuing keys added early in the boot 
process and measured them when the policy is loaded.

We can make this (the queuing) optional through a config, but leave the 
runtime key measurement auto-enabled (as is the config 
IMA_MEASURE_ASYMMETRIC_KEYS now).

  -lakshmi

