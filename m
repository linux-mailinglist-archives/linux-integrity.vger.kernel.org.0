Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2F9EB3E6
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Oct 2019 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfJaP1t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Oct 2019 11:27:49 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49938 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfJaP1t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Oct 2019 11:27:49 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3414920B7192;
        Thu, 31 Oct 2019 08:27:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3414920B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572535668;
        bh=PSOfNbhonJxnlQ8FQZ6akUmZvFLh3Q/fwlVELiDODGs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S8uM4Cu6ZThFH0ta8hY1CBsCcxeittxOpA2tkQJciOM57UWWwgifMp+XbxJrwPbKQ
         Tzakp2WTibrZ38y5COPyO/bGmzfqY+kdXKkmp80AcjnogM94/G7d8KPHMaAzuKCNiA
         BbcoWzddT5ed8PKKDW72RS4VxM+okx4/FCK/0eTc=
Subject: Re: [PATCH v3 1/9] KEYS: Defined an IMA hook to measure keys on key
 create or update
To:     Sasha Levin <sashal@kernel.org>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        prsriva@linux.microsoft.com
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-2-nramas@linux.microsoft.com>
 <20191031091041.GO1554@sasha-vm>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <af591616-ac80-c862-6822-d11addeabb91@linux.microsoft.com>
Date:   Thu, 31 Oct 2019 08:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031091041.GO1554@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/31/19 2:10 AM, Sasha Levin wrote:

Hi Sasha,

> On Wed, Oct 30, 2019 at 06:19:02PM -0700, Lakshmi Ramasubramanian wrote:
>> Asymmetric keys used for verifying file signatures or certificates
>> are currently not included in the IMA measurement list.
>>
>> This patch defines a new IMA hook namely ima_post_key_create_or_update()
>> to measure asymmetric keys.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> What are the prerequisites for this patch?

I built this patch set on kernel v5.3

I applied the following patch provided by Nayna Jain@IBM and then added 
my changes:

	[PATCH v9 5/8] ima: make process_buffer_measurement() generic

thanks,
  -lakshmi

