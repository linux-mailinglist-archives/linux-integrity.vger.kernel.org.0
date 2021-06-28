Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68D3B68FF
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhF1TXy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 15:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3784 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235037AbhF1TXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 15:23:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SJ3mjX160591;
        Mon, 28 Jun 2021 15:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4wu0Ddv1MfZ3y5Ez7fexH8dvSk3YjDkNVPwDhX77vG0=;
 b=QTaSZhPZSZilSvnADPOVBpeMJxR1KcEkzkGNdQONeeP5RZ2PZP5IeRvnUv6hlOHgmBc8
 OSAQbTluSq0Tble855eiuILMM0tTh9mJkg6Xhw8e1v+Wn5/EeJC6TwQoVeU0GuKvx7eF
 D8ZxgX0+xNW38Iqqs+3b0AktukIusj5kqkNlTZhvAGS/HTDARwtCsKkxcAT25kqw/+qf
 8uqfDs7KxD5/EBsamS9fMZ1BtizZdffTBLctfZSZnAzeWmbHUvaPz5W/30d7u7dEZeZe
 f1OoEh/ODxqaURFLGV3FBKQ8Of4MbLiwzHamE38C0jbgAZr6y/k7vSGRrvMb7UhNIgXk vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fhu2mtvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 15:21:23 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SJ6O8A170613;
        Mon, 28 Jun 2021 15:21:23 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fhu2mtvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 15:21:22 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SJHFXg003644;
        Mon, 28 Jun 2021 19:21:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 39duvbrf14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 19:21:22 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SJLKkr22675828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 19:21:20 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79F286A08B;
        Mon, 28 Jun 2021 19:21:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A35F6A094;
        Mon, 28 Jun 2021 19:21:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jun 2021 19:21:18 +0000 (GMT)
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
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d3fd4b64-be6a-2210-5cfa-fc1947aea293@linux.ibm.com>
Date:   Mon, 28 Jun 2021 15:21:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <CAHk-=wibQ3ahmo0m3BynA3bw2Fkhv0OfMJuV0+wEMwg93Fbj0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N4ftWuMCLZo4HqMsM5D9th5CXzb2qFak
X-Proofpoint-GUID: 0_RKVwjoY670kTNcsMS_OCNW2JinGW-M
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/28/21 3:11 PM, Linus Torvalds wrote:
> On Mon, Jun 28, 2021 at 11:33 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> The removal is triggered by the user changing the type of key from what
>> is in the keyfile.
>
>
> So no. No backups either. Because there is not a single valid
> situation where you'd want a backup - because the kernel build should
> never EVER modify the original.
>
> Maybe I misunderstand what is going on, but I think the whole thing is
> completely wrongly designed. The _only_ key that the kernel build
> should touchn is the auto-generated throw-away one (ie
> "certs/signing_key.pem"), not CONFIG_MODULE_SIG_KEY in general.

Correct, and the code (certs/Makefile) is surrounded by the check for 
this particular file here, so it won't touch anything else:

[...]

ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")

ifeq ($(openssl_available),yes)
X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
endif

# Support user changing key type
ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
ifeq ($(openssl_available),yes)
$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f 
$(CONFIG_MODULE_SIG_KEY)))
endif
endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA

ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
ifeq ($(openssl_available),yes)
$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f 
$(CONFIG_MODULE_SIG_KEY)))
endif
endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA

[...]


There's one dent in this patch series that requires suppressing an error 
output:  https://lkml.org/lkml/2021/6/25/452


   Stefan


>
>                   Linus
