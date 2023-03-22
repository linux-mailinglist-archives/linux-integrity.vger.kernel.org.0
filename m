Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A796C59A8
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 23:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjCVW6U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 18:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVW6T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 18:58:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236DB728D;
        Wed, 22 Mar 2023 15:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=OBnYzZy3fC6UWVKQq92ULDzDnysgfAJsQHJA+q0UW60=; b=PR5ae4z8Nwlbw6qbPpu815yY2Z
        L9XsyXiX681Yi8XCDzqYu5L6u/Gw0xPvcllh2yq615gn/brC44+pLUdv+HF6c+Uz610za9C8wexuA
        xXAdcrTsPo348ixNijXY2Gfq3okAS0toZW0N7OlphG3Ap3z8gDQ73DmGJPvNGrOof3bZEp+CCLeSM
        twQ+8wM/lOog+0qyPXGPXv7bccnFLP48v0fBenlb7wWQ0M78xLOiEce5Xb9CtUrtLWD9xr4rKCPf4
        helE5y+YJm3eUdRZkkOAN5sODPWFcYAXgPg0hk9mNJhoYfcfllGuW7jymCmrtrl4+ejv+2sO1mtox
        sZgbsOUA==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pf7PK-0003a8-3D;
        Wed, 22 Mar 2023 22:58:15 +0000
Message-ID: <ccfb7800-41ed-6849-a2fe-4f11573d3162@infradead.org>
Date:   Wed, 22 Mar 2023 15:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Documentation on IMA for Linux Kernel Documentation
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <7c91820d-0153-e4db-1c60-38b6f650ed20@linux.ibm.com>
 <60ac4c41-65b8-3c3d-7e31-1a580e728ca5@infradead.org>
 <a50110ca-843a-7586-ed2a-aca12702dde9@infradead.org>
 <c03bf464-00c1-9121-fb2f-549ac991a658@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c03bf464-00c1-9121-fb2f-549ac991a658@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

On 3/22/23 15:02, Ken Goldman wrote:
> On 3/13/2023 6:34 PM, Randy Dunlap wrote:
>> On 3/13/23 15:25, Randy Dunlap wrote:
>>> [add IMA list]
>>>
>>> On 3/13/23 14:43, Ken Goldman wrote:
>>>> I'm writing documentation on IMA targeting users (not kernel developers).  It includes concepts, details on writing policies, the IMA event log format, utilities, and more.  It aggregates existing scattered documentation, but adds much more.  It's maybe 1/2 done.
>>>>
>>>> Questions:
>>>>
>>>> 1. Are there people who could look at it and see if I'm on the right path?
>>>>
>>>> It's a lot of work.  I'd like to know that it has some chance of acceptance.
>>>>
>>>> 2. What is the process for getting a block of documentation added to https://www.kernel.org/doc/html?
>>>
>>> It should be added to the kernel tree in the Documentation/userspace-api/ subdirectory
>>> or Documentation/security/ subdirectory.  The kernel.org/doc/ web pages are generated
>>> from what is in the Linux kernel tree.
>> Ken, if you are not familiar with in-tree kernel documentation, you should take a look
>> at the Documentation/doc-guide/ subdirectory for some documentation on the documentation.
>>
>> Also you can ask for help with specific issues at linux-doc@vger.kernel.org
> 
> I've read the guidelines, coding in rest markdown, using sphinx to test the web pages.  I think it's right.
> 
> 1. I was hoping that someone could look at what I'm doing to see if it has a chance of acceptance.
> 
> I.e., I don't want to spend months on this only to get a quick 'nack'.
> 
> 2. I wonder what the process for submission is.

It's documented in Documentation/process/submitting-patches.rst,
but just ask if you have any questions about it.

-- 
~Randy
