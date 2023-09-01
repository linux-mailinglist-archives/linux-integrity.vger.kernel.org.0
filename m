Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662379032C
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Sep 2023 23:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbjIAVq1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Sep 2023 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350805AbjIAVmu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Sep 2023 17:42:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28AA71BFE;
        Fri,  1 Sep 2023 14:22:41 -0700 (PDT)
Received: from [192.168.86.41] (unknown [50.46.242.41])
        by linux.microsoft.com (Postfix) with ESMTPSA id 372E5212A780;
        Fri,  1 Sep 2023 14:22:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 372E5212A780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693603360;
        bh=4JQjdrI292EM3uTRhuuRomABTjztaCmafSCbCythPpo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j30XoI5vPo8T3nfJL9MN6kNFYCQB+CNeUOW2GiK0ojRnnmunk7GhuBXobWOux+4tY
         UrKElmoYgxqVEpUtD9BTMfq9Rb2yO4xwZ/yTv3ysw/HPeL/0idV82XqbRGA0b6u9NH
         E56ByYSPFK3sPcWXTOElRqwQziO0eL/LPhCEhmDQ=
Message-ID: <1d2b1df7-aabd-8a18-a564-24399b53f3d2@linux.microsoft.com>
Date:   Fri, 1 Sep 2023 14:22:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
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
 <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
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



On 8/30/23 12:12, Ken Goldman wrote:
> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> 
>> For remote attestation to work, the service will need to know how to
>>  validate the snapshot_aggregate entry in the IMA log.  It will have
>> to read the PCR values present in the template data of
>> snapshot_aggregate event in the latest IMA log, and ensure that the
>> PCR quotes align with the contents of the past UM_snapshot_file(s).
>> This will re-establish the chain of trust needed for the device to
>> pass remote attestation.  This will also maintain the ability of the
>> remote-attestation-service to seal the secrets, if the client-server
>>  use TPM unseal mechanism to attest the state of the device.
> 
> I think that seal/unseal to IMA PCRs is futile.  Since boot is
> multi-threaded, the IMA PCR is unpredictable even when valid.

True. But here we are talking about seal/unseal post boot when the
device is in a stable state, and there are relatively less number of
events extending IMA PCR. The value of the actual IMA PCR doesn't matter
in this context as long as it stays the same between seal-unseal window.

If it changes between that window, the clients typically retry by
sending the request to the service with a new stable PCR.

Seal-unseal is supported by TPM spec, and is used widely. So we had to
ensure that our proposed design wouldn't regress this existing
functionality.

~Tushar
