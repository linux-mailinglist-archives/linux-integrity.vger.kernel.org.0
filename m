Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724EE79032A
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Sep 2023 23:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350836AbjIAVq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Sep 2023 17:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350835AbjIAVmy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Sep 2023 17:42:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E1641BEC;
        Fri,  1 Sep 2023 14:20:27 -0700 (PDT)
Received: from [192.168.86.41] (unknown [50.46.242.41])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9E54B212A780;
        Fri,  1 Sep 2023 14:20:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E54B212A780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693603226;
        bh=it67IfdVDRVdX2moDR85C5xi3JsHlNUpiQ1PvFyXwyc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=si6z6nr5hRK+iur7H3WtbmbfLXMYnnXtzVppQ+Hf3C0IlThevpaWcfHSHL/Tlsy6p
         krlwvMSqsjlLhT9tTCyxtvuNg8VJSPPU/XSRpRbbLkES+L8ZCWuftDMWWN+Vhwfo8F
         hhLQib+/gMVIhWXU8jArwJoYbG45uy7qrDsORhIc=
Message-ID: <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
Date:   Fri, 1 Sep 2023 14:20:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-21.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks a lot Ken for looking at the proposal, and sharing your thoughts.

On 8/30/23 11:06, Ken Goldman wrote:
> 
> 
> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
>> In addition, a large IMA log can add pressure on the network bandwidth 
>> when
>> the attestation client sends it to remote-attestation-service.
> 
> I would not worry too much about network bandwidth.
Our bandwidth concerns are about scaled out system.

When IMA log size increases in the range of megabytes, and when the
number of client devices increases, it makes an impact on the overall
network bandwidth.

> 
> 1. Every solution eventually realizes that sending the entire log each 
> time hurts performance.  The verifier will ask the attestor, "give me 
> everything since record n", and the number of new entries approaches zero.
> 
Completely agreed. IMA log snapshotting (this proposed feature) is a
solution in that direction.

> 2. My benchmarks show that
> 
> On the client, the TPM quote time swamps everything else.
> On the server, verifying the IMA entry signatures swamps everything else.
> 
> The network transfer time is negligible.
Agreed, it is true in the context of an individual client device.

Our network bandwidth concerns are for the overall traffic on the scaled
out system. It impacts the network bandwidth when the IMA log is large
(MBs).  And the issue is compounded when there are large number of
client devices.

Thanks,
Tushar
