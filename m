Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F217CFC0B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Oct 2023 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjJSOGB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Oct 2023 10:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345929AbjJSOF7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2023 10:05:59 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256C136
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2023 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1697724352; x=1698329152; i=juergen_repp@web.de;
        bh=fhlyzthvcpbc/7YohqvgoFn4vYQ3OkDBQr4W37eIm8g=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
        b=uERSW/DX0vk0/S/dC42N/ZcwSPL9tm+RyPTNoXENG/nRi6RlvXzJEXC6Avr9da3C
         //+cgors3XIkvX7Lg5CyjRYuC+2ukYMQtd27BTIJxiuzomX3VUjSkpP3EUb3bH5Nj
         gEstKCuzuOzJGqbxgkyD8fzV1B74PznKi8VYkoXhYB3rH8JzKXHi70W9zdxNEbI6B
         hWrOH74MHNiU2JYaUgIUB42G6iarU4iIQC1iHeNGtZGcus7E3tsMAoCT7HOWJukj2
         L/RfQPsWj3Nn/l+pM0n7TGCyvSbxw0UB1GOogUtctZgPLqMM1CAY6OO7hWdBMAjKS
         9HTlDUOJUq22MO8IWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.33] ([37.201.241.134]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ept-1qs5YT1PNl-0084sk; Thu, 19
 Oct 2023 16:05:52 +0200
Message-ID: <0a8b84bd-7c79-415c-afac-b3c7d6341805@web.de>
Date:   Thu, 19 Oct 2023 16:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
From:   Juergen Repp <juergen_repp@web.de>
Subject: TPM resource manager returns -1 for TPM2_RC_CONTEXT_GAP
To:     linux-integrity@vger.kernel.org
Cc:     Andreas Fuchs <andreas.fuchs@infineon.com>,
        "Plappert, Christian" <christian.plappert@sit.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mcnhF+KtdpGi6w1eIzsJ/Fd+efU7+gDo4ge5d7GE/eybV0xnolz
 //E5S5ulhFNBwwaG6qXmoZp410osB/Qt832Ujp+/uxW8Ss6C0chv2kIzRoip3hyV4DJyEpa
 JYLuAVdKJoeoE09HMUf8Yh5hZNRnGlK8hOdXQ0VQfWKZ5uq32ER+OBClFL+nX5DTC3JEF82
 fcLYPuh8L/OJe02SJOciw==
UI-OutboundReport: notjunk:1;M01:P0:CPgjmUoxXk8=;dCj7amUa00OD0yFmrGMRqzyFQ9+
 9H9xqDB9ruQnrBijdEMZxbHUMPfYIGenTlL/UqV4Ed+xTEfo8hs6pkvRpyJ9VCICW9vzCP8/0
 hL63mZxsv4HoFl+JwSNw9hK6PL+fzWOc1CPvkLVMC8N1vSqBacMgUkg5miw0/9uW8hPHtggiJ
 GMFfjUH24y5bENvesC0kwVHGtkfvRYMhzj67cUkFcbAEGuZbraM5XYrVBv22+nzJV7ovXs7/8
 ziCUjBDBQzr3KPTRNCkJ1pznJEEGHHsGGQWhnKl3yrmmBhn/A68z7adOpG1bSwTpUCkECmRK0
 AOocRl8lsbSotnnYHwmKQjhy61j+//XHr/AotWTzFVvBdS31JWft+iUO+T0HYBmLGJn2cpeXN
 tVEWih0m15gXraew15BujmXBsV+k1qmWRT37DMkAJySF6FBYgFxaOs4ZSyLtDz46pyv/n0cEG
 7ZnTPDdyl01k+rXK6u7kSAF7nK8BXjbHooMTkDzryid7dVEEfZrAs3gZpQhctcu41XDpwddYP
 1URbBPlhr6jfEBjZ2oU09C4NmzWXeFvMMqqR4h8HmMkDqxjFN3D2Ee3vu3iWFWqg3awDrj3ez
 kWycJlvyu6xlT6cpZiVFldbk3MSOtD9UB2r7FdIoBjQ/c8jFSUU1graOx+CuiC6SZZbVumiT4
 yiN5YNjxXQl1jQTL4aCqaRDDnCZqULxkeZkIdQTAbcyWYmJ/etD5yS80MmanpNAtr2oROY3Cx
 w+QsMp2y5LqFZGbm5wqD/k4UgsTBX6aVMWZjNc6HK+BmFoa5HvapehVteWa5no2/iZQAOWGYi
 tSnzZWxwqZ/ltbo/ZBbs26Ds3GiF789igpuOK/SYjSNja18MBR1PZi1uQ5xBGGjUiYmdP4InT
 LWbiiLCZ+ENu4gMH1Z2VCTfMAzwahAEbhmhd7bsU5u4AGMmQ7/rJm6ow5yBkha6QnIoDt42LB
 FdWqUi39FTsJJVE3HCmF4rSt0Jk=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is an issue related to this problem on github for tpm2-tss:
https://github.com/tpm2-software/tpm2-tss/issues/2691 (/dev/tpmrm0 was used)
The error did occur after abbout 200 signing operations when a second session was opened by a second process at the same time.
Kernel log:
[ 401.923826] tpm tpm0: tpm2_save_context: failed with a TPM error 0x0901
[  401.925049] tpm tpm0: A TPM error (459) occurred flushing context

Juergen


