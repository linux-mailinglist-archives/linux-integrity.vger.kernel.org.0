Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18D7E791
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 03:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfHBBmb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 21:42:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39435 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731411AbfHBBmb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 21:42:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TYR759._1564710146;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TYR759._1564710146)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Aug 2019 09:42:27 +0800
Subject: Re: [PATCH] ima: Allow to import the blacklisted cert signed by
 secondary CA cert
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Mark D. Baushke" <mdb@juniper.net>,
        Petko Manolov <petkan@mip-labs.com>
References: <1564622625-112173-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1564700229.11223.9.camel@linux.ibm.com>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <d6a27436-3822-3dda-a3be-4e2dfbe04390@linux.alibaba.com>
Date:   Fri, 2 Aug 2019 09:42:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1564700229.11223.9.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2019/8/2 上午6:57, Mimi Zohar wrote:
> Hi Jia,
> 
> On Thu, 2019-08-01 at 09:23 +0800, Jia Zhang wrote:
>> Similar to .ima, the cert imported to .ima_blacklist is able to be
>> authenticated by a secondary CA cert.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> 
> The IMA blacklist, which is defined as experimental for a reason, was
> upstreamed prior to the system blacklist.  Any reason you're not using
> the system blacklist?  Before making this sort of change, I'd like
> some input from others.

In our trusted cloud service, the IMA private key is controlled by
tenant for some reason. Some unprofessional operations made by tenant
may lead to the leakage of IMA private key. So the need for importing
the blacklisted is necessary，without system/kexec reboot, on the
contrary, the system blacklist needs a kernel rebuild and system/kexec
reboot, without runtime and fine-grained control.

The secondary CA cert has a similar story, but it is not controlled by
tenant. It is always imported during system/kexec boot to serve
importing IMA trusted cert and IMA blacklisted cert.

Jia

> 
> thanks,
> 
> Mimi
> 
