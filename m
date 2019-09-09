Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963EBAE171
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfIIXTA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 19:19:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50680 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfIIXTA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 19:19:00 -0400
Received: from [10.200.156.146] (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5FAD420B7186;
        Mon,  9 Sep 2019 16:18:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FAD420B7186
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via
 kexec_file_load
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
References: <20190829200532.13545-1-prsriva@linux.microsoft.com>
 <20190829200532.13545-2-prsriva@linux.microsoft.com>
 <87r252kxc8.fsf@morokweng.localdomain>
 <0c7453d4-620d-2d98-3fda-f902b18da535@linux.microsoft.com>
 <1567985476.4614.224.camel@linux.ibm.com>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <cb7840de-b26b-7e56-9d9a-dac5ccd8692f@linux.microsoft.com>
Date:   Mon, 9 Sep 2019 16:18:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567985476.4614.224.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/8/19 4:31 PM, Mimi Zohar wrote:
> Hi Prakhar,
> "Carrying over the ima log during kexec_file_load" was originally
> posted on 5/10 and 5/31 without a cover letter. On 8/29 it was
> reposted as an RFC with a cover letter.  The cover letter was v1, but
> the patch itself was not.  In the future, please use the "git format-
> patch "-subject-prefix" option to add the version number to both the
> cover letter and the patches.
>
> The comments you received were based on the 8/29 version.  I haven't
> seen anything after that.
>
> Mimi

Added the correct subject prefix, resent patches.

I resent the patches sent at 5/31, since i had no response.

v1 version addresses the comments in the RFC patch.

I have cc-ed you to the email, hopefully its not missed again.

Thankyou for pointing it out.

Thanks,

Prakhar Srivastava

