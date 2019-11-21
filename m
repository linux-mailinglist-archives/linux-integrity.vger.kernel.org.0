Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866C410472D
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 01:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKUACn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 19:02:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60960 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKUACn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 19:02:43 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3CFAA20B7185;
        Wed, 20 Nov 2019 16:02:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CFAA20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574294562;
        bh=Nx7FpAeREdfQqZZz2uLZtOiIJYjK6fek5qV+toHpBaI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sYQwijFj6MBhFH/urC2eZ2vc15KxWA4yf3qIPx8OQIrpGoSj2oRh/VJuzflpff9sx
         Ai2tcsobEKccZSRUJRVLLpf0HdjVsJ1SmgWT8kpytCUcogKsVZKKskzOzwK4PSkzT6
         F0iLGnTJgiMGLT2QRjPFeoAVyKUEeJmK1Y2TdfCw=
Subject: Re: [PATCH v8 4/5] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-5-nramas@linux.microsoft.com>
 <1574291957.4793.144.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fef8fc67-643d-e579-9628-6516fd02b4db@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 16:03:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574291957.4793.144.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/20/2019 3:19 PM, Mimi Zohar wrote:

Hi Mimi,

>> The above can be used to correlate the key measurement IMA entry,
>> ima-sig and ima-modsig entries using the same key.
> 
> True, but associating the public key measurement with the file
> signature requires information from the certificate (e.g. issuer,
> serial number, and/or subject, subject keyid).
> 
> For a regression test, it would be nice if the key measurement,
> itself, contained everything needed in order to validate the file
> signatures in the measurement list.

I am just trying to understand your asks - Please clarify:

1, My change includes only the public key and not the entire certificate 
information in the measured buffer.

Should I update this current patch set to measure the entire cert. Or, 
can that be done as a separate patch set?

2, Should a regression test be part of this patch set for the key 
measurement changes to be accepted?

thanks,
  -lakshmi
