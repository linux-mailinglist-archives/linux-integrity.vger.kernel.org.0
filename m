Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33CDEBB1
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfD2Ufl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 16:35:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41950 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfD2Ufl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 16:35:41 -0400
Received: from [10.91.6.157] (unknown [131.107.159.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 271D2302E6E2;
        Mon, 29 Apr 2019 13:35:40 -0700 (PDT)
Subject: Re: linux-tpmdd self signed kernel failing to boot with secreboot on
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <f9ad2e46-e458-6c78-76da-b85db4601ee3@linux.microsoft.com>
 <CACdnJuuhiQQ8Uq1A_qfidCLVPVQ_3Ty_Kqg+tQPDx2z3P0Yp9w@mail.gmail.com>
 <6373c67f-ea2f-ae1d-0343-4bb774f1d52f@linux.microsoft.com>
 <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com>
From:   Jordan Hand <jorhand@linux.microsoft.com>
Message-ID: <b4f9cc9d-bded-fb0a-1d53-40fa1460ddec@linux.microsoft.com>
Date:   Mon, 29 Apr 2019 13:35:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACdnJusXEq=7LXB=Ry0zH4CTRkQLHPC+5DnP07yXi0TNPeCYTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/29/19 12:17 PM, Matthew Garrett wrote:
> On Mon, Apr 29, 2019 at 8:31 AM Jordan Hand <jorhand@linux.microsoft.com> wrote:
>>
>> On 4/25/19 2:47 PM, Matthew Garrett wrote:
>>> On Wed, Apr 24, 2019 at 11:30 AM 'Jordan' via mjg59 <mjg59@google.com> wrote:
>>>> Under the following circumstances my kernel will not boot:
>>>
>>> Will it boot under other circumstances (ie, if you disable Secure
>>> Boot, does it work fine with the patches?)
>>
>> Yes it works fine if secure boot is disabled.
> 
> That is… very strange. Disabling secure boot will change the contents
> of PCR7, but I can't think of any reason that would matter. What
> hardware is this on?
> 
I have tried this both on a Gen2 Hyper-V VM (from a Windows Host) and on 
a Lenovo X1 Carbon with the same results.
