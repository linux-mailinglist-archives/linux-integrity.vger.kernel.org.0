Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFA93B687D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhF1Sfq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 14:35:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230220AbhF1Sfq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 14:35:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SI4L01018784;
        Mon, 28 Jun 2021 14:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rD0Mllce7o9ZzJ8Ke5E2rxYbC1DQAEShWwnSntQMtgw=;
 b=APQYJldCiRwDbqzZsVu3eQYsa7AY9tTHuDDuSL7SyzrHq/oVkTnVUad3FHpfmgy0XhQO
 3LF8eo6Q0Ic8IbpBMvVo8KuRQtmDQc4JW2wRmNX8+30OpQEP8ak5/B9BZ9xsr328CGfv
 TYyRrdYr+udGG+/FXH1TOA9jfGWfn8kvwuM/pY8/HwkZ+Oo01UZ1EQaxzcMfZWMbXc0Z
 bLsneZ2KH+LOA2h+Tggiev6jcsP+QITQeMIYNKSmBdn1dM2jBLbS4nI/LGei6vIoyom8
 X77Bl+WQyePMzEZQks4udkAy1tS+GM694ZYPMqm8dh9mZFmoTF2yH2M0pWMJx1pp2cp2 nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fhse3jtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:33:18 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SI4Rea019625;
        Mon, 28 Jun 2021 14:33:17 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fhse3jtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 14:33:17 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SISNdN022460;
        Mon, 28 Jun 2021 18:33:16 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 39ejyx46a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 18:33:16 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SIXFZ829032842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 18:33:15 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 638E678F16;
        Mon, 28 Jun 2021 18:33:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0893478F11;
        Mon, 28 Jun 2021 18:33:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 18:33:14 +0000 (GMT)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        James Morris James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
References: <20210623135600.n343aglmvu272fsg@kernel.org>
 <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8de9d45e-4389-8316-b0d0-e9a43be9fade@linux.ibm.com>
Date:   Mon, 28 Jun 2021 14:33:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whhEf=xJz=rdcLWNnRU1uR6Ft-mn6xNrOg3OcQ=5cX6BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5V-UhUDvez3V8zY1-nwvI6xqrjHfvL9o
X-Proofpoint-GUID: Czzx6BhMAaK9L2I2APhY2sWgg9WNrG0e
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/28/21 1:34 PM, Linus Torvalds wrote:
> On Wed, Jun 23, 2021 at 6:56 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>> Contains bug fixes for TPM, and support for signing modules using elliptic
>> curve keys, which I promised to pick up to my tree.
> I pulled this, but then I looked at the key type changes, and that
> made me so scared that I unpulled it again.
>
> In particular, that code will do
>
>      shell rm -f $(CONFIG_MODULE_SIG_KEY)
>
> from the Makefile if some config options have changed.

I suppose it is from this part here.

+# Support user changing key type
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
+ifeq ($(openssl_available),yes)
+$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f 
$(CONFIG_MODULE_SIG_KEY)))
+endif
+endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
+
+ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
+ifeq ($(openssl_available),yes)
  $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f 
$(CONFIG_MODULE_SIG_KEY)))
  endif
+endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA


If the user changed the build option from an ECDSA module signing key to 
an RSA signing key or vice versa then this code deletes the current 
signing key and subsequent code in the Makefile will create an RSA or 
ECDSA signing key following the user's choice. I suppose this is 
expected behavior that when a user chooses an RSA signing key it will 
use an RSA signing key. Maybe we should make a backup copy of the 
previous key, if that helps.


>
> That just seems too broken for words. Maybe I misunderstand this, but
> this really seems like an easy mistake might cause the kernel build to
> actively start removing some random user key files that the user
> pointed at previously.

The removal is triggered by the user changing the type of key from what 
is in the keyfile.

   Stefan



>
>                    Linus
