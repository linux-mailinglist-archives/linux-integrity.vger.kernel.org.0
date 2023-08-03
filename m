Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4998076F36C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Aug 2023 21:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjHCTb1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 15:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHCTb0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 15:31:26 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 901FB1A8
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 12:31:25 -0700 (PDT)
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id C2F05207F594;
        Thu,  3 Aug 2023 12:31:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2F05207F594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691091085;
        bh=cRoxFKq+VV+6aAVg/tuxJaYkcO2AqWQnBLwOt83PZM4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hlgHZB1BO9l4MDU7W8kLZzOdja3Qcr+0aOYOoxbsGdAvsx91wk1+di/m6aoapbsy/
         RC1PJYegmxev+a6kIuvkbsTxyejmc+gyBWj3M/w56ZduXOV2NZicko+BzXLqoSh/Kj
         QDNs33/T4/GMvtGexJVugvaxImIJFFi34ikR2WW0=
Message-ID: <a057a6c2-92c7-33f0-f03d-2f4e255ce04c@linux.microsoft.com>
Date:   Thu, 3 Aug 2023 12:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] tpm: implement TPM2 function to get update counter
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <20230801181917.8535-2-tusharsu@linux.microsoft.com>
 <CUHFWAAKMKJN.2EA3ZHLOOPPGB@suppilovahvero>
 <1d592ca1-1f6c-9eef-ce71-b07a837372b0@linux.microsoft.com>
 <CUHRAC79EW66.1VQRXS97GB0UO@suppilovahvero>
 <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8c4257fb07a8c9fd26b70ce716665a9535e6af54.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/2/23 18:22, Mimi Zohar wrote:
> On Wed, 2023-08-02 at 06:58 +0300, Jarkko Sakkinen wrote:
>>  From long description I see zero motivation to ack this change, except
>> some heresay about IMA requiring it. Why does IMA need update_cnt and
>> why this is not documented to the long description?
> The motivation is to detect whether the IMA measurement list has been
> truncated, for whatever reason.  A new IMA record should be defined
> containing the "pcrCounter" value.  (I have not had a chance to review
> this patch set.)
>
> This new record would be a pre-req for both Tushar's "ima: measure
> events between kexec load and execute" patch set and Sush's proposal to
> trim the measurement list.  (I haven't looked at it yet either.)
>
  Thanks Mimi. Take your time.
