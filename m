Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC52F0E7E
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jan 2021 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbhAKIsq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jan 2021 03:48:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:42193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbhAKIsp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jan 2021 03:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610354834;
        bh=7bpg4vn9AFZJ/OppA/5IRTeX2R2d4+2/OOxtWYuhW3w=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=V80fmVZrNzLZnzi6KUEkRJY9yDEir9Vhf3DTyWElyY6SARY1arMuKjCsEWlmCumsP
         9DkdVhhlR2P80e9wVLpr8ctMFeDcvx+mK07a77PzbqYizc9b1iqKtZIbkxjk8D/saS
         4q1SC9mvdPIOHKnVlg3Qg9OdSooIq8kZD5v19P0Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.6] ([213.225.13.17]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1kMoPv0FcT-00cv1t for
 <linux-integrity@vger.kernel.org>; Mon, 11 Jan 2021 09:47:14 +0100
To:     linux-integrity@vger.kernel.org
From:   =?UTF-8?Q?Christian_Schaubschl=c3=a4ger?= 
        <christian.schaubschlaeger@gmx.at>
Subject: evmctl and pkcs#11
Message-ID: <4bcdbf3a-7600-8c0f-5d47-11dc69584d44@gmx.at>
Date:   Mon, 11 Jan 2021 09:47:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:cnoCR93T1Y18eJT35aiTEbexNtE1Ac3EmRRkMMQLxmMZMnLVi+h
 mjwndDxHIEL7MrBSuoBlm939INvZJSiE8sftWf9D3livW/h350q/X68qn8btm6DFNL7Za9f
 6aPz6Le/V543IMhzmJMo2DQUirZe+YYm4oCGXUWebQ7CanXIq6Oasdp/D2kJ0yxg+zSdiUA
 dTazwnkiPEODIFqdIDtDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m//8a0/Dwpw=:mr+Jbl6eTZrnLlOQMn0tHk
 9MHbxX6y37u1qgnqzQCZsUqN047jAab1DwZH3VAzH/0ezKZ8Dugtyt9SSy958DhQhPc6saHC3
 F6JUOF9AGzSKezgSmsTcjdzzDdeArIOq24wPXOdZ5Stq+Msr+IFeYsmgsGz4RLCmyQZGiiA2G
 WllG4mTUwA7wkwukUaL5QnoWc4OFSnlr5oE2Pd9Nlvnxx6XLHK9VwDUQM6hAv2ZWIE7zH1eyC
 gZ2PtUE1S6GZzUVXmV2rR3aFt+CtoPNgSfG3Z5cRfbl2cBuUu5A61AidmnOCecFtPM5h3uyKS
 zyo4hfS4yxZc979+SKG6ht2+i613/sIr2cdg2KiI7Hgk2F47co9vs0tvFINjLeOv7h8DDQOpG
 e5DD38Q0YUnI6WkQk/H1KZyDv+bDPIqMjWVzK+aHjcX4uY2SzEEi9H2SmiCQprGDUtNZL5I7n
 h10rVq4ACgf7iKNkyX1psuNo8hlMbOm1XXDLmqKlnqjgdDzD7w6jv3vmXHVHzopYo6VkydVh4
 585nL6KZ25WYjiN0BA2FXSKorIMGPJuelMQLgK26yx7SwMVUNrXM06KXXegcv5jdRz4GPZmZE
 5tv0asDOhH02X8iY4vHKJ3v3T2/zn+NZWQx9Le6zQ6Qb8/PzAnbmjl3q1j27Ch7mJN15bPDmY
 LaC3WGu0hyNJ7z2EHRPDh4IlpWMTNCZ9rujjKOqBz31TR3qUJw6VLW7PslGZxcwTBkGPWAnyJ
 5nXRbwHCCklRmCS+J1788oeJEbFJBinkmtCSV+YiixOOUBTePi4bECfrEFzUZmPreFbwf3KLT
 JzKjSVS62fd+nmkM/j6zRmydbqzF1+w07Mp3k7l1B1PqwhEFBxNa1IiASWy9Hxqc36FwfzZEK
 jNDbYvEJ0zskcM3PsACKrbSWzK6Ucn1qT+ixLl5HM=
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello list,

I'm using evmctl's ima_sign facility to sign binaries like this:

evmctl -a sha256 ima_sign -k keyfile.priv binary_file

Now I would like to use a smartcard to do the cryptography instread of providing the private key in a file using the "-k" option. Is this possible? I see that evmctl knows the option "--engine"; can I specify an openssl pkcs#11 engine with that to get the hash signed by the smartcard via pkcs#11 and openssl?

Thanks and best regards,
Christian

