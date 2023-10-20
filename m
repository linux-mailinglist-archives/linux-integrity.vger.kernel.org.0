Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5D7D186E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Oct 2023 23:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjJTVxT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Oct 2023 17:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTVxS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Oct 2023 17:53:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11A7ED41
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2023 14:53:17 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7046320B74C0;
        Fri, 20 Oct 2023 14:53:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7046320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697838796;
        bh=plFbNIXHlGBEFstPge8t77v40f9VEzwt7+PBAdejGv4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P2pEODlh3mQTQQTrTMdm6cOy0U86thZH8Pmfd84wUw09NaRqR7scGZNgOwm2NWGs+
         MdIqpNdAiMGMovMatiAckGHC3++lVgijwH3pDlQGlNh8lth7Fg4TosZHgspoQjNPGI
         TYKccM71hgxMUCxrAzlFD8tQWRoirwT3s7Fuo/RA=
Message-ID: <262bd4e0-e6c9-90fe-a072-4accea2154a3@linux.microsoft.com>
Date:   Fri, 20 Oct 2023 14:53:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
 <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
 <55585644-2170-d462-4d64-ca3a963b30fe@linux.microsoft.com>
 <15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/20/23 14:16, Stefan Berger wrote:
> No, what I mean is you should ask the user for how many extra kilobytes 
> (kb) to allocate - not ask for pages.
> 
> 
>     Stefan
Ok. Will do.
I will align the input config value to the PAGE_SIZE as well.
