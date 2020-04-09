Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB15D1A37EF
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Apr 2020 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDIQZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Apr 2020 12:25:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54992 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgDIQZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Apr 2020 12:25:58 -0400
Received: from [10.137.106.115] (unknown [131.107.174.243])
        by linux.microsoft.com (Postfix) with ESMTPSA id CC37A2007679;
        Thu,  9 Apr 2020 09:25:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC37A2007679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586449558;
        bh=mxgHZSJk9nY2+sfPQybAXK1hYlxOn5wF6OLSUaiTeXQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SVIUfVQPfYXivTtnf81II2+cuX+VuuFT/cdRyrSfPQa/NspfBGhnRo9yWKcDnzRbk
         LJ3Ki75Ows6uAhw3zh0yXVdiT1bgycAFmEUG1RPPnFEYcitcKAqCmE0Cd8qQo22Fey
         1mwwxBUG5vr/LHYHNEZymvqJ6fmpTEryjbQU2kPw=
Subject: Re: [RFC PATCH v2 00/12] Integrity Policy Enforcement LSM (IPE)
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com, linux-kernel@vger.kernel.org
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
 <c1466cc8-8a08-708a-4629-234485bb833e@linux.vnet.ibm.com>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <35afdffe-179c-aedd-333a-9dfc20635fc3@linux.microsoft.com>
Date:   Thu, 9 Apr 2020 09:25:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c1466cc8-8a08-708a-4629-234485bb833e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/7/2020 2:31 PM, Nayna wrote:

>
> On 4/6/20 6:14 PM, deven.desai@linux.microsoft.com wrote:
>> From: Deven Bowers <deven.desai@linux.microsoft.com>
>>
>> Changelog:
>> ------------------------------------
>>
>> v1: Introduced
>>
>> v2:
>>    Split the second patch of the previous series into two.
>>    Minor corrections in the cover-letter and documentation
>>    comments regarding CAP_MAC_ADMIN checks in IPE.
>>
>> Overview:
>> ------------------------------------
>> IPE is a Linux Security Module, which allows for a configurable
>> policy to enforce integrity requirements on the whole system. It
>> attempts to solve the issue of Code Integrity: that any code being
>> executed (or files being read), are identical to the version that
>> was built by a trusted source.
>
> Can you please clarify the "motivation" for this patch set more 
> clearly? It seems to define a policy layer on top of dm-verity, which 
> may be compiled into the kernel. In the motivation, can you please 
> also make it explicit why existing mechanisms cannot be extended to 
> achieve your purpose?
>
This LSM was born out of a motivation to provide strong integrity 
guarantees without a dependency on file-metadata, allow the integrity 
claims to be configurable on a hot system, and allow for the mechanisms 
for ensuring integrity to be extendable.

This naturally had to be an LSM, as controlling execution at the block 
or filesystem layer does not make sense. Existing LSM implementations 
use filesystem metadata, and since one of IPE's goals is to secure file 
metadata, it is circular to depend on the file metadata itself to make 
decisions about whether the file has been modified.

Additionally, IPE while IPE currently provides dm-verity support and the 
trust root support, it can be easily extended to other implementations 
such as fs-verity. At it's core, IPE is attempting to separate mechanism 
(dm-verity, fs-verity, etc.) from policy (IPE).

> Also, AFIK, the changelog should be moved to the end of the patch 
> description.
>
Thanks! I'll move the changelog.
