Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AB0AC372
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2019 01:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393258AbfIFX47 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Sep 2019 19:56:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51504 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390114AbfIFX47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Sep 2019 19:56:59 -0400
Received: from [10.200.156.146] (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5C88C20B7186;
        Fri,  6 Sep 2019 16:56:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C88C20B7186
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via
 kexec_file_load
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org,
        zohar@linux.ibm.com
References: <20190829200532.13545-1-prsriva@linux.microsoft.com>
 <20190829200532.13545-2-prsriva@linux.microsoft.com>
 <87r252kxc8.fsf@morokweng.localdomain>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <0c7453d4-620d-2d98-3fda-f902b18da535@linux.microsoft.com>
Date:   Fri, 6 Sep 2019 16:56:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87r252kxc8.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/30/19 5:11 PM, Thiago Jung Bauermann wrote:
> Hello Prakhar,
>
> Answering this part from the cover letter:
>
>> The code is in most part same as powerpc, i want to get feedback as to
>> how/correct way to refactor the code so that cross architecture
>> partial helpers can be put in a common place.

I started refactoring code to bring helpers under drivers/of, but

i soon reliazed the current implementation can be changed a bit

so that some of the additional functions can be sourced from

existing fdt_*/of_* functions since the fdt_ima was seeming to be

an overkill. I have done so in the V1 patch and also addressed

comments you have.

Hopefully its(v1) is a cleaner approach.

- Thanks for the review, and guidance.

Thanks,

Prakhar Srivastava

> That's a great idea. If it could go to drivers/of/ as Stephen Boyd
> mentioned in the other email that would be great.
>
> More comments below.
> -Addressed those in the v1 patch
> Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
>
