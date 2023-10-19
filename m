Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457BE7D0051
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Oct 2023 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjJSRNv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Oct 2023 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjJSRNu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2023 13:13:50 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB13CA
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2023 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1697735617; x=1698340417; i=juergen_repp@web.de;
        bh=PrGgP1WAEeWnq0drlTUAXa1WIq6AY14RhfFwcX8wcEo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Vao2G1vWBY86C3XRD9cn9fDt57gGryLzhlCLihYC74YGMwF0eXirmxwQ03Pmj07z
         6QyQXiduFTYhqBNO3UIDgzwYCJEFufN0O0ttc7XHOjxBYTbsCbn9ySdcPTjeKoV3A
         rzbd1m6P9AIhev1QdTIRMVriuXO0O7YdZJXG+sN5U/SuBRsTr+K9B2yu1d62hv2ih
         +udSg/AeKj4cwyiI5BepD6PBsU+oBghNxP00ULpi2qlLrmYgrwXT6B1LgWSWx+NCi
         gEYHc9dxrIDTl3Qwj9TQsje7RE/A/tKhOrJ4a99Oj0n2gcVvJoDCtOlyFXR9x3+Aw
         mb26zSv9HVNElnMEKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.33] ([37.201.241.134]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4bUg-1qvB151JmY-001mgt; Thu, 19
 Oct 2023 19:13:37 +0200
Message-ID: <513b3dd3-3a3a-46a6-a626-9a6c0b7eef4e@web.de>
Date:   Thu, 19 Oct 2023 19:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
Content-Language: de-DE
To:     Andreas.Fuchs@infineon.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     christian.plappert@sit.fraunhofer.de
References: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
 <48485679a3d66fe802960ea2826885a3456b9180.camel@HansenPartnership.com>
 <23488b27daae488e97323ff07f52db6f@infineon.com>
From:   Juergen Repp <juergen_repp@web.de>
In-Reply-To: <23488b27daae488e97323ff07f52db6f@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tN63aJHqeE0lgsEmeDuJP6jeHaODzt1y403hZZ9KeI8kdjAaQk8
 wUoR7fhRzQqOsIK/wzB03pIYoGf7Q9Od8+GZSpYP20jcEe5HmsAs0gmWjYxXtUCdwXxmyoE
 FroMYHovYVMV1zDQ9sFFUwWQPDfjvICmV20JGJfI3G3nQnbBtjx/SBMwy7VZ31gQtVnZYD7
 ZRB6Y4zU6z1nVlxrH4rUg==
UI-OutboundReport: notjunk:1;M01:P0:Bo1JRvuvv44=;zjeydcYfJYPmoZN1JMd42ZOYYQM
 SggXKOcEKdgHdCFm/oLSDYX2+zId2CHC+Gs3kY8ztJV2boaNwPtPU3R7c7YVsD+dxiFTWZ5E7
 ZITsKv46v+EUIEEMXAxiXkYGKTSgrfsujWL3aJhqHlJ5qC2wadmTvQtuk1XKNYqkEIygl0s4r
 qC6jszLnNmsNDZotThxo2OT1icKWEgcPC9ZatL6KIHhsX+G+tCKY1ufu6k2B88clDzGTh9HZG
 fFWw+T9mYgIP6584hl6Cbt/0QNueilMJ22E//kJQF19vCSwBN+yMMYKTMHLg3/eTZ3eXIQgUB
 OaYdtPSSu7aWCmWuNhTbxEDC/Z6IcQ+yZcacsOK4kyFiw1T/+0GkszHxCi/fcAs416x4XntBK
 1ICpgFsxWsPBmdlhrItAiwNGkl2xNLRn776QHhNISFLB1iCzY8WBXpyG3WDw0+jcgK1owLOAS
 B00PW6hwmjEy1Id+QobPznjFEBO42rWDCepwmIUo9nWg/wcdgHarBefDyuSEESDbjMqV9Djdu
 z5TKFMqWr0u9upjc3vZZjNJhmw+KW9XCBpjb1oG3llcOPs+kKTPspBle5HBprL7USa2MvYuU+
 ks6+42gqFRgLFJaIRzIne+40uYcwHGwyz2NqQe4kmt8vzLN7yNjcJLCig43o3ZgD3oNIMu4WQ
 v1NdpWQ8FfD7k885IlBjpV3HdwTtrcr25yvUNFWDttbM3e6npUrXog5RMqG2N7JxB3rAEYJlR
 XKjpcY3l4hL0oG+lFQq9L4d4uKZyd2eQVL1mBKuMfbjfK5WU+pOU6GU1UDPgoh8RLdYqkA2P9
 nTeO9c0Bu1vvYToZ7YpPZjw5bJuF5P8EpdG/4fJu6refcoAL1hEDLhErQOO1f4nrVE2feCttn
 c3hioc+OW/2pAT3HNJmdGCx3TdtoKu8iJ2+PKgWHgTTqz4L5bAOhQeF1KklYEpn8hLqXtvIsY
 qE3SOZmUoXBTbtuxl7679/ohtCk=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 19.10.23 um 18:16 schrieb Andreas.Fuchs@infineon.com:
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>> On Thu, 2023-10-19 at 16:05 +0200, Juergen Repp wrote:
>>> There is an issue related to this problem on github for tpm2-tss:
>>> https://github.com/tpm2-software/tpm2-tss/issues/2691 (/dev/tpmrm0 was
>>> used) The error did occur after abbout 200 signing operations when a
>>> second session was opened by a second process at the same time.
>>> Kernel log:
>>> [ 401.923826] tpm tpm0: tpm2_save_context: failed with a TPM error
>>> 0x0901
>>> [=C2=A0 401.925049] tpm tpm0: A TPM error (459) occurred flushing cont=
ext
>>
>> I'm afraid that's a known problem with the Intel TSS: it saves the cont=
ext, which will cause a gapping error if you keep it saved while doing oth=
er context requiring operations.  The solutions are either to implement de=
gapping in the kernel or persuade the Intel TSS not to save contexts unnec=
essarily.
>
> This is independent of the TSS used.
> When you have one long lasting session being used seldomly (i.e. in Appl=
ication A) and another session or multiple sessions being used frequently =
(i.e. in Application B), then you will hit this problem at some point.
> As such ANY resource manager (in kernel or outside) needs to implement s=
ession ungaping, otherwise it will fail such scenarios.
>
yes we were able to work around the problem by using the resource mangager=
 from https://github.com/tpm2-software/tpm2-abrmd which implements the ung=
apping.


