Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778893D8604
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 05:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhG1DKb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 23:10:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53984 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DKa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 23:10:30 -0400
Received: from [192.168.86.34] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id ACC712043B96;
        Tue, 27 Jul 2021 20:10:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACC712043B96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1627441829;
        bh=cZnlhJEeNiBlv5hXlj1BPoJxyc3ZKWu4q0r+/xmo4rs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=d5h47iAbI5y01rc3PnOIxoVMTt4dbcKvMulHNV+k2l3ex0H8zDsLID7y2UcvvtWE+
         HC2ahbxvPRamaV2FyPhK4xdNF7g/jRNulig/yaCQHGMCzkexCMw5dl0xo5i8DwQ1/0
         J6asiAraFalFLOPqffSDlp2dqE2Hxjc18h9wPzUM=
Subject: Re: [dm-devel] [PATCH 0/7] device mapper target measurements using
 IMA
To:     Thore Sommer <public@thson.de>, agk@redhat.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, snitzer@redhat.com, zohar@linux.ibm.com
References: <c833339e-c4bf-6e78-5719-cd902fa8426f@linux.microsoft.com>
 <20210727101802.779067-1-public@thson.de>
 <20210727203337.GA81220@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <a30c8208-f255-d0f0-0bfb-c037367e638c@linux.microsoft.com>
Date:   Tue, 27 Jul 2021 20:10:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727203337.GA81220@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thore,

On 7/27/21 1:33 PM, Alasdair G Kergon wrote:
>> Creating a dm-verity device with mount then removing it and now if you create it
>> again no measurement is generated. Is that the expected behavior?
> Each of the relevant dm ioctls should be logged separately each time.  If that's
> not happening it might need fixing.
> 
Most likely this is because you haven't set CONFIG_IMA_DISABLE_HTABLE=y.

See "IMA: support for duplicate measurement records" [1] for details.

Please let us know if you still see this behavior after setting
CONFIG_IMA_DISABLE_HTABLE=y.

Thanks,
Tushar

[1] 
https://github.com/torvalds/linux/commit/52c208397c246f0c31d031eb8c41f9c7e9fdec0e
