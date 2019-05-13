Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B56331B25E
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 11:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfEMJJp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 05:09:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32933 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfEMJJo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 05:09:44 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 65554E80839DF2F7883E
        for <linux-integrity@vger.kernel.org>; Mon, 13 May 2019 10:09:43 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 13 May
 2019 10:09:38 +0100
Subject: Re: Whitelisting with IMA
To:     m3hm00d <f.m3hm00d@gmail.com>, <linux-integrity@vger.kernel.org>
References: <CAL8qiskDtYJ0NY3u+zV3YBMR4Qs_YcHSHZ61per5jwZ3n54r8A@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <c4adc9d7-9244-1cbe-693c-2f090851d804@huawei.com>
Date:   Mon, 13 May 2019 11:09:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAL8qiskDtYJ0NY3u+zV3YBMR4Qs_YcHSHZ61per5jwZ3n54r8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/12/2019 11:37 AM, m3hm00d wrote:
> tldr: Is there some way to ask IMA not to open (execute) unknown binaries
> 
> Hi all,
> 
> I saw some comments on RFC for WhiteEgret LSM. Someone on the same
> thread said that IMA could be used for whitelisting as well. Based on
> a couple of hours with IMA, it seems to me that IMA can only stop
> execution of (altered) binaries whose hash/sign was earlier measured.

Hi

I'm developing an extension (IMA Digest Lists) to allow access to files
depending on a white list (for example digests in RPM headers). I will
publish a new version soon. For the concept, please have a look at:

https://github.com/euleros/linux/wiki/IMA-Digest-Lists-Extension
https://github.com/euleros/digest-list-tools/wiki/Architecture


> If a user installs a new (unknown) application, it seems like IMA is
> going to allow that application to run since IMA can't find any
> integrity loss since IMA doesn't have any 'good' value against the new
> application. Is this correct? Or is there some other option to ask IMA
> not to execute any unknown binary?

If appraisal is enabled, and the application has no signature/HMAC,
access would be denied. If the application is installed by a package
manager, probably files will have a HMAC and access would be granted
unless the IMA policy requires signatures.

Roberto


> Kind regards,
> m3hm00d
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
