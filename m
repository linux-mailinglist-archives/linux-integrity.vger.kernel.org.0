Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21C3B6936
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 21:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhF1Thz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 15:37:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234210AbhF1Thr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 15:37:47 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SJYTwc187874;
        Mon, 28 Jun 2021 15:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R4S2xD3vm3oT8VEEnXLkrTD8IIOFUMMCvhpioC/joRY=;
 b=a8V+KmJPMAeBjV4bPkX7NnlLLZx393ra6tAOIb1yhYYHamX++bael3M04RnQxkjtly02
 JbMiEl6ZJs9s6kEweyok/biE9DCwHMvb102UVoVeZ0kctqD6F4hYNPeOQSdIRSP7zDlh
 Tfyov4e/ba+nTyAbuCaTXurF1KbzjbjV7ZKD1TI72vBjH2M1O6qIDDT4dCM5c3r+nB4/
 ZNNafHE3uvZtXvmCXXp4vxvU/HMV1qYjgSaky61SC2+8aeqKIlWB4fP52fAZDF8rbhvH
 rJ2Uz7UoR/KBdOK5S/lvVoLT2RW4UlNNgErUOm+zpEQeHIEfxIO2wq+2EXKpWSEs1t8L /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fjqb38hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 15:35:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SJYqMK188651;
        Mon, 28 Jun 2021 15:35:18 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fjqb38gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 15:35:18 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SJS0VB010426;
        Mon, 28 Jun 2021 19:35:17 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 39duvam257-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 19:35:17 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SJZGTp33292560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 19:35:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 939F7AE075;
        Mon, 28 Jun 2021 19:35:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A35AE06D;
        Mon, 28 Jun 2021 19:35:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 19:35:16 +0000 (GMT)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
References: <20210623135600.n343aglmvu272fsg@kernel.org>
 <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
 <8de9d45e-4389-8316-b0d0-e9a43be9fade@linux.ibm.com>
 <CAHk-=wibQ3ahmo0m3BynA3bw2Fkhv0OfMJuV0+wEMwg93Fbj0g@mail.gmail.com>
 <d3fd4b64-be6a-2210-5cfa-fc1947aea293@linux.ibm.com>
 <CAHk-=wgQJESJ-q-4FNgwpTJTZrEr033gzpXM2gWWviVOHJNnaQ@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <efeb27d1-5c75-b61f-0cc4-583a589e0f7f@linux.ibm.com>
Date:   Mon, 28 Jun 2021 15:35:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgQJESJ-q-4FNgwpTJTZrEr033gzpXM2gWWviVOHJNnaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Rd25VMkPW1pa_dpSay-4vtbBR_HTyHf
X-Proofpoint-GUID: jAmMaUp1yq9sgoQByjXj9KUCCR74ReE8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106280127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/28/21 3:27 PM, Linus Torvalds wrote:
> On Mon, Jun 28, 2021 at 12:21 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> Correct, and the code (certs/Makefile) is surrounded by the check for
>> this particular file here, so it won't touch anything else:
> Ahh, I missed that part.
>
> Can we just make it really really obvious, and not use
> CONFIG_MODULE_SIG_KEY at all, then?
>
> IOW, make these literally be about "certs/signing_key.pem" and nothing
> else, so that when people grep for this, or look at the Makefile, they
> don't fall into that trap I fell into?

Yes, sir.

    Stefan


>
> That also would make it obvious that there are no pathname quoting issues etc.
>
>               Linus
