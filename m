Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD3247AA2
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 00:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgHQWpW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 18:45:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53108 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbgHQWpT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 18:45:19 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 592E620B4908;
        Mon, 17 Aug 2020 15:45:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 592E620B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597704318;
        bh=ELoXb6y6fs1Pm42OwyGovpUZV/jZUL94FH6q7n8Pm6Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZzTWlTEmfu2arW//OlcDcI2WJQYzZxYk3z4tAGkyeI7c24YTcoIUAvJQNSxRQjbj0
         Z9yN86YZYVU/WV8gjcL3FoDYtpioxmE7NkjO8zpfkkpl10NUZpxDuMeteWq/9n2JPp
         /YCOOYhalpCe8kIdD7Uxlxp51ezf445oPkQnDb4g=
Subject: Re: [PATCH 0/2] dm-devel:dm-crypt: infrastructure for measurement of
 DM target data using IMA
To:     Mimi Zohar <zohar@linux.ibm.com>, agk@redhat.com,
        snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200816210250.11506-1-tusharsu@linux.microsoft.com>
 <5f12cc89c535ccfc6c3d63efa2bf716a1fdd966d.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <f252a595-7b6a-9e20-bf08-97f102c41c01@linux.microsoft.com>
Date:   Mon, 17 Aug 2020 15:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f12cc89c535ccfc6c3d63efa2bf716a1fdd966d.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-08-17 2:46 p.m., Mimi Zohar wrote:
> On Sun, 2020-08-16 at 14:02 -0700, Tushar Sugandhi wrote:
>> There are several device-mapper targets which contribute to verify
>> the integrity of the mapped devices e.g. dm-integrity, dm-verity,
>> dm-crypt etc.
>>
>> But they do not use the capabilities provided by kernel integrity
>> subsystem (IMA). For instance, the IMA capability that measures several
>> in-memory constructs and files to detect if they have been accidentally
>> or maliciously altered, both remotely and locally. IMA also has the
>> capability to include these measurements in the IMA measurement list and
>> use them to extend a TPM PCR so that it can be quoted.
> 
> "both remotely" refers to measurement and attestation, while "locally"
> refers to integrity enforcement, based on hashes or signatures.  Is
> this patch set adding both IMA-measurement and IMA-appraisal?
> 
> Mimi
> 
Thanks Mimi for looking at this patch set.

I added both "remotely" and "locally" in the description, so that
people less familiar with IMA would get a general overview of whats
possible with IMA.

In this patch set we are only adding support for measurement and
attestation. In the next iteration, I will remove the references to
"local" detection.
~Tushar
<snip>
