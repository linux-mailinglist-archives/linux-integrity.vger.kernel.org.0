Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D15EE1F0
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiI1Qdv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiI1Qdu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 12:33:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ABE24F0E;
        Wed, 28 Sep 2022 09:33:48 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SGWftt001897;
        Wed, 28 Sep 2022 16:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=YxGK65bERyHGDZ0NikSMS6Pq247mdVcfcfK5VTcrENA=;
 b=lVYXE/nwpL2wNycJGv6Vp4n8wouzb9Gmx9x2Uuau434NIVBpYcCZFTfdZZnf1818nlPO
 HBgd2VlI8VKdj8CNiEsQRhO3aPZm1UF0bB3RkHF5FlGIPG//UHGy9nxzzQGgo1PBmbp7
 YKjsMSDi0NGc/3O4wvGml0qvM3z7TRpXjN7Feoz+WVQ050EV3FJN7aTti45tY+3DoIuS
 OTR3eH+UzZuDStT7R5AtZmC8ZtrcSPg69giyoMG6/RTkoMCQyHmLbqfNtJtRlptnshmq
 ukX+Nmst6qo/Z2UWAysgUPGiBNfB9AR3CQkCbKQstygzKYhxHentaQshn3hfvHjoBRV5 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvqxp4ggu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 16:33:43 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28SEuxhE004743;
        Wed, 28 Sep 2022 16:33:42 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvqxp4ggc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 16:33:42 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28SGLFMt013293;
        Wed, 28 Sep 2022 16:33:42 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 3jssh9v936-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 16:33:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28SGXfjb3474034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 16:33:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0D1D5805C;
        Wed, 28 Sep 2022 16:33:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B136D58059;
        Wed, 28 Sep 2022 16:33:39 +0000 (GMT)
Received: from sig-9-65-238-59.ibm.com (unknown [9.65.238.59])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Sep 2022 16:33:39 +0000 (GMT)
Message-ID: <42dbb8f6bc0a3e8339a5283bf26a50bd7bec3767.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: fix key instantiation with
 user-provided data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yael Tzur <yaelt@google.com>
Date:   Wed, 28 Sep 2022 12:33:39 -0400
In-Reply-To: <2fe0144d-ee19-ec17-9566-16bce6386925@vosn.de>
References: <20220919072317.E41421357@mail.steuer-voss.de>
           <53730789a41358673b1715dd650706e9ffcb1199.camel@linux.ibm.com>
           <35fd816-d755-967-5712-b5496875ac7a@vosn.de>
          <2ee1e3e68d847001c4bf856d980a553e52de5023.camel@linux.ibm.com>
          <439012d8-dd4-7fd2-3788-49cf72faa99@vosn.de>
         <6b4229386dced275f745619f190f64a71b7c0aec.camel@linux.ibm.com>
         <2fe0144d-ee19-ec17-9566-16bce6386925@vosn.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hIywS9S9ebs2kWr8-Xst2qFiBsJQ_hsC
X-Proofpoint-GUID: sh6o-FOlLD1aPHMsdoQc-1wtAeHSbW90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-09-28 at 14:08 +0200, Nikolaus Voss wrote:
> On Wed, 21 Sep 2022, Mimi Zohar wrote:
> > On Wed, 2022-09-21 at 09:24 +0200, Nikolaus Voss wrote:
> >> On Tue, 20 Sep 2022, Mimi Zohar wrote:
> >>> On Tue, 2022-09-20 at 18:23 +0200, Nikolaus Voss wrote:
> >>>> On Tue, 20 Sep 2022, Mimi Zohar wrote:
> >>>>> On Fri, 2022-09-16 at 07:45 +0200, Nikolaus Voss wrote:
> >>>>>> Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> >>>>>> decrypted data") added key instantiation with user provided decrypted data.
> >>>>>> The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> >>>>>> Fix this to use hex2bin instead.
> >>>>>
> >>>>> Thanks, Nikolaus.  We iterated a number of times over what would be the
> >>>>> safest userspace input.  One of the last changes was that the key data
> >>>>> should be hex-ascii-encoded.  Unfortunately, the LTP
> >>>>> testcases/kernel/syscalls/keyctl09.c example isn't hex-ascii-encoded
> >>>>> and the example in Documentation/security/keys/trusted-encrypted.rst
> >>>>> just cat's a file.  Both expect the length to be the length of the
> >>>>> userspace provided data.   With this patch, when hex2bin() fails, there
> >>>>> is no explanation.
> >>>>
> >>>> That's true. But it's true for all occurrences of hex2bin() in this file.
> >>>> I could pr_err() an explanation, improve the trusted-encrypted.rst example
> >>>> and respin the patch. Should I, or do you have another suggestion?
> >>>
> >>>> I wasn't aware of keyctl09.c, but quickly looking into it, the user data
> >>>> _is_ hex-ascii-encoded, only the length is "wrong": Imho, the specified
> >>>> length should be the binary length as this is consistent with key-length
> >>>> specs in other cases (e.g. when loading the key from a blob).
> >>>> keyctl09.c could be easy to fix, if only the length is modified. Should
> >>>> I propose a patch? What is the correct/appropriate workflow there?
> >>>
> >>> I'm concerned that this change breaks existing encrypted keys created
> >>> with user-provided data.  Otherwise I'm fine with your suggestion.
> >>
> >> Ok, but this change does not touch the hex-ascii format of encrypted key
> >> blobs?
> >
> > True, but any persistent data based on this key would be affected.
> 
> Persistent data is stored encypted with e.g. the master key in hex-ascii 
> already and should not be affected. Only persistent data stored 
> unencrypted is affected, but the encrypted-keys stuff is just about 
> avoiding that. Or do I still misunderstand something?

Perhaps an existing encrypted key usage example would help clarify what
is meant by persistent data.  The two original encrypted key usages are
the EVM HMAC key and ecryptfs.  The EVM key is an encrypted key used to
calculate the EVM HMAC, which is stored in security.evm.  In that
scenario, the persistent data would be the data stored in security.evm.

Would this patch break existing kernel/application persistent data
based on encrypted keys created with user-provided data?

-- 
thanks,

Mimi

