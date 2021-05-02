Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F33709B7
	for <lists+linux-integrity@lfdr.de>; Sun,  2 May 2021 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEBDQT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 May 2021 23:16:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:45289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhEBDQT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 May 2021 23:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619925314;
        bh=lp1DUMxwIxuXBmtBlzRd7HCviresfWbtWy97/TcI23w=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gOfEZfKEZSB4zHTgimN/uZmgBvtsaAEVdQg0Y53aYKJ1JOVO0mS8Yma6loiszcAa9
         J1aEJsk5Xxa84YcFzar/x/qhdm7upgKWv20NgBu9SGPEuGNOTu9FtJIVABUFOymsrJ
         cIPgdvVEqD7bK+xHdANBB3I5PcZRY7HTFD+TgRrs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1lRB6M2s0a-0132le; Sun, 02
 May 2021 05:15:14 +0200
Subject: Re: [PATCH v3 4/4] tpm: Only enable supported irqs
To:     Stefan Berger <stefanb@linux.ibm.com>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-5-LinoSanfilippo@gmx.de>
 <d9da4946-c380-d56d-6d42-1ec6f9bd3d8b@linux.ibm.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <2a11e90e-d012-141a-5977-74935d175f5b@gmx.de>
Date:   Sun, 2 May 2021 05:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9da4946-c380-d56d-6d42-1ec6f9bd3d8b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AqUbjHZm+mttLvCAVvgb4wkybsFfI9HRmoPRMS3IqCBBbeRIs6D
 j2Z4sbQSI5b+qE2aTlrsvIQdAOEo4duIyUwjySzzZpaYzgvYD4QFSfugH1LJN3Ly7rx3hDN
 s9jc9CxId1q2+dtLtfxpmZWSjzjyD2l4xH8QJtA0ndBWVBM6C7uS2X01F9jvnlcym7iGvjZ
 RsCrzjya7JKCUMiOiIMOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:csYJNsVV8NY=:vKsVhGYOQl5ejgN8q5hMrY
 qKykD5EY1hMcKz9rDBGqRmdwMjeJ/SmnBBebwvd9vBsYaTi4Jw+sDaazWnc96NqOurbzJImjM
 cQ96y2FVdOnsM8tztoBMWmzlo8t/vwoJm08LlL4ailKGe4WFM6oTDqMxCRv4wZKUR4+n3ik8C
 gsErfq7wtn+DJjooKk66TcuXtlm5ZB5OmQJ+SoqnakVJ5CZN3gkF0P1roQKj+cXF5zhHNEFas
 dd3fQwSYhGUz0pRe3vrB6iF3zVMzEdcGLeF6DUchwGXAMnJJ42neW4vzsFlLVoPSFrzwb8FIZ
 /pVOH7U8iQCjK3r5A4Igohcvm8KmYPBeQuQLNMA9FH9ijn6x1MeF88EKZ85xczMmR9Mw3i4/+
 FS35evoB0iSmO1tM9kT+0KGKSeVordSUw9PPpGz4LZKxkT10mPbPlDahmJ/XP1Q4yi5M6PF16
 ObiX9oKXPq9Nusc8vCwXAzieY9w0zbtX4wiZTV2MGMa7CqZR/2qrj+DFdYZXS4yAe2qdS4YXj
 oXMjI40FAGb7S/2WZhibhQzxt42jeqRBKWzT5RByKiSIEI3gqFsrCbCTD9JmlvNXi88v3ctKU
 gsjZElLKb2sU5GOJ/HqduubvkMTu9XDaoN5hWU3dTc2oLyhHTI5nM2o8gNPKtrEEuuwdMfy8E
 Ya2Bzdfz8P0oUzYKPx/YZnFM0R5Zwth6vuclYuyDJO9CKJOq/gtFJqATU8iR0P/QAU8rFhHI2
 wy+NqKoJOMMW9kYZX8j564fT1ddnyRz/2j3ZJ9cZK1FAalIvs+yZGZG0fntA5A9JZO6C8YovO
 37RtzHIdSAa5qMIgb3WvjgdbRQ1oxo65BU2JVL6VtdIo3a40AhCIdOgGE/HbA0XZASVf2EBkk
 TZziXnRLJjAwEgTSls2Rv8bCtq0OUfi3Ao+7+oIWDtbqmnrbouh3eHfTSUaPVXxIkhKS2QYeg
 nY+M4BPlrRR6ZbnCi3XUqw4gH4+5s2bX46wf1MnjycFEmIasfo6z27nLP4zRniBQmxYhXKHnY
 cq/lFpzapOEsX1KMInzjzHCjB90qtnuUPAIMj/30OxY9CkycmqDbaKCnYB8TRo/W8sJj8AmZZ
 XK337qY4MNH6HN1tp+UPfLKBH7szV3BEGGuoAefo8aQcW69hefOAbZ9/1QW2woPc4/8rlUoQ8
 PGYZbc5obH/eCEdSzl0d3O/1cQxws61VJlDj0BGJxILKtTSs1tuJilDABr9Cbs28YQWmt+57Z
 XhzUOW2XXsDHcKf9U
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 01.05.21 at 21:09, Stefan Berger wrote:
>
> On 5/1/21 9:57 AM, Lino Sanfilippo wrote:
>> Do not set interrupts which are not supported by the hardware. Instead =
use
>> the information from the capability query and activate only the reporte=
d
>> interrupts.
>>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>

Ah sorry, I forgot to add your Reviewed-By for this patch. Will do so in t=
he
next version.

Thx,
Lino
