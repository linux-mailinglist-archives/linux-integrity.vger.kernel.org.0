Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9659E6B84B7
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCMWZ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Mar 2023 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCMWZ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Mar 2023 18:25:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747342139;
        Mon, 13 Mar 2023 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=7fD82img2uYW6l+JPbSYQpQ8XMjxzAAJmh7FOzEbhVQ=; b=ovxttbQFW+cXEoHxOUvxjtK5yd
        phL86ak8O6OmZ41kkc6j4Ze/ek6m605M/hUwy2cwUGk+GL3I4oj8JjuA2dg+sFpLRN/oyARoQfMtn
        c1w+PoKZy5I5kHd6YJpsSlC386qQhcvpJFpzmrdMFEtWnQQGd9gdTCvb9Dsdb89vbbFk+nPRPwqNa
        HIGNNzp1bELuXzHI9oaXmou2VfO0UNAqMMOUHtoeWdVy2W4Gs7gZ25P7mrsDaF+qFkhNHGx67fty2
        9Ykpw8LACrhG94x7A67cbZuMRRiqXhVix5Vi3tzEvabwd8FDaLqIveFE9l5oCSe7IrK+IKpEENrb+
        pt7bihpw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbqc5-0084cq-F0; Mon, 13 Mar 2023 22:25:53 +0000
Message-ID: <60ac4c41-65b8-3c3d-7e31-1a580e728ca5@infradead.org>
Date:   Mon, 13 Mar 2023 15:25:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Documentation on IMA for Linux Kernel Documentation
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <7c91820d-0153-e4db-1c60-38b6f650ed20@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7c91820d-0153-e4db-1c60-38b6f650ed20@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[add IMA list]

On 3/13/23 14:43, Ken Goldman wrote:
> I'm writing documentation on IMA targeting users (not kernel developers).  It includes concepts, details on writing policies, the IMA event log format, utilities, and more.  It aggregates existing scattered documentation, but adds much more.  It's maybe 1/2 done.
> 
> Questions:
> 
> 1. Are there people who could look at it and see if I'm on the right path?
> 
> It's a lot of work.  I'd like to know that it has some chance of acceptance.
> 
> 2. What is the process for getting a block of documentation added to https://www.kernel.org/doc/html?


It should be added to the kernel tree in the Documentation/userspace-api/ subdirectory
or Documentation/security/ subdirectory.  The kernel.org/doc/ web pages are generated
from what is in the Linux kernel tree.

Thanks.
-- 
~Randy
